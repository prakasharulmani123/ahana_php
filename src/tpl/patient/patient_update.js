app.controller('PatientUpdateController', ['$rootScope', '$scope', '$http', '$anchorScroll', '$timeout', '$state', function ($rootScope, $scope, $http, $anchorScroll, $timeout, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.$watch('app.patientDetail.patientId', function (newValue, oldValue) {
            if (newValue != '') {
                $scope.data = {};
                $scope.data.PatPatient = $scope.patientObj;
                $scope.data.PatPatientAddress = $scope.patientObj.address;
                
                $scope.initForm();
                
            }
        }, true);

        $scope.initForm = function () {

            $rootScope.commonService.GetGenderList(function (response) {
                $scope.genders = response;
            });

            $rootScope.commonService.GetPatientBillingList(function (response) {
                $scope.bill_types = response;
            });

            $rootScope.commonService.GetCountryList(function (response) {
                $scope.countries = response.countryList;
            });

            $rootScope.commonService.GetStateList(function (response) {
                $scope.states = response.stateList;
                $scope.updateState2();
                $scope.updateState();
            });

            $rootScope.commonService.GetCityList(function (response) {
                $scope.cities = response.cityList;
                $scope.updateCity2();
                $scope.updateCity();
            });

            $rootScope.commonService.GetPatientRegisterModelList(function (response) {
                $scope.registerModes = response;
            });

            $rootScope.commonService.GetTitleCodes(function (response) {
                $scope.titleCodes = response;
            });

            $rootScope.commonService.GetMaritalStatus(function (response) {
                $scope.maritalStatuses = response;
            });

            $rootScope.commonService.GetPatientCateogryList('', '1', false, function (response) {
                $scope.categories = response.patientcategoryList;
            });
        }

        $scope.updateState2 = function () {
            $scope.availableStates2 = [];
            $scope.availableCities2 = [];

            _that = this;
            angular.forEach($scope.states, function (value) {
                if (value.countryId == _that.data.PatPatientAddress.addr_country_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableStates2.push(obj);
                }
            });
        }

        $scope.updateCity2 = function () {
            $scope.availableCities2 = [];

            _that = this;
            angular.forEach($scope.cities, function (value) {
                if (value.stateId == _that.data.PatPatientAddress.addr_state_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableCities2.push(obj);
                }
            });
        }

        $scope.updateState = function () {
            $scope.availableStates = [];
            $scope.availableCities = [];

            _that = this;
            angular.forEach($scope.states, function (value) {
                if (value.countryId == _that.data.PatPatientAddress.addr_perm_country_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableStates.push(obj);
                }
            });
        }

        $scope.updateCity = function () {
            $scope.availableCities = [];

            _that = this;
            angular.forEach($scope.cities, function (value) {
                if (value.stateId == _that.data.PatPatientAddress.addr_perm_state_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableCities.push(obj);
                }
            });
        }

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        var today = new Date();
        today.setMonth(today.getMonth() + 6);
        $scope.tre = today;

        $scope.maxDate = new Date(today.getFullYear(), today.getMonth(), today.getDate());
//        $scope.today = function () {
//            $scope.data = {};
//            $scope.data.PatPatient.patient_dob = new Date();
//        };
//        $scope.today();

        $scope.toggleMin = function () {
            $scope.minDate = $scope.minDate ? null : new Date();
        };
        $scope.toggleMin();

        $scope.disabled = function (date, mode) {
            return mode === 'day' && (date.getDay() === 0 || date.getDay() === 6);
        };


        $scope.setDateEmpty = function () {
            $scope.data.PatPatient.patient_dob = '';
        }

        $scope.setAgeEmpty = function () {
            $scope.data.PatPatient.patient_age = '';
        }

        $scope.getDOB = function () {
            var newValue = this.data.PatPatient.patient_age;
            if (parseInt(newValue) && !isNaN(newValue)) {
                $http({
                    method: 'POST',
                    url: $rootScope.IRISOrgServiceUrl + '/patient/getdatefromage',
                    data: {'age': newValue},
                }).success(
                        function (response) {
                            $scope.data.PatPatient.patient_dob = response.dob;
                        }
                );
            }
        }

        $scope.getAge = function () {
            var newValue = this.data.PatPatient.patient_dob;
            if (newValue != '') {
                $http({
                    method: 'POST',
                    url: $rootScope.IRISOrgServiceUrl + '/patient/getagefromdate',
                    data: {'date': newValue},
                }).success(
                        function (response) {
                            $scope.data.PatPatient.patient_age = response.age;
                        }
                );
            }
        }
        
        $scope.CopyAddress = function(){
            if($scope.data.is_permanent){
                $scope.data.PatPatientAddress.addr_perm_address = $scope.data.PatPatientAddress.addr_current_address;
                $scope.data.PatPatientAddress.addr_perm_country_id = $scope.data.PatPatientAddress.addr_country_id;
                $scope.data.PatPatientAddress.addr_perm_state_id = $scope.data.PatPatientAddress.addr_state_id;
                $scope.data.PatPatientAddress.addr_perm_city_id = $scope.data.PatPatientAddress.addr_city_id;
                $scope.data.PatPatientAddress.addr_perm_zip = $scope.data.PatPatientAddress.addr_zip;
                $scope.updateState();
                $scope.updateCity();
            }
        }

        //Save Both Add Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/patient/registration';
            method = 'POST';
            succ_msg = 'Patient saved successfully';

            _that.data.PatPatient.patient_dob = moment(_that.data.PatPatient.patient_dob).format('YYYY-MM-DD');
            
            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $anchorScroll();
                        $scope.loadbar('hide');
                        if (response.success == true) {
                            $scope.successMessage = succ_msg;
                            
                            $scope.app.patientDetail.patientTitleCode = response.patient.patient_title_code;
                            $scope.app.patientDetail.patientName = response.patient.patient_firstname;
                            $scope.app.patientDetail.patientId = response.patient.patient_id;
                            $scope.app.patientDetail.patientDOA = response.patient.doa;
                            $scope.app.patientDetail.patientOrg = response.patient.org_name;
                            $scope.app.patientDetail.patientAge = response.patient.patient_age;
                            $scope.app.patientDetail.patientCasesheetno = response.patient.casesheetno;
                            $rootScope.commonService.GetLabelFromValue(response.patient.patient_gender, 'GetGenderList', function (response) {
                                $scope.app.patientDetail.patientSex = response;
                            });
                            $scope.patientObj = response;
                            
                            $timeout(function () {
                                $state.go('patient.view', {id: response.patient_id});
                            }, 1000)
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
        };

    }]);