// this is a lazy load controller, 
// so start with "app." to register this controller

app.filter('propsFilter', function () {
    return function (items, props) {
        var out = [];

        if (angular.isArray(items)) {
            items.forEach(function (item) {
                var itemMatches = false;

                var keys = Object.keys(props);
                for (var i = 0; i < keys.length; i++) {
                    var prop = keys[i];
                    var text = props[prop].toLowerCase();
                    if (item[prop].toString().toLowerCase().indexOf(text) !== -1) {
                        itemMatches = true;
                        break;
                    }
                }

                if (itemMatches) {
                    out.push(item);
                }
            });
        } else {
            // Let the output be the input untouched
            out = items;
        }

        return out;
    };
})
app.controller('ProcedureController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$timeout', '$filter', 'modalService', function ($rootScope, $scope, $timeout, $http, $state, $timeout, $filter, modalService) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.open_date = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened_date = true;
        };

        $scope.disabled = function (date, mode) {
            date = moment(date).format('YYYY-MM-DD');
            return $.inArray(date, $scope.enabled_dates) === -1;
        };

        $scope.ctrl = {};
        $scope.allExpanded = true;
        $scope.expanded = true;
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        $scope.enc = {};
        $scope.$watch('patientObj.patient_id', function (newValue, oldValue) {
            if (newValue != '') {
                $rootScope.commonService.GetEncounterListByPatient('', '0,1', false, $scope.patientObj.patient_id, function (response) {
                    angular.forEach(response, function (resp) {
                        resp.encounter_id = resp.encounter_id.toString();
                    });
                    $scope.encounters = response;
                    if (response != null) {
                        $scope.enc.selected = $scope.encounters[0];
                    }
                });
            }
        }, true);

        $scope.$watch('enc.selected.encounter_id', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.loadProceduresList();
            }
        }, true);

        $scope.initProcedureIndex = function () {
            $scope.data = {};
        }

        $scope.enabled_dates = [];
        $scope.loadProceduresList = function (date) {
            $scope.loadbar('show');
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            if (typeof date == 'undefined') {
                url = $rootScope.IRISOrgServiceUrl + '/procedure/getprocedurebyencounter?patient_id=' + $state.params.id;
            } else {
                date = moment(date).format('YYYY-MM-DD');
                url = $rootScope.IRISOrgServiceUrl + '/procedure/getprocedurebyencounter?patient_id=' + $state.params.id + '&date=' + date;
            }

            // Get data's from service
            $http.get(url)
                    .success(function (procedures) {
                        $scope.loadbar('hide');
                        $scope.isLoading = false;
                        $scope.rowCollection = procedures.result;
                        $scope.displayedCollection = [].concat($scope.rowCollection);

                        angular.forEach($scope.rowCollection, function (row) {
                            angular.forEach(row.all, function (all) {
                                var result = $filter('filter')($scope.enabled_dates, moment(all.proc_date).format('YYYY-MM-DD'));
                                if (result.length == 0)
                                    $scope.enabled_dates.push(moment(all.proc_date).format('YYYY-MM-DD'));
                            });
                        });
                        $scope.$broadcast('refreshDatepickers');
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading procedures!";
                    });
        };

        $scope.isPatientHaveActiveEncounter = function (callback) {
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveactiveencounter', {patient_id: $state.params.id})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        $scope.initCanSaveAdmission = function () {
            $scope.showForm = false;
            $scope.isPatientHaveActiveEncounter(function (response) {
                is_success = true;
                if (response.success == true) {
                    if (response.model.encounter_id != $state.params.enc_id) {
                        is_success = false;
                    }
                } else {
                    is_success = false;
                }

                if (!is_success) {
                    alert("This is not an active Encounter");
                    $state.go("patient.procedure", {id: $state.params.id});
                }
                $scope.showForm = true;
            });
        }

        $scope.initForm = function () {
            $scope.loadbar('show');
            $scope.data = {};
            $scope.data.proc_date = moment().format('YYYY-MM-DD HH:mm:ss');
            $rootScope.commonService.GetChargeCategoryList('', '1', false, 'PRC', function (response) {
                $scope.procedures = response.categoryList;
            });

            $scope.doctors = [];
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
                $scope.loadbar('hide');
            });
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.msg.successMessage = "";

            docIds = [];
            angular.forEach($scope.data.consultant_ids, function (list) {
                docIds.push(list.user_id);
            });
            _that.data.proc_consultant_ids = docIds;
            angular.extend(_that.data, {patient_id: $scope.patientObj.patient_id});
            _that.data.proc_date = moment(_that.data.proc_date).format('YYYY-MM-DD HH:mm:ss');

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/procedures';
                method = 'POST';
                succ_msg = 'Procedure Added successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/procedures/' + _that.data.proc_id;
                method = 'PUT';
                succ_msg = 'Procedure updated successfully';
            }

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.msg.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            $state.go('patient.procedure', {id: $scope.patientObj.patient_guid});
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
                url: $rootScope.IRISOrgServiceUrl + "/procedures/" + $state.params.proc_id,
                method: "GET"
            }).success(
                    function (response1) {
                        $scope.loadbar('hide');
                        $scope.ids = response1.proc_consultant_ids;
                        $scope.data = response1;

                        $scope.data.consultant_ids = [];
                        $scope.$watch('doctors', function (newValue, oldValue) {
                            angular.forEach($scope.doctors, function (n, i) {
                                if ($.inArray(n.user_id, $scope.ids) >= 0) {
                                    $scope.data.consultant_ids.push($scope.doctors[i]);
                                }
                            });
                        }, true);
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
        $scope.removeRow = function (id) {
            var modalOptions = {
                closeButtonText: 'No',
                actionButtonText: 'Yes',
                headerText: 'Delete Procedure?',
                bodyText: 'Are you sure you want to delete this procedure?'
            };

            modalService.showModal({}, modalOptions).then(function (result) {
                $scope.loadbar('show');
                $http({
                    method: 'POST',
                    url: $rootScope.IRISOrgServiceUrl + "/procedure/remove",
                    data: {id: id},
                }).then(
                        function (response) {
                            $scope.loadbar('hide');
                            if (response.data.success === true) {
                                $scope.loadProceduresList();
                                $scope.msg.successMessage = 'Procedure deleted successfully';
                            }
                            else {
                                $scope.errorData = response.data.message;
                            }
                        }
                );
            });
        };

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
