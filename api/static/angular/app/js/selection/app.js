'use strict';


// Declare app level module which depends on filters, and services
angular.module('select', ['ui.state', 'select.filters', 'select.services', 'select.directives', 'select.controllers']).
    config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
        $urlRouterProvider.when('', '/').otherwise('/');
        $stateProvider
            .state('index', {
                url: "/",
                views: {
                    "desc": {
                        templateUrl: '/static/angular-seed/app/partials/desc.html',
                        controller:
                            ['$scope', function ($scope) {
                                $scope.brand = "欢迎您选购我们的产品";
                                $scope.desc = "我们的产品提供了必要的参数和足量的图片，希望能帮助您合理选择";
                            }]
                    },
                    "sidebar": {
                        templateUrl: '/static/angular-seed/app/partials/sidebar.html',
                        controller: 'BrandsCtrl'
                    }
                }
            });
    }]);
