#coding:utf-8
""" Cornice services.
"""
import json
import re
from cornice import Service
from pyramid.security import remember, authenticated_userid, Allow, Authenticated, Everyone, effective_principals
from webob import exc
from webob.response import Response
from api.mapping.product import Product
from api.mapping.user import User, manager
from couchdb.json import encode as couchdb_json_encode


VALID_USERNAME = re.compile(r"^[A-Za-z][\w.-]{5,29}$")
VALID_PASSWORD = re.compile(r"^[\w\-\~\`\!\@\#\$\%\^\&\*\(\)\+\=\\\{\}\[\]\|\;\:\'\,\.\/\<\>\?\"]{6,30}$")



def _check_acl(request):
    return [(Allow, 'admin', 'add')]


user_create = Service(name='users_create', path='/users/create', description="create a user", cors_origins=('*',))
user_login_logout = Service(name='users', path='/users', description="user login or logout", cors_origins=('*',))
products = Service(name='products', path='/products', description="product management", cors_origins=('*',), acl=_check_acl)
brands = Service(name='brands', path='/brands', description="get all brand and their categories", cors_origins=('*',))
brand_desc = Service(name="brand_desc", path='/brand/desc', description='get the desc for the spec brand', cors_origins=('*',))


#
# users
#

class _401(exc.HTTPError):
    def __init__(self, msg=u'Unauthorized'):
        body = {'status': 401, 'message': msg}
        Response.__init__(self, json.dumps(body))
        self.status = 401
        self.content_type = 'application/json'


class _400(exc.HTTPError):
    def __init__(self, msg=u'Bad request, missing data.'):
        body = {'status': 400, 'message': msg}
        Response.__init__(self, json.dumps(body))
        self.status = 400
        self.content_type = 'application/json'


def valid_token(request):
    try:
        token = request.token
    except AttributeError:
        raise _401(msg=u'token is empty')
    user_id = authenticated_userid(request)

    if user_id is None:
        raise _401(msg=u"token cannot parse to a valid username")

    db = request.db
    result = db.view('_design/user/_view/by_user', key=user_id)
    if len(result):
        user = result.rows[0].value
        user_token = user.get('token', "")
        if user_token != token:
            raise _401(msg=u'token invalid')
        else:
            request.validated['user'] = user

    else:
        raise _401(msg=u'user not exist')


def create_validate(request):
    try:
        username = request.json_body['user']
        password = request.json_body['password']
        password_confirm = request.json_body['passwordConfirm']
        if not VALID_USERNAME.match(username):
            request.errors.add('signup', 'username_invalid', u'用户名只能以英文字母开头，其余为英文、数字、点、减号和下划线，长度为6到30个字符')
        elif not VALID_PASSWORD.match(password):
            request.errors.add('signup', 'password_invalid', u'密码包含非法字符，长度为6到30个字符')
        elif not VALID_PASSWORD.match(password_confirm):
            request.errors.add('signup', 'password_confirm_invalid', u'密码包含非法字符，长度为6到30个字符')
        elif password != password_confirm:
            request.errors.add('signup', 'password_mismatch', u'两次密码不一致')
        else:
            db = request.db
            result = db.view('_design/user/_view/by_user', key=username)
            if len(result):
                request.errors.add('signup', 'username_exist', u'用户名已经存在')
            else:
                user = User(username=username, password=password)
                request.validated['user'] = user
    except ValueError:
        raise _400()
    except KeyError as e:
        if e.message == 'user':
            request.errors.add('signup', 'username_none', u'用户名不能为空')
        elif e.message == 'password':
            request.errors.add('signup', 'password_none', u'密码不能为空')
        elif e.message == 'passwordConfirm':
            request.errors.add('signup', 'password_confirm_none', u'确认密码不能为空')


def login_validate(request):
    try:
        username = request.json_body['user']
        password = request.json_body['password']
        if not VALID_USERNAME.match(username):
            request.errors.add('login', 'username_invalid', u'用户名不合法')
        elif not VALID_PASSWORD.match(password):
            request.errors.add('login', 'password_invalid', u'密码包含非法字符')
        else:
            db = request.db
            user = db.view('_design/user/_view/by_user', key=username)
            if len(user):
                hashed_password = user.rows[0].value['password']
                if manager.check(hashed_password, password):
                    headers = remember(request, username)
                    cookie_value = headers[0][1].split(';')[0][:-1][10:]
                    user_id = user.rows[0].id
                    user = db[user_id]
                    user['token'] = cookie_value
                    db[user_id] = user
                    request.validated['user'] = user
                else:
                    request.errors.add('login', 'password_error', u'密码不正确')
            else:
                request.errors.add('login', 'username_not_exist', u'用户不存在')
    except ValueError:
        raise _400()
    except KeyError as e:
        if e.message == 'user':
            request.errors.add('login', 'username_none', u'用户名不能为空')
        elif e.message == 'password':
            request.errors.add('login', 'password_none', u'密码不能为空')



@user_create.post(validators=create_validate)
def create_user(request):
    user = request.validated['user']
    headers = remember(request, user.username)
    cookie_value = headers[0][1].split(';')[0][:-1][10:]
    user.token = cookie_value

    db = request.db
    user.store(db)
    return {'token': cookie_value}


@user_login_logout.post(validators=login_validate)
def login(request):
    user = request.validated['user']
    cookie_value = user['token']
    return {'token': cookie_value}


@user_login_logout.get(validators=valid_token)
def logout(request):
    user = request.validated['user']
    db = request.db
    user = db[user['_id']]
    del user['token']
    db[user['_id']] = user
    return {'username': user['username']}

#
# product
#


def validate_product(request):
    try:
        brand = request.json_body['brand']
        spec = request.json_body['spec']
        category = request.json_body['category']
        cover = request.json_body['cover']
        images = []
        image_list = request.json_body['images']
        if not isinstance(image_list, list):
            raise _400()
        if not image_list:
            request.errors.add('products', 'images_none', u'照片不能为空')
        for image in image_list:
            if not isinstance(image, dict):
                raise _400()
            images.append(image['url'])
        new_product = Product(spec=spec, brand=brand, category=category, cover=cover, images=images)
        request.validated['product'] = new_product
    except ValueError:
        raise _400()
    except KeyError as e:
        if e.message == 'spec':
            request.errors.add('products', 'spec_none', u'型号规格不能为空')
        elif e.message == 'brand':
            request.errors.add('products', 'brand_none', u'品牌不能为空')
        elif e.message == 'category':
            request.errors.add('products', 'category_none', u'分类不能为空')
        elif e.message == 'cover':
            request.errors.add('products', 'cover_none', u'封面照片不能为空')
        elif e.message == 'images':
            request.errors.add('products', 'images_none', u'照片不能为空')
        elif e.message == 'url':
            request.errors.add('products', 'image_none', u'每个添加的照片都不能为空')



@products.get()
def get_product(request):
    try:
        name = request.params['name']
        category = request.params['ca']
    except KeyError:
        raise _400()
    db = request.db
    name = couchdb_json_encode([name, category])
    result = db.resource('_design', 'product', '_view', 'by_brand_category').get_json(key=name)[2]
    return result


@products.post(validators=(valid_token, validate_product), permission='add')
def add_product(request):
    new_product = request.validated['product']
    db = request.db
    new_product.store(db)
    return {'success': 123}


@brands.get()
def get_brands(request):
    db = request.db
    if 'name' not in request.params:
        return db.resource('_design', 'product', '_view', 'brand_list').get_json(group=u'true')[2]
    else:
        name = request.params['name']
        name = couchdb_json_encode(name)
        return db.resource('_design', 'product', '_view', 'brand_list').get_json(group=u'true', key=name)[2]


@brand_desc.get()
def get_brand_desc(request):
    try:
        name = request.params['name']
    except KeyError:
        raise _400()
    db = request.db
    result = db.resource('_design', 'brand', '_view', 'by_desc').get_json(key=couchdb_json_encode(name))[2]
    return result