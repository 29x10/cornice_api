'use strict';

angular.module('login.controllers', ['ngCookies']).
    controller('LoginCtrl', ['$scope', '$cookies', '$timeout', 'Login', function ($scope, $cookies, $timeout, Login) {

        $scope.loginText = "登陆";

        $scope.loginSubmit = function () {
            $scope.waitLogin = true;
            $scope.loginText = "登录中...";
            var user = new Login($scope.login);
            user.$login(function (data) {
                if (data.token) {
                    $cookies.auth_tkt = data.token;
                    $timeout(function() {
                        location.href = '/';
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

    }]);

