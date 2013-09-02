'use strict';

angular.module('signup.controllers', ['ngCookies']).
    controller('SignupCtrl', ['$scope', '$cookies', '$timeout', 'Signup', function ($scope, $cookies, $timeout, Signup) {

        $scope.signupText = "注册";

        $scope.signupSubmit = function () {
            $scope.waitSign = true;
            $scope.signupText = "注册中...";
            var newUser = new Signup($scope.signup);
            newUser.$signup(function (data) {
                if (data.token){
                    $cookies.auth_tkt = data.token;
                    $timeout(function() {
                        location.href = '/';
                    }, 10);
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

    }]);


