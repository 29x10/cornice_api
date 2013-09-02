'use strict';

angular.module('login.services', ['ngResource']).
    factory('Login', ['$resource', function ($resource) {
        return $resource('/users', {}, {
            login: {method: 'POST'}
        })
    }]);