'use strict';

angular.module('signup.services', ['ngResource']).
    factory('Signup', ['$resource', function ($resource) {
        return $resource('/users', {}, {
            signup: {method: 'PUT'}
        })
    }]);
