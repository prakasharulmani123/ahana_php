'use strict';

/* Controllers */

angular.module('app')
        .controller('AppCtrl', ['$scope', '$localStorage', '$window', '$rootScope', '$state', '$cookieStore', '$http', 'CommonService', '$timeout', 'AuthenticationService', 'toaster', 'hotkeys', '$modal',
            function ($scope, $localStorage, $window, $rootScope, $state, $cookieStore, $http, CommonService, $timeout, AuthenticationService, toaster, hotkeys, $modal) {
                // add 'ie' classes to html
                var isIE = !!navigator.userAgent.match(/MSIE/i);
                isIE && angular.element($window.document.body).addClass('ie');
                isSmartDevice($window) && angular.element($window.document.body).addClass('smart');

                // config
                $scope.app = {
                    name: 'IRIS',
                    org_name: '',
                    org_address: '',
                    org_country: '',
                    org_state: '',
                    org_city: '',
                    org_mobile: '',
                    version: '',
                    username: '',
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
                        patientFullname: '',
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
                        patientActiveCasesheetno: '',
                        patientActiveIP: '',
                        patientCurrentRoom: '',
                        patientLastConsultantId: '',
                        patientLastConsultantName: '',
                        patientHaveEncounter: '',
                        patientImage: '',
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
                    $http.post($rootScope.IRISOrgServiceUrl + '/user/logout')
                            .success(function (response) {
                                if (response.success) {
                                    if (AuthenticationService.ClearCredentials()) {
                                        $timeout(function () {
                                            $window.location.reload();
                                        }, 1000);
                                    }
                                } else {
                                    $scope.errorData = response.message;
                                }
                            })
                            .error(function () {
                                $scope.errorData = "An Error has occured while loading patient!";
                            });
                };

                $rootScope.$on('unauthorized', function () {
                    toaster.clear();
                    toaster.pop('error', 'Session Expired', 'Kindly Login Again');
                    $scope.logout();
                });

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
                        $('.save-btn,.get-report,.search-btn,.save-print,.save-future').attr('disabled', true).html("<i class='fa fa-spin fa-spinner'></i> Please Wait...");
                    } else if (mode == 'hide') {
                        $('.butterbar').removeClass('active').addClass('hide');
                        $('.save-btn').attr('disabled', false).html("Save");
                        $('.get-report').attr('disabled', false).html("Get Report");
                        $('.search-btn').attr('disabled', false).html("Search");
                        $('.save-print').attr('disabled', false).html("<i class='fa fa-print'></i> Save and Print Bill");
                        $('.save-future').attr('disabled', false).html("Save & Future Appointment");
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
                                        $scope.app.patientDetail.patientTitleCode = patient.patient_title_code;
                                        $scope.app.patientDetail.patientName = patient.patient_firstname;
                                        $scope.app.patientDetail.patientFullname = patient.fullname;
                                        $scope.app.patientDetail.patientId = patient.patient_id;
                                        $scope.app.patientDetail.patientIntCode = patient.patient_int_code;
                                        $scope.app.patientDetail.patientGuid = patient.patient_guid;
                                        $scope.app.patientDetail.patientDOA = patient.doa;
                                        $scope.app.patientDetail.patientOrg = patient.org_name;
                                        $scope.app.patientDetail.patientAge = patient.patient_age;
                                        $scope.app.patientDetail.patientCasesheetno = patient.activeCasesheetno;
                                        $scope.app.patientDetail.patientHasAlert = patient.hasalert;
                                        $scope.app.patientDetail.patientAlert = patient.alert;
                                        $scope.app.patientDetail.patientActiveCasesheetno = patient.activeCasesheetno;
                                        $scope.app.patientDetail.patientActiveIp = patient.patActiveIp;
                                        $scope.app.patientDetail.patientCurrentRoom = patient.current_room;
                                        $scope.app.patientDetail.patientLastConsultantId = patient.last_consultant_id;
                                        $scope.app.patientDetail.patientLastConsultantName = patient.consultant_name;
                                        $scope.app.patientDetail.patientHaveEncounter = patient.have_encounter;
                                        $scope.app.patientDetail.patientImage = patient.patient_image;
                                        $rootScope.commonService.GetLabelFromValue(patient.patient_gender, 'GetGenderList', function (response) {
                                            $scope.app.patientDetail.patientSex = response;
                                        });

                                        $scope.patientObj = patient;
                                    }

                                })
                                .error(function () {
                                    $scope.errorData = "An Error has occured while loading patient!";
                                });
                    }
                };

                $scope.loadUserCredentials = function () {
                    var user = AuthenticationService.getCurrentUser();
                    $scope.app.org_name = user.credentials.org;
                    $scope.app.org_address = user.credentials.org_address;
                    $scope.app.org_country = user.credentials.org_country;
                    $scope.app.org_state = user.credentials.org_state;
                    $scope.app.org_city = user.credentials.org_city;
                    $scope.app.org_mobile = user.credentials.org_mobile;
                    $scope.app.username = user.credentials.username;
                };

                $scope.checkAccess = function (url) {
                    var ret = true;
                    $rootScope.commonService.CheckStateAccess(url, function (response) {
                        ret = response;
                    });
                    return ret;
                }

                $scope.$watch('successMessage', function () {
                    if ($scope.successMessage) {
                        $timeout(function () {
                            $scope.successMessage = false;
                        }, 3000);
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

                $scope.$on('encounter_id', function (event, data) {
                    $scope.encounter_id = data;
                });

                $scope.addNotes = function () {
                    if (jQuery.isEmptyObject($scope.data)) {
                        $scope.notes_error = true;
                        return;
                    }
                    $scope.notes_error = false;

                    $scope.errorData = "";
                    $scope.successMessage = "";

                    angular.extend($scope.data, {
                        patient_id: $scope.app.patientDetail.patientId,
                        encounter_id: $scope.encounter_id
                    });

                    $scope.loadbar('show');

                    $http.post($rootScope.IRISOrgServiceUrl + '/patientnotes', $scope.data)
                            .success(function (response) {
                                $scope.data = {};
                                $scope.child.notes.push(response);
                                $scope.loadbar('hide');

                                $(".vbox .row-row .cell:visible").animate({scrollTop: $('.vbox .row-row .cell:visible').prop("scrollHeight")}, 1000);
//                                $scope.successMessage = 'Note saved successfully';
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
                    combo: 'ctrl+n',
                    description: 'Create',
                    callback: function (event) {
                        $scope.$broadcast('HK_CREATE');
                        event.preventDefault();
                    }
                });

                hotkeys.add({
                    combo: 'ctrl+s',
                    description: 'Save',
                    allowIn: ['INPUT', 'SELECT', 'TEXTAREA'],
                    callback: function (event) {
                        $scope.$broadcast('HK_SAVE');
                        event.preventDefault();
                    }
                });

                hotkeys.add({
                    combo: 's',
                    description: 'Search',
                    callback: function (event) {
                        $scope.$broadcast('HK_SEARCH');
                        event.preventDefault();
                    }
                });

                hotkeys.add({
                    combo: 'ctrl+left',
                    description: 'Back',
                    callback: function () {
                        $window.history.back();
                    }
                });

                hotkeys.add({
                    combo: 'ctrl+right',
                    description: 'Forward',
                    callback: function () {
                        $window.history.forward();
                    }
                });

                $scope.$on('HK_CREATE', function (e) {
                    alert('create');
                    angular.element(document.querySelectorAll("[hot-key-create]")).trigger('click');
                });
                $scope.$on('HK_SAVE', function (e) {
                    alert('create');
                });
                $scope.$on('HK_SEARCH', function (e) {
                    alert('create');
                });

                $scope.assignNotifications = function () {
                    //Assign Notes
                    $http({
                        method: 'POST',
                        url: $rootScope.IRISOrgServiceUrl + '/patientnotes/assignnotes',
                        data: {'patient_guid': $state.params.id},
                    });

                    //Assign Vitals
                    $http({
                        method: 'POST',
                        url: $rootScope.IRISOrgServiceUrl + '/patientvitals/assignvitals',
                        data: {'patient_guid': $state.params.id},
                    });
                }

                $scope.openUploadForm = function () {
                    var modalInstance = $modal.open({
                        templateUrl: 'tpl/modal_form/modal.patient_image.html',
                        controller: "PatientImageController",
                        size: 'lg',
                        resolve: {
                            scope: function () {
                                return $scope;
                            },
                        }
                    });
                }
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

//Patient image upload
angular.module('app').controller('PatientImageController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', 'fileUpload', '$state', '$http', function (scope, $scope, $modalInstance, $rootScope, $timeout, fileUpload, $state, $http) {
        $scope.fileUpload = fileUpload;

        $scope.uploadFile = function () {
            var file = $scope.myFile;
            var uploadUrl = $rootScope.IRISOrgServiceUrl + '/patient/uploadimage?patient_id=' + $state.params.id;
            fileUpload.uploadFileToUrl(file, uploadUrl).success(function (response) {
                if (response.success) {
                    scope.app.patientDetail.patientImage = response.patient.patient_image;
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
                $scope.uploadPatientPicture(newValue);
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
        $scope.uploadPatientPicture = function (image_data) {
            $http({
                method: "POST",
                url: $rootScope.IRISOrgServiceUrl + '/patient/uploadimage?patient_id=' + $state.params.id,
                data: {file_data: image_data},
            }).success(
                    function (response) {
                        if (response.success) {
                            scope.app.patientDetail.patientImage = response.patient.patient_image;
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