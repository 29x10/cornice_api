#coding:utf-8
""" Cornice services.
"""
from cgi import FieldStorage
import json
import re
from uuid import uuid4
from cornice import Service
from pyramid.security import remember, authenticated_userid, Allow
from webob import exc
from webob.response import Response
from api.mapping.product import Product
from api.mapping.user import User, manager, groupfinder
from couchdb.json import encode as couchdb_json_encode


VALID_USERNAME = re.compile(ur"^[A-Za-z0-9\u4e00-\u9fa5][\u4e00-\u9fa5\w.-@]{1,29}$")
VALID_PASSWORD = re.compile(r"^[\w\-\~\`\!\@\#\$\%\^\&\*\(\)\+\=\\\{\}\[\]\|\;\:\'\,\.\/\<\>\?\"]{6,30}$")

def _check_acl(request):
    return [
        (Allow, 'admin', 'add'),
        (Allow, 'admin', 'view')
    ]


users = Service(name='users', path='/users', description="user management", cors_origins=('*',))
user_groups = Service(name='users_groups', path='/users/{user_id}', description="get user's groups based on user_id", cors_origins=('*',))
user = Service(name='user', path='/user', description='user info', cors_origins=('*',))


product_all = Service(name='product_all', path='/products', description="all product for display", cors_origins=('*',))
product_brand = Service(name='product_brand', path='/products/{brand}', description="spec brand for display", cors_origins=('*',))
product_category = Service(name='product_category', path='/products/{brand}/{category}', description="spec category for display", cors_origins=('*',))

product_all_with_price = Service(name='product_all_with_price', path='/product', description="product for admin", cors_origins=('*',), acl=_check_acl)

brands = Service(name='brands', path='/brands', description="get all brand and their categories", cors_origins=('*',))


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
            request.errors.add('body', 'username_invalid', u'用户名只能以中英文数字开头，其余为中英文、数字、点、减号、@和下划线，长度为2到30个字符')
        elif not VALID_PASSWORD.match(password):
            request.errors.add('body', 'password_invalid', u'密码包含非法字符，长度为6到30个字符')
        elif not VALID_PASSWORD.match(password_confirm):
            request.errors.add('body', 'password_confirm_invalid', u'密码包含非法字符，长度为6到30个字符')
        elif password != password_confirm:
            request.errors.add('body', 'password_mismatch', u'两次密码不一致')
        else:
            db = request.db
            result = db.view('_design/user/_view/by_user', key=username)
            if len(result):
                request.errors.add('body', 'username_exist', u'用户名已经存在')
            else:
                user = User(username=username, password=password)
                request.validated['user'] = user
    except ValueError:
        raise _400()
    except KeyError as e:
        if e.message == 'user':
            request.errors.add('body', 'username_none', u'用户名不能为空')
        elif e.message == 'password':
            request.errors.add('body', 'password_none', u'密码不能为空')
        elif e.message == 'passwordConfirm':
            request.errors.add('body', 'password_confirm_none', u'确认密码不能为空')


def login_validate(request):
    try:
        username = request.json_body['user']
        password = request.json_body['password']
        if not VALID_USERNAME.match(username):
            request.errors.add('body', 'username_invalid', u'用户名不合法')
        elif not VALID_PASSWORD.match(password):
            request.errors.add('body', 'password_invalid', u'密码包含非法字符')
        else:
            db = request.db
            user = db.view('_design/user/_view/by_user', key=username)
            if len(user):
                hashed_password = user.rows[0].value['password']
                if manager.check(hashed_password, password):
                    cookie_value = remember(request, username)
                    user_id = user.rows[0].id
                    user = db[user_id]
                    user['token'] = cookie_value
                    db[user_id] = user
                    request.validated['user'] = user
                else:
                    request.errors.add('body', 'password_error', u'密码不正确')
            else:
                request.errors.add('body', 'username_not_exist', u'用户不存在')
    except ValueError:
        raise _400()
    except KeyError as e:
        if e.message == 'user':
            request.errors.add('body', 'username_none', u'用户名不能为空')
        elif e.message == 'password':
            request.errors.add('body', 'password_none', u'密码不能为空')


@users.put(validators=create_validate)
def create_user(request):
    user = request.validated['user']
    cookie_value = remember(request, user.username)
    user.token = cookie_value

    db = request.db
    user.store(db)
    return {'token': cookie_value, 'username': user['username']}


@users.post(validators=login_validate)
def login(request):
    user = request.validated['user']
    cookie_value = user['token']
    username = user['username']
    return {'token': cookie_value, 'username': username}


@users.get(validators=valid_token)
def logout(request):
    user = request.validated['user']
    db = request.db
    user = db[user['_id']]
    del user['token']
    db[user['_id']] = user
    return {'username': user['username']}


@user.get(validators=valid_token)
def user_info(request):
    user = request.validated['user']
    return {'username': user['username']}


@user_groups.get()
def get_user_groups(request):
    user_id = request.matchdict['user_id']
    groups = []
    if user_id:
        db = request.db
        result = db.view('_design/user/_view/by_user', key=user_id)
        if len(result):
            groups = result.rows[0].value.get('groups', None)
            if not groups:
                groups = []
    return dict(groups=groups)


#
# product
#


def validate_product(request):
    images = []
    cover = ''
    up = request.up
    try:
        brand = request.params.get('brand', 'undefined')
        if brand == 'undefined':
            request.errors.add('body', 'brand_none', u'品牌不能为空')
        spec = request.params.get('spec', 'undefined')
        if spec == 'undefined':
            request.errors.add('body', 'spec_none', u'型号不能为空')
        category = request.params.get('category', 'undefined')
        if category == 'undefined':
            request.errors.add('body', 'category_none', u'所属目录不能为空')
        price = request.params.get('price', 'undefined')
        if price == 'undefined':
            request.errors.add('body', 'price_none', u'面价不能为空')
        price = int(price)
        for file_type, file_wrapper in request.params.items():
            if isinstance(file_wrapper, FieldStorage):
                file_ext = '.' + file_wrapper.type.split('/')[-1]
                image_url = '/li-electric/product/' + uuid4().hex + file_ext
                if 'image' in file_type:
                    up.put(image_url, file_wrapper.file, checksum=True)
                    images.append('http://lirentaihua.b0.upaiyun.com' + image_url)
                elif 'cover' in file_type:
                    up.put(image_url, file_wrapper.file, checksum=True)
                    cover = 'http://lirentaihua.b0.upaiyun.com' + image_url
        if not images:
            request.errors.add('body', 'images_none', u'产品图片不能为空')
        if not cover:
            request.errors.add('body', 'cover_none', u'封面照片不能为空')
        new_product = Product(spec=spec, brand=brand, category=category, cover=cover, price=price, images=images)
        request.validated['product'] = new_product
    except ValueError as error:
        if 'int' in error.message:
            request.errors.add('body', 'price_not_number', u'面价必须为数字')
    except Exception:
        pass


@product_all.get()
def all_product(request):
    db = request.db
    return db.resource('_design', 'product', '_view', '_all_product').get_json()[2]


@product_brand.get()
def product_on_brand(request):
    brand = request.matchdict['brand']
    db = request.db
    startkey = couchdb_json_encode([brand, ])
    endkey = couchdb_json_encode([brand, {}])
    return db.resource('_design', 'product', '_view', 'product_list').get_json(startkey=startkey, endkey=endkey)[2]


@product_category.get()
def product_on_category(request):
    brand = request.matchdict['brand']
    category = request.matchdict['category']
    db = request.db
    key = couchdb_json_encode([brand, category])
    return db.resource('_design', 'product', '_view', 'product_list').get_json(key=key)[2]


@product_all_with_price.get(validators=valid_token, permission="view")
def product_with_price(request):
    db = request.db
    try:
        id = request.params['id']
        product = db[id].items()
        return {'product': product}
    except KeyError as e:
        if e.message == 'id':
            return db.resource('_design', 'product', '_view', 'product_list').get_json()[2]


@product_all_with_price.post(validators=(valid_token, validate_product), permission='add')
def add_product(request):
    new_product = request.validated['product']
    db = request.db
    new_product.store(db)
    return {'success': 'true'}


@brands.get()
def get_brands(request):
    db = request.db
    if 'name' not in request.params:
        return db.resource('_design', 'product', '_view', 'brand_list').get_json(group=u'true')[2]
    else:
        name = request.params['name']
        name = couchdb_json_encode(name)
        return db.resource('_design', 'product', '_view', 'brand_list').get_json(group=u'true', key=name)[2]