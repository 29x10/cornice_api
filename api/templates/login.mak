<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>登陆</title>
    <link rel="shortcut icon" href="${request.static_url('api:static/favicon.ico')}" />
    <!-- Bootstrap -->
    <link href="${request.static_url('api:static/bootstrap/css/bootstrap.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/docs.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/adjust.css')}" rel="stylesheet">
</head>
<body data-spy="scroll" data-target=".bs-docs-sidebar">
<div class="container">
    <div class="row bs-masthead">
        <div class="col-lg-6 col-offset-3">
            <div class="panel panel-primary">
                <div class="panel-heading">登陆</div>
                <div class="row">
                    <div class="col-lg-8 col-offset-2">
                        <form class="form-horizontal">
                            <div class="row">
                                <div class="col-lg-12">
                                    <input type="text" id="mail" placeholder="邮件地址" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <input type="password" id="password" placeholder="密码">
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-12">
                                    <button id="login-submit" class="btn btn-primary btn-block" data-loading-text="登录中..." autocomplete="off">登陆</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script src="${request.static_url('api:static/jquery-1.10.1.min.js')}"></script>
<script src="${request.static_url('api:static/bootstrap/js/bootstrap.min.js')}"></script>
<script src="${request.static_url('api:static/jquery.cookie.js')}"></script>
</body>
</html>