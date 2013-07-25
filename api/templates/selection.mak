<%block name="title">
    <title>产品选型</title>
</%block>

<%block name="extra_js">
    <script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular.js')}"></script>
    <script src="${request.static_url('api:static/angular-seed/app/lib/angular/angular-resource.js')}"></script>
    <script src="${request.static_url('api:static/angular-ui-router.js')}"></script>
    <script src="${request.static_url('api:static/angular-seed/app/js/app.js')}"></script>
    <script src="${request.static_url('api:static/angular-seed/app/js/services.js')}"></script>
    <script src="${request.static_url('api:static/angular-seed/app/js/controllers.js')}"></script>
    <script src="${request.static_url('api:static/angular-seed/app/js/filters.js')}"></script>
    <script src="${request.static_url('api:static/angular-seed/app/js/directives.js')}"></script>
</%block>

<%inherit file="base.mak" />
<div ng-app="select">
    <div ui-view="desc"></div>
    <div class="container bs-docs-container">
        <div class="row">
            <div class="col-lg-3">
                <div ui-view="sidebar"></div>

            </div>
            <div class="col-lg-9">
            </div>
        </div>
    </div>
</div>