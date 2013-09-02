'use strict';


// Declare app level module which depends on filters, and services
angular.module('select', ['navbar','ui.router.compat', 'select.services', 'select.controllers', 'ngAnimate', 'ngTouch']).
    config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
        $urlRouterProvider.when('', '/').otherwise('/');
        $stateProvider
            .state('index', {
                url: '/',
                abstract: true,
                templateUrl: '/static/angular-seed/app/partials/selection.html',
                controller: 'BrandsCtrl'
            })
            .state('index.about', {
                url: '',
                templateUrl: '/static/angular-seed/app/partials/about.html'
            })
            .state('index.brand', {
                url: 'brand/{brand_name}',
                abstract: true,
                templateUrl: '/static/angular-seed/app/partials/content.html',
                controller: 'DescCtrl'
            })
            .state('index.brand.all', {
                url: '',
                templateUrl: '/static/angular-seed/app/partials/product-list.html',
                controller: 'ProductCtrl'
            })
            .state('index.brand.category', {
                url: '/category/{category_name}',
                templateUrl: '/static/angular-seed/app/partials/product-category-list.html',
                controller: 'ProductCtrl'
            });
    }]).
    run(
        ['$rootScope', '$state', '$stateParams', '$location',
            function ($rootScope, $state, $stateParams, $location) {
                $rootScope.$state = $state;
                $rootScope.$stateParams = $stateParams;
                $rootScope.$location = $location;
            }]);
