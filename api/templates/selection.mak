<!DOCTYPE html>
<html lang="en" ng-app="select">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>立仁泰华 | 产品选型</title>
    <link rel="shortcut icon" href="${request.static_url('api:static/favicon.ico')}"/>
    <!-- Bootstrap -->
##    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="${request.static_url('api:static/bootstrap/css/bootstrap.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/base.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/navbar.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/selection.css')}" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="${request.static_url('api:static/html5shiv.js')}"></script>
    <script src="${request.static_url('api:static/respond.min.js')}"></script>
    <![endif]-->
</head>
<body>
<%namespace name="comp" file="component.mak" />
${comp.navbar_with_sidebar()}
<div class="container" ui-view></div>

<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-route.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-resource.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-cookies.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-animate.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-touch.min.js"></script>
<script src="${request.static_url('api:static/angular-bootstrap/ui-bootstrap-tpls-0.5.0-SNAPSHOT.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular-ui-router.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/navbar/compat-min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/selection/app.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/selection/controllers.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/selection/services.js')}"></script>
</body>
</html>