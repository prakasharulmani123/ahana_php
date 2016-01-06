app.controller('OrganizationController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        //Index Page
        //  pagination
        $scope.rowCollection = [];  // base collection
        $scope.itemsByPage = 10;
        $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection
        // Display Data
//        $http.get($rootScope.IRISOrgServiceUrl + '/organizations?expand=coMasterCity,coMasterState,coMasterCountry')
        $http.get($rootScope.IRISOrgServiceUrl + '/organizations')
                .success(function (usr) {
                    $scope.rowCollection = usr;
                    $scope.displayedCollection = [].concat($scope.rowCollection);
//                console.log($scope.rowCollection);
                })
                .error(function () {
                    $scope.error = "An Error has occured while loading posts!";

                });


        // Form Page
        $rootScope.commonService.GetCountryList(function (response) {
            $scope.countries = response.countryList;
        });

        $rootScope.commonService.GetStateList(function (response) {
            $scope.states = response.stateList;
        });

        $rootScope.commonService.GetCityList(function (response) {
            $scope.cities = response.cityList;
        });

        $rootScope.commonService.GetTitleCodes(function (response) {
            $scope.title_codes = response;
        });

        if ($state.current.name == 'app.org_new') {
            $http.get($rootScope.IRISOrgServiceUrl + "/default/get-module-tree").then(
                    function (response) {
                        $scope.modules = response.data.moduleList;
                    }
            );
        }


        $scope.updateState = function () {
            $scope.availableStates = [];
            $scope.availableCities = [];

            _that = this;
            angular.forEach($scope.states, function (value) {
                if (value.countryId == _that.data.Tenant.tenant_country_id) {
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
                if (value.stateId == _that.data.Tenant.tenant_state_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableCities.push(obj);
                }
            });
        }

        $scope.updateState2 = function () {
            $scope.availableStates2 = [];
            $scope.availableCities2 = [];

            _that = this;
            angular.forEach($scope.states, function (value) {
                if (value.countryId == _that.data.User.country_id) {
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
                if (value.stateId == _that.data.User.state_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableCities2.push(obj);
                }
            });
        }

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

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";
            $scope.moduleList = [];

            angular.forEach($scope.modules, function (parent) {
                if (parent.selected == true || parent.__ivhTreeviewIndeterminate == true) {
                    $scope.moduleList.push(parent.value);
                    angular.forEach(parent.children, function (child) {
                        if (child.selected == true)
                            $scope.moduleList.push(child.value);
                    });
                }
            });
            if (typeof this.data != "undefined") {
                this.data.Module = [];
                this.data.Module = {'resource_ids': $scope.moduleList};
            }

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/organizations/createorg';
                post_data = _that.data;
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/organizations/updateorg';
                if (mode == 'Organization') {
                    post_data = {Tenant: sanitizeVariable(this.data.Tenant)};
                } else if (mode == 'Role') {
                    post_data = {Role: sanitizeVariable(this.data.Role)};
                } else if (mode == 'Login') {
                    post_data = {Login: sanitizeVariable(this.data.Login)};
                } else if (mode == 'User') {
                    post_data = {User: sanitizeVariable(this.data.User)};
                } else if (mode == 'Module') {
                    this.data.Module['role_id'] = this.data.Role.role_id;
                    this.data.Module['tenant_id'] = this.data.Tenant.tenant_id;
                    post_data = {Module: sanitizeVariable(this.data.Module)};
                }
            }
            
            $('.butterbar').removeClass('hide').addClass('active');
            $http({
                method: "POST",
                url: post_url,
                data: post_data,
            }).then(
                    function (response) {
                        $('.butterbar').removeClass('active').addClass('hide');
                        if (response.data.success === true) {

                            if (mode !== 'add') {
                                $scope.successMessage = mode + " updated successfully";
                                $timeout(function () {
                                    $state.go('app.org_list');
                                }, 1000)
                            }
                            else {
                                $scope.steps.percent = 100;
                                $scope.successMessage = "Organization saved successfully";
                                $scope.data = {};
                                $timeout(function () {
                                    $state.go('app.org_list');
                                }, 1000)
                            }
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
        };

        $scope.validateForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'Organization') {
                post_data = {Tenant: sanitizeVariable(this.data.Tenant)};
            } else if (mode == 'Role') {
                post_data = {Role: sanitizeVariable(this.data.Role)};
            } else if (mode == 'Login') {
                post_data = {Login: sanitizeVariable(this.data.Login)};
            } else if (mode == 'User') {
                post_data = {User: sanitizeVariable(this.data.User)};
            }
            
            $('.butterbar').removeClass('hide').addClass('active');
            $http({
                method: "POST",
                url: $rootScope.IRISOrgServiceUrl + '/organizations/validateorg',
                data: post_data,
            }).then(
                    function (response) {
                        $('.butterbar').removeClass('active').addClass('hide');
                        if (response.data.success === false) {
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
                url: $rootScope.IRISOrgServiceUrl + "/organization/getorg?id=" + $state.params.id,
                method: "GET"
            }).then(
                    function (response) {
                        if (response.data.success === true) {
                            _that.data = response.data.return;
                            $scope.updateState();
                            $scope.updateCity();
                            $scope.updateState2();
                            $scope.updateCity2();
                            $scope.modules = response.data.modules;
                        }
                        else {
                            $scope.errorData = response.data;
                        }
                    }
            )
        };

        $scope.removeRow = function (row) {
            var index = $scope.rowCollectionBasic.indexOf(row);
            if (index !== -1) {
                $scope.rowCollectionBasic.splice(index, 1);
            }
        };
        
    }]);