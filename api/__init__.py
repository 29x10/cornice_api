"""Main entry point
"""
import hashlib
from urllib import quote
from couchdb.client import Server
from pyelasticsearch.client import ElasticSearch
from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy
from pyramid.config import Configurator
from pyramid.events import NewRequest
from pyramid.security import Allow, Everyone
from api.auth import MozillaTokenLibAuthenticationPolicy
from api.mapping.user import groupfinder


def add_couchdb_to_request(event):
    request = event.request
    settings = request.registry.settings
    db = settings['CouchDB.server'][settings['CouchDB.db_name']]
    event.request.db = db
    event.request.es = settings['ES.server']
    if 'token' in request.params:
        token = request.params.get('token', '')
        cookie_value = 'auth_tkt = %s' % token
        request.headers['Cookie'] = str(cookie_value)
        request.token = token


class RootFactory(object):
    __acl__ = [
        (Allow, Everyone, 'view')]

    def __init__(self, request):
        pass


def main(global_config, **settings):
    auth_token = MozillaTokenLibAuthenticationPolicy(secret='what_makes_so_secret', hashmod=hashlib.sha256, callback=groupfinder, timeout=86400)
    auth_permission = ACLAuthorizationPolicy()
    config = Configurator(settings=settings,
                          root_factory=RootFactory)
    config.set_authentication_policy(auth_token)
    config.set_authorization_policy(auth_permission)
    db_server = Server(url=settings['CouchDB.url'])
    es_server = ElasticSearch(settings['ES.url'])
    if settings['CouchDB.db_name'] not in db_server:
        db_server.create(settings['CouchDB.db_name'])
    config.registry.settings['CouchDB.server'] = db_server
    config.registry.settings['ES.server'] = es_server
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.include("cornice")
    config.add_subscriber(add_couchdb_to_request, NewRequest)
    config.add_route('home', '/')
    config.scan("api.views.restapi")
    config.scan("api.views.display")
    return config.make_wsgi_app()
