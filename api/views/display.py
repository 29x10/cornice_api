from pyramid.view import view_config


@view_config(route_name='home', renderer='login.mak')
def my_view(request):
    return {'project': 'Admin'}
