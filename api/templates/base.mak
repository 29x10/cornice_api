<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <%block name="title" />
    <link rel="shortcut icon" href="${request.static_url('api:static/favicon.ico')}" />
    <!-- Bootstrap -->
    <link href="${request.static_url('api:static/bootstrap/css/bootstrap.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/docs.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/adjust.css')}" rel="stylesheet">
</head>
<body data-spy="scroll" data-target=".bs-sidebar">
<div class="navbar navbar-inverse navbar-fixed-top bs-docs-nav">
    <div class="container">
##        <div class="btn-group navbar-btn">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".nav-bar">
                <span class="glyphicon glyphicon-list"></span>
            </button>
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".search-bar">
                <span class="glyphicon glyphicon-search"></span>
            </button>
##        </div>
        <a class="navbar-brand" href="/">后台管理中心</a>
        <div class="nav-collapse nav-bar collapse">
            <ul class="nav navbar-nav pull-right">
                <li><a href="#">你好，${user_login}</a> </li>
                <li><a href="/logout">登出</a></li>

            </ul>
            <ul class="nav navbar-nav">
                <li class="active"><a href="#"><span class="glyphicon glyphicon-home"></span> 后台</a></li>
            </ul>

        </div><!-- /.nav-collapse -->
        <div class="nav-collapse search-bar collapse">
            <form class="navbar-form" action="">
                <div class="input-group">
                    <input type="text" placeholder="搜索">
                    <span class="input-group-btn">
                        <button class="btn" type="button">搜索</button>
                    </span>
                </div>
            </form>
        </div>
    </div><!-- /.container -->
</div>


<div class="modal fade" id="login">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">登陆</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="row">
                        <label class="col-lg-2 control-label" for="usernamel">用户名</label>
                        <div class="col-lg-10">
                            <input type="text" id="usernamel" placeholder="用户名">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-lg-2 control-label" for="passwordl">密码</label>
                        <div class="col-lg-10">
                            <input type="password" id="passwordl" placeholder="密码">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="login-submit" class="btn btn-primary" data-loading-text="登录中..." autocomplete="off">登陆</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dalog -->
</div><!-- /.modal -->

<div class="modal fade" id="signup">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">注册</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="row">
                        <label class="col-lg-2 control-label" for="usernames">用户名</label>
                        <div class="col-lg-10">
                            <input type="text" id="usernames" placeholder="用户名">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-lg-2 control-label" for="passwords1">密码</label>
                        <div class="col-lg-10">
                            <input type="password" id="passwords1" placeholder="密码">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-lg-2 control-label" for="passwords2">确认密码</label>
                        <div class="col-lg-10">
                            <input type="password" id="passwords2" placeholder="确认密码">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="signup-submit" class="btn btn-primary" data-loading-text="注册中..." autocomplete="off">注册</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dalog -->
</div><!-- /.modal -->

<!--navbar-->
${self.body()}
<script src="${request.static_url('api:static/jquery-1.10.1.min.js')}"></script>
<script src="${request.static_url('api:static/bootstrap/js/bootstrap.min.js')}"></script>
<script src="${request.static_url('api:static/application.js')}"></script>
<script src="${request.static_url('api:static/jquery.cookie.js')}"></script>
</body>
</html>