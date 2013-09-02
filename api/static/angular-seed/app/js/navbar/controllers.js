'use strict';

angular.module('navbar.controllers', ['ngCookies']).
  controller('NavBar', ['$scope', 'Users', '$cookies', '$rootScope', '$timeout', function($scope, Users, $cookies, $rootScope, $timeout) {

        $scope.toggleMenu = function () {
            $rootScope.show_menu = !$rootScope.show_menu;
        };

        $scope.isNav = true;
        $scope.signupText = "注册";
        $scope.loginText = "登陆";


        $rootScope.login = function () {
            $scope.loginOpen = true;
        };

        $rootScope.signup = function () {
            location.href = '/signup';
        };

        $scope.opts = {
            backdropFade: true,
            dialogFade:true
        };

        $scope.loginClose = function () {
            $scope.loginOpen = false;
        };

        $scope.loginSubmit = function () {
            $scope.waitLogin = true;
            $scope.loginText = "登录中...";
            var user = new Users($scope.login);
            user.$login(function (data) {
                if (data.token) {
                    $cookies.auth_tkt = data.token;
                    $timeout(function() {
                        $scope.loginOpen = false;
                        location.reload();
                    }, 10);
                }
                else {
                    $scope.waitLogin = false;
                    $scope.loginText = "登陆";
                }
            }, function (data) {
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
                $scope.waitLogin = false;
                $scope.loginText = "登陆";
            });
        };

        $scope.rmNUE = function () {
            $scope.userNExist = false;
        };

        $scope.rmPasError = function () {
            $scope.passError = false;
        };

        $scope.logout = function () {
            var token = $cookies.auth_tkt;
            Users.logout({token: token}, function () {
                $cookies.auth_tkt = "";
                $timeout(function() {
                    location.reload();
                }, 10);
            }, function () {
                $cookies.auth_tkt = "";
                $timeout(function() {
                    location.reload();
                }, 10);
            });
        };

  }]);