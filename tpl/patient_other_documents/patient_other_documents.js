app.controller('OtherDocumentsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'toaster', '$localStorage', function ($rootScope, $scope, $timeout, $http, $state, toaster, $localStorage) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.data = {};
        $scope.encounter = {};

        //Index Page
        $scope.loadPatientScannedDocumentsList = function () {
            $scope.isLoading = true;
            $scope.rowCollection = [];

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/patientscanneddocuments/getscanneddocuments?patient_id=' + $state.params.id)
                    .success(function (scanneddocuments) {
                        $scope.isLoading = false;
                        $scope.rowCollection = scanneddocuments.result;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patient scanned documents!";
                    });
        };

        // Check patient have active encounter
        $scope.isPatientHaveActiveEncounter = function (callback) {
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveactiveencounter', {patient_id: $state.params.id})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        // Initialize Create Form
        $scope.initForm = function () {
            $scope.isLoading = true;
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == false) {
                    $scope.isLoading = false;
                    alert("Sorry, you can't upload a scanned document");
                    $state.go("patient.scannedDocuments", {id: $state.params.id});
                } else {
                    $scope.data = {};
                    $scope.data.formtype = 'add';
                    $scope.data.status = '1';
                    $scope.encounter = response.model;
                }
            });
        }

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.data = {};
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientotherdocuments/" + $state.params.other_doc_id,
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
            $scope.data.formtype = 'update';
        };

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.msg.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientotherdocuments';
                method = 'POST';
                succ_msg = 'Added successfully';

                angular.extend(_that.data, {
                    patient_id: $scope.patientObj.patient_id,
                    encounter_id: $scope.encounter.encounter_id
                });
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientotherdocuments/' + $state.params.other_doc_id;
                method = 'PUT';
                succ_msg = 'Updated successfully';
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
                            $state.go('patient.document', {id: $state.params.id});
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

        //Delete
        $scope.deleteDocument = function (scanned_doc_id) {
            var conf = confirm('Are you sure to delete ?');
            if (conf) {
                $scope.loadbar('show');
                $http({
                    url: $rootScope.IRISOrgServiceUrl + "/patientscanneddocuments/remove",
                    method: "POST",
                    data: {scanned_doc_id: scanned_doc_id}
                }).then(
                        function (response) {
                            $scope.loadbar('hide');
                            if (response.data.success === true) {
                                $scope.loadPatientScannedDocumentsList();
                                $scope.msg.successMessage = 'Scanned Document Deleted Successfully';
                            }
                            else {
                                $scope.errorData = response.data.message;
                            }
                        }
                )
            }
        };

        $scope.displayspin = '';
        $scope.downloadDocument = function (scanned_doc_id) {
            $scope.displayspin = scanned_doc_id;
            $http.get($rootScope.IRISOrgServiceUrl + "/patientscanneddocuments/getscanneddocument?id=" + scanned_doc_id)
                    .success(function (response) {
                        $scope.displayspin = '';
                        if (response.success === true) {
                            var link = document.createElement('a');
                            link.href = 'data:' + response.result.file_type + ';base64,' + response.file;
                            link.download = response.result.file_org_name;
                            document.body.appendChild(link);
                            link.click();
                            $timeout(function () {
                                document.body.removeChild(link);
                            }, 1000);
                        } else {
                            $scope.errorData = response.message;
                        }
                    }).
                    error(function (data, status) {
                    });

        };
    }]);