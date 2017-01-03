'use strict';

/**
 * Config for the router
 */

angular.module('app')
        .run(run)
        .config(config);

config.$inject = ['$stateProvider', '$urlRouterProvider', '$httpProvider', 'ivhTreeviewOptionsProvider', 'JQ_CONFIG', 'hotkeysProvider', '$compileProvider'];
function config($stateProvider, $urlRouterProvider, $httpProvider, ivhTreeviewOptionsProvider, JQ_CONFIG, hotkeysProvider, $compileProvider) {

//    hotkeysProvider.template = '<div class="my-own-cheatsheet">Hai</div>';

    $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|chrome-extension):/);

    ivhTreeviewOptionsProvider.set({
        twistieExpandedTpl: '<i class="fa fa-caret-right"></i>',
        twistieCollapsedTpl: '<i class="fa fa-caret-down"></i>',
        twistieLeafTpl: '',
    });

//    var newBaseUrl = "";
//
//    if (window.location.hostname == "localhost") {
//        newBaseUrl = "http://hms.ark/api/IRISORG/web/v1";
//    } else {
////        var deployedAt = window.location.href.substring(0, window.location.href);
//        newBaseUrl = "http://demo.arkinfotec.in/ahana/demo/api/IRISORG/web/v1";
//    }
//    RestangularProvider.setBaseUrl(newBaseUrl);

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
            })
            //401 PAGE
            .state('configuration.401', {
                url: '/401',
                templateUrl: 'tpl/page_401.html'
            })

            //CONFIGURATION ROLES
            .state('configuration.roles', {
                url: '/roles',
                templateUrl: 'tpl/roles/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/roles/roles.js');
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
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/organization/org.js');
                                    }
                            );
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
                            return $ocLazyLoad.load('tpl/registration/registration.js');
                        }]
                }
            })
            .state('configuration.user_create', {
                url: '/user_create',
                templateUrl: 'tpl/registration/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load([
                                'tpl/registration/registration.js',
                                'tpl/modal_form/modal.country.js',
                                'tpl/modal_form/modal.state.js',
                                'tpl/modal_form/modal.city.js'
                            ]);
                        }]
                }
            })
            .state('configuration.user_update', {
                url: '/user_update/{id}',
                templateUrl: 'tpl/registration/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load([
                                'tpl/registration/registration.js',
                                'tpl/modal_form/modal.country.js',
                                'tpl/modal_form/modal.state.js',
                                'tpl/modal_form/modal.city.js'
                            ]);
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
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/organization_module/org_module.js');
                                    }
                            );
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
            //CONFIGURATION USER BRANCHES ASSIGN
            .state('configuration.userBranches', {
                url: '/userBranches',
                templateUrl: 'tpl/user_branches/index.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/user_branches/user_branches.js']);
                        }]
                }
            })
            //CONFIGURATION FLOOR
            .state('configuration.floors', {
                url: '/floors',
                templateUrl: 'tpl/floors/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/floors/floors.js');
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
                url: '/roomMaintenanceUpdate/{id}',
                templateUrl: 'tpl/room_maintenance/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room_maintenance/room_maintenance.js']);
                        }]
                }
            })
            //CONFIGURATION WARD
            .state('configuration.wards', {
                url: '/wards',
                templateUrl: 'tpl/wards/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/wards/wards.js');
                        }]
                }
            })
            .state('configuration.ward_create', {
                url: '/ward_create',
                templateUrl: 'tpl/wards/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/wards/wards.js']);
                        }]
                }
            })
            .state('configuration.ward_update', {
                url: '/ward_update/{id}',
                templateUrl: 'tpl/wards/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/wards/wards.js']);
                        }]
                }
            })
            //CONFIGURATION ROOM CHARGE CATEGORY
            .state('configuration.roomChargeCategory', {
                url: '/roomChargeCategory',
                templateUrl: 'tpl/room_charge_category/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge_category/room_charge_category.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.roomChargeCategoryCreate', {
                url: '/roomChargeCategoryCreate',
                templateUrl: 'tpl/room_charge_category/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge_category/room_charge_category.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.roomChargeCategoryUpdate', {
                url: '/roomChargeCategoryUpdate/{id}',
                templateUrl: 'tpl/room_charge_category/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge_category/room_charge_category.js');
                                    }
                            );
                        }]
                }
            })
            //CONFIGURATION ALLIED CHARGE
            .state('configuration.alliedCharge', {
                url: '/alliedCharge',
                params: {
                    code: 'ALC',
                },
                templateUrl: 'tpl/room_charge_category_custom/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge_category_custom/room_charge_category_custom.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.alliedChargeCreate', {
                url: '/alliedChargeCreate/{cat_id}',
                templateUrl: 'tpl/room_charge_category_custom/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge_category_custom/room_charge_category_custom.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.alliedChargeUpdate', {
                url: '/alliedChargeUpdate/{cat_id}/{id}',
                templateUrl: 'tpl/room_charge_category_custom/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge_category_custom/room_charge_category_custom.js');
                                    }
                            );
                        }]
                }
            })
            //CONFIGURATION PROCEDURE CHARGE
            .state('configuration.procedure', {
                url: '/procedure',
                params: {
                    code: 'PRC',
                },
                templateUrl: 'tpl/room_charge_category_custom/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge_category_custom/room_charge_category_custom.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.procedureChargeCreate', {
                url: '/procedureChargeCreate/{cat_id}',
                templateUrl: 'tpl/room_charge_category_custom/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge_category_custom/room_charge_category_custom.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.procedureChargeUpdate', {
                url: '/procedureChargeUpdate/{cat_id}/{id}',
                templateUrl: 'tpl/room_charge_category_custom/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge_category_custom/room_charge_category_custom.js');
                                    }
                            );
                        }]
                }
            })

            //CONFIGURATION ROOM CHARGE CATEGORY ITEM
            .state('configuration.roomChargeCategoryItem', {
                url: '/roomChargeCategoryItem',
                templateUrl: 'tpl/room_charge_category_item/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/room_charge_category_item/room_charge_category_item.js');
                        }]
                }
            })
            .state('configuration.roomChargeCategoryItemCreate', {
                url: '/roomChargeCategoryItemCreate',
                templateUrl: 'tpl/room_charge_category_item/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room_charge_category_item/room_charge_category_item.js']);
                        }]
                }
            })
            .state('configuration.roomChargeCategoryItemUpdate', {
                url: '/roomChargeCategoryItemUpdate/{id}',
                templateUrl: 'tpl/room_charge_category_item/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room_charge_category_item/room_charge_category_item.js']);
                        }]
                }
            })
            //Room Types
            .state('configuration.roomType', {
                url: '/roomType',
                templateUrl: 'tpl/room_type/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_type/room_type.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.roomTypeCreate', {
                url: '/roomTypeCreate',
                templateUrl: 'tpl/room_type/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room_type/room_type.js']);
                        }]
                }
            })
            .state('configuration.roomTypeUpdate', {
                url: '/roomTypeUpdate/{id}',
                templateUrl: 'tpl/room_type/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room_type/room_type.js']);
                        }]
                }
            })

            //Room
            .state('configuration.room', {
                url: '/room',
                templateUrl: 'tpl/room/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/room/room.js');
                        }]
                }
            })
            .state('configuration.roomCreate', {
                url: '/roomCreate',
                templateUrl: 'tpl/room/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room/room.js']);
                        }]
                }
            })
            .state('configuration.roomUpdate', {
                url: '/roomUpdate/{id}',
                templateUrl: 'tpl/room/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room/room.js']);
                        }]
                }
            })
            .state('configuration.updateMaintenance', {
                url: '/updateMaintenance/{id}',
                templateUrl: 'tpl/room/update_maintenance.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room/room.js']);
                        }]
                }
            })
            //Room Charge
            .state('configuration.roomCharge', {
                url: '/roomCharge',
                templateUrl: 'tpl/room_charge/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge/room_charge.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.roomChargeCreate', {
                url: '/roomChargeCreate',
                templateUrl: 'tpl/room_charge/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room_charge/room_charge.js']);
                        }]
                }
            })
            .state('configuration.roomChargeUpdate', {
                url: '/roomChargeUpdate/{id}',
                templateUrl: 'tpl/room_charge/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room_charge/room_charge.js']);
                        }]
                }
            })
            //Room and Room Type
            .state('configuration.roomTypeRoom', {
                url: '/roomTypeRoom',
                templateUrl: 'tpl/room_types_rooms/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_types_rooms/room_types_rooms.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.roomTypeRoomUpdate', {
                url: '/roomTypeRoomUpdate/{room_id}',
                templateUrl: 'tpl/room_types_rooms/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/room_types_rooms/room_types_rooms.js']);
                        }]
                }
            })

            //Speciality
            .state('configuration.specialities', {
                url: '/specialities',
                templateUrl: 'tpl/specialities/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/specialities/speciality.js');
                        }]
                }
            })
            .state('configuration.specialityCreate', {
                url: '/specialityCreate',
                templateUrl: 'tpl/specialities/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/specialities/speciality.js']);
                        }]
                }
            })
            .state('configuration.specialityUpdate', {
                url: '/specialityUpdate/{id}',
                templateUrl: 'tpl/specialities/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/specialities/speciality.js']);
                        }]
                }
            })
            //CONFIGURATION MASTER COUNTRY
            .state('configuration.countries', {
                url: '/countries',
                templateUrl: 'tpl/countries/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/countries/countries.js');
                        }]
                }
            })
            .state('configuration.countryCreate', {
                url: '/countryCreate',
                templateUrl: 'tpl/countries/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/countries/countries.js']);
                        }]
                }
            })
            .state('configuration.countryUpdate', {
                url: '/countryUpdate/{id}',
                templateUrl: 'tpl/countries/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/countries/countries.js']);
                        }]
                }
            })
            //CONFIGURATION MASTER STATE
            .state('configuration.states', {
                url: '/states',
                templateUrl: 'tpl/states/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/states/states.js');
                        }]
                }
            })
            .state('configuration.stateCreate', {
                url: '/stateCreate',
                templateUrl: 'tpl/states/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/states/states.js']);
                        }]
                }
            })
            .state('configuration.stateUpdate', {
                url: '/stateUpdate/{id}',
                templateUrl: 'tpl/states/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/states/states.js']);
                        }]
                }
            })
            //CONFIGURATION MASTER CITY
            .state('configuration.cities', {
                url: '/cities',
                templateUrl: 'tpl/cities/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/cities/cities.js');
                        }]
                }
            })
            .state('configuration.cityCreate', {
                url: '/cityCreate',
                templateUrl: 'tpl/cities/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/cities/cities.js']);
                        }]

                }
            })
            .state('configuration.cityUpdate', {
                url: '/cityUpdate/{id}',
                templateUrl: 'tpl/cities/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/cities/cities.js']);
                        }]
                }
            })
            //CONFIGURATION ALERTS
            .state('configuration.alerts', {
                url: '/alerts',
                templateUrl: 'tpl/alerts/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/alerts/alerts.js');
                        }]
                }
            })
            .state('configuration.alertCreate', {
                url: '/alertCreate',
                templateUrl: 'tpl/alerts/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/alerts/alerts.js']);
                        }]

                }
            })
            .state('configuration.alertUpdate', {
                url: '/alertUpdate/{id}',
                templateUrl: 'tpl/alerts/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/alerts/alerts.js']);
                        }]
                }
            })

            //Patient Category
            .state('configuration.patientCategories', {
                url: '/patientCategories',
                templateUrl: 'tpl/patient_categories/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/patient_categories/patient_category.js');
                        }]
                }
            })
            .state('configuration.patientCategoryCreate', {
                url: '/patientCategoryCreate',
                templateUrl: 'tpl/patient_categories/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_categories/patient_category.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.patientCategoryUpdate', {
                url: '/patientCategoryUpdate/{id}',
                templateUrl: 'tpl/patient_categories/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_categories/patient_category.js']);
                        }]
                }
            })
            //CONFIGURATION CHARGES FOR CATEGORY
            .state('configuration.chargePerCategory', {
                url: '/charge_per_category',
                templateUrl: 'tpl/charge_per_category/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/charge_per_category/charge_per_category.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.chargePerCategoryCreate', {
                url: '/chargePerCategoryCreate',
                templateUrl: 'tpl/charge_per_category/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/charge_per_category/charge_per_category.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.chargePerCategoryUpdate', {
                url: '/chargePerCategoryUpdate/{id}',
                templateUrl: 'tpl/charge_per_category/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/charge_per_category/charge_per_category.js');
                                    }
                            );
                        }]
                }
            })

            //Bill-No Prefix
            .state('configuration.internalCode', {
                url: '/internalCode',
                templateUrl: 'tpl/internal_code/index.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/internal_code/internal_code.js']);
                        }]
                }
            })

            //CONFIGURATION DOCTOR SCHEDULE
            .state('configuration.docSchedule', {
                url: '/docSchedule',
                templateUrl: 'tpl/doctor_schedule/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/doctor_schedule/doctor_schedule.js');
                                    }
                            );
                        }]
                }
            })
            .state('configuration.docScheduleCreate', {
                url: '/docScheduleCreate',
                templateUrl: 'tpl/doctor_schedule/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/doctor_schedule/doctor_schedule.js');
                                    }
                            );
                        }]
                }
            })

            //CONFIGURATION PATIENT GROUPING
            .state('configuration.patientgroup', {
                url: '/patientgroup',
                templateUrl: 'tpl/patient_groups/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('tpl/patient_groups/patient_groups.js');
                        }]
                }
            })
            .state('configuration.patientgroupCreate', {
                url: '/patientgroupCreate',
                templateUrl: 'tpl/patient_groups/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_groups/patient_groups.js']);
                        }]

                }
            })
            .state('configuration.patientgroupUpdate', {
                url: '/patientgroupUpdate/{id}',
                templateUrl: 'tpl/patient_groups/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_groups/patient_groups.js']);
                        }]
                }
            })

            //PATIENT
            .state('patient', {
                abstract: true,
                url: '/patient',
                templateUrl: 'tpl/patient.html',
            })
            .state('patient.registration', {
                url: '/registration',
                templateUrl: 'tpl/patient_registration/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load([
                                'tpl/patient_registration/patient_registration.js',
                                'tpl/modal_form/modal.country.js',
                                'tpl/modal_form/modal.state.js',
                                'tpl/modal_form/modal.city.js'
                            ]);
                        }]
                }
            })
            .state('patient.view', {
                url: '/view/{id}',
                templateUrl: 'tpl/patient/view.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient/patient.js']);
                        }]
                }
            })
            //PATIENT UPDATE
            .state('patient.update', {
                url: '/update/{id}',
                templateUrl: 'tpl/patient/update_patient.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient/patient_update.js']);
                        }]
                }
            })
            //PATIENT MODIFY CASESHEET NO
            .state('patient.modifyCaseSheetNo', {
                url: '/modifyCaseSheetNo/{id}',
                templateUrl: 'tpl/patient/modify_case_sheet.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient/patient_casesheet.js']);
                        }]
                }
            })

            //PATIENT ENCOUNTER
            .state('patient.encounter', {
                url: '/encounter/{id}',
                templateUrl: 'tpl/patient_encounter/encounters.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'xeditable']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_encounter/encounter.js');
                                    }
                            );
                        }]
                }
            })
            //PATIENT APPOINTMENT
            .state('patient.appointment', {
                url: '/appointment/{id}',
                templateUrl: 'tpl/patient_appointment/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_appointment/patient_appointment.js');
                                    }
                            );
                        }]
                }
            })

            //PATIENT TRANSFER
            .state('patient.transfer', {
                url: '/transfer/{id}/{enc_id}',
                templateUrl: 'tpl/patient_admission/transfer.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_admission/patient_admission.js');
                                    }
                            );
                        }]
                }
            })

            //PATIENT DISCHARGE
            .state('patient.discharge', {
                url: '/discharge/{id}/{enc_id}',
                templateUrl: 'tpl/patient_admission/discharge.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_admission/patient_admission.js');
                                    }
                            );
                        }]
                }
            })

            //PATIENT SWAPPING
            .state('patient.swapping', {
                url: '/swapping/{id}/{enc_id}',
                templateUrl: 'tpl/patient_admission/swapping.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_admission/patient_admission.js');
                                    }
                            );
                        }]
                }
            })

            //ADMISSION UPDATE
            .state('patient.update_admission', {
                url: '/update_admission/{id}/{enc_id}',
                templateUrl: 'tpl/patient_admission/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_admission/patient_admission.js');
                                    }
                            );
                        }]
                }
            })

            // In-Patient
            .state('patient.inPatients', {
                url: '/inPatients',
                templateUrl: 'tpl/in_patients/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'ui.select']).then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'tpl/in_patients/in_patients.js',
                                            'tpl/modal_form/modal.patient_consultant_visit.js',
                                            'tpl/modal_form/modal.patient_procedures.js'
                                        ]);
                                    }
                            );
                        }]
                }
            })

            // Out-Patient
            .state('patient.outPatients', {
                url: '/outPatients',
                templateUrl: 'tpl/out_patients/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'xeditable']).then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'tpl/out_patients/out_patients.js',
                                            'tpl/modal_form/modal.patient_appointment_reschedule.js'
                                        ]);
                                    }
                            );
                        }]
                }
            })

            // In-Patient - Admission
            .state('patient.admission', {
                url: '/admission/{id}',
                templateUrl: 'tpl/patient_admission/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_admission/patient_admission.js']);
                        }]
                }
            })
            //PATIENT PROCEDURE
            .state('patient.procedure', {
                url: '/procedure/{id}',
                templateUrl: 'tpl/patient_procedure/procedures.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'ui.select']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_procedure/procedure.js');
                                    }
                            );
                        }]
                }
            })
            //PATIENT ADD PROCEDURE
            .state('patient.add_procedure', {
                url: '/add_procedure/{id}/{enc_id}',
                templateUrl: 'tpl/patient_procedure/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'ui.select']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_procedure/procedure.js');
                                    }
                            );
                        }]
                }
            })
            //PATIENT Edit PROCEDURE
            .state('patient.edit_procedure', {
                url: '/edit_procedure/{id}/{proc_id}',
                templateUrl: 'tpl/patient_procedure/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'ui.select']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_procedure/procedure.js');
                                    }
                            );
                        }]
                }
            })

            //Encounter change appointment status - OP
            .state('patient.changeStatus', {
                url: '/changeStatus/{id}/{enc_id}',
                templateUrl: 'tpl/patient_appointment/change_status.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'ui.select']).then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'tpl/patient_appointment/patient_appointment.js',
                                            'tpl/modal_form/modal.patient_future_appointment.js'
                                        ]);
                                    }
                            );
                        }]
                }
            })

            //Encounter Edit Doctor Fee - OP
            .state('patient.editDoctorFee', {
                url: '/editDoctorFee/{id}/{enc_id}',
                templateUrl: 'tpl/patient_appointment/edit_doctor_fee.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'ui.select']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_appointment/patient_appointment.js');
                                    }
                            );
                        }]
                }
            })

            //Patient Alert
            .state('patient.alert', {
                url: '/alert/{id}',
                templateUrl: 'tpl/patient_alert/index.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_alert/patient_alert.js');
                                    }
                            );
                        }]
                }
            })

            //Patient Alert Create
            .state('patient.alertCreate', {
                url: '/alertCreate/{id}',
                templateUrl: 'tpl/patient_alert/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_alert/patient_alert.js']);
                        }]
                }
            })

            //Patient Alert Create
            .state('patient.alertUpdate', {
                url: '/alertUpdate/{id}/{alert_id}',
                templateUrl: 'tpl/patient_alert/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_alert/patient_alert.js']);
                        }]
                }
            })

            //Patient Notes
            .state('patient.notes', {
                url: '/notes/{id}',
                templateUrl: 'tpl/patient_notes/index.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_notes/patient_notes.js');
                                    }
                            );
                        }]
                }
            })

            //Patient Note Create
            .state('patient.noteCreate', {
                url: '/noteCreate/{id}',
                templateUrl: 'tpl/patient_notes/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_notes/patient_notes.js']);
                        }]
                }
            })

            //Patient Note Update
            .state('patient.noteUpdate', {
                url: '/noteUpdate/{id}/{note_id}',
                templateUrl: 'tpl/patient_notes/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_notes/patient_notes.js']);
                        }]
                }
            })

            //Patient Note View
            .state('patient.noteView', {
                url: '/noteView/{id}/{note_id}',
                templateUrl: 'tpl/patient_notes/view.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_notes/patient_notes.js']);
                        }]
                }
            })

            //Patient Consultant
            .state('patient.consultant', {
                url: '/consultant/{id}',
                templateUrl: 'tpl/patient_consultant/index.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'ui.select']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_consultant/patient_consultant.js');
                                    }
                            );
                        }]
                }
            })

            //Patient Note Create
            .state('patient.consultantCreate', {
                url: '/consultantCreate/{id}/{enc_id}',
                templateUrl: 'tpl/patient_consultant/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_consultant/patient_consultant.js']);
                        }]
                }
            })

            //Patient Note Update
            .state('patient.consultantUpdate', {
                url: '/consultantUpdate/{id}/{cons_id}',
                templateUrl: 'tpl/patient_consultant/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_consultant/patient_consultant.js']);
                        }]
                }
            })

            //PHARMACY
            .state('pharmacy', {
                abstract: true,
                url: '/pharmacy',
                templateUrl: 'tpl/pharmacy.html'
            })
            //PHARMACY BRAND
            .state('pharmacy.brand', {
                url: '/brand',
                templateUrl: 'tpl/pharmacy_brand/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_brand/pharmacy_brand.js');
                                    }
                            );
                        }]
                }
            })
            //PHARMACY BRAND CREATE
            .state('pharmacy.brandCreate', {
                url: '/brandCreate',
                templateUrl: 'tpl/pharmacy_brand/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_brand/pharmacy_brand.js']);
                        }]
                }
            })

            //PHARMACY BRAND UPDATE
            .state('pharmacy.brandUpdate', {
                url: '/brandUpdate/{id}',
                templateUrl: 'tpl/pharmacy_brand/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_brand/pharmacy_brand.js']);
                        }]
                }
            })

            //PHARMACY BRAND REP
            .state('pharmacy.brandrep', {
                url: '/brandrep',
                templateUrl: 'tpl/pharmacy_brandrep/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_brandrep/pharmacy_brandrep.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY BRAND REP CREATE
            .state('pharmacy.brandrepCreate', {
                url: '/brandrepCreate',
                templateUrl: 'tpl/pharmacy_brandrep/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_brandrep/pharmacy_brandrep.js']);
                        }]
                }
            })

            //PHARMACY BRAND REP UPDATE
            .state('pharmacy.brandrepUpdate', {
                url: '/brandrepUpdate/{id}',
                templateUrl: 'tpl/pharmacy_brandrep/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_brandrep/pharmacy_brandrep.js']);
                        }]
                }
            })
            //PHARMACY BRAND Division
            .state('pharmacy.brandDivision', {
                url: '/brandDivision',
                templateUrl: 'tpl/pharmacy_brand_division/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_brand_division/pharmacy_brand_division.js');
                                    }
                            );
                        }]
                }
            })
            //PHARMACY BRAND Division CREATE
            .state('pharmacy.brandDivisionCreate', {
                url: '/brandDivisionCreate',
                templateUrl: 'tpl/pharmacy_brand_division/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_brand_division/pharmacy_brand_division.js']);
                        }]
                }
            })

            //PHARMACY BRAND Division UPDATE
            .state('pharmacy.brandDivisionUpdate', {
                url: '/brandDivisionUpdate/{id}',
                templateUrl: 'tpl/pharmacy_brand_division/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_brand_division/pharmacy_brand_division.js']);
                        }]
                }
            })

            //PHARMACY DRUG CLASS
            .state('pharmacy.drugclass', {
                url: '/drugclass',
                templateUrl: 'tpl/pharmacy_drugclass/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_drugclass/pharmacy_drugclass.js');
                                    }
                            );
                        }]
                }
            })
            //PHARMACY DRUG CLASS CREATE
            .state('pharmacy.drugclassCreate', {
                url: '/drugclassCreate',
                templateUrl: 'tpl/pharmacy_drugclass/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_drugclass/pharmacy_drugclass.js']);
                        }]
                }
            })

            //PHARMACY DRUG CLASS UPDATE
            .state('pharmacy.drugclassUpdate', {
                url: '/drugclassUpdate/{id}',
                templateUrl: 'tpl/pharmacy_drugclass/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_drugclass/pharmacy_drugclass.js']);
                        }]
                }
            })

            //PHARMACY GENERICNAME
            .state('pharmacy.genericName', {
                url: '/genericName',
                templateUrl: 'tpl/pharmacy_generic_name/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_generic_name/pharmacy_generic_name.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY GENERICNAME CREATE
            .state('pharmacy.genericNameCreate', {
                url: '/genericNameCreate',
                templateUrl: 'tpl/pharmacy_generic_name/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_generic_name/pharmacy_generic_name.js']);
                        }]
                }
            })

            //PHARMACY GENERICNAME UPDATE
            .state('pharmacy.genericNameUpdate', {
                url: '/genericNameUpdate/{id}',
                templateUrl: 'tpl/pharmacy_generic_name/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_generic_name/pharmacy_generic_name.js']);
                        }]
                }
            })

            //PHARMACY Routes
            .state('pharmacy.routes', {
                url: '/routes',
                templateUrl: 'tpl/pharmacy_routes/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_routes/pharmacy_routes.js');
                                    }
                            );
                        }]
                }
            })
            //PHARMACY Routes CREATE
            .state('pharmacy.routesCreate', {
                url: '/routesCreate',
                templateUrl: 'tpl/pharmacy_routes/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_routes/pharmacy_routes.js']);
                        }]
                }
            })
            //PHARMACY Routes UPDATE
            .state('pharmacy.routesUpdate', {
                url: '/routesUpdate/{id}',
                templateUrl: 'tpl/pharmacy_routes/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_routes/pharmacy_routes.js']);
                        }]
                }
            })

            //PHARMACY Product Description
            .state('pharmacy.prodesc', {
                url: '/prodesc',
                templateUrl: 'tpl/pharmacy_prodesc/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_prodesc/pharmacy_prodesc.js');
                                    }
                            );
                        }]
                }
            })
            //PHARMACY Product Description CREATE
            .state('pharmacy.prodescCreate', {
                url: '/prodescCreate',
                templateUrl: 'tpl/pharmacy_prodesc/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_prodesc/pharmacy_prodesc.js']);
                        }]
                }
            })

            //PHARMACY Product Description UPDATE
            .state('pharmacy.prodescUpdate', {
                url: '/prodescUpdate/{id}',
                templateUrl: 'tpl/pharmacy_prodesc/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_prodesc/pharmacy_prodesc.js']);
                        }]
                }
            })
            //PHARMACY PACKING UNIT
            .state('pharmacy.packingUnit', {
                url: '/packingUnit',
                templateUrl: 'tpl/pharmacy_packing_unit/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_packing_unit/pharmacy_packing_unit.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY PACKING UNIT CREATE
            .state('pharmacy.packingUnitCreate', {
                url: '/packingUnitCreate',
                templateUrl: 'tpl/pharmacy_packing_unit/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_packing_unit/pharmacy_packing_unit.js']);
                        }]
                }
            })

            //PHARMACY PACKING UNIT UPDATE
            .state('pharmacy.packingUnitUpdate', {
                url: '/packingUnitUpdate/{id}',
                templateUrl: 'tpl/pharmacy_packing_unit/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_packing_unit/pharmacy_packing_unit.js']);
                        }]
                }
            })

            //PHARMACY SUPPLIER
            .state('pharmacy.supplier', {
                url: '/supplier',
                templateUrl: 'tpl/pharmacy_supplier/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_supplier/pharmacy_supplier.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY SUPPLIER CREATE
            .state('pharmacy.supplierCreate', {
                url: '/supplierCreate',
                templateUrl: 'tpl/pharmacy_supplier/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_supplier/pharmacy_supplier.js']);
                        }]
                }
            })

            //PHARMACY SUPPLIER UPDATE
            .state('pharmacy.supplierUpdate', {
                url: '/supplierUpdate/{id}',
                templateUrl: 'tpl/pharmacy_supplier/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_supplier/pharmacy_supplier.js']);
                        }]
                }
            })

            //PHARMACY VAT
            .state('pharmacy.vat', {
                url: '/vat',
                templateUrl: 'tpl/pharmacy_vat/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_vat/pharmacy_vat.js');
                                    }
                            );
                        }]
                }
            })
            //PHARMACY BRAND CREATE
            .state('pharmacy.vatCreate', {
                url: '/vatCreate',
                templateUrl: 'tpl/pharmacy_vat/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_vat/pharmacy_vat.js']);
                        }]
                }
            })

            //PHARMACY BRAND UPDATE
            .state('pharmacy.vatUpdate', {
                url: '/vatUpdate/{id}',
                templateUrl: 'tpl/pharmacy_vat/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_vat/pharmacy_vat.js']);
                        }]
                }
            })

            //PHARMACY DRUG & GENERIC
            .state('pharmacy.drugGeneric', {
                url: '/drugGeneric',
                templateUrl: 'tpl/pharmacy_drug_generic/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_drug_generic/pharmacy_drug_generic.js');
                                    }
                            );
                        }]
                }
            })
            //PHARMACY DRUG & GENERIC CREATE
            .state('pharmacy.drugGenericCreate', {
                url: '/drugGenericCreate',
                templateUrl: 'tpl/pharmacy_drug_generic/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_drug_generic/pharmacy_drug_generic.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY DRUG & GENERIC UPDATE
            .state('pharmacy.drugGenericUpdate', {
                url: '/drugGenericUpdate/{id}',
                templateUrl: 'tpl/pharmacy_drug_generic/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_drug_generic/pharmacy_drug_generic.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY NEW PURCHASE
            .state('pharmacy.purchaseCreate', {
                url: '/purchaseCreate',
                templateUrl: 'tpl/pharmacy_purchase/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'tpl/pharmacy_purchase/pharmacy_purchase.js',
                                            'tpl/modal_form/modal.supplier.js'
                                        ]);
                                    }
                            );
                        }]
                }
            })

            //PHARMACY EDIT PURCHASE
            .state('pharmacy.purchaseUpdate', {
                url: '/purchaseUpdate/{id}',
                templateUrl: 'tpl/pharmacy_purchase/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_purchase/pharmacy_purchase.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY PURCHASE LIST
            .state('pharmacy.purchase', {
                url: '/purchase',
                templateUrl: 'tpl/pharmacy_purchase/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'tpl/pharmacy_purchase/pharmacy_purchase.js',
                                            'tpl/pharmacy_purchase/purchase_make_payment.js',
                                        ]);
                                    }
                            );
                        }]
                }
            })

            //PHARMACY NEW PURCHASE RETURN
            .state('pharmacy.purchaseReturnCreate', {
                url: '/purchaseReturnCreate',
                templateUrl: 'tpl/pharmacy_purchase_return/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_purchase_return/pharmacy_purchase_return.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY EDIT PURCHASE RETURN
            .state('pharmacy.purchaseReturnUpdate', {
                url: '/purchaseReturnUpdate/{id}',
                templateUrl: 'tpl/pharmacy_purchase_return/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_purchase_return/pharmacy_purchase_return.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY PURCHASE RETURN LIST
            .state('pharmacy.purchaseReturn', {
                url: '/purchaseReturn',
                templateUrl: 'tpl/pharmacy_purchase_return/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_purchase_return/pharmacy_purchase_return.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY PRODUCTS
            .state('pharmacy.products', {
                url: '/products',
                templateUrl: 'tpl/pharmacy_products/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['tpl/pharmacy_products/pharmacy_products.js']);
                        }]
                }
            })
            //PHARMACY PRODUCT ADD
            .state('pharmacy.productAdd', {
                url: '/productAdd',
                templateUrl: 'tpl/pharmacy_products/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load([
                                'tpl/pharmacy_products/pharmacy_products.js',
                                'tpl/modal_form/modal.description.js',
                                'tpl/modal_form/modal.brand.js',
                                'tpl/modal_form/modal.division.js',
                                'tpl/modal_form/modal.generic.js',
                                'tpl/modal_form/modal.vat.js',
                                'tpl/modal_form/modal.package.js',
                                'tpl/modal_form/modal.supplier.js',
                            ]);
                        }]
                }
            })
            //PHARMACY PRODUCT EDIT
            .state('pharmacy.productEdit', {
                url: '/productEdit/{id}',
                templateUrl: 'tpl/pharmacy_products/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/pharmacy_products/pharmacy_products.js']);
                        }]
                }
            })

            //PHARMACY SALE LIST
            .state('pharmacy.sales', {
                url: '/sales',
                templateUrl: 'tpl/pharmacy_sale/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'tpl/pharmacy_sale/pharmacy_sale.js',
                                            'tpl/pharmacy_sale/sale_make_payment.js',
                                        ]);
                                    }
                            );
                        }]
                }
            })

            //SALE CREATE
            .state('pharmacy.saleCreate', {
                url: '/saleCreate',
                templateUrl: 'tpl/pharmacy_sale/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_sale/pharmacy_sale.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY EDIT SALE
            .state('pharmacy.saleUpdate', {
                url: '/saleUpdate/{id}',
                templateUrl: 'tpl/pharmacy_sale/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_sale/pharmacy_sale.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY PRODUCT ADD
            .state('pharmacy.stockAdjust', {
                url: '/stockAdjust',
                templateUrl: 'tpl/pharmacy_stock/adjust.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_stock/pharmacy_stock.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY SALE RETURN LIST
            .state('pharmacy.saleReturn', {
                url: '/saleReturn',
                templateUrl: 'tpl/pharmacy_sale_return/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_sale_return/pharmacy_sale_return.js');
                                    }
                            );
                        }]
                }
            })

            //SALE RETURN CREATE
            .state('pharmacy.saleReturnCreate', {
                url: '/saleReturnCreate',
                templateUrl: 'tpl/pharmacy_sale_return/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_sale_return/pharmacy_sale_return.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY EDIT SALE RETURN
            .state('pharmacy.saleReturnUpdate', {
                url: '/saleReturnUpdate/{id}',
                templateUrl: 'tpl/pharmacy_sale_return/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_sale_return/pharmacy_sale_return.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY PRODUCT ADD
            .state('pharmacy.batchDetails', {
                url: '/batchDetails',
                templateUrl: 'tpl/pharmacy_stock/batch_details.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_stock/pharmacy_stock.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY REPORT
            .state('pharmacy.report', {
                url: '/report/{mode}',
                templateUrl: 'tpl/pharmacy_report/report.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_report/report.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY PATIENT GROUP
            .state('pharmacy.patientgroup', {
                url: '/patientgroup',
                templateUrl: 'tpl/patient_groups/pharmacy_patient_list.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_groups/patient_groups.js');
                                    }
                            );
                        }]
                }
            })

            //Patient Billing
            .state('patient.allbilling', {
                url: '/allbilling/{id}',
                templateUrl: 'tpl/patient_billing/allbilling.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'ui.select']).then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'tpl/patient_billing/patient_billing.js',
                                        ]);
                                    }
                            );
                        }]
                }
            })

            //Patient Billing
            .state('patient.billing', {
                url: '/billing/{id}?enc_id',
                templateUrl: 'tpl/patient_billing/index.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'ui.select']).then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'tpl/patient_billing/patient_billing.js',
                                            'tpl/modal_form/modal.password_auth.js',
                                            'tpl/modal_form/modal.print_bill.js',
                                        ]);
                                    }
                            );
                        }]
                }
            })

            //Patient Billing Add Payment
            .state('patient.addPayment', {
                url: '/addPayment/{id}/{enc_id}',
                templateUrl: 'tpl/patient_payment/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_payment/patient_payment.js']);
                        }]
                }
            })

            //Patient Billing Edit Payment
            .state('patient.editPayment', {
                url: '/editPayment/{id}/{payment_id}/{enc_id}',
                templateUrl: 'tpl/patient_payment/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_payment/patient_payment.js']);
                        }]
                }
            })

            //Patient Billing Add Other Charges
            .state('patient.addOtherCharge', {
                url: '/addOtherCharge/{id}/{enc_id}',
                templateUrl: 'tpl/patient_other_charges/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_other_charges/patient_other_charges.js']);
                        }]
                }
            })
            //Patient Billing Edit Other Charges
            .state('patient.editOtherCharge', {
                url: '/editOtherCharge/{id}/{other_charge_id}/{enc_id}',
                templateUrl: 'tpl/patient_other_charges/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_other_charges/patient_other_charges.js']);
                        }]
                }
            })

            //Patient Billing Add Extra Amount
            .state('patient.addExtraAmount', {
                url: '/addExtraAmount/{id}/{ec_type}/{link_id}/{enc_id}',
                params: {
                    mode: 'E',
                },
                templateUrl: 'tpl/patient_extra_concession/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_extra_concession/patient_extra_concession.js']);
                        }]
                }
            })
            //Patient Billing Edit Extra Amount
            .state('patient.editExtraAmount', {
                url: '/editExtraAmount/{id}/{ec_id}/{enc_id}',
                params: {
                    mode: 'E',
                },
                templateUrl: 'tpl/patient_extra_concession/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_extra_concession/patient_extra_concession.js']);
                        }]
                }
            })

            //Patient Billing Add Concession Amount
            .state('patient.addConcessionAmount', {
                url: '/addConcessionAmount/{id}/{ec_type}/{link_id}/{enc_id}',
                params: {
                    mode: 'C',
                },
                templateUrl: 'tpl/patient_extra_concession/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_extra_concession/patient_extra_concession.js']);
                        }]
                }
            })
            //Patient Billing Edit Concession Amount
            .state('patient.editConcessionAmount', {
                url: '/editConcessionAmount/{id}/{ec_id}/{enc_id}',
                params: {
                    mode: 'C',
                },
                templateUrl: 'tpl/patient_extra_concession/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_extra_concession/patient_extra_concession.js']);
                        }]
                }
            })

            //Patient Billing Room Concession
            .state('patient.roomConcession', {
                url: '/roomConcession/{id}/{encounter_id}',
                templateUrl: 'tpl/patient_billing/room_concession.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_billing/patient_billing.js']);
                        }]
                }
            })

            //Patient Billing Room Concession
            .state('patient.timeLine', {
                url: '/timeLine/{id}',
                templateUrl: 'tpl/patient/timeline.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient/timeline.js']);
                        }]
                }
            })

            //Patient Prescription
            .state('patient.prescription', {
                url: '/prescription/{id}',
                templateUrl: 'tpl/patient_prescription/index.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table', 'ui.select', 'xeditable']).then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'tpl/patient_prescription/patient_prescription.js'
                                        ]);
                                    }
                            );
                        }]
                }
            })

            //Patient Vitals
            .state('patient.vitals', {
                url: '/vitals/{id}',
                templateUrl: 'tpl/patient_vitals/index.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_vitals/patient_vitals.js');
                                    }
                            );
                        }]
                }
            })

            //Patient Vital Create
            .state('patient.vitalCreate', {
                url: '/vitalCreate/{id}',
                templateUrl: 'tpl/patient_vitals/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_vitals/patient_vitals.js']);
                        }]
                }
            })

            //Patient Vital Update
            .state('patient.vitalUpdate', {
                url: '/vitalUpdate/{id}/{vital_id}',
                templateUrl: 'tpl/patient_vitals/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_vitals/patient_vitals.js']);
                        }]
                }
            })

            //ChangePassword
            .state('configuration.changePassword', {
                url: '/changePassword',
                templateUrl: 'tpl/organization/change_password.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/organization/org.js');
                                    }
                            );
                        }]

                }
            })

            //App Configuration
            .state('configuration.settings', {
                url: '/settings',
                templateUrl: 'tpl/organization/settings.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/organization/org.js');
                                    }
                            );
                        }]
                }
            })

            // fullCalendar - Future Appointments
            .state('patient.futureAppointment', {
                url: '/futureAppointment',
                templateUrl: 'tpl/future_appointment/index.html',
                // use resolve to load other dependences
                resolve: {
                    deps: ['$ocLazyLoad', 'uiLoad',
                        function ($ocLazyLoad, uiLoad) {
                            return uiLoad.load(
                                    JQ_CONFIG.fullcalendar.concat('tpl/future_appointment/future_appointment_calender.js')
                                    ).then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'xeditable',
                                            'ui.calendar',
                                            'tpl/modal_form/modal.patient_appointment.js',
                                            'tpl/out_patients/out_patients.js'
                                        ]);
                                    }
                            )
                        }]
                }
            })

            //Future appointments list
            .state('patient.futureAppointmentList', {
                url: '/futureAppointmentList/{consultant_id}/{date}',
                templateUrl: 'tpl/future_appointment/list.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load([
                                            'tpl/future_appointment/future_appointment.js',
                                            'tpl/modal_form/modal.patient_appointment_reschedule.js'
                                        ]);
                                    }
                            );
                        }]
                }
            })

            //Patient Document - Index
            .state('patient.document', {
                url: '/document/{id}',
                templateUrl: 'tpl/patient_documents/index.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_documents/patient_documents.js']);
                        }]
                }
            })
            //Patient Document - Create
            .state('patient.addDocument', {
                url: '/addDocument/{id}',
                templateUrl: 'tpl/patient_documents/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load([
                                'ckeditor/ckeditor.js',
                                'tpl/patient_documents/patient_documents.js'
                            ]);
                        }]
                }
            })
            //Patient Document - Update
            .state('patient.editDocument', {
                url: '/editDocument/{id}/{doc_id}',
                templateUrl: 'tpl/patient_documents/update.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load([
                                'ckeditor/ckeditor.js',
                                'tpl/patient_documents/patient_documents.js'
                            ]);
                        }]
                }
            })
            //Patient Document - View
            .state('patient.viewDocument', {
                url: '/viewDocument/{id}/{doc_id}',
                templateUrl: 'tpl/patient_documents/view.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_documents/patient_documents.js']);
                        }]
                }
            })

            //Patient Scanned Document - Create
            .state('patient.addScannedDocument', {
                url: '/addScannedDocument/{id}',
                templateUrl: 'tpl/patient_scanned_documents/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('angularFileUpload').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_scanned_documents/patient_scanned_documents.js');
                                    }
                            );
                        }]
                }
            })

            //Patient Other Document - Create
            .state('patient.addOtherDocument', {
                url: '/addOtherDocument/{id}',
                templateUrl: 'tpl/patient_other_documents/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('textAngular').then(
                                    function () {
                                        return $ocLazyLoad.load(['tpl/patient_other_documents/patient_other_documents.js']);
                                    }
                            );
                        }]
                }
            })
            //Patient Other Document - Update
            .state('patient.editOtherDocument', {
                url: '/editOtherDocument/{id}/{other_doc_id}',
                templateUrl: 'tpl/patient_other_documents/update.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('textAngular').then(
                                    function () {
                                        return $ocLazyLoad.load(['tpl/patient_other_documents/patient_other_documents.js']);
                                    }
                            );
                        }]
                }
            })
            //Patient Other Document - View
            .state('patient.viewOtherDocument', {
                url: '/viewOtherDocument/{id}/{other_doc_id}',
                templateUrl: 'tpl/patient_other_documents/view.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_other_documents/patient_other_documents.js']);
                        }]
                }
            })

            //Assisgn Patient Sharing
            .state('patient.assignShare', {
                url: '/assignShare/{id}',
                templateUrl: 'tpl/patient_share/assign.html',
                controller: 'PatientLeftSideNotificationCtrl',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_share/patient_share.js']);
                        }]
                }
            })

            //Pharmacy Reorder
            .state('pharmacy.reorder', {
                url: '/reorder',
                templateUrl: 'tpl/pharmacy_reorder/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_reorder/pharmacy_reorder.js');
                                    }
                            );
                        }]
                }
            })

            //PHARMACY ReOrder History Update
            .state('pharmacy.reorderHistoryUpdate', {
                url: '/reorderHistoryUpdate/{id}',
                templateUrl: 'tpl/pharmacy_reorder/create.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('xeditable').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/pharmacy_reorder/pharmacy_reorder.js');
                                    }
                            );
                        }]
                }
            })

            //Myworks
            .state('myworks', {
                abstract: true,
                url: '/myworks',
                templateUrl: 'tpl/myworks.html'
            })
            //Myworks Dashboard
            .state('myworks.dashboard', {
                url: '/dashboard',
                templateUrl: 'tpl/myworks/dashboard.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/myworks/myworks.js');
                                    }
                            );
                        }]
                }
            })
            //Myworks OPDoctorPay
            .state('myworks.opDoctorPay', {
                url: '/opDoctorPay',
                templateUrl: 'tpl/myworks_report/opdoctorpay.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/myworks_report/opdoctorpay.js');
                                    }
                            );
                        }]
                }
            })
            //Myworks ipBillStatus
            .state('myworks.ipBillStatus', {
                url: '/ipBillStatus',
                templateUrl: 'tpl/myworks_report/ipBillStatus.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/myworks_report/ipBillStatus.js');
                                    }
                            );
                        }]
                }
            })
            //Myworks Doctors monthly pay
            .state('myworks.monthlyDocPay', {
                url: '/monthlyDocPay',
                templateUrl: 'tpl/myworks_report/docmonthlypay.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/myworks_report/docmonthlypay.js');
                                    }
                            );
                        }]
                }
            })

            //Myworks Patient Merge
            .state('myworks.patientMerge', {
                url: '/patientMerge',
                templateUrl: 'tpl/myworks/patient_merge.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/myworks/patient_merge.js');
                                    }
                            );
                        }]
                }
            })

    $httpProvider.interceptors.push('APIInterceptor');

}
run.$inject = ['$rootScope', '$state', '$stateParams', '$location', '$cookieStore', '$http', '$window', 'CommonService', 'AuthenticationService', '$timeout'];
function run($rootScope, $state, $stateParams, $location, $cookieStore, $http, $window, CommonService, AuthenticationService, $timeout) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;

    var serviceUrl = '';
    var orgUrl = '';
    var clientURL = '';

    if ($location.host() == 'hms.ark') {
        serviceUrl = 'http://hms.ark/api/IRISORG/web/v1'
        orgUrl = 'http://hms.ark/client';
        clientURL = 'http://hms.ark';
    } else if ($location.host() == 'apollo.local') {
        serviceUrl = 'http://apollo.local/api/IRISORG/web/v1'
        orgUrl = 'http://apollo.local/client';
        clientURL = 'http://apollo.local';
    } else {
        clientURL = orgUrl = $location.absUrl().split('#')[0].slice(0, -1);
//        clientURL = orgUrl = $location.protocol() + '://' + $location.host();
        serviceUrl = clientURL + '/api/IRISORG/web/v1'
    }

    $rootScope.IRISOrgServiceUrl = serviceUrl;
    $rootScope.commonService = CommonService;
    $rootScope.authenticationService = AuthenticationService;
    $rootScope.IRISOrgUrl = orgUrl;
    $rootScope.clientUrl = clientURL;

//    var currentUser = AuthenticationService.getCurrentUser();

    $rootScope.globals = $cookieStore.get('globals') || {};

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
            var currentUser = AuthenticationService.getCurrentUser();
            var loggedIn = Boolean(currentUser);
            var stay_date = AuthenticationService.getCurrent();
            var today_date = moment().format("YYYY-MM-DD");

            if (restrictedPage && !loggedIn) {
                $location.path('/access/signin');
            } else if (!restrictedPage && loggedIn) {
                $location.path('/configuration/organization');
            } else if (restrictedPage && loggedIn) {
                $http.post($rootScope.IRISOrgServiceUrl + '/user/welcome',
                        {
                            user_id: currentUser.credentials.user_id,
                            today_date: today_date,
                            stay_date: stay_date,
                        })
                        .success(function (response) {
                            event.preventDefault();
                            if (!response) {
                                if (AuthenticationService.ClearCredentials()) {
                                    $timeout(function () {
                                        $window.location.reload();
                                    }, 1000);
                                }
                            }
                        });
            }
        }
    });

    //Check Access
    $rootScope.$on('$stateChangeSuccess', function (event, toState, toParams, fromState, fromParams) {
        var restrictedPage = $.inArray($location.path(), ['/configuration/changePassword']) === -1;
        var currentUser = AuthenticationService.getCurrentUser();
        var loggedIn = Boolean(currentUser);

        if (loggedIn) {
            var stateName = toState.name;
            if (stateName) {
                if (restrictedPage) {
                    $rootScope.commonService.CheckStateAccess(stateName, function (response) {
                        if (!response) {
                            $state.go('configuration.organization');
                        }
                    });
                }
            }
        }

    });
}