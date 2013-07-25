'use strict';

/* Controllers */


angular.module('select.controllers', []).
  controller('BrandsCtrl', ['$scope', 'Brands', function($scope, Brands) {
        $scope.brands = Brands.query();
  }]);

