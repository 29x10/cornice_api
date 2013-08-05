'use strict';

/* Services */


// Demonstrate how to register services
// In this case it is a simple value service.
angular.module('select.services', ['ngResource'])
    .factory('Brands', ['$resource', function ($resource) {
        return $resource('/brands', {}, {
            query: {method: 'GET', params: {}, isArray: false}
        });
    }])
    .factory('Desc', ['$resource', function ($resource) {
        return $resource('/brand/desc', {}, {
            query: {method: 'GET', params: {}, isArray: false}
        })
    }])
    .factory('Product', ['$resource', function ($resource) {
        return $resource('/products', {}, {
            query: {method: 'GET', params: {}, isArray: false}
        })
    }])
    .factory('Carts', [function () {
        return {
            get: function () {
                return JSON.parse(localStorage.getItem('cart') || '{}');
            },
            put: function (carts) {
                localStorage.setItem('cart', JSON.stringify(carts));
            },
            clear: function () {
                localStorage.setItem('cart', '{}');
            }
        }
    }]);
