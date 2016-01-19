app.controller('DoctorSchedulesController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        //Index Page
        $scope.loadDoctorSchedulesList = function () {
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/DoctorSchedule')
                    .success(function (DoctorSchedules) {
                        $scope.rowCollection = DoctorSchedules;
                        $scope.displayedCollection = [].concat($scope.rowCollection);

                        //Load All Subcategories
                        $http.get($rootScope.IRISOrgServiceUrl + '/roomchargesubcategory')
                                .success(function (roomChargeSubCategorys) {
                                    $scope.allSubCategories = roomChargeSubCategorys;

                                    angular.forEach($scope.displayedCollection, function (parent) {
                                        parent.subcategories = [];
                                        angular.forEach($scope.allSubCategories, function (sub) {
                                            if (sub.charge_cat_id == parent.charge_cat_id) {
                                                parent.subcategories.push(sub);
                                            }
                                        });
                                    });
                                })
                                .error(function () {
                                    $scope.error = "An Error has occured while loading roomChargesubCategorys!";
                                });
                        //End
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading DoctorSchedules!";
                    });

        };

        //For Form
        $scope.initForm = function () {
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });
            $rootScope.commonService.GetDayList(function (response) {
                $scope.days = response;
                angular.forEach($scope.days, function (day) {
                    day.checked = '';
                });
            });
        }

        $scope.addSubRow = function (id) {
            angular.forEach($scope.displayedCollection, function (parent) {
                if (parent.charge_cat_id == id) {
                    $scope.inserted = {
                        temp_charge_cat_id: parent.subcategories.length + 1,
                        charge_cat_id: id,
                        charge_subcat_name: '',
                    };
                    parent.subcategories.push($scope.inserted);
                    return;
                }
            });
        };

        $scope.updateName = function (data, id, charge_cat_id, temp_charge_cat_id) {
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

                            //Update Subcategory
                            angular.forEach($scope.displayedCollection, function (parent) {
                                if (parent.charge_cat_id == charge_cat_id) {
                                    angular.forEach(parent.subcategories, function (sub) {
                                        if (typeof temp_charge_cat_id != 'undefined') {
                                            if (sub.temp_charge_cat_id == temp_charge_cat_id) {
                                                var index = parent.subcategories.indexOf(sub);
                                                parent.subcategories.splice(index, 1);
                                                parent.subcategories.push(response);
                                            }
                                        }
                                    });
                                }
                            });
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

        $scope.deleteSubRow = function (charge_cat_id, charge_subcat_id, temp_charge_cat_id) {
            //Remove Temp Row from Table
            if (typeof temp_charge_cat_id != 'undefined') {
                angular.forEach($scope.displayedCollection, function (parent) {
                    if (parent.charge_cat_id == charge_cat_id) {
                        angular.forEach(parent.subcategories, function (sub) {
                            if (sub.temp_charge_cat_id == temp_charge_cat_id) {
                                var index = parent.subcategories.indexOf(sub);
                                parent.subcategories.splice(index, 1);
                            }
                        });
                    }
                });
            }
            //Remove Row from Table & DB
            if (typeof charge_subcat_id != 'undefined') {
                var conf = confirm('Are you sure to delete ?');
                if (conf) {
                    angular.forEach($scope.displayedCollection, function (parent) {
                        if (parent.charge_cat_id == charge_cat_id) {
                            angular.forEach(parent.subcategories, function (sub) {
                                if (sub.charge_subcat_id == charge_subcat_id) {
                                    var index = parent.subcategories.indexOf(sub);
                                    $scope.loadbar('show');
                                    if (index !== -1) {
                                        $http({
                                            url: $rootScope.IRISOrgServiceUrl + "/roomchargesubcategory/remove",
                                            method: "POST",
                                            data: {id: charge_subcat_id}
                                        }).then(
                                                function (response) {
                                                    $scope.loadbar('hide');
                                                    if (response.data.success === true) {
                                                        parent.subcategories.splice(index, 1);
                                                        $scope.successMessage = sub.charge_subcat_name + ' deleted successfully !!!';
                                                    }
                                                    else {
                                                        $scope.errorData = response.data.message;
                                                    }
//                                                    $scope.loadDoctorSchedulesList();
                                                }
                                        )
                                    }
                                }
                            });
                        }
                    });
                }
            }
        };
        //End
        $scope.checkInput = function (data) {
            if (typeof data === 'undefined' || data == '') {
                return "Field should not be empty.";
            }
        };

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/doctorschedules';
                method = 'POST';
                succ_msg = 'DoctorSchedule saved successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/doctorschedules/' + _that.data.charge_cat_id;
                method = 'PUT';
                succ_msg = 'DoctorSchedule updated successfully';
            }

            console.log($scope.timings);
            _that.data.custom_day = [];
            angular.forEach($scope.days, function (day) {
                if (day.checked == true)
                    _that.data.custom_day.push(day.value);
            });

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
                            $state.go('configuration.docSchedule');
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
                url: $rootScope.IRISOrgServiceUrl + "/doctorschedules/" + $state.params.id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;

                        //Load Subcategories
                        $http.get($rootScope.IRISOrgServiceUrl + '/roomchargesubcategory')
                                .success(function (DoctorSchedules) {
                                    angular.forEach(DoctorSchedules, function (sub) {
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
                        url: $rootScope.IRISOrgServiceUrl + "/DoctorSchedule/remove",
                        method: "POST",
                        data: {id: row.charge_cat_id}
                    }).then(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.data.success === true) {
                                    $scope.successMessage = row.charge_cat_name + ' deleted successfully !!!';
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
            $scope.timings = [{
                    time_in: '',
                    time_out: '',
                    checked: '',
                }];
            $scope.deletedsubcategories = [];
        // add Row
        $scope.addRow = function () {
            $scope.inserted = {
                time_in: '',
                time_out: '',
                checked: '',
            };
            $scope.timings.push($scope.inserted);
        };

        // remove Row
        $scope.removeTime = function (index, id) {
            if (id != '')
                $scope.deletedsubcategories.push(id);
            $scope.timings.splice(index, 1);
        };

        $scope.ctrl = {};
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };
    }]);
