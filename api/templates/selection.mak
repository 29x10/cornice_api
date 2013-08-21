<!DOCTYPE html>
<html lang="en" ng-app="select">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>立仁泰华 | 产品选型</title>
    <link rel="shortcut icon" href="${request.static_url('api:static/favicon.ico')}"/>
    <!-- Bootstrap -->
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">

##    <link href="${request.static_url('api:static/docs.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/adjust.css')}" rel="stylesheet">
</head>
<body>
<%namespace name="comp" file="component.mak" />
${comp.navbar()}
<div class="container bs-docs-container" ui-view ng-animate="{enter:'slide-reveal'}"></div>

##<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular.min.js"></script>
##<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular-resource.min.js"></script>
##<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular-cookies.min.js"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular-resource.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular-cookies.min.js')}"></script>
<script src="${request.static_url('api:static/angular-bootstrap/ui-bootstrap-tpls-0.5.0-SNAPSHOT.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular-ui-router.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/custom-ng-focus.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/navbar/compat.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/selection/app.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/selection/controllers.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/selection/services.js')}"></script>
</body>
</html>