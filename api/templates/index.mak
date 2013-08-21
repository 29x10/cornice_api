<!DOCTYPE html>
<html lang="en" ng-app="index">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>立仁泰华 | 首页</title>
    <link rel="shortcut icon" href="${request.static_url('api:static/favicon.ico')}"/>
    <!-- Bootstrap -->
##    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
##    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
<link href="${request.static_url('api:static/bootstrap/css/bootstrap.css')}" rel="stylesheet">
##    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-theme.min.css">
##    <link href="${request.static_url('api:static/docs.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/adjust.css')}" rel="stylesheet">
</head>
<body>
<%namespace name="comp" file="component.mak" />
${comp.navbar()}
<div class="index">
    <div class="bg"></div>
    <div class="container">
        <h1>立仁泰华</h1>
        <p>我们致力于为客户提供优质电气产品以及服务</p>
        <a class="btn btn-primary">关于我们</a>
        <div>您可以先看下我们的<a href="/accounts/sign">选型手册</a></div>
    </div>
</div>

<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular-resource.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular-cookies.min.js')}"></script>
##<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular-resource.min.js"></script>
##<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular-cookies.min.js"></script>
<script src="${request.static_url('api:static/angular-bootstrap/ui-bootstrap-tpls-0.5.0-SNAPSHOT.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/custom-ng-focus.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/navbar/compat.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/index/app.js')}"></script>
</body>
</html>

