from pyramid.security import authenticated_userid
from pyramid.view import view_config


@view_config(route_name='home', renderer='index.mak')
def my_view(request):
    return {'user_login': authenticated_userid(request)}
