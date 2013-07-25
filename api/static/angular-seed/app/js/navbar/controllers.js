'use strict';

angular.module('navbar.controllers', ['ngCookies']).
  controller('NavBar', ['$scope', 'SignUp', '$cookieStore', 'Login', function($scope, SignUp, $cookieStore, Login) {

        $scope.isNav = true;
        $scope.isSearch = true;
        $scope.signupText = "注册";
        $scope.loginText = "登陆";


        $scope.login = function () {
            $scope.loginOpen = true;
        };

        $scope.signup = function () {
            $scope.signupOpen = true;
        };

        $scope.opts = {
            backdropFade: true,
            dialogFade:true
        };



        $scope.loginClose = function () {
            $scope.loginOpen = false;
        };

        $scope.signupClose = function () {
            $scope.signupOpen = false;
        };

        $scope.signupSubmit = function () {
            $scope.waitSign = true;
            $scope.signupText = "注册中...";
            var newUser = new SignUp($scope.signup);
            newUser.$signup(function (data) {
                if (data.token){
                    $cookieStore.put('auth_tkt', data.token);
                    setTimeout(function() {
                        $scope.signupOpen = false;
                        location.reload();
                    }, 500);
                }
                else {
                    $scope.waitSign = false;
                    $scope.signupText = "注册";
                }
            }, function (data) {
                data.data.errors.forEach(function (error) {
                    if (/username_exist/g.test(error.name)) {
                        $scope.userExist = true;
                    }
                    else if (/username_none/g.test(error.name) || /username_invalid/g.test(error.name)) {
                        $scope.signupUserF = true;
                    }
                    else if (/password_none/g.test(error.name) || /password_invalid/g.test(error.name)) {
                        $scope.signupPsdF = true;
                    }
                    else if (/password_confirm_none/g.test(error.name) || /password_confirm_invalid/g.test(error.name) || /password_mismatch/g.test(error.name)) {
                        $scope.signupPsddF = true;
                    }
                });
                $scope.waitSign = false;
                $scope.signupText = "注册";
            });
        };

        $scope.rmUE = function () {
            $scope.userExist = false;
        };

        $scope.loginSubmit = function () {
            $scope.waitLogin = true;
            $scope.loginText = "登录中...";
            var user = new Login($scope.login);
            user.$login(function (data) {
                if (data.token) {
                    $cookieStore.put('auth_tkt', data.token);
                    setTimeout(function() {
                        $scope.loginOpen = false;
                        location.reload();
                    }, 500);
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
            var token = $cookieStore.get('auth_tkt');
            var user = new Login({token: token});
            Login.logout({token: token}, function (data) {
                $cookieStore.remove('auth_tkt');
                setTimeout(function() {
                    location.reload();
                }, 500);
            }, function () {
                $cookieStore.remove('auth_tkt');
                $cookieStore.remove('auth_tkt');
                setTimeout(function() {
                    location.reload();
                }, 500);
            });
        }


  }]);