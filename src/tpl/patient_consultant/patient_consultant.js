app.controller('PatConsultantsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';
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

        $scope.initCanCreatePatConsultant = function () {
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
                    alert("Sorry, you can't create a Consultant for this encounter");
                    $state.go("patient.consultant", {id: $state.params.id});
                }
                $scope.showForm = true;
            });
        }
        
        //Index Page
        $scope.loadPatConsultantsList = function () {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/patientconsultant')
                    .success(function (PatConsultants) {
                        $scope.isLoading = false;
                        $scope.rowCollection = PatConsultants;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading patient Consultant!";
                    });
        };

        //For Form
        $scope.initForm = function () {
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientconsultants';
                method = 'POST';
                succ_msg = 'Consultant saved successfully';

                angular.extend(_that.data, {patient_id: $scope.app.patientDetail.patientId, encounter_id: $state.params.enc_id});
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientconsultants/' + _that.data.pat_consult_id;
                method = 'PUT';
                succ_msg = 'Consultant updated successfully';
            }
            _that.data.consult_date = moment(_that.data.consult_date).format('YYYY-MM-DD HH:mm:ss');

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            $state.go('patient.consultant', {id: $state.params.id});
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
                url: $rootScope.IRISOrgServiceUrl + "/patientconsultants/" + $state.params.cons_id,
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
                        url: $rootScope.IRISOrgServiceUrl + "/patientconsultants/remove",
                        method: "POST",
                        data: {id: row.pat_consult_id}
                    }).then(
                            function (response) {
                                $scope.loadbar('hide');
                                if (response.data.success === true) {
                                    $scope.displayedCollection.splice(index, 1);
                                    $scope.loadPatConsultantsList();
                                    $scope.successMessage = 'Patient Consultant Deleted Successfully';
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