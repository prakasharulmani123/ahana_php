// config

var app =
        angular.module('app')
        .config(config);

config.$inject = ['$controllerProvider', '$compileProvider', '$filterProvider', '$provide', 'ivhTreeviewOptionsProvider'];
function config($controllerProvider, $compileProvider, $filterProvider, $provide, ivhTreeviewOptionsProvider) {
    // lazy controller, directive and service
    app.controller = $controllerProvider.register;
    app.directive = $compileProvider.directive;
    app.filter = $filterProvider.register;
    app.factory = $provide.factory;
    app.service = $provide.service;
    app.constant = $provide.constant;
    app.value = $provide.value;

    ivhTreeviewOptionsProvider.set({
        idAttribute: 'id',
        labelAttribute: 'label',
        childrenAttribute: 'items',
        selectedAttribute: 'selected',
//        useCheckboxes: true,
//        expandToDepth: 0,
//        indeterminateAttribute: '__ivhTreeviewIndeterminate',
//        defaultSelectedState: true,
//        validate: true,
        twistieExpandedTpl: '<span class="glyphicon glyphicon-chevron-right"></span>',
        twistieCollapsedTpl: '<span class="glyphicon glyphicon-chevron-down"></span>',
        twistieLeafTpl: '&#9679;',
//        nodeTpl: '...'
    });
}