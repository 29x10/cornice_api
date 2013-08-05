'use strict';

angular.module('navbar.services', ['ngResource']).
    factory('Users', ['$resource', function ($resource) {
        return $resource('/users', {}, {
            login: {method: 'POST'},
            logout: {method: 'GET'},
            signup: {method: 'PUT'}
        })
    }]);
