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
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading roomChargeCategorys!";
                    });
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
                                        if (sub.charge_cat_id == response.charge_cat_id)
                                            $scope.subcategories.push(sub);
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
                var index = $scope.displayedCollection.indexOf(row);
                if (index !== -1) {
                    $http({
                        url: $rootScope.IRISOrgServiceUrl + "/roomchargecategory/remove",
                        method: "POST",
                        data: {id: row.charge_cat_id}
                    }).then(
                            function (response) {
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
    }]);