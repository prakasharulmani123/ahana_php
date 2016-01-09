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
            //SIGNIN
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
            //FORGOT PASSWORD
            .state('access.forgotpwd', {
                url: '/forgotpwd',
                templateUrl: 'tpl/page_forgotpwd.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['js/controllers/signin.js']);
                        }]
                }
            })
            //RESET PASSWORD
            .state('access.resetpwd', {
                url: '/resetpwd?token=',
                templateUrl: 'tpl/page_resetpwd.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['js/controllers/signin.js']);
                        }]
                }
            })
            //LOGOUT
            .state('access.logout', {
                url: '/forgotpwd',
                templateUrl: 'tpl/page_forgotpwd.html'
            })
            //404 PAGE
            .state('access.404', {
                url: '/404',
                templateUrl: 'tpl/page_404.html'
            })

            .state('configuration', {
                abstract: true,
                url: '/configuration',
                templateUrl: 'tpl/configuration.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('toaster');
                        }]
                }
            })
            //CONFIGURATION ROLES
            .state('configuration.roles', {
                url: '/roles',
                templateUrl: 'tpl/roles/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/roles/roles.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.role_create', {
                url: '/role_create',
                templateUrl: 'tpl/roles/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/roles/roles.js']);
                        }]
                }
            })
            .state('configuration.role_update', {
                url: '/role_update/{id}',
                templateUrl: 'tpl/roles/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/roles/roles.js']);
                        }]
                }
            })
            //ORGANIZATION VIEW
            .state('configuration.organization', {
                url: '/organization',
                templateUrl: 'tpl/organization/index.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/organization/org.js']);
                        }]

                }
            })
            //CONFIGURATION USER REGISTRATION
            .state('configuration.registration', {
                url: '/registration',
                templateUrl: 'tpl/registration/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/registration/registration.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.user_create', {
                url: '/user_create',
                templateUrl: 'tpl/registration/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/registration/registration.js']);
                        }]
                }
            })
            .state('configuration.user_update', {
                url: '/user_update/{id}',
                templateUrl: 'tpl/registration/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/registration/registration.js']);
                        }]
                }
            })
            //CONFIGURATION LOGIN UPDATE
            .state('configuration.login_update', {
                url: '/login_update/{id}',
                templateUrl: 'tpl/registration/login_update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/registration/registration.js']);
                        }]
                }
            })
            //CONFIGURATION MODULES
            .state('configuration.organizationModule', {
                url: '/organizationModule',
                templateUrl: 'tpl/organization_module/index.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/organization_module/org_module.js']);
                        }]

                }
            })
            //CONFIGURATION ROLES MODULES ASSIGN
            .state('configuration.roleRights', {
                url: '/roleRights',
                templateUrl: 'tpl/role_rights/index.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/role_rights/role_rights.js']);
                        }]
                }
            })
            //CONFIGURATION USERS ROLES ASSIGN
            .state('configuration.userRoles', {
                url: '/userRoles',
                templateUrl: 'tpl/user_roles/index.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/user_roles/user_roles.js']);
                        }]
                }
            })
		//CONFIGURATION FLOOR
            .state('configuration.floors', {
                url: '/floors',
                templateUrl: 'tpl/floors/index.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/floors/floors.js']);
                        }]
                }
            })
            .state('configuration.floor_create', {
                url: '/floor_create',
                templateUrl: 'tpl/floors/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/floors/floors.js']);
                        }]
                }
            })
            .state('configuration.floor_update', {
                url: '/floor_update/{id}',
                templateUrl: 'tpl/floors/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/floors/floors.js']);
                        }]
                }
            })
            
            //Room Maintenance
            .state('configuration.roomMaintenance', {
                url: '/roomMaintenance',
                templateUrl: 'tpl/room_maintenance/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_maintenance/room_maintenance.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.roomMaintenanceCreate', {
                url: '/roomMaintenanceCreate',
                templateUrl: 'tpl/room_maintenance/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room_maintenance/room_maintenance.js']);
                        }]
                }
            })
            .state('configuration.roomMaintenanceUpdate', {
                url: '/roomMaintenanceUpdate',
                templateUrl: 'tpl/room_maintenance/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room_maintenance/room_maintenance.js']);
                        }]
                }
            })
}
run.$inject = ['$rootScope', '$state', '$stateParams', '$location', '$cookieStore', '$http', '$window', 'CommonService'];
function run($rootScope, $state, $stateParams, $location, $cookieStore, $http, $window, CommonService) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;

    var serviceUrl = '';
    if ($location.host() == 'ahana.local' || $location.host() == 'localhost') {
        serviceUrl = 'http://ahana.local/IRIS-service/IRISORG/web/v1'
    } else if ($location.host() == 'demo.arkinfotec.in') {
        serviceUrl = 'http://demo.arkinfotec.in/ahana/demo/IRIS-service/IRISORG/web/v1'
    }
    $rootScope.IRISOrgServiceUrl = serviceUrl;
    $rootScope.commonService = CommonService;

    $rootScope.globals = $cookieStore.get('globals') || {};
    if ($window.sessionStorage.access_token) {
        $http.defaults.headers.common['Authorization'] = 'Bearer ' + $window.sessionStorage.access_token; // jshint ignore:line
    }

    $rootScope.$on('$locationChangeStart', function (event, next, current) {
        if ($location.path() == '/access/resetpwd') {
            var token = $location.search().token;
            $rootScope.commonService.GetPasswordResetAccess(token, function (response) {
                if (response.success === false) {
//                    $scope.authError = response.message;
                    $location.path('/access/signin');
                }
            });
        } else {
            var restrictedPage = $.inArray($location.path(), ['/access/signin', '/access/forgotpwd', '/access/resetpwd']) === -1;
            var loggedIn = $window.sessionStorage.access_token || false;
            if (restrictedPage && !loggedIn) {
                $location.path('/access/signin');
            } else if (!restrictedPage && loggedIn) {
                $location.path('/app/org_list');
            }
        }
    });
}