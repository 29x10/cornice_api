<%def name="navbar()">
    <div class="header" ng-controller="NavBar">
        <div class="navbar navbar-fixed-top navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" ng-click="isNav =!isNav">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/">立仁泰华</a>
                </div>

                <div class="navbar-collapse" collapse="isNav">
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="产品" autocomplete="off">
                        </div>
                        <button type="submit" class="btn btn-primary">搜索</button>
                    </form>

                    <ul class="nav navbar-nav navbar-right">
                        <li ${'class=active' if request.path == '/' else ''}><a href="/">首页</a></li>
                        <li ${'class=active' if request.path == '/selection' else ''}><a href="/selection">产品选型</a></li>
                        <li ${'class=active' if request.path == '/checkout' else ''}><a href="/checkout">结算</a></li>
                        <li class="sep"></li>
                        %if user_login:
                                <li><a href="#">${user_login}</a></li>
                                <li><a href ng-click="logout()">登出</a>
                                </li>
                        %else:
                                <li><a href ng-click="login()">登陆</a></li>
                                <li><button type="button" class="btn btn-primary navbar-btn">注册</button></li>
                        %endif
                    </ul>



                </div>
            </div>
        </div>

        <div modal="loginOpen" options="opts" close="loginClose()">
            <div class="modal-dialog" ng-include="'/static/angular-seed/app/partials/login.html'"></div>
        </div>

        <div modal="signupOpen" options="opts" close="signupClose()">
            <div class="modal-dialog" ng-include="'/static/angular-seed/app/partials/signup.html'"></div>
        </div>
    </div>
</%def>