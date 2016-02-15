'use strict';

/**
 * Config for the router
 */
angular.module('app')
        .run(run)
        .config(config);

config.$inject = ['$stateProvider', '$urlRouterProvider', 'JQ_CONFIG'];
function config($stateProvider, $urlRouterProvider, JQ_CONFIG) {
    $urlRouterProvider
            .otherwise('/access/signin');

    $stateProvider
            .state('access', {
                url: '/access',
                template: '<div ui-view class="fade-in-right-big smooth"></div>'
            })
            .state('access.signin', {
                url: '/signin',
                templateUrl: 'tpl/page_signin.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['js/controllers/signin.js']);
                        }]
                }
            })
            .state('access.forgotpwd', {
                url: '/forgotpwd',
                templateUrl: 'tpl/page_forgotpwd.html'
            })
            .state('access.logout', {
                url: '/forgotpwd',
                templateUrl: 'tpl/page_forgotpwd.html'
            })
            .state('access.404', {
                url: '/404',
                templateUrl: 'tpl/page_404.html'
            })
            .state('app', {
                abstract: true,
                url: '/app',
                templateUrl: 'tpl/app.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function( $ocLazyLoad){
                          return $ocLazyLoad.load('toaster');
                      }]
                }
            })
            .state('app.org_list', {
                url: '/org_list',
                templateUrl: 'tpl/organization/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/organization/org.js');
                                    }
                            );
                        }]
                }
            })
            .state('app.org_new', {
                url: '/org_new',
                templateUrl: 'tpl/organization/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/organization/org.js']);
                        }]
                }
            })
            .state('app.org_edit', {
                url: '/org_edit/{id}',
                templateUrl: 'tpl/organization/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/organization/org.js']);
                        }]
                }
            })
            .state('app.dashboard-v1', {
                url: '/dashboard-v1',
                templateUrl: 'tpl/app_dashboard_v1.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['js/controllers/chart.js']);
                        }]
                }
            })
            .state('app.inpatient', {
                url: '/inpatient',
                templateUrl: 'tpl/inpatient.html',
                controller: 'XeditableCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('js/controllers/xeditable.js');
                                    }
                            );
                        }]
                }
            })
            .state('app.outpatient', {
                url: '/outpatient',
                templateUrl: 'tpl/outpatient.html',
                controller: 'XeditableCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('js/controllers/xeditable.js');
                                    }
                            );
                        }]
                }
            })
}
run.$inject = ['$rootScope', '$state', '$stateParams', '$location', '$cookieStore', '$http', '$window', 'CommonService'];
function run($rootScope, $state, $stateParams, $location, $cookieStore, $http, $window, CommonService) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;

    var serviceUrl = '';
    if($location.host() == 'ahana.local' || $location.host() == 'localhost'){
        serviceUrl = 'http://ahana.local/IRIS-service/IRISADMIN/web/v1'
    }else if($location.host() == 'demo.arkinfotec.in'){
        serviceUrl = 'http://demo.arkinfotec.in/ahana/demo/IRIS-service/IRISADMIN/web/v1'
    }
    $rootScope.IRISAdminServiceUrl = serviceUrl;
    $rootScope.commonService = CommonService;

    $rootScope.globals = $cookieStore.get('globals') || {};
    if ($rootScope.globals.currentUser) {
        $http.defaults.headers.common['Authorization'] = 'Bearer ' + $rootScope.globals.currentUser.authdata; // jshint ignore:line
    }

    $rootScope.$on('$locationChangeStart', function (event, next, current) {
        var restrictedPage = $.inArray($location.path(), ['/access/signin']) === -1;
        var loggedIn = Boolean($rootScope.globals.currentUser);

        if (restrictedPage && !loggedIn) {
            $location.path('/access/signin');
        } else if (!restrictedPage && loggedIn) {
            $location.path('/app/org_list');
        }
    });
}