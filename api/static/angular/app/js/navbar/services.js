'use strict';

angular.module('navbar.services', ['ngResource']).
    factory('SignUp', ['$resource', function ($resource) {
        return $resource('/users/create', {}, {
            signup: {method: 'POST'}
        });
    }]).
    factory('Login', ['$resource', function ($resource) {
        return $resource('/users', {}, {
            login: {method: 'POST'},
            logout: {method: 'GET'}
        })
    }]);
