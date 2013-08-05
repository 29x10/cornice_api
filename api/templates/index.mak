<!DOCTYPE html>
<html lang="en" ng-app="index">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>立仁泰华 | 首页</title>
    <link rel="shortcut icon" href="${request.static_url('api:static/favicon.ico')}"/>
    <!-- Bootstrap -->
##    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/css/bootstrap.min.css" rel="stylesheet">

    <link href="${request.static_url('api:static/bootstrap/css/bootstrap.min.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/icons/css/bootstrap-glyphicons.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/docs.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/adjust.css')}" rel="stylesheet">
</head>
<body>
<%namespace name="comp" file="component.mak" />
${comp.navbar()}
<div class="container">
    <div class="bs-masthead">

        <h1>立仁泰华</h1>
        <p class="lead">我们致力于为客户提供优质电气产品以及服务</p>
        <p>
            <a href="#" class="btn btn-large btn-bs">关于我们</a>
        </p>

        <div class="bs-social">
            <ul class="bs-social-buttons">
                <li class="follow-btn">
                    <a href="https://twitter.com/twbootstrap" class="twitter-follow-button" data-link-color="#0069D6" data-show-count="true">Follow @twbootstrap</a>
                </li>
                <li class="tweet-btn">
                    <a href="https://twitter.com/share" class="twitter-share-button" data-url="http://twitter.github.com/bootstrap/" data-count="horizontal" data-via="twbootstrap" data-related="mdo:Creator of Twitter Bootstrap">Tweet</a>
                </li>
            </ul>
        </div>


        <ul class="bs-masthead-links">
        </ul>

    </div>
</div>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular-resource.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular-cookies.min.js')}"></script>
##<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular-resource.min.js"></script>
##<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.1.5/angular-cookies.min.js"></script>
<script src="${request.static_url('api:static/angular-bootstrap/ui-bootstrap-tpls-0.5.0-SNAPSHOT.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/custom-ng-focus.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/navbar/controllers.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/navbar/services.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/index/app.js')}"></script>
</body>
</html>

