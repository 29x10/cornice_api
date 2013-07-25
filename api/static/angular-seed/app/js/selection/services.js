'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('select.services', ['ngResource']).
  factory('Brands', ['$resource', function($resource) {
        return $resource('/brands', {}, {
            query: {method: 'GET', params: {}, isArray: false}
        });
    }]);
