app.controller('UsersController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'toaster', function ($rootScope, $scope, $timeout, $http, $state, toaster) {
        
        //Index Page
        $scope.loadList = function () {
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/user/getuserdata')
                    .success(function (roles) {
                        $scope.rowCollection = roles;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading roles!";
                    });
        };

        //For User Form
        $rootScope.commonService.GetTitleCodes(function (response) {
            $scope.title_codes = response;
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

            $('.butterbar').removeClass('hide').addClass('active');
            $http({
                method: "POST",
                url: post_url,
                data: _that.data,
            }).then(
                    function (response) {
                        $('.butterbar').removeClass('active').addClass('hide');
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
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/user/getuser?id=" + $state.params.id,
                method: "GET"
            }).then(
                    function (response) {
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

            $scope.errorData = "";
            $scope.successMessage = "";

            $('.butterbar').removeClass('hide').addClass('active');
            $http({
                method: "POST",
                url: $rootScope.IRISOrgServiceUrl + '/users/updatelogin',
                data: sanitizeVariable(_that.data),
            }).then(
                    function (response) {
                        $('.butterbar').removeClass('active').addClass('hide');
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

            switch (mode) {
                case 'opened1':
                    $scope.opened1 = true;
                    break;
                case 'opened2':
                    $scope.opened2 = true;
                    break;
            }
        };

    }]);