'use strict';

angular.module('navbar.controllers', ['ngCookies']).
  controller('NavBar', ['$scope', '$rootScope', '$modal', '$cookies', 'Users', 'User', function($scope, $rootScope, $modal, $cookies, Users, User) {

        $scope.navbarInit = function () {
            var token = $cookies.auth_tkt;
            User.get({token: token}, function (data) {
                $rootScope.userLogin = data.username;
            });
        };

        $scope.toggleMenu = function () {
            $rootScope.show_menu = !$rootScope.show_menu;
        };

        $rootScope.showMenu = function () {
            $rootScope.show_menu = true;
        };

        $rootScope.hideMenu = function () {
            $rootScope.show_menu = false;
        };

        $scope.isNav = true;

        $rootScope.login = function () {
            var loginModal = $modal.open({
                templateUrl: '/static/angular-seed/app/partials/login.html',
                controller: ['$scope', '$modalInstance', '$cookies', 'Users', '$rootScope', function ($scope, $modalInstance, $cookies, Users, $rootScope) {

                    $scope.loginText = "登陆";

                    $scope.loginSubmit = function () {
                        $scope.waitLogin = true;
                        $scope.loginText = "登录中...";
                        var user = new Users($scope.login);
                        user.$login(function (data) {
                            if (data.token) {
                                $cookies.auth_tkt = data.token;
                                $rootScope.userLogin = data.username;
                            }
                            $scope.loginClose();
                            $scope.waitLogin = false;
                            $scope.loginText = "登陆";
                        }, function (data) {
                            $scope.waitLogin = false;
                            $scope.loginText = "登陆";

                            data.data.errors.forEach(function (error) {
                                if (/username_none/g.test(error.name) || /username_invalid/g.test(error.name)) {
                                    $scope.loginUserF = true;
                                }
                                else if (/password_none/g.test(error.name) || /password_invalid/g.test(error.name)) {
                                    $scope.loginPsdF = true;
                                }
                                else if (/username_not_exist/g.test(error.name)) {
                                    $scope.userNExist = true;
                                }
                                else if (/password_error/g.test(error.name)) {
                                    $scope.passError = true;
                                }
                            });
                        });
                    };

                    $scope.rmNUE = function () {
                        $scope.userNExist = false;
                    };

                    $scope.rmPasError = function () {
                        $scope.passError = false;
                    };

                    $scope.loginClose = function () {
                        $modalInstance.dismiss('cancel');
                    };
                }]
            });
        };

        $rootScope.signup = function () {
            location.href = '/signup';
        };

        $scope.logout = function () {
            var token = $cookies.auth_tkt;
            Users.logout({token: token}, function () {
                $cookies.auth_tkt = "";
                $rootScope.userLogin = "";
            }, function () {
                $cookies.auth_tkt = "";
                $rootScope.userLogin = "";
            });
        };

  }]);