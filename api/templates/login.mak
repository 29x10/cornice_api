<!DOCTYPE html>
<html lang="en" ng-app="login">
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
    <link href="${request.static_url('api:static/login.css')}" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="${request.static_url('api:static/html5shiv.js')}"></script>
    <script src="${request.static_url('api:static/respond.min.js')}"></script>
    <![endif]-->
</head>
<body class="login">
<div class="container">
    <div class="row">
        <div class="col-sm-5 col-sm-offset-1 login-left">
            <h3>立仁泰华</h3>
            <div class="login-list">
                <h1>登陆您的账户</h1>
                <div class="intro-list">
                    <span class="glyphicon glyphicon-check"></span>登陆账户后您方可下单
                </div>
                <div class="intro-list">
                    <span class="glyphicon glyphicon-check"></span>登陆后您可以查看历史订单
                </div>
                <div class="intro-list">
                    <span class="glyphicon glyphicon-check"></span>登陆后您可以对您的账户进行管理
                </div>
            </div>
        </div>
        <div class="col-sm-4 box col-sm-offset-1">
            <form class="form-horizontal" name="loginForm">
                <div class="form-group" ng-class="{'has-error': (loginUserF && !(loginForm.loginUser.$valid)) || userNExist}">
                    <label class="control-label" for="loginUser">用户名: </label>
                    <input class="form-control" type="text" id="loginUser" name="loginUser" placeholder="用户名" autocomplete="off"
                           ng-model="login.user"
                           ng-click="rmNUE()"
                           ng-focus="loginUserF"
                           ng-minlength="6" ng-maxlength="30"
                           ng-pattern="/^[A-Za-z][\w.-]*$/"
                           required>
                    <div class="alert alert-warning" ng-show="loginUserF && loginForm.loginUser.$error.minlength">
                        用户名不能少于6个字符
                    </div>
                    <div class="alert" ng-show="loginUserF && loginForm.loginUser.$error.maxlength">
                        用户名不能多于30个字符
                    </div>
                    <div class="alert" ng-show="loginUserF && loginForm.loginUser.$error.required">
                        用户名不能为空
                    </div>
                    <div class="alert" ng-show="loginUserF && loginForm.loginUser.$error.pattern">
                        用户名只能以英文字母开头，其余为英文、数字、点、减号或者下划线
                    </div>
                    <div class="alert" ng-show="userNExist">
                        用户不存在
                    </div>
                </div>
                <div class="form-group" ng-class="{'has-error': (loginPsdF && !(loginForm.loginPsd.$valid)) || passError}">
                    <label class="control-label" for="loginPsd">密码:</label>
                    <input class="form-control" type="password" id="loginPsd" name="loginPsd" placeholder="密码" autocomplete="off"
                           ng-model="login.password"
                           ng-focus="loginPsdF"
                           ng-click="rmPasError()"
                           ng-minlength="6" ng-maxlength="30"
                           ng-pattern="/^[\w\-\~\`\!\@\#\$\%\^\&\*\(\)\+\=\\\{\}\[\]\|\;\:\'\&quot;\,\.\/\<\>\?]+$/"
                           required>
                    <div class="alert" ng-show="loginPsdF && loginForm.loginPsd.$error.minlength">
                        密码不能少于6个字符
                    </div>
                    <div class="alert" ng-show="loginPsdF && loginForm.loginPsd.$error.maxlength">
                        密码不能多于30个字符
                    </div>
                    <div class="alert" ng-show="loginPsdF && loginForm.loginPsd.$error.required">
                        密码不能为空
                    </div>
                    <div class="alert" ng-show="loginPsdF && loginForm.loginPsd.$error.pattern">
                        密码包含非法字符
                    </div>
                    <div class="alert" ng-show="passError">
                        密码不正确
                    </div>
                </div>
                <div class="forget">
                    <span>没有帐号?</span>
                    <a href="/signup">点击注册</a>
                </div>
                <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-log-in"></span> 登陆</button>
            </form>
        </div>
    </div>
</div>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular-resource.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular-cookies.min.js')}"></script>
<script src="${request.static_url('api:static/angular-bootstrap/ui-bootstrap-tpls-0.5.0-SNAPSHOT.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/custom-ng-focus.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/navbar/compat.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/custom-ng-focus.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/login/app.js')}"></script>
</body>
</html>