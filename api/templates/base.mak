<!DOCTYPE html>
<html lang="en" ng-app="boot">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <%block name="title" />
    <link rel="shortcut icon" href="${request.static_url('api:static/favicon.ico')}"/>
    <!-- Bootstrap -->
    <link href="${request.static_url('api:static/bootstrap/css/bootstrap.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/icons/css/bootstrap-glyphicons.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/docs.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/adjust.css')}" rel="stylesheet">
    <%block name="extra_css" />
</head>
<body>
<div class="header" ng-controller="NavBar">
    <div class="navbar navbar-inverse navbar-fixed-top bs-docs-nav">
        <div class="container">

            <button type="button" class="navbar-toggle collapsed" ng-click="isNav =!isNav">
                <span class="glyphicon glyphicon-list"></span>
            </button>
            <button type="button" class="navbar-toggle collapsed" ng-click="isSearch =!isSearch">
                <span class="glyphicon glyphicon-search"></span>
            </button>

            <a class="navbar-brand" href="/">立仁泰华</a>

            <div class="nav-collapse nav-bar collapse" collapse="isNav">
                <ul class="nav navbar-nav">

                        %if user_login:
                            <li><a href="#"><span class="glyphicon glyphicon-user"></span> ${user_login}</a></li>
                            <li><a href ng-click="logout()"><span class="glyphicon glyphicon-eject"></span> 登出</a></li>
                        %else:
                            <li><a href ng-click="login()">登陆</a></li>
                            <li><a href ng-click="signup()">注册</a></li>
                        %endif

                </ul>
                <ul class="nav navbar-nav">
                    <li ${'class=active' if request.path == '/' else ''}><a href="/"><span
                            class="glyphicon glyphicon-home"></span> 首页</a></li>
                    <li ${'class=active' if request.path == '/selection' else ''}><a href="/selection"><span
                            class="glyphicon glyphicon-book"></span> 产品选型</a></li>
                </ul>

            </div>
            <!-- /.nav-collapse -->
            <div class="nav-collapse search-bar collapse" collapse="isSearch">
                <form class="navbar-form" action="">
                    <div class="input-group">
                        <input type="text" placeholder="搜索">
                        <span class="input-group-btn">
                            <button class="btn" type="button">搜索</button>
                        </span>
                    </div>
                </form>
            </div>
        </div>
        <!-- /.container -->
    </div>


    <div class="hide" modal="loginOpen" options="opts" close="loginClose()">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="loginClose()">&times;</button>
                    <h4 class="modal-title">登陆</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" name="loginForm">
                        <div class="login-row row" ng-class="{'has-error': (loginUserF && !(loginForm.loginUser.$valid)) || userNExist}">
                            <label class="col-lg-2 control-label" for="loginUser">用户名</label>

                            <div class="col-lg-10">
                                <input class="input-with-feedback" type="text" id="loginUser" name="loginUser" placeholder="用户名"
                                       ng-model="login.user"
                                       ng-click="rmNUE()"
                                       ng-focus="loginUserF"
                                       ng-minlength="6" ng-maxlength="30"
                                       ng-pattern="/^[A-Za-z][\w.-]*$/"
                                       required>
                                <div class="alert" ng-show="loginUserF && loginForm.loginUser.$error.minlength">
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
                        </div>
                        <div class="login-row row" ng-class="{'has-error': (loginPsdF && !(loginForm.loginPsd.$valid)) || passError}">
                            <label class="col-lg-2 control-label" for="loginPsd">密码</label>

                            <div class="col-lg-10">
                                <input class="input-with-feedback" type="password" id="loginPsd" name="loginPsd" placeholder="密码"
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
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" ng-click="loginClose()">取消</button>
                    <button id="login-submit" class="btn btn-primary" autocomplete="off"
                            ng-disabled="waitLogin"
                            ng-click="loginSubmit()">
                        {{loginText}}
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dalog -->
    </div>
    <!-- /.modal -->

    <div class="hide" modal="signupOpen" options="opts" close="signupClose()">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="signupClose()">&times;</button>
                    <h4 class="modal-title">注册</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" name="signupForm">
                        <div class="signup-row row" ng-class="{'has-error': (signupUserF && !(signupForm.signupUser.$valid)) || userExist}">
                            <label class="col-lg-2 control-label" for="signupUser">用户名</label>

                            <div class="col-lg-10">
                                <input class="input-with-feedback" type="text" id="signupUser" name="signupUser" placeholder="用户名"
                                       ng-model="signup.user"
                                       ng-focus="signupUserF"
                                       ng-click="rmUE()"
                                       ng-minlength="6" ng-maxlength="30"
                                       ng-pattern="/^[A-Za-z][\w.-]*$/"
                                       required>
                                <div class="alert" ng-show="signupUserF && signupForm.signupUser.$error.minlength">
                                    用户名不能少于6个字符
                                </div>
                                <div class="alert" ng-show="signupUserF && signupForm.signupUser.$error.maxlength">
                                    用户名不能多于30个字符
                                </div>
                                <div class="alert" ng-show="signupUserF && signupForm.signupUser.$error.required">
                                    用户名不能为空
                                </div>
                                <div class="alert" ng-show="signupUserF && signupForm.signupUser.$error.pattern">
                                    用户名只能以英文字母开头，其余为英文、数字、点、减号或者下划线
                                </div>
                                <div class="alert" ng-show="userExist">
                                    用户名已经存在
                                </div>

                            </div>
                        </div>
                        <div class="signup-row row" ng-class="{'has-error': signupPsdF && !(signupForm.signupPsd.$valid)}">
                            <label class="col-lg-2 control-label" for="password1s">密码</label>

                            <div class="col-lg-10">
                                <input class="input-with-feedback" type="password" id="signupPsd" name="signupPsd" placeholder="密码"
                                       ng-model="signup.password"
                                       ng-focus="signupPsdF"
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
                        </div>
                        <div class="signup-row row" ng-class="{'has-error': signupPsddF && (!(signupForm.signupPsdd.$valid) || (signup.password != signup.passwordConfirm))}">
                            <label class="col-lg-2 control-label" for="signupPsdd">确认密码</label>

                            <div class="col-lg-10">
                                <input class="input-with-feedback" type="password" id="signupPsd1" name="signupPsdd" placeholder="确认密码"
                                       ng-model="signup.passwordConfirm"
                                       ng-focus="signupPsddF"
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
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" ng-click="signupClose()">取消</button>
                    <button id="signup-submit" class="btn btn-primary" autocomplete="off"
                            ng-disabled="waitSign"
                            ng-click="signupSubmit()">
                        {{signupText}}
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dalog -->
    </div>
    <!-- /.modal -->
</div>


    ${self.body()}

##<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular.min.js"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular.js')}"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular-resource.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.0.7/angular-cookies.min.js"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/ui-bootstrap-tpls-0.4.0.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/custom-ng-focus.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/navbar/controllers.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/navbar/services.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/index/app.js')}"></script>
    <%block name="extra_js" />
</body>
</html>