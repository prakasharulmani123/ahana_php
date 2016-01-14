app.controller('RoomChargeCategorysController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        //Index Page
        $scope.loadRoomChargeCategorysList = function () {
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/roomchargecategory')
                    .success(function (roomChargeCategorys) {
                        $scope.rowCollection = roomChargeCategorys;
                        $scope.displayedCollection = [].concat($scope.rowCollection);

                        //Load All Subcategories
                        var _all_sub_cat = {};
                        $http.get($rootScope.IRISOrgServiceUrl + '/roomchargesubcategory')
                                .success(function (roomChargeSubCategorys) {
                                    _all_sub_cat = roomChargeSubCategorys;
                                    $scope.allSubCategories = roomChargeSubCategorys;
                                })
                                .error(function () {
                                    $scope.error = "An Error has occured while loading roomChargesubCategorys!";
                                });
                        angular.forEach(roomChargeCategorys, function (parent) {

                        });
                        //End
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading roomChargeCategorys!";
                    });
                    
//            $http.get($rootScope.IRISOrgServiceUrl + '/roomchargesubcategory/getcustomlist').success(function (data) {
//                $scope.allSubCategories = data;
//            });
        };

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/roomchargecategories';
                method = 'POST';
                succ_msg = 'RoomChargeCategory saved successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/roomchargecategories/' + _that.data.charge_cat_id;
                method = 'PUT';
                succ_msg = 'RoomChargeCategory updated successfully';
            }

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        angular.forEach($scope.subcategories, function (sub) {
                            sub.charge_cat_id = response.charge_cat_id;
                            if (sub.charge_subcat_id == '') {
                                $http.post($rootScope.IRISOrgServiceUrl + '/roomchargesubcategories', sub);
                            } else {
                                $http.put($rootScope.IRISOrgServiceUrl + '/roomchargesubcategories/' + sub.charge_subcat_id, sub);
                            }
                        });

                        //Delete Subcategories
                        angular.forEach($scope.deletedsubcategories, function (del) {
                            $http({
                                url: $rootScope.IRISOrgServiceUrl + "/roomchargesubcategory/remove",
                                method: "POST",
                                data: {id: del}
                            });
                        });
                        $scope.loadbar('hide');
                        $scope.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            $state.go('configuration.roomChargeCategory');
                        }, 1000)

                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };
        
        $scope.updateName = function (data, id, charge_cat_id) {
            $scope.errorData = $scope.successMessage = '';
            if (typeof data.charge_subcat_name != 'undefined') {
                if (typeof id != 'undefined') {
                    post_method = 'PUT';
                    post_url = $rootScope.IRISOrgServiceUrl + '/roomchargesubcategories/' + id;
                    succ_msg = 'ChargePerCategory Updated successfully';
                } else {
                    post_method = 'POST';
                    post_url = $rootScope.IRISOrgServiceUrl + '/roomchargesubcategories';
                    angular.extend(data, {charge_cat_id: charge_cat_id});
                    succ_msg = 'ChargePerCategory saved successfully';
                }
                $http({
                    method: post_method,
                    url: post_url,
                    data: data,
                }).success(
                        function (response) {
                            $scope.loadbar('hide');
                            $scope.successMessage = succ_msg;
                        }
                ).error(function (data, status) {
                    $scope.loadbar('hide');
                    if (status == 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
            }
        };

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/roomchargecategories/" + $state.params.id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;

                        //Load Subcategories
                        $http.get($rootScope.IRISOrgServiceUrl + '/roomchargesubcategory')
                                .success(function (roomChargeCategorys) {
                                    angular.forEach(roomChargeCategorys, function (sub) {
                                        if (sub.charge_cat_id == response.charge_cat_id) {
                                            $scope.inserted = {
                                                charge_subcat_id: sub.charge_subcat_id,
                                                charge_subcat_name: sub.charge_subcat_name,
                                            };
                                            $scope.subcategories.push($scope.inserted);
                                        }
                                    });
                                })
                                .error(function () {
                                    $scope.error = "An Error has occured while loading roomChargesubCategorys!";
                                });
                        //End
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
                        url: $rootScope.IRISOrgServiceUrl + "/roomchargecategory/remove",
                        method: "POST",
                        data: {id: row.charge_cat_id}
                    }).then(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.data.success === true) {
                                    $scope.displayedCollection.splice(index, 1);
                                }
                                else {
                                    $scope.errorData = response.data.message;
                                }
                            }
                    )
                }
            }
        };

        // editable table
        $scope.subcategories = [];
        $scope.deletedsubcategories = [];
        // add Row
        $scope.addRow = function () {
            $scope.inserted = {
                charge_subcat_id: '',
                charge_subcat_name: '',
            };
            $scope.subcategories.push($scope.inserted);
        };

        // remove Row
        $scope.removeSubcat = function (index, id) {
            if (id != '')
                $scope.deletedsubcategories.push(id);
            $scope.subcategories.splice(index, 1);
        };

        $scope.checkInput = function (data, id) {
            if (data == '') {
                return "Field should not be empty.";
            }
        };

        $scope.ctrl = {};
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };
    }]);
