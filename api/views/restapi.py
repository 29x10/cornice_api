#coding:utf-8
""" Cornice services.
"""
import json
from cornice import Service
from pyramid.security import remember
from webob import exc
from webob.response import Response
from api.mapping.user import User


users = Service(name='users', path='/users', description="account management")


#
# validators
#

class _401(exc.HTTPError):
    def __init__(self, msg=u'Unauthorized'):
        body = {'status': 401, 'message': msg}
        Response.__init__(self, json.dumps(body))
        self.status = 401
        self.content_type = 'application/json'


def valid_token(request):
    pass


def unique(request):
    username = request.params.get('username', '')
    password = request.params.get('password', '')
    password_confirm = request.params.get('password_confirm', '')
    if not (username and password and password_confirm):
        request.errors.add('signup', 'not_none', u'用户名或者密码不能为空')
    elif password != password_confirm:
        request.errors.add('signup', 'not_match', u'两次密码不一致')
    else:
        ## get the target db
        settings = request.registry.settings
        db = settings['CouchDB.server'][settings['CouchDB.db_name']]

        map_fun = User.by_user.map_fun
        result = db.query(map_fun, key=username)
        if len(result):
            request.errors.add('signup', 'username', u'用户名已经存在')
        else:
            user = User(username=username, password=password)
            request.validated['user'] = user


@users.post(validators=unique)
def create_user(request):
    user = request.validated['user']
    headers = remember(request, user.username)
    cookie_value = headers[0][1].split(';')[0][:-1][10:]
    user.token = cookie_value

    settings = request.registry.settings
    db = settings['CouchDB.server'][settings['CouchDB.db_name']]
    user.store(db)
    return {'auth_tkt': cookie_value}