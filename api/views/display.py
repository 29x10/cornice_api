from pyramid.security import authenticated_userid
from pyramid.view import view_config
from api.mapping.product import Product


@view_config(route_name='home', renderer='index.mak')
def my_view(request):
    return {'user_login': authenticated_userid(request)}


@view_config(name='selection', renderer='selection.mak')
def selection(request):
    return dict(user_login=authenticated_userid(request))