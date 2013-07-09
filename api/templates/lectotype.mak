<%block name="title">
    <title>产品选型</title>
</%block>

<%block name="extra_js">
    <script src="${request.static_url('api:static/build/JSXTransformer.js')}"></script>
    <script src="${request.static_url('api:static/build/react.js')}"></script>
    <script type="text/jsx" src="${request.static_url('api:static/product-display.js')}"></script>
</%block>

<%inherit file="base.mak" />
<div id="lectotype"></div>