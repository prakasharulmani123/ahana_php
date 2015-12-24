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
                templateUrl: 'tpl/app.html'
            })
            .state('app.org_list', {
                url: '/org_list',
                views: {
                    '': {
                        templateUrl: 'tpl/org_list.html'
                    },
                    'footer': {
                        templateUrl: 'tpl/layout_footer_fullwidth.html'
                    }
                },
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['js/controllers/chart.js']);
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
run.$inject = ['$rootScope', '$state', '$stateParams', '$location', '$cookieStore', '$http', '$window'];
function run($rootScope, $state, $stateParams, $location, $cookieStore, $http, $window) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;

    $rootScope.IRISAdminServiceUrl = 'http://ahana.local/IRIS-service/IRISADMIN/web/v1';

    $rootScope.globals = $cookieStore.get('globals') || {};
    if ($window.sessionStorage.access_token) {
        $http.defaults.headers.common['Authorization'] = 'Basic ' + $window.sessionStorage.access_token; // jshint ignore:line
    }

    $rootScope.$on('$locationChangeStart', function (event, next, current) {
        var restrictedPage = $.inArray($location.path(), ['/access/signin']) === -1;
        var loggedIn = $window.sessionStorage.access_token || false;

        if (restrictedPage && !loggedIn) {
            $location.path('/access/signin');
        }
    });
}
//
//angular.module('app')
//        .factory('authInterceptor', function ($q, $window, $location) {
//            return {
//                request: function (config) {
//                    if ($window.sessionStorage.access_token) {
//                        //HttpBearerAuth
//                        config.headers.Authorization = 'Bearer ' + $window.sessionStorage.access_token;
//                    }
//                    return config;
//                },
//                responseError: function (rejection) {
//                    if (rejection.status === 401) {
//                        $location.path('/login').replace();
//                    }
//                    return $q.reject(rejection);
//                }
//            };
//        });