<%def name="navbar()">
    <div class="header" ng-controller="NavBar" ng-init="navbarInit()">
        <div class="navbar navbar-fixed-top navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" ng-click="isNav =!isNav">
                        <span class="glyphicon glyphicon-th-large"></span>
                    </button>
                    <a class="navbar-brand" href="/">立仁泰华</a>
                </div>

                <div class="navbar-collapse" collapse="isNav">
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="产品">
                        </div>
                        <button type="submit" class="btn btn-default">搜索</button>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <li ${'class=active' if request.path == '/' else ''}><a href="/">首页</a></li>
                        <li ${'class=active' if request.path == '/selection' else ''}><a href="/selection">产品选型</a></li>
                        <li ${'class=active' if request.path == '/checkout' else ''}><a href="/checkout">结算</a></li>
                        <li class="sep"></li>
                        <li ng-if="userLogin"><a href="#" ng-bind="userLogin"></a></li>
                        <li ng-if="userLogin"><a href ng-click="logout()">登出</a></li>
                        <li ng-if="!userLogin"><a href="/login">登陆</a></li>
                        <li ng-if="!userLogin" class="btn-navbar"><button class="btn btn-default signup-btn navbar-btn" ng-click="signup()">注册</button></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</%def>


<%def name="navbar_with_sidebar()">
    <div class="header" ng-controller="NavBar">
        <div class="navbar navbar-fixed-top navbar-default" ng-class="{show_menu: show_menu}">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle pull-left" ng-click="toggleMenu()">
                        <span class="glyphicon glyphicon-list"></span>
                    </button>
                    <button type="button" class="navbar-toggle" ng-click="isNav =!isNav">
                        <span class="glyphicon glyphicon-th-large"></span>
                    </button>
                    <a class="navbar-brand" href="/">立仁泰华</a>
                </div>

                <div class="navbar-collapse" collapse="isNav">
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="产品">
                        </div>
                        <button type="submit" class="btn btn-default">搜索</button>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <li ${'class=active' if request.path == '/' else ''}><a href="/">首页</a></li>
                        <li ${'class=active' if request.path == '/selection' else ''}><a href="/selection">产品选型</a></li>
                        <li ${'class=active' if request.path == '/checkout' else ''}><a href="/checkout">结算</a></li>
                        <li class="sep"></li>
                        <li ng-if="userLogin"><a href="#" ng-bind="userLogin"></a></li>
                        <li ng-if="userLogin"><a href ng-click="logout()">登出</a></li>
                        <li ng-if="!userLogin"><a href="/login">登陆</a></li>
                        <li ng-if="!userLogin" class="btn-navbar"><button class="btn btn-default signup-btn navbar-btn" ng-click="signup()">注册</button></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</%def>