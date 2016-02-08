'use strict';

/* Controllers */

angular.module('app')
        .controller('AppCtrl', ['$scope', '$translate', '$localStorage', '$window', '$rootScope', '$state', '$cookieStore', '$http', 'CommonService',
            function ($scope, $translate, $localStorage, $window, $rootScope, $state, $cookieStore, $http, CommonService) {
                // add 'ie' classes to html
                var isIE = !!navigator.userAgent.match(/MSIE/i);
                isIE && angular.element($window.document.body).addClass('ie');
                isSmartDevice($window) && angular.element($window.document.body).addClass('smart');

                // config
                $scope.app = {
                    name: 'IRIS',
                    org_name: '',
                    version: '',
                    // for chart colors
                    color: {
                        primary: '#7266ba',
                        info: '#23b7e5',
                        success: '#27c24c',
                        warning: '#fad733',
                        danger: '#f05050',
                        light: '#e8eff0',
                        dark: '#3a3f51',
                        black: '#1c2b36'
                    },
                    settings: {
                        themeID: 1,
                        navbarHeaderColor: 'bg-black',
                        navbarCollapseColor: 'bg-white-only',
                        asideColor: 'bg-black',
                        headerFixed: true,
                        asideFixed: false,
                        asideFolded: false,
                        asideDock: false,
                        container: false,
                        patientTopBar: true,
                        patientSideMenu: true,
                        patientContentClass: 'app-content app-content2',
                        patientFooterClass: 'app-footer app-footer2',
                    },
                    patientDetail: {
                        patientTitleCode: '',
                        patientName: '',
                        patientId: '',
                        patientGuid: '',
                        patientIntCode: '',
                        patientSex: '',
                        patientDOA: '',
                        patientOrg: '',
                        patientAge: '',
                        patientCasesheetno: '',
                        patientHasAlert: '',
                        patientAlert: '',
                    }
                }

                // save settings to local storage
//                if (angular.isDefined($localStorage.settings)) {
//                    $scope.app.settings = $localStorage.settings;
//                } else {
//                    $localStorage.settings = $scope.app.settings;
//                }

                $localStorage.settings = $scope.app.settings;

                $scope.$watch('app.settings', function () {
                    if ($scope.app.settings.asideDock && $scope.app.settings.asideFixed) {
                        // aside dock and fixed must set the header fixed.
                        $scope.app.settings.headerFixed = true;
                    }
                    // save to local storage
                    $localStorage.settings = $scope.app.settings;
                }, true);

                $scope.loggedIn = function () {
                    return Boolean($rootScope.globals.currentUser);
                };

                $scope.logout = function () {
                    $rootScope.globals = {};
                    $cookieStore.remove('globals');
                    $window.location.reload();
                };


                //Change Status
                $scope.updateStatus = function (modelName, primaryKey) {
                    $scope.service = CommonService;
                    $scope.service.ChangeStatus(modelName, primaryKey, function (response) {
                        $scope.successMessage = 'Status changed successfully !!!';
                    });
                }

                //error Summary
                $scope.errorSummary = function (error) {
                    var html = '<div><p>Please fix the following errors:</p><ul>';
                    angular.forEach(error, function (error) {
                        html += '<li>' + error.message + '</li>';
                    });

                    html += '</ul></div>';
                    return html;
                }

                //show/hide Load bar
                $scope.loadbar = function (mode) {
                    if (mode == 'show') {
                        $('.butterbar').removeClass('hide').addClass('active');
                        $('.save-btn').attr('disabled', true);
                    } else if (mode == 'hide') {
                        $('.butterbar').removeClass('active').addClass('hide');
                        $('.save-btn').attr('disabled', false);
                    }
                }


                function isSmartDevice($window)
                {
                    // Adapted from http://www.detectmobilebrowsers.com
                    var ua = $window['navigator']['userAgent'] || $window['navigator']['vendor'] || $window['opera'];
                    // Checks for iOs, Android, Blackberry, Opera Mini, and Windows mobile devices
                    return (/iPhone|iPod|iPad|Silk|Android|BlackBerry|Opera Mini|IEMobile/).test(ua);
                }

                $scope.navigationMenu = '';
                $scope.getNavigationMenu = function (resourceName) {
                    $http.get($rootScope.IRISOrgServiceUrl + '/default/getnavigation?resourceName=' + resourceName)
                            .success(function (response) {
                                $scope.navigationMenu = response.navigation;
                            })
                            .error(function () {
                                $scope.errorData = "An Error has occured while loading posts!";
                            });
                }

                $scope.patientObj = {};

                $scope.loadPatientDetail = function () {
                    // Get data's from service
                    if (typeof $state.params.id != 'undefined') {
                        $http.post($rootScope.IRISOrgServiceUrl + '/patient/getpatientbyguid', {guid: $state.params.id})
                                .success(function (patient) {
                                    $scope.errorData = "";
                                    if (patient == null || patient == '') {
                                        $scope.errorData = "Invalid Access !";
                                        $state.go('configuration.organization');
                                    } else {
                                        $scope.app.patientDetail.patientId = '';
                                        $scope.app.patientDetail.patientTitleCode = patient.patient_title_code;
                                        $scope.app.patientDetail.patientName = patient.patient_firstname;
                                        $scope.app.patientDetail.patientId = patient.patient_id;
                                        $scope.app.patientDetail.patientIntCode = patient.patient_int_code;
                                        $scope.app.patientDetail.patientGuid = patient.patient_guid;
                                        $scope.app.patientDetail.patientDOA = patient.doa;
                                        $scope.app.patientDetail.patientOrg = patient.org_name;
                                        $scope.app.patientDetail.patientAge = patient.patient_age;
                                        $scope.app.patientDetail.patientCasesheetno = patient.casesheetno;
                                        $scope.app.patientDetail.patientHasAlert = patient.hasalert;
                                        $scope.app.patientDetail.patientAlert = patient.alert;
                                        $rootScope.commonService.GetLabelFromValue(patient.patient_gender, 'GetGenderList', function (response) {
                                            $scope.app.patientDetail.patientSex = response;
                                        });

                                        $scope.patientObj = patient;
                                    }

                                })
                                .error(function () {
                                    $scope.error = "An Error has occured while loading patient!";
                                });
                    }
                };

                $scope.loadUserDetail = function () {
                    if (typeof $rootScope.globals.currentUser != 'undefined') {

                        $http.post($rootScope.IRISOrgServiceUrl + '/user/getusercredentialsbytoken', {token: $rootScope.globals.currentUser.authdata})
                                .success(function (response) {
                                    $scope.app.org_name = response.credentials.org;
                                })
                                .error(function () {
                                    $scope.error = "An Error has occured while loading patient!";
                                });
                    }
                };

                $scope.checkAccess = function (url) {
                    return $rootScope.globals.currentUser.resources.hasOwnProperty(url);
                }

            }]);
