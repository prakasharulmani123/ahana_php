app.controller('ExtraConcessionController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.isPatientHaveActiveEncounter = function (callback) {
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveactiveencounter', {patient_id: $state.params.id})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        $scope.initCanExtraConcession = function () {
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == false) {
                    alert("Sorry, you can't add other charge");
                    $state.go("patient.billing", {id: $state.params.id});
                } else {
                    $scope.encounter = response.model;
                    $scope.data = {};
                    $scope.data.formtype = 'add';
                    $scope.data.ec_type = $state.params.ec_type;

                    if ($scope.data.ec_type == 'P') {
                        $scope.data.type = 'Procedure Charges';
                        post_url = $rootScope.IRISOrgServiceUrl + "/roomchargesubcategories/" + $state.params.link_id;
                        method = 'GET';
                    } else if ($scope.data.ec_type == 'C') {
                        $scope.data.type = 'Consultant Charges';
                        post_url = $rootScope.IRISOrgServiceUrl + "/users/" + $state.params.link_id;
                        method = 'GET';
                    }

                    $scope.loadbar('show');
                    $http({
                        method: method,
                        url: post_url,
                    }).success(
                            function (response) {
                                $scope.loadbar('hide');
                                $scope.data.link = response;

                                if ($scope.data.ec_type == 'P') {
                                    $scope.data.link_id = response.charge_subcat_id;
                                } else if ($scope.data.ec_type == 'C') {
                                    $scope.data.link_id = response.user_id;
                                }
                            }
                    ).error(function (data, status) {
                        $scope.loadbar('hide');
                        if (status == 422)
                            $scope.errorData = $scope.errorSummary(data);
                        else
                            $scope.errorData = data.message;
                    });

                }
            });
        }

        $scope.initForm = function () {
            $rootScope.commonService.GetChargeCategoryList('', '1', false, 'ALC', function (response) {
                $scope.alliedCharges = response.categoryList;
            });
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/patientbillingextraconcession/addcharge';
            method = 'POST';
            succ_msg = 'Amount updated successfully';

            if (mode == 'add') {
                angular.extend(_that.data, {
                    patient_id: $scope.app.patientDetail.patientId,
                    encounter_id: $scope.encounter.encounter_id
                });
            }

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');

                        if (response.success != false) {
                            $scope.successMessage = succ_msg;
//                            $scope.data = {};
//                        $timeout(function () {
//                            $state.go('patient.billing', {id: $state.params.id});
//                        }, 1000)
                        }else{
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
                url: $rootScope.IRISOrgServiceUrl + "/patientbillingothercharges/" + $state.params.other_charge_id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;
                        $scope.encounter = {encounter_id: response.encounter_id};
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
                        url: $rootScope.IRISOrgServiceUrl + "/patientnotes/remove",
                        method: "POST",
                        data: {id: row.pat_note_id}
                    }).then(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.data.success === true) {
                                    $scope.displayedCollection.splice(index, 1);
                                    $scope.loadPatNotesList();
                                    $scope.successMessage = 'Patient Note Deleted Successfully';
                                }
                                else {
                                    $scope.errorData = response.data.message;
                                }
                            }
                    )
                }
            }
        };
    }]);