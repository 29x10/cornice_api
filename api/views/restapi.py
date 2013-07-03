#coding:utf-8
""" Cornice services.
"""
import json
import re
from cornice import Service
from pyramid.security import remember, authenticated_userid, Allow, Authenticated
from webob import exc
from webob.response import Response
from api.mapping.user import User, manager


VALID_USERNAME = re.compile(r"^[A-Za-z][\w.-]*$")


def _check_acl(request):
    return [(Allow, Authenticated, 'view')]


user_create = Service(name='create_user', path='/users/create', description="create a user", cors_origins=('*',))
user_login_logout = Service(name='user_login_logout', path='/users', description="user login or logout", cors_origins=('*',))
products = Service(name="product", path='/products', description="product management", cors_origins=('*',), acl=_check_acl)


#
# users
#

class _401(exc.HTTPError):
    def __init__(self, msg=u'Unauthorized'):
        body = {'status': 401, 'message': msg}
        Response.__init__(self, json.dumps(body))
        self.status = 401
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
    map_fun = User.by_user.map_fun
    result = db.query(map_fun, key=user_id)
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
    username = request.params.get('username', '')
    password = request.params.get('password', '')
    password_confirm = request.params.get('password_confirm', '')
    if not (username and password and password_confirm):
        request.errors.add('signup', 'not_none', u'用户名或者密码不能为空')
    elif not (VALID_USERNAME.match(username) and (len(username) < 31)):
        request.errors.add('login', 'username_invalid', u'用户名只能以英文字母开头，其余为英文、数字、点、减号和下划线，且不能超过30个字符')
    elif password != password_confirm:
        request.errors.add('signup', 'password_mismatch', u'两次密码不一致')
    else:
        db = request.db
        map_fun = User.by_user.map_fun
        result = db.query(map_fun, key=username)
        if len(result):
            request.errors.add('signup', 'username_exist', u'用户名已经存在')
        else:
            user = User(username=username, password=password)
            request.validated['user'] = user


def login_validate(request):
    username = request.params.get('username', '')
    password = request.params.get('password', '')
    if not (username and password):
        request.errors.add('login', 'not_none', u'用户名或者密码不能为空')
    elif not (VALID_USERNAME.match(username) and (len(username) < 31)):
        request.errors.add('login', 'username_invalid', u'用户名不合法')
    else:
        db = request.db

        map_fun = User.by_user.map_fun
        user = db.query(map_fun, key=username)
        if len(user):
            hashed_password = user.rows[0].value['password']
            if manager.check(hashed_password, password):
                headers = remember(request, username)
                cookie_value = headers[0][1].split(';')[0][:-1][10:]
                user_id = user.rows[0].value['_id']
                user = db[user_id]
                user['token'] = cookie_value
                db[user_id] = user
                request.validated['user'] = user
            else:
                request.errors.add('login', 'password_error', u'密码不正确')
        else:
            request.errors.add('login', 'username_not_exist', u'用户不存在')


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
    return {'username': user['username']}


#
# product
#


@products.get(validators=valid_token, permission="view")
def get_product(request):
    a = 1
    b = 2
    return {}