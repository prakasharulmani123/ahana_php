app.controller('ChargePerCategoriesController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$modal', function ($rootScope, $scope, $timeout, $http, $state, $modal) {

        //Index Page
        $scope.loadChargePerCategoriesList = function () {
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/chargepercategory')
                    .success(function (charge_per_categories) {
                        $scope.rowCollection = charge_per_categories;
                        $scope.displayedCollection = [].concat($scope.rowCollection);

//                        angular.forEach($scope.rowCollection, function (value) {
//                            $rootScope.commonService.GetChargePerSubCategoryList(false, value.charge_id, function (response) {
//                                $scope.displayedCollection.subcategories = response.subcategoryList;
//                            });
//                        });
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading charges!";
                    });

            $rootScope.commonService.GetChargePerSubCategoryList(false, '', function (response) {
                $scope.allSubCategories = response.subcategoryList;
            });
        };
        $scope.ctrl = {};
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        //For Form
        $scope.initForm = function () {
            $rootScope.commonService.GetRoomChargeCategoryList('', '1', false, function (response) {
                $scope.categories = response.categoryList;
            });
            $rootScope.commonService.GetRoomChargeSubCategoryList('', '1', false, '', function (response) {
                $scope.sub_categories = response.subcategoryList;
            });
            $rootScope.commonService.GetPatientCateogryList('', '1', false, function (response) {
                $scope.patient_categories = [];
                angular.forEach(response.patientcategoryList, function (value) {
                    value.amount = '';
                    $scope.patient_categories.push(value);
                });
            });
            $rootScope.commonService.GetRoomTypeList('', '1', false, function (response) {
                $scope.room_types = [];
                angular.forEach(response.roomtypeList, function (value) {
                    value.amount = '';
                    $scope.room_types.push(value);
                });
            });
        }

        $scope.updateSubCateogry = function () {
            $scope.availableSubcategories = [];

            _that = this;
            angular.forEach($scope.sub_categories, function (value) {
                if (value.charge_cat_id == _that.data.charge_cat_id) {
                    $scope.availableSubcategories.push(value);
                }
            });
        }


        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            if ($scope.chargeForm.$valid) {
                _that = this;

                $scope.errorData = "";
                $scope.successMessage = "";

                if (mode == 'add') {
                    post_url = $rootScope.IRISOrgServiceUrl + '/chargepercategories';
                    method = 'POST';
                    succ_msg = 'ChargePerCategory saved successfully';
                } else {
                    post_url = $rootScope.IRISOrgServiceUrl + '/chargepercategories/' + _that.data.charge_id;
                    method = 'PUT';
                    succ_msg = 'ChargePerCategory updated successfully';
                }

                $scope.loadbar('show');

                $http({
                    method: method,
                    url: post_url,
                    data: _that.data,
                }).success(
                        function (response) {
                            form_datas = [];
                            angular.forEach($scope.patient_categories, function (value) {
                                form_data = {};
                                form_data.charge_id = response.charge_id;
                                form_data.charge_type = 'OP';
                                form_data.charge_link_id = value.patient_cat_id;
                                form_data.charge_amount = value.amount;

                                form_datas.push(form_data);
                            });

                            angular.forEach($scope.room_types, function (value) {
                                form_data = {};
                                form_data.charge_id = response.charge_id;
                                form_data.charge_type = 'IP';
                                form_data.charge_link_id = value.room_type_id;
                                form_data.charge_amount = value.amount;

                                form_datas.push(form_data);
                            });

                            angular.forEach(form_datas, function (form_data) {
                                $http.post($rootScope.IRISOrgServiceUrl + '/chargepersubcategories', form_data)
                                        .error(function (data, status) {
                                            $scope.loadbar('hide');
                                            if (status == 422)
                                                $scope.errorData = $scope.errorSummary(data);
                                            else
                                                $scope.errorData = data.message;
                                            return false;
                                        });
                            });

                            $scope.loadbar('hide');
                            $scope.successMessage = succ_msg;
                            $scope.data = {};
                            $timeout(function () {
                                $state.go('configuration.chargePerCategory');
                            }, 1000)
                        }
                ).error(function (data, status) {
                    $scope.loadbar('hide');
                    if (status == 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
                return false;
            } else {
                $scope.errorData = 'Please fill the required fields';
            }
        };

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/chargepercategories/" + $state.params.id,
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
            var conf = confirm('Are you sure to delete ?');
            if (conf) {
                $scope.loadbar('show');
                var index = $scope.displayedCollection.indexOf(row);
                if (index !== -1) {
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/charge/remove",
                        method: "POST",
                        data: {id: row.charge_id}
                    }).then(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.data.success === true) {
                                    $scope.displayedCollection.splice(index, 1);
                                    $scope.loadChargePerCategoriesList();
                                }
                                else {
                                    $scope.errorData = response.data.message;
                                }
                            }
                    )
                }
            }
        };

        //Update Modal
        $scope.open = function (size) {
            var modalInstance = $modal.open({
                templateUrl: 'myModalContent.html',
                controller: 'ModalInstanceCtrl',
                size: size,
//                resolve: {
//                    items: function () {
//                        return 'test';
//                    }
//                }
            });
        };

    }]);

app.controller('ModalInstanceCtrl', ['$scope', '$modalInstance', function ($scope, $modalInstance) {

        $scope.ok = function () {
            $modalInstance.close($scope.selected.item);
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };
    }]); 