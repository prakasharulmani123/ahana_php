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
                templateUrl: 'tpl/patient.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('toaster');
                        }]
                }
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
            
            //PATIENT ENCOUNTER
            .state('patient.encounter', {
                url: '/encounter/{id}',
                templateUrl: 'tpl/patient/encounters.html',
                resolve: {
                    deps: ['$ocLazyLoad',
                        function ($ocLazyLoad) {
                            return $ocLazyLoad.load('smart-table').then(
                                    function () {
                                        return $ocLazyLoad.load('tpl/patient/patient.js');
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
    if ($rootScope.globals.currentUser) {
        $http.defaults.headers.common['Authorization'] = 'Bearer ' + $rootScope.globals.currentUser.authdata; // jshint ignore:line
    }

//    $rootScope.$on('$stateChangeStart', function (event, toState, toParams, fromState, fromParams) {
//        var stateName = toState.name;
//        if (stateName) {
//            $rootScope.commonService.CheckStateAccess(stateName, function (response) {
//                if (response.success === false) {
//                    $state.go('configuration.401');
//                }
//            });
//        }
//    });

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
            var loggedIn = Boolean($rootScope.globals.currentUser);
            if (restrictedPage && !loggedIn) {
                $location.path('/access/signin');
            } else if (!restrictedPage && loggedIn) {
                $location.path('/configuration/organization');
            }
        }
    });
//
//    $rootScope.$on('$stateChangeSuccess', function (event, toState, toParams, fromState, fromParams) {
//        alert('stateChangeSuccess');
//        var stateName = toState.name;
//        if (stateName) {
//            $rootScope.commonService.CheckStateAccess(stateName, function (response) {
//                if (response.success === false) {
//                    $state.go('configuration.organization');
//                }
//            });
//        }
//    });
}