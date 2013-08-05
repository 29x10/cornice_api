'use strict';

/* Controllers */


angular.module('select.controllers', [])
    .controller('BrandsCtrl', ['$scope', 'Brands', function ($scope, Brands) {
        Brands.query(function (data) {
            $scope.brands = data.rows;
        });
    }])
    .controller('DescCtrl', ['$scope', '$stateParams', 'Desc', function ($scope, $stateParams, Desc) {
        Desc.query({name: $stateParams.brand_name}, function (data) {
            $scope.desc = data.rows[0]
        });
    }])
    .controller('ProductCtrl', ['$scope', '$stateParams', 'Product', '$rootScope', 'Carts', '$timeout', function ($scope, $stateParams, Product, $rootScope, Carts, $timeout) {
        Product.query({brand: $stateParams.brand_name}, function (data) {
            $scope.products = data.rows;
        });

        var cartItems = $scope.cartItems = Carts.get();

        $scope.add2Cart = function (itemId) {
            if (itemId in $scope.cartItems) {
                $rootScope.cartItemExist = true;
                $timeout(function () {
                    $rootScope.cartItemExist = false;
                }, 1000);
            }
            else {
                $scope.cartItems[itemId] = itemId;
                $rootScope.add2CartSuccess = true;
                $timeout(function () {
                    $rootScope.add2CartSuccess = false;
                }, 1500);
            }
        };

        $scope.clearCart = function () {
            $scope.cartItems = {};
        };

        $scope.$watch('cartItems', function () {
            Carts.put(cartItems);
        }, true);

    }]);

