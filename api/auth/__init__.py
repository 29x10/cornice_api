from pyramid.security import Authenticated, Everyone
from tokenlib import TokenManager

__author__ = 'binleixue'

class MozillaTokenLibAuthenticationPolicy(object):

    def _clean_principal(self, princid):
        if princid in (Authenticated, Everyone):
            princid = None
        return princid


    def __init__(self,
                 secret,
                 callback=None,
                 timeout=None,
                 hashmod=None,
                 cookie_name='auth_tkt'):
        self.manager = TokenManager(secret=secret,
                                    timeout=timeout,
                                    hashmod=hashmod)
        self.callback = callback
        self.cookie_name = cookie_name


    def authenticated_userid(self, request):
        userid = self.unauthenticated_userid(request)

        if userid is None:
            return None
        if self._clean_principal(userid):
            return None
        if self.callback is None:
            return None
        callback_ok = self.callback(userid, request)
        if callback_ok is not None:
            return userid
        else:
            return None


    def unauthenticated_userid(self, request):
        cookie = request.cookies.get(self.cookie_name)
        try:
            data = self.manager.parse_token(cookie)
        except ValueError:
            return None
        return data['userid']


    def effective_principals(self, request):

        effective_principals = [Everyone]
        userid = self.unauthenticated_userid(request)

        if userid is None:
            return effective_principals
        if self._clean_principal(userid):
            return effective_principals
        if self.callback is None:
            groups = []
        else:
            groups = self.callback(userid, request)

        if groups is None:
            return effective_principals

        effective_principals.append(Authenticated)
        effective_principals.append(userid)
        effective_principals.extend(groups)

        return effective_principals



    def remember(self, request, principal, **kw):
        return self.manager.make_token({'userid': principal})


    def forget(self, request):
        pass