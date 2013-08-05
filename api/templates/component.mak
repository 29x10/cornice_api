<%def name="navbar()">
    <div class="header" ng-controller="NavBar">
        <div class="navbar navbar-inverse navbar-fixed-top bs-docs-nav">
            <div class="container">

                <button type="button" class="navbar-toggle" ng-click="isNav =!isNav">
                    <span class="glyphicon glyphicon-list"></span>
                </button>
                <button type="button" class="navbar-toggle" ng-click="isSearch =!isSearch">
                    <span class="glyphicon glyphicon-search"></span>
                </button>

                <a class="navbar-brand" href="/">立仁泰华</a>

                <div class="nav-collapse nav-bar" collapse="isNav">
                    <ul class="nav navbar-nav">

                            %if user_login:
                                <li><a href="#"><span class="glyphicon glyphicon-user"></span> ${user_login}</a></li>
                                <li><a href ng-click="logout()"><span class="glyphicon glyphicon-eject"></span> 登出</a>
                                </li>
                            %else:
                                <li><a href ng-click="login()">登陆</a></li>
                                <li>
                                    <button type="button" class="btn btn-primary navbar-btn" href ng-click="signup()">
                                        注册
                                    </button>
                                </li>
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
                <div class="nav-collapse search-bar" collapse="isSearch">
                    <form class="navbar-form" action="">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="产品">
                        <span class="input-group-btn">
                            <button class="btn btn-default btn-success" type="button">搜索</button>
                        </span>
                        </div>
                    </form>
                </div>
            </div>
            <!-- /.container -->
        </div>


        <div modal="loginOpen" options="opts" close="loginClose()">
            <div class="modal-dialog" ng-include="'/static/angular-seed/app/partials/login.html'"></div>
        </div>

        <div modal="signupOpen" options="opts" close="signupClose()">
            <div class="modal-dialog" ng-include="'/static/angular-seed/app/partials/signup.html'"></div>
        </div>
    </div>
</%def>