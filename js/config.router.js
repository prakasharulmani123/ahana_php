'use strict';

/**
 * Config for the router
 */

angular.module('app')
        .run(run)
        .config(config);

config.$inject = ['$stateProvider', '$urlRouterProvider', '$httpProvider'];
function config($stateProvider, $urlRouterProvider, $httpProvider) {
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
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('toaster');
                        }]
                }
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
            //CONFIGURATION FLOOR
            .state('configuration.floors', {
                url: '/floors',
                templateUrl: 'tpl/floors/index.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/floors/floors.js');
                                    }
                            );
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
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/wards/wards.js');
                                    }
                            );
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
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room_charge_category_item/room_charge_category_item.js');
                                    }
                            );
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
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/room/room.js');
                                    }
                            );
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
                            return $ocLazyLoad.load('smart-table').then(
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
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/specialities/speciality.js');
                                    }
                            );
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
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/countries/countries.js');
                                    }
                            );
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
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/states/states.js');
                                    }
                            );
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
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/cities/cities.js');
                                    }
                            );
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
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/alerts/alerts.js');
                                    }
                            );
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
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient_categories/patient_category.js');
                                    }
                            );
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
                            return $ocLazyLoad.load(['xeditable', 'smart-table']).then(
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

            //PATIENT
            .state('patient', {
                abstract: true,
                url: '/patient',
                templateUrl: 'tpl/patient.html'
            })
            .state('patient.registration', {
                url: '/registration',
                templateUrl: 'tpl/patient_registration/create.html',
                resolve: {
                    deps: ['uiLoad',
                        function (uiLoad) {
                            return uiLoad.load(['tpl/patient_registration/patient_registration.js']);
                        }]
                }
            })
            .state('patient.view', {
                url: '/view/{id}',
                templateUrl: 'tpl/patient/view.html',
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
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
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
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/in_patients/in_patients.js');
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
                                        return $ocLazyLoad.load('tpl/out_patients/out_patients.js');
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
                                        return $ocLazyLoad.load('tpl/patient_appointment/patient_appointment.js');
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
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load(['smart-table']).then(
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
                                        return $ocLazyLoad.load('tpl/pharmacy_purchase/pharmacy_purchase.js');
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
                                        return $ocLazyLoad.load('tpl/pharmacy_purchase/pharmacy_purchase.js');
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
                            return $ocLazyLoad.load(['smart-table']).then(
                                    function () {
                                        return $ocLazyLoad.load(['tpl/pharmacy_products/pharmacy_products.js']);
                                    }
                            );
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
                            return uiLoad.load(['tpl/pharmacy_products/pharmacy_products.js', 'tpl/modal_form/modal.description.js']);
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
                                        return $ocLazyLoad.load('tpl/pharmacy_sale/pharmacy_sale.js');
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

    $httpProvider.interceptors.push('APIInterceptor');

}
run.$inject = ['$rootScope', '$state', '$stateParams', '$location', '$cookieStore', '$http', '$window', 'CommonService', 'AuthenticationService'];
function run($rootScope, $state, $stateParams, $location, $cookieStore, $http, $window, CommonService, AuthenticationService) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;

    var serviceUrl = '';
    var orgUrl = '';
    var clientURL = '';

    if ($location.host() == 'hms.ark') {
        serviceUrl = 'http://hms.ark/api/IRISORG/web/v1'
        orgUrl = 'http://hms.ark/client';
        clientURL = 'http://hms.ark';
    } else {
        clientURL = orgUrl = $location.absUrl().split('#')[0].slice(0, -1);
//        clientURL = orgUrl = $location.protocol() + '://' + $location.host();
        serviceUrl = clientURL + '/api/IRISORG/web/v1'
    }

    $rootScope.IRISOrgServiceUrl = serviceUrl;
    $rootScope.commonService = CommonService;
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
            if (restrictedPage && !loggedIn) {
                $location.path('/access/signin');
            } else if (!restrictedPage && loggedIn) {
                $location.path('/configuration/organization');
            }
        }
    });

    //Check Access
//    $rootScope.$on('$stateChangeSuccess', function (event, toState, toParams, fromState, fromParams) {
//        var stateName = toState.name;
//        if (stateName) {
//            $rootScope.commonService.CheckStateAccess(stateName, function (response) {
//                if (!response) {
//                    $state.go('configuration.organization');
//                }
//            });
//        }
//    });
}