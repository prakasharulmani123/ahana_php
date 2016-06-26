app.controller('UsersController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$modal', '$log', function ($rootScope, $scope, $timeout, $http, $state, $modal, $log) {

        //Index Page
        $scope.loadList = function () {
            $scope.isLoading = true;
            $scope.rowCollection = [];

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/user/getuserdata')
                    .success(function (users) {
                        $scope.isLoading = false;
                        $scope.rowCollection = users;

                        //Avoid pagination problem, when come from other pages.
                        $scope.footable_redraw();
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading users!";
                    });
        };

        //For User Form
        $scope.initForm = function () {
            $scope.loadbar('show');
            $rootScope.commonService.GetTitleCodes(function (response) {
                $scope.title_codes = response;

                $rootScope.commonService.GetCountryList(function (response) {
                    $scope.countries = response.countryList;

                    $rootScope.commonService.GetStateList(function (response) {
                        $scope.states = response.stateList;

                        $rootScope.commonService.GetCityList(function (response) {
                            $scope.cities = response.cityList;

                            $rootScope.commonService.GetSpecialityList('', '1', false, function (response) {
                                $scope.specialities = response.specialityList;

                                $scope.loadbar('hide');
                                if ($scope.data.formrole == 'update') {
                                    $scope.loadForm();
                                }
                            });
                        });
                    });
                });
            });

        }
        
        $scope.updateState2 = function () {
            $scope.availableStates2 = [];
            $scope.availableCities2 = [];

            _that = this;
            angular.forEach($scope.states, function (value) {
                if (value.countryId == _that.data.country_id) {
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
                if (value.stateId == _that.data.state_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableCities2.push(obj);
                }
            });
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/users/createuser';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/user/updateuser';
            }

            $scope.loadbar('show');
            $http({
                method: "POST",
                url: post_url,
                data: _that.data,
            }).then(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.data.success === true) {

                            if (mode !== 'add') {
                                $scope.successMessage = " User updated successfully";
                                $timeout(function () {
                                    $state.go('configuration.registration');
                                }, 1000)
                            }
                            else {
                                $scope.successMessage = "User saved successfully";
                                $scope.data = {};
                                $timeout(function () {
                                    $state.go('configuration.registration');
                                }, 1000)
                            }
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
        };

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/user/getuser?id=" + $state.params.id,
                method: "GET"
            }).then(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.data.success === true) {
                            $scope.data = response.data.return;
                            $scope.updateState2();
                            $scope.updateCity2();
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
        };

        //Get Data for Login update Form
        $scope.loadLoginForm = function () {
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/user/getlogin?id=" + $state.params.id,
                method: "GET"
            }).then(
                    function (response) {
                        if (response.data.success === true) {
                            if (!jQuery.isEmptyObject(response.data.return)) {
                                $scope.data = response.data.return;
                                $scope.data.password = '';
                                $scope.data.form_type = 'update';
                            } else {
                                $scope.data.form_type = 'add';
                            }
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
        };

        //Save Both Add & Update Login Data
        $scope.saveLogin = function () {
            _that = this;

            _that.data.user_id = {};
            _that.data.user_id = $state.params.id;

            _that.data.activation_date = moment(_that.data.activation_date).format('YYYY-MM-DD');
            _that.data.Inactivation_date = moment(_that.data.Inactivation_date).format('YYYY-MM-DD');

            $scope.errorData = "";
            $scope.successMessage = "";

            $scope.loadbar('show');
            $http({
                method: "POST",
                url: $rootScope.IRISOrgServiceUrl + '/users/updatelogin',
                data: sanitizeVariable(_that.data),
            }).then(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.data.success === true) {
                            $scope.successMessage = "Login saved successfully";
//                            $scope.data = {};
                            $timeout(function () {
                                $state.go('configuration.registration');
                            }, 1000)
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
        };

        sanitizeVariable = function (data) {
            var result = {};
            angular.forEach(data, function (value, key) {
                if (typeof value == "undefined") {
                    result[key] = '';
                } else {
                    result[key] = value;
                }
            }, result);
            return result;
        }

        //For Datepicker
        $scope.open = function ($event, mode) {
            $event.preventDefault();
            $event.stopPropagation();

            $scope.opened1 = $scope.opened2 = false;

            switch (mode) {
                case 'opened1':
                    $scope.opened1 = true;
                    break;
                case 'opened2':
                    $scope.opened2 = true;
                    break;
            }
        };

        $scope.toggleMin = function () {
            $scope.minDate = $scope.minDate ? null : new Date();
        };
        $scope.toggleMin();

        $scope.disabled = function (date, mode) {
            return mode === 'day' && (date.getDay() === 0 || date.getDay() === 6);
        };
        
        $scope.openModal = function (size, ctrlr, tmpl, update_col) {
            var modalInstance = $modal.open({
                templateUrl: tmpl,
                controller: ctrlr,
                size: size,
                resolve: {
                    scope: function () {
                        return $scope;
                    },
                    column: function () {
                        return update_col;
                    },
                    country_id: function () {
                        return $scope.data.country_id;
                    },
                    state_id: function () {
                        return $scope.data.state_id;
                    },
                }
            });

            modalInstance.result.then(function (selectedItem) {
                $scope.selected = selectedItem;
            }, function () {
                $log.info('Modal dismissed at: ' + new Date());
            });
        };
        
        $scope.afterCountryAdded = function(country_id){
            $scope.data.country_id = country_id;
            $scope.updateState2();
        }
        
        $scope.afterStateAdded = function(state_id){
            $scope.data.state_id = state_id;
            $scope.updateState2();
        }

        $scope.afterCityAdded = function(city_id){
            $scope.data.city_id = city_id;
            $scope.updateCity2();
        }
    }]);