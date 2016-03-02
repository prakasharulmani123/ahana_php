app.controller('PatientRegisterController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = false;
        $scope.app.settings.patientSideMenu = false;
        $scope.app.settings.patientContentClass = 'app-content app-content3';
        $scope.app.settings.patientFooterClass = 'app-footer app-footer3';

        //Index Page
        $scope.loadPatientsList = function () {
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/patient')
                    .success(function (patients) {
                        $scope.rowCollection = patients;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patients!";
                    });
        };

        $scope.initForm = function () {
            $rootScope.commonService.GetFloorList('', '1', false, function (response) {
                $scope.floors = response.floorList;
            });

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
            });

            $rootScope.commonService.GetCityList(function (response) {
                $scope.cities = response.cityList;
            });

            $rootScope.commonService.GetPatientRegisterModelList(function (response) {
                $scope.registerModes = response;
            });

            $rootScope.commonService.GetTitleCodes(function (response) {
                $scope.titleCodes = response;
            });

            $rootScope.commonService.GetBloodList(function (response) {
                $scope.bloods = response;
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

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.maxDate = new Date();

//        $scope.disabled = function (date, mode) {
//            return mode === 'day' && (date.getDay() === 0 || date.getDay() === 6);
//        };

        var changeTimer = false;

        $scope.$watch('data.PatPatient.patient_firstname', function (newValue, oldValue) {
            $scope.post_search(newValue);
        }, true);

//        $scope.$watch('data.PatPatient.patient_lastname', function (newValue, oldValue) {
//            $scope.post_search(newValue);
//        }, true);

        $scope.$watch('data.PatPatient.patient_mobile', function (newValue, oldValue) {
            $scope.post_search(newValue);
        }, true);

        $scope.post_search = function (newValue) {
            if (newValue != '') {
                if (changeTimer !== false)
                    clearTimeout(changeTimer);

                changeTimer = setTimeout(function () {
                    $http({
                        method: 'POST',
                        url: $rootScope.IRISOrgServiceUrl + '/patient/search',
                        data: {'search': newValue},
                    }).success(
                            function (response) {
                                $scope.matchings = response.patients;
                            }
                    );
                    changeTimer = false;
                }, 300);
            }
        }

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

        //Save Both Add Data
        $scope.saveForm = function (mode) {
            _that = this;
            reg_mode = _that.data.PatPatient.patient_reg_mode;

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/patient/registration';
            method = 'POST';
            succ_msg = 'Patient saved successfully';

//            _that.data.PatPatient.patient_dob = moment(_that.data.PatPatient.patient_dob).format('YYYY-MM-DD');

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.success == true) {
                            $scope.successMessage = succ_msg;
                            var patient_guid = response.patient_guid;
                            $timeout(function () {
                                if (reg_mode == "IP") {
                                    $state.go('patient.admission', {id: patient_guid});
                                } else if (reg_mode == "OP") {
                                    $state.go('patient.appointment', {id: patient_guid});
                                } else {
                                    $state.go('patient.view', {id: patient_guid});
                                }
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

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patients/" + $state.params.id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        //Delete
        $scope.removeRow = function (row) {
            var conf = confirm('Are you sure to delete ? \nNote: All the Rooms under this patient will also be deleted !!!');
            if (conf) {
                $scope.loadbar('show');
                var index = $scope.displayedCollection.indexOf(row);
                if (index !== -1) {
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/patient/remove",
                        method: "POST",
                        data: {id: row.patient_id}
                    }).then(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.data.success === true) {
                                    $scope.displayedCollection.splice(index, 1);
                                    $scope.loadPatientsList();
                                }
                                else {
                                    $scope.errorData = response.data.message;
                                }
                            }
                    )
                }
            }
        };
    }])
        .filter('highlight', function ($sce) {
            return function (text, phrase) {
                if (phrase)
                    text = text.replace(new RegExp('(' + phrase + ')', 'gi'),
                            '<span class="highlighted">$1</span>')

                return $sce.trustAsHtml(text)
            }
        });
;