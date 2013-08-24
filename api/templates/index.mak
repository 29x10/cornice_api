<!DOCTYPE html>
<html lang="en" ng-app="index">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>立仁泰华 | 首页</title>
    <link rel="shortcut icon" href="${request.static_url('api:static/favicon.ico')}"/>
    <!-- Bootstrap -->
##    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="${request.static_url('api:static/bootstrap/css/bootstrap.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/base.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/navbar.css')}" rel="stylesheet">
    <link href="${request.static_url('api:static/index.css')}" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="${request.static_url('api:static/html5shiv.js')}"></script>
    <script src="${request.static_url('api:static/respond.min.js')}"></script>
    <![endif]-->
</head>
<body>
<%namespace name="comp" file="component.mak" />
${comp.navbar()}
<header class="index">
    <div class="bg"></div>
    <div class="container">
        <h1>立仁泰华</h1>
        <p>我们致力于为客户提供优质电气产品以及服务</p>
        <a class="btn btn-primary">关于我们</a>
        <div>您可以先看下我们的<a href="/accounts/sign">选型手册</a></div>
    </div>
</header>
<section class="intro">
    <h2>我们的优势</h2>
    <div class="container">
        <div class="row">
            <div class="col col-sm-4">
                <div>
                    <h4>科学管理模式</h4>
                    <p>
                        做到客户下单、提需求、查订单方便快捷，销售人员报价迅速
                    </p>
                </div>
            </div>
            <div class="col col-sm-4">
                <div>
                    <h4>尽可能低的价格</h4>
                    <p>
                        我们期待与客户长期合作，扩大需求量来解决盈利问题
                    </p>
                </div>
            </div>
            <div class="col col-sm-4">
                <div>
                    <h4>良好的服务</h4>
                    <p>
                        提供优质产品、提高备货速度，做好物流及售后服务
                    </p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col col-sm-4">
                <div>
                    <h4>强大的站内搜索能力</h4>
                    <p>
                        通过站内搜索，用户可以很方便的找到自己想要的产品
                    </p>
                </div>
            </div>
            <div class="col col-sm-4">
                <div>
                    <h4>全平台浏览</h4>
                    <p>
                        我们为平板和手机做了特别的优化，提高用户的浏览体验
                    </p>
                </div>
            </div>
            <div class="col col-sm-4">
                <div>
                    <h4>丰富的产品经验</h4>
                    <p>
                        立仁泰华在北京电气行业有近二十年的销售经验
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<footer>
    <div class="container">
        <div class="row">
            <div class="col-lg-7">
                <p>联系地址: 北京市西城区西四北大街157号838-839</p>
            </div>
            <div class="col-lg-2">
                <p>销售电话: 010-66170526</p>
            </div>
            <div class="col-lg-2">
                <p>传真: 010-66131728</p>
            </div>
        </div>
    </div>
</footer>

<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-resource.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-cookies.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-route.min.js"></script>
<script src="${request.static_url('api:static/angular-bootstrap/ui-bootstrap-tpls-0.5.0-SNAPSHOT.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/lib/custom-ng-focus.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/navbar/compat.min.js')}"></script>
<script src="${request.static_url('api:static/angular-seed/app/js/index/app.js')}"></script>
</body>
</html>

