<!DOCTYPE html>
<html lang="en" ng-app="signup">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>立仁泰华 | 登陆</title>
    <link rel="shortcut icon" href="${request.static_url('api:static/favicon.ico')}"/>
    <!-- Bootstrap -->
##    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="${request.static_url('api:static/bootstrap/css/bootstrap.css')}" rel="stylesheet">
##    <link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css" rel="stylesheet">
##    <link href="${request.static_url('api:static/font-awesome/css/font-awesome.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/base.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/signup.css')}" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="${request.static_url('api:static/html5shiv.js')}"></script>
    <script src="${request.static_url('api:static/respond.min.js')}"></script>
    <![endif]-->
</head>
<body class="signup" ng-controller="SignupCtrl">
<div class="container">
    <div class="row">
        <div class="col-sm-5 col-sm-offset-1 signup-left">
            <h3>立仁泰华</h3>
            <div class="login-list">
                <h1>创建您的账户</h1>
                <div class="intro-list">
                    <span class="glyphicon glyphicon-check"></span>注册我们的账户方便您查看并管理您的订单信息
                </div>
                <div class="intro-list">
                    <span class="glyphicon glyphicon-check"></span>注册我们的账户您可以在线进行下单
                </div>
                <div class="intro-list">
                    <span class="glyphicon glyphicon-check"></span>注册我们的账户可以为您提供更优质的服务
                </div>
            </div>
        </div>
        <div class="col-sm-4 box col-sm-offset-1">
            <form class="form-horizontal" name="signupForm">
                <div class="form-group"
                     ng-class="{'has-error': (signupUserF && !(signupForm.signupUser.$valid)) || userExist}">
                    <label class="control-label" for="signupUser">用户名</label>

                    <input class="form-control" type="text" id="signupUser" name="signupUser" placeholder="用户名"
                           autocomplete="off"
                           ng-model="signup.user"
                           ng-focus="signupUserF=true"
                           ng-blur="signupUserF=false"
                           ng-click="rmUE()"
                           ng-minlength="2" ng-maxlength="30"
                           ng-pattern="/^[A-Za-z0-9\u4e00-\u9fa5][\u4e00-\u9fa5\w.-@]*$/"
                           required>

                    <div class="alert" ng-show="signupUserF && signupForm.signupUser.$error.minlength">
                        用户名不能少于2个字符
                    </div>
                    <div class="alert" ng-show="signupUserF && signupForm.signupUser.$error.maxlength">
                        用户名不能多于30个字符
                    </div>
                    <div class="alert" ng-show="signupUserF && signupForm.signupUser.$error.required">
                        用户名不能为空
                    </div>
                    <div class="alert" ng-show="signupUserF && signupForm.signupUser.$error.pattern">
                        用户名只能以中英文数字开头，其余为中英文、数字、点、减号、@或者下划线
                    </div>
                    <div class="alert" ng-show="userExist">
                        用户名已经存在
                    </div>

                </div>
                <div class="form-group" ng-class="{'has-error': signupPsdF && !(signupForm.signupPsd.$valid)}">
                    <label class="control-label" for="signupPsd">密码</label>

                    <input class="form-control" type="password" id="signupPsd" name="signupPsd" placeholder="密码"
                           autocomplete="off"
                           ng-model="signup.password"
                           ng-focus="signupPsdF=true"
                           ng-blur="signupPsdF=false"
                           ng-minlength="6" ng-maxlength="30"
                           ng-pattern="/^[\w\-\~\`\!\@\#\$\%\^\&\*\(\)\+\=\\\{\}\[\]\|\;\:\'\&quot;\,\.\/\<\>\?]+$/"
                           required>

                    <div class="alert" ng-show="signupPsdF && signupForm.signupPsd.$error.minlength">
                        密码不能少于6个字符
                    </div>
                    <div class="alert" ng-show="signupPsdF && signupForm.signupPsd.$error.maxlength">
                        密码不能多于30个字符
                    </div>
                    <div class="alert" ng-show="signupPsdF && signupForm.signupPsd.$error.required">
                        密码不能为空
                    </div>
                    <div class="alert" ng-show="signupPsdF && signupForm.signupPsd.$error.pattern">
                        密码包含非法字符
                    </div>
                </div>
                <div class="form-group"
                     ng-class="{'has-error': signupPsddF && (!(signupForm.signupPsdd.$valid) || (signup.password != signup.passwordConfirm))}">
                    <label class="control-label" for="signupPsd1">确认密码</label>

                    <input class="form-control" type="password" id="signupPsd1" name="signupPsdd" placeholder="确认密码"
                           autocomplete="off"
                           ng-model="signup.passwordConfirm"
                           ng-focus="signupPsddF=true"
                           ng-blur="signupPsddF=false"
                           ng-minlength="6" ng-maxlength="30"
                           ng-pattern="/^[\w\-\~\`\!\@\#\$\%\^\&\*\(\)\+\=\\\{\}\[\]\|\;\:\'\&quot;\,\.\/\<\>\?]+$/"
                           required>

                    <div class="alert" ng-show="signupPsddF && signupForm.signupPsdd.$error.minlength">
                        密码不能少于6个字符
                    </div>
                    <div class="alert" ng-show="signupPsddF && signupForm.signupPsdd.$error.maxlength">
                        密码不能多于30个字符
                    </div>
                    <div class="alert" ng-show="signupPsddF && signupForm.signupPsdd.$error.required">
                        密码不能为空
                    </div>
                    <div class="alert" ng-show="signupPsddF && signupForm.signupPsdd.$error.pattern">
                        密码包含非法字符
                    </div>
                    <div class="alert" ng-show="signupPsddF && (signup.password != signup.passwordConfirm)">
                        两次密码不一致
                    </div>
                </div>
                <div class="forget">
                    <span>已有帐号?</span>
                    <a href="/login">点击登陆</a>
                </div>
                <a href="/" type="button" class="btn btn-default">返回首页</a>
                <button type="submit" class="btn btn-primary" ng-disabled="waitSignup || !(signupForm.$valid)" ng-click="signupSubmit()">
                    <span class="glyphicon glyphicon-log-in"></span> {{ signupText }}
                </button>
            </form>
        </div>
    </div>
</div>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-resource.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-cookies.min.js"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/signup/controllers.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/signup/services.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/signup/app.js')}"></script>
</body>
</html>