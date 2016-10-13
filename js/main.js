'use strict';

/* Controllers */
angular.module('app')
        .controller('AppCtrl', ['$scope', '$localStorage', '$window', '$rootScope', '$state', '$cookieStore', '$http', 'CommonService', '$timeout', 'AuthenticationService', 'toaster', 'hotkeys', '$modal', '$filter',
            function ($scope, $localStorage, $window, $rootScope, $state, $cookieStore, $http, CommonService, $timeout, AuthenticationService, toaster, hotkeys, $modal, $filter) {
//                socket.forward('someEvent', $scope);

                $scope.$on('socket:someEvent', function (ev, data) {
                    console.log($scope.theData);
                });

                // add 'ie' classes to html
                var isIE = !!navigator.userAgent.match(/MSIE/i);
                isIE && angular.element($window.document.body).addClass('ie');
                isSmartDevice($window) && angular.element($window.document.body).addClass('smart');

                // config
                $scope.app = {
                    name: 'IRIS',
                    page_title: 'IRIS',
                    org_name: '',
                    org_address: '',
                    org_country: '',
                    org_state: '',
                    org_city: '',
                    org_mobile: '',
                    org_full_address: '',
                    version: '',
                    username: '',
                    logged_tenant_id: '',
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
                        patientSex: '',
                        patientMaritalStatus: '',
                        patientUnseenNotesCount: '0',
                        patientUnseenVitalsCount: '0',
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

//                $scope.loggedIn = function () {
//                    return Boolean($rootScope.globals.currentUser);
//                };

//
                $scope.logout = function () {
                    var state_name = $state.current.name;
                    var state_params = $state.params;

                    $http.post($rootScope.IRISOrgServiceUrl + '/user/logout')
                            .success(function (response) {
                                if (response.success) {
                                    if (AuthenticationService.ClearCredentials(state_name, state_params)) {
                                        $timeout(function () {
                                            $window.location.reload();
                                        }, 1000);
                                    }
                                } else {
                                    $scope.errorData = response.message;
                                }
                            })
                            .error(function () {
                                $scope.errorData = "An Error has occured";
                            });
                };

                //Change Status
                $scope.updateStatus = function (modelName, primaryKey) {
                    $scope.service = CommonService;
                    $scope.service.ChangeStatus(modelName, primaryKey, function (response) {
                        $scope.msg.successMessage = 'Status changed successfully !!!';
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
                        $('.save-btn,.get-report,.search-btn,.save-print,.save-future,.save-btn-1,.save-print-bill').attr('disabled', true).html("<i class='fa fa-spin fa-spinner'></i> Please Wait...");
                    } else if (mode == 'hide') {
                        $('.butterbar').removeClass('active').addClass('hide');
                        $('.save-btn').attr('disabled', false).html("Save");
                        $('.get-report').attr('disabled', false).html("Get Report");
                        $('.search-btn').attr('disabled', false).html("Search");
                        $('.save-btn-1').attr('disabled', false).html("<i class='fa fa-check'></i> Save");
                        $('.save-print').attr('disabled', false).html("<i class='fa fa-print'></i> Save and Print");
                        $('.save-print-bill').attr('disabled', false).html("<i class='fa fa-print'></i> Save and Print Bill");
                        $('.save-future').attr('disabled', false).html("Save & Future Appointment");
                    }
                }

                $scope.spinnerbar = function (mode) {
                    if (mode == 'show') {
                        $('.modalload').removeClass("hide").addClass("show");
                    } else if (mode == 'hide') {
                        $('.modalload').removeClass("show").addClass("hide");
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
                $scope.leftNotificationNotes = [];
                $scope.leftNotificationVitals = [];
                $scope.patient_alert_html = '';

                $scope.loadPatientDetail = function () {
                    // Get data's from service
                    if (typeof $state.params.id != 'undefined') {
                        $http.post($rootScope.IRISOrgServiceUrl + '/patient/getpatientbyguid', {guid: $state.params.id})
                                .success(function (patient) {
                                    if (patient.success == false) {
                                        $state.go('configuration.organization');
                                        $scope.msg.errorMessage = "An Error has occured while loading patient!";
                                    } else {
                                        $scope.patientObj = patient;

                                        var alert_link = '#/patient/alert/' + $scope.patientObj.patient_guid;
                                        $scope.patient_alert_html = '<div>' + $scope.patientObj.alert + '<br><a class="text-info alert-read-more" ui-sref="patient.alert({id: $scope.patientObj.patient_guid})" href="' + alert_link + '">ReadMore</a><div>';

                                        $rootScope.commonService.GetLabelFromValue(patient.patient_gender, 'GetGenderList', function (response) {
                                            $scope.app.patientDetail.patientSex = response;
                                        });

                                        $rootScope.commonService.GetLabelFromValue(patient.patient_marital_status, 'GetMaritalStatus', function (response) {
                                            $scope.app.patientDetail.patientMaritalStatus = response;
                                        });
                                    }
                                })
                                .error(function () {
                                    $scope.msg.errorMessage = "An Error has occured while loading patient!";
                                });
                    }
                };

                $scope.loadUserCredentials = function () {
                    var user = AuthenticationService.getCurrentUser();
                    $scope.app.logged_tenant_id = user.credentials.logged_tenant_id;
                    $scope.app.org_name = user.credentials.org;
                    $scope.app.org_address = user.credentials.org_address;
                    $scope.app.org_country = user.credentials.org_country;
                    $scope.app.org_state = user.credentials.org_state;
                    $scope.app.org_city = user.credentials.org_city;
                    $scope.app.org_mobile = user.credentials.org_mobile;
                    $scope.app.org_full_address = user.credentials.org_address + ', ' + user.credentials.org_city;
                    $scope.app.username = user.credentials.username;
                    $scope.app.page_title = $scope.app.name + '(' + $scope.app.org_name + ')';
                };

                $scope.checkAccess = function (url) {
                    var ret = true;
                    $rootScope.commonService.CheckStateAccess(url, function (response) {
                        ret = response;
                    });
                    return ret;
                }

                $scope.msg = {};
                $scope.msg.successMessage = "";
                $scope.msg.errorMessage = "";

                $scope.$watch('msg', function (newValue, oldValue) {
                    if (newValue != oldValue) {
                        $timeout(function () {
                            $scope.msg.successMessage = false;
                            $scope.msg.errorMessage = false;
                        }, 5000);
                    }
                }, true);

                //Avoid pagination problem, when come from other pages.
                //Used in all the controller index function.
                $scope.footable_redraw = function () {
                    $timeout(function () {
                        $('.table').trigger('footable_redraw');
                    }, 100);
                }

                $scope.child = {}

                $scope.GetNote = function (id, note_id) {

                    $scope.errorData = "";
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/patientnotes/" + note_id,
                        method: "GET"
                    }).success(
                            function (response) {
                                $scope.loadbar('hide');
                                $scope.data = response;
                                $scope.encounter = {encounter_id: response.encounter_id};
                            }
                    ).error(function (data, status) {
                        $scope.loadbar('hide');
                        if (status == 422)
                            $scope.errorData = $scope.errorSummary(data);
                        else
                            $scope.errorData = data.message;
                    });
                }

                $scope.addNotes = function () {

                    if (jQuery.isEmptyObject($scope.data)) {
                        $scope.xrror = true;
                        return;
                    }
                    $scope.notes_error = false;

                    $scope.errorData = "";
                    $scope.msg.successMessage = "";

                    angular.extend($scope.data, {
                        patient_id: $scope.patientObj.patient_id,
                        encounter_id: $scope.encounter_id
                    });

                    $scope.loadbar('show');

                    if ($scope.data.pat_note_id == null) {
                        var posturl = $rootScope.IRISOrgServiceUrl + '/patientnotes';
                        var method = 'POST';
                        var mode = 'add';
                    } else {
                        var posturl = $rootScope.IRISOrgServiceUrl + '/patientnotes/' + $scope.data.pat_note_id;
                        var method = 'PUT';
                        var mode = 'update';
                    }

                    $http({
                        method: method,
                        url: posturl,
                        data: $scope.data,
                    }).success(function (response) {
                        $scope.data = {};

                        angular.extend(response, {
                            created_at: moment().format('YYYY-MM-DD HH:mm:ss'),
                        });

                        if (mode == "update")
                        {
                            var notes_exists = '';
                            notes_exists = $filter('filter')($scope.child.notes, {pat_note_id: response.pat_note_id});
                            if (notes_exists.length > 0) {
                                $scope.child.notes.splice($scope.child.notes.indexOf(notes_exists[0]), 1);
                            }
                        }

                        $scope.child.notes.push(response);

                        $scope.loadbar('hide');

                        $(".vbox .row-row .cell:visible").animate({scrollTop: $('.vbox .row-row .cell:visible').prop("scrollHeight")}, 1000);
//                                $scope.msg.successMessage = 'Note saved successfully';
                    })
                            .error(function (data, status) {
                                $scope.loadbar('hide');
                                if (status == 422)
                                    $scope.errorData = $scope.errorSummary(data);
                                else
                                    $scope.errorData = data.message;
                            });
                }

                $scope.GetVital = function (id, vital_id) {

                    $scope.errorData = "";
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/patientvitals/" + vital_id,
                        method: "GET"
                    }).success(
                            function (response) {
                                $scope.loadbar('hide');
                                $scope.vitaldata = response;
                                $scope.encounter = {encounter_id: response.encounter_id};
                            }
                    ).error(function (data, status) {
                        $scope.loadbar('hide');
                        if (status == 422)
                            $scope.errorData = $scope.errorSummary(data);
                        else
                            $scope.errorData = data.message;
                    });
                }

                $scope.addVital = function () {
                    if (jQuery.isEmptyObject($scope.vitaldata)) {
                        $scope.vital_error = true;
                        return;
                    }

                    $scope.vital_error = false;

                    $scope.errorData = "";
                    $scope.msg.successMessage = "";

                    angular.extend($scope.vitaldata, {
                        patient_id: $scope.patientObj.patient_id,
                        encounter_id: $scope.encounter_id,
                        vital_time: moment().format('YYYY-MM-DD HH:mm:ss')
                    });

                    if ($scope.vitaldata.vital_id == null) {
                        var posturl = $rootScope.IRISOrgServiceUrl + '/patientvitals';
                        var method = 'POST';
                        var mode = 'add';
                    } else {
                        var posturl = $rootScope.IRISOrgServiceUrl + '/patientvitals/' + $scope.vitaldata.vital_id;
                        var method = 'PUT';
                        var mode = 'update';
                    }

                    $scope.loadbar('show');

                    $http({
                        method: method,
                        url: posturl,
                        data: $scope.vitaldata,
                    }).success(function (response) {
                        $scope.vitaldata = {};

                        if (mode == "update")
                        {
                            var vital_exists = '';
                            vital_exists = $filter('filter')($scope.child.vitals, {vital_id: response.vital_id});
                            if (vital_exists.length > 0) {
                                $scope.child.vitals.splice($scope.child.vitals.indexOf(vital_exists[0]), 1);
                            }
                        }

                        $scope.child.vitals.push(response);

                        $scope.loadbar('hide');

                        $(".vbox .row-row .cell:visible").animate({
                            scrollTop: $('.vbox .row-row .cell:visible').prop("scrollHeight")
                        }, 1000);
                    })
                            .error(function (data, status) {
                                $scope.loadbar('hide');
                                if (status == 422)
                                    $scope.errorData = $scope.errorSummary(data);
                                else
                                    $scope.errorData = data.message;
                            });
                }

                //Toggle favorite product status in prescription page.
                $scope.toggleFavourite = function (favourite_id) {
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/patientprescriptionfavourite/togglefavourite",
                        method: "POST",
                        data: {id: favourite_id}
                    }).then(
                            function (response) {
//                                console.log(response);
                            }
                    )
                }

                //Pass fav to patient_prescription.js
                $scope.addFavouritePrescForm = function (fav) {
                    $scope.$broadcast('presc_fav', fav);
                }

                //Hot Keys
                hotkeys.add({
                    combo: 'f5',
                    description: 'Create',
                    allowIn: ['INPUT', 'SELECT', 'TEXTAREA'],
                    callback: function (event) {
                        $scope.$broadcast('HK_CREATE');
                        event.preventDefault();
                    }
                });

                hotkeys.add({
                    combo: 'f6',
                    description: 'Save',
                    allowIn: ['INPUT', 'SELECT', 'TEXTAREA'],
                    callback: function (event) {
                        $scope.$broadcast('HK_SAVE');
                        event.preventDefault();
                    }
                });

//                hotkeys.add({
//                    combo: 'f7',
//                    description: 'Delete',
//                    callback: function (event) {
//                        $scope.$broadcast('HK_DELETE');
//                        event.preventDefault();
//                    }
//                });

//                hotkeys.add({
//                    combo: 'f8',
//                    description: 'Cancel',
//                    callback: function (event) {
//                        $scope.$broadcast('HK_CANCEL');
//                        event.preventDefault();
//                    }
//                });

                hotkeys.add({
                    combo: 'f9',
                    description: 'List',
                    allowIn: ['INPUT', 'SELECT', 'TEXTAREA'],
                    callback: function (event) {
                        $scope.$broadcast('HK_LIST');
                        event.preventDefault();
                    }
                });

                hotkeys.add({
                    combo: 'f10',
                    description: 'Print',
                    allowIn: ['INPUT', 'SELECT', 'TEXTAREA'],
                    callback: function (event) {
                        $scope.$broadcast('HK_PRINT');
                        event.preventDefault();
                    }
                });

                hotkeys.add({
                    combo: 'f11',
                    description: 'View',
                    allowIn: ['INPUT', 'SELECT', 'TEXTAREA'],
                    callback: function (event) {
                        $scope.$broadcast('HK_VIEW');
                        event.preventDefault();
                    }
                });

//                hotkeys.add({
//                    combo: 'f12',
//                    description: 'Close',
//                    callback: function (event) {
//                        $scope.$broadcast('HK_CLOSE');
//                        event.preventDefault();
//                    }
//                });

                hotkeys.add({
                    combo: 's',
                    description: 'Search',
                    callback: function (event) {
                        $scope.$broadcast('HK_SEARCH');
                        event.preventDefault();
                    }
                });
//
//                hotkeys.add({
//                    combo: 'ctrl+left',
//                    description: 'Back',
//                    callback: function () {
//                        $window.history.back();
//                    }
//                });
//
//                hotkeys.add({
//                    combo: 'ctrl+right',
//                    description: 'Forward',
//                    callback: function () {
//                        $window.history.forward();
//                    }
//                });

                $rootScope.$on('unauthorized', function () {
                    toaster.clear();
//                    toaster.pop('error', 'Session Expired', 'Kindly Login Again');
                    $scope.logout();
                });

                $rootScope.$on('internalerror', function () {
                    toaster.clear();
                    toaster.pop('error', 'Internal Error', 'NetworkError: 500 Internal Server Error');
                    $scope.loadbar('hide');
                });

                $scope.$on('encounter_id', function (event, data) {
                    $scope.encounter_id = data;
                });

                $scope.$on('patient_obj', function (event, data) {
                    $scope.patientObj = data;
                });

                $scope.$on('patient_alert', function (event, data) {
                    $scope.patientObj.hasalert = data.hasalert;
                    $scope.patientObj.alert = data.alert;
                });

                $scope.openUploadForm = function (block) {
                    var modalInstance = $modal.open({
                        templateUrl: 'tpl/modal_form/modal.patient_image.html',
                        controller: "PatientImageController",
                        size: 'lg',
                        resolve: {
                            scope: function () {
                                return $scope;
                            },
                            block: function () {
                                return block;
                            },
                        }
                    });
                }

                //Different ORG
                $scope.importPatient = function (patient, key) {
                    var conf = confirm('Are you sure to import basic data ?')

                    if (!conf)
                        return;

                    $scope.errorData = "";
                    $scope.msg.successMessage = "";

                    $scope.loadbar('show');
                    $('#import_' + key).attr('disabled', true).html("<i class='fa fa-spin fa-spinner'></i> Please Wait...");

                    $http({
                        method: 'POST',
                        url: $rootScope.IRISOrgServiceUrl + '/patient/importpatient',
                        data: patient,
                    }).success(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.success == true) {
                                    $scope.msg.successMessage = 'Patient imported successfully';
                                    var patient_guid = response.patient.patient_guid;
                                    $('#import_' + key).html('Completed').toggleClass('btn-success').removeAttr('ng-click');
                                    $timeout(function () {
                                        $state.go('patient.view', {id: patient_guid});
                                    }, 1000);
                                } else {
                                    $scope.errorData = response.message;
                                }

                            }
                    ).error(function (data, status) {
                        $scope.loadbar('hide');
                        if (status == 422)
                            $scope.errorData = $scope.errorSummary(data);
                        else
                            $scope.errorData = data.message;
                    });
                }

                //Same ORG But different branch so Import and book
                $scope.importBookPatient = function (patient, key) {
                    $scope.errorData = "";
                    $scope.msg.successMessage = "";

                    $scope.loadbar('show');
                    $('#import_book_' + key).attr('disabled', true).html("<i class='fa fa-spin fa-spinner'></i> Please Wait...");

                    $http({
                        method: 'POST',
                        url: $rootScope.IRISOrgServiceUrl + '/patient/importpatient',
                        data: patient,
                    }).success(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.success == true) {
                                    var patient_guid = response.patient.patient_guid;
                                    $('#import_book_' + key).html('Completed').toggleClass('btn-success').removeAttr('ng-click');
                                    $timeout(function () {
                                        $state.go('patient.appointment', {id: patient_guid});
                                    }, 1000);
                                } else {
                                    $scope.errorData = response.message;
                                }
                            }
                    ).error(function (data, status) {
                        $scope.loadbar('hide');
                        if (status == 422)
                            $scope.errorData = $scope.errorSummary(data);
                        else
                            $scope.errorData = data.message;
                    });
                }

                $scope.switched_branches_list = [];
                $scope.branch_switch = {};
                $scope.initSwitchedBranch = function () {
                    if (AuthenticationService.getCurrentUser()) {
                        $http({
                            url: $rootScope.IRISOrgServiceUrl + '/user/getswitchedbrancheslist',
                            method: "GET",
                        }).then(
                                function (response) {
                                    if (response.data.success) {
                                        $scope.switched_branches_list = response.data.branches;
                                        $scope.branch_switch.branch_id = response.data.default_branch;
                                    }
                                }
                        );
                    }
                }

                $scope.switchBranch = function () {
                    $http({
                        method: 'POST',
                        url: $rootScope.IRISOrgServiceUrl + '/default/switchbranch',
                        data: {'branch_id': $scope.branch_switch.branch_id},
                    }).success(
                            function (response) {
                                if (response.tenant) {
                                    $localStorage.user.credentials.logged_tenant_id = response.tenant.tenant_id;
                                    $localStorage.user.credentials.org = response.tenant.tenant_name;
                                    $localStorage.user.credentials.org_address = response.tenant.tenant_address;
                                    $localStorage.user.credentials.org_country = response.tenant.tenant_country_name;
                                    $localStorage.user.credentials.org_state = response.tenant.tenant_state_name;
                                    $localStorage.user.credentials.org_city = response.tenant.tenant_city_name;
                                    $localStorage.user.credentials.org_mobile = response.tenant.tenant_mobile;
                                }

                                if (response.admin) {
                                    $state.go('myworks.dashboard', {}, {reload: true});
                                } else {
                                    if (response.success && !jQuery.isEmptyObject(response.resources)) {
                                        //Branch wise resource assign.
                                        var currentUser = AuthenticationService.getCurrentUser();
                                        delete currentUser.resources;
                                        currentUser.resources = response.resources;
                                        AuthenticationService.setCurrentUser(currentUser);
                                        $state.go('myworks.dashboard', {}, {reload: true});
                                    } else {
                                        $state.go($state.current, {}, {reload: true});
                                        $timeout(function () {
                                            toaster.clear();
                                            toaster.pop('info', '', 'Branch not set up');
                                        }, 1000);
                                    }
                                }

//                                if (Object.keys($state.params).length > 0 && Object.keys($scope.patientObj).length > 0 && $state.params.id == $scope.patientObj.patient_guid) {
//                                    $state.go('configuration.organization');
//                                    $timeout(function () {
//                                        toaster.clear();
//                                        toaster.pop('error', 'Internal Error', 'Do not switch between branches when loading screens with patient details');
//                                    }, 5000);
//                                } else {
//                                    $state.go($state.current, {}, {reload: true});
//                                }
                            }
                    );
                }
            }]);

angular.module('app').filter('unsafe', ['$sce', function ($sce) {
        return function (val) {
            return $sce.trustAsHtml(val);
        };
    }]);

angular.module("template/popover/popover.html", []).run(["$templateCache", function ($templateCache) {
        $templateCache.put("template/popover/popover.html",
                "<div class=\"popover {{placement}}\" ng-class=\"{ in: isOpen(), fade: animation() }\">\n" +
                "  <div class=\"arrow\"></div>\n" +
                "\n" +
                "  <div class=\"popover-inner\">\n" +
                "      <h3 class=\"popover-title\" ng-bind-html=\"title | unsafe\" ng-show=\"title\"></h3>\n" +
                "      <div class=\"popover-content\"ng-bind-html=\"content | unsafe\"></div>\n" +
                "  </div>\n" +
                "</div>\n" +
                "");
    }]);

//Moment Filter
angular.module('app').filter('moment', function () {
    return function (dateString, format) {
        return moment(dateString).format(format);
    };
});

//Form Upload with file data
angular.module('app').factory('fileUpload', ['$http', function ($http) {
        return {
            uploadFileToUrl: function (file, uploadUrl) {
                var fd = new FormData();
                fd.append('file', file);

                return $http.post(uploadUrl, fd, {
                    transformRequest: angular.identity,
                    headers: {'Content-Type': undefined}
                })
                        .success(function (response) {
                        })
                        .error(function (data, status) {
                        });
            }
        }
    }]);

angular.module('app').controller('PatientLeftSideNotificationCtrl', ['$rootScope', '$scope', '$http', '$state', '$filter', '$timeout', function ($rootScope, $scope, $http, $state, $filter, $timeout) {

        $scope.assignNotifications = function () {
            //Assign Notes
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/patientnotes/assignnotes',
                data: {'patient_guid': $state.params.id},
            }).success(
                    function (response) {
                        if (response.success) {
                            if (typeof $state.params.id != 'undefined') {
                                //Get Notes
                                $http.get($rootScope.IRISOrgServiceUrl + '/patientnotes/getpatientnotes?patient_id=' + $state.params.id)
                                        .success(function (notes) {
                                            angular.forEach(notes.result, function (result) {
                                                angular.forEach(result.all, function (note) {
                                                    $scope.leftNotificationNotes.push(note);
                                                });
                                            });
                                            $scope.unseen_notes = notes.usernotes;
                                            $scope.app.patientDetail.patientUnseenNotesCount = notes.usernotes.length;

                                            angular.forEach($scope.leftNotificationNotes, function (note) {
                                                note.seen_by = 1;
                                            });

                                            angular.forEach(notes.usernotes, function (note) {
                                                var seen_filter_note = $filter('filter')($scope.leftNotificationNotes, {pat_note_id: note.note_id});

                                                if (seen_filter_note.length > 0) {
                                                    seen_filter_note[0].seen_by = 0;
                                                }
                                            });
                                        })
                                        .error(function () {
                                            $scope.errorData = "An Error has occured while loading patientnote!";
                                        });
                            }

                        }
                    }
            );

            //Assign Vitals
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/patientvitals/assignvitals',
                data: {'patient_guid': $state.params.id},
            }).success(
                    function (response) {
                        if (response.success) {
                            if (typeof $state.params.id != 'undefined') {
                                // Get Vitals
                                $http.get($rootScope.IRISOrgServiceUrl + '/patientvitals/getpatientvitals?patient_id=' + $state.params.id)
                                        .success(function (vitals) {
                                            angular.forEach(vitals.result, function (result) {
                                                angular.forEach(result.all, function (vital) {
                                                    $scope.leftNotificationVitals.push(vital);
                                                });
                                            });
                                            $scope.unseen_vitals = vitals.uservitals;
                                            $scope.app.patientDetail.patientUnseenVitalsCount = vitals.uservitals.length;

                                            angular.forEach($scope.leftNotificationVitals, function (vital) {
                                                vital.seen_by = 1;
                                            });

                                            angular.forEach(vitals.uservitals, function (vital) {
                                                var seen_filter_vital = $filter('filter')($scope.leftNotificationVitals, {vital_id: vital.vital_id});
                                                if (seen_filter_vital.length > 0) {
                                                    seen_filter_vital[0].seen_by = 0;
                                                }
                                            });
                                        })
                                        .error(function () {
                                            $scope.errorData = "An Error has occured while loading patientvitals!";
                                        });
                            }
                        }
                    }
            );
        };
        $scope.assignNotifications();

        $scope.seen_notes_left_notification = function () {
            if ($scope.app.patientDetail.patientUnseenNotesCount > 0) {
                var unseen_filter_note = $filter('filter')($scope.leftNotificationNotes, {seen_by: 0});
                var note_ids = [];
                angular.forEach(unseen_filter_note, function (unseen, key) {
                    note_ids.push(unseen.pat_note_id);
                });

                $http({
                    method: 'POST',
                    url: $rootScope.IRISOrgServiceUrl + '/patientnotes/seennotes',
                    data: {'ids': note_ids, 'patient_guid': $state.params.id},
                }).success(
                        function (response) {
                            $timeout(function () {
                                angular.forEach($scope.leftNotificationNotes, function (note, key) {
                                    note.seen_by = 1;
                                });
                                $scope.app.patientDetail.patientUnseenNotesCount = 0;
                            }, 5000);
                        }
                );
            }
        }

        $scope.seen_vitals_left_notification = function () {
            if ($scope.app.patientDetail.patientUnseenVitalsCount > 0) {
                var unseen_filter_vital = $filter('filter')($scope.leftNotificationVitals, {seen_by: 0});
                var vital_ids = [];
                angular.forEach(unseen_filter_vital, function (unseen, key) {
                    vital_ids.push(unseen.vital_id);
                });

                $http({
                    method: 'POST',
                    url: $rootScope.IRISOrgServiceUrl + '/patientvitals/seenvitals',
                    data: {'ids': vital_ids, 'patient_guid': $state.params.id},
                }).success(
                        function (response) {
                            $timeout(function () {
                                angular.forEach($scope.leftNotificationVitals, function (vital, key) {
                                    vital.seen_by = 1;
                                });
                                $scope.app.patientDetail.patientUnseenVitalsCount = 0;
                            }, 5000);
                        }
                );
            }
        }
    }]);

//Patient image upload
angular.module('app').controller('PatientImageController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', 'fileUpload', '$state', '$http', 'block', function (scope, $scope, $modalInstance, $rootScope, $timeout, fileUpload, $state, $http, block) {
        $scope.fileUpload = fileUpload;
        $scope.block = block;

        $scope.uploadFile = function () {
            var file = $scope.myFile;
            var uploadUrl = $rootScope.IRISOrgServiceUrl + '/patient/uploadimage?patient_id=' + $state.params.id;
            fileUpload.uploadFileToUrl(file, uploadUrl).success(function (response) {
                if (response.success) {
                    scope.patientObj.patient_image = response.patient.patient_image;
                    $scope.cancel();
                } else {
                    $scope.errorData2 = response.message;
                }
            }).error(function (data, status) {
                if (status == 422)
                    $scope.errorData2 = $scope.errorSummary(data);
                else
                    $scope.errorData2 = data.message;
            });
        };

        //Take Picture From WebCam.
        $scope.picture = '';

        $scope.$watch('picture', function (newValue, oldValue) {
            if (newValue != '') {
                $scope.uploadPatientPicture(newValue, 'topbar');
            }
        }, true);

        //Crop Picture Concept.
        $scope.myImage = '';
        $scope.myCroppedImage = '';

        var handleFileSelect = function (evt) {
            var file = evt.currentTarget.files[0];
            var reader = new FileReader();
            reader.onload = function (evt) {
                $scope.$apply(function ($scope) {
                    $scope.myImage = evt.target.result;
                });
            };
            reader.readAsDataURL(file);
        };

        $timeout(function () {
            angular.element(document.querySelector('#fileInput')).on('change', handleFileSelect);
        }, 1000, false);

        //Upload file in database
        $scope.uploadPatientPicture = function (image_data, block) {
            $http({
                method: "POST",
                url: $rootScope.IRISOrgServiceUrl + '/patient/uploadimage?patient_id=' + $state.params.id,
                data: {file_data: image_data, block: block},
            }).success(
                    function (response) {
                        if (response.success) {
                            if (block == 'topbar')
                                scope.patientObj.patient_image = response.patient.patient_image;

                            if (block == 'register') {
                                scope.$broadcast('register_patient_image', response.file);
                            }
                            $scope.cancel();
                        } else {
                            $scope.errorData2 = response.message;
                        }
                    }
            ).error(function (data, status) {
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };

    }]);
