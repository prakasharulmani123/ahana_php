app.controller('ScannedDocumentsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'toaster','$localStorage', 'FileUploader', function ($rootScope, $scope, $timeout, $http, $state, toaster,$localStorage, FileUploader) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
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

                        //Avoid pagination problem, when come from other pages.
                        $scope.footable_redraw();
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
                    alert("Sorry, you can't create a scanned document");
                    $state.go("patient.scanneddocument", {id: $state.params.id});
                } else {
                    $scope.encounter = response.model;
                }
            });
        }
        
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
                                $scope.successMessage = 'Scanned Document Deleted Successfully';
                            }
                            else {
                                $scope.errorData = response.data.message;
                            }
                        }
                )
            }
        };

        var uploader = $scope.uploader = new FileUploader({
             url: $rootScope.IRISOrgServiceUrl + "/patientscanneddocuments/savedocument?access-token="+$localStorage.user.access_token,
        });

        // FILTERS

        uploader.filters.push({
            name: 'customFilter',
            fn: function (item /*{File|FileLikeObject}*/, options) {
                return this.queue.length < 10;
            }
        });

        // CALLBACKS

        uploader.onWhenAddingFileFailed = function (item /*{File|FileLikeObject}*/, filter, options) {
            console.info('onWhenAddingFileFailed', item, filter, options);
        };
        uploader.onAfterAddingFile = function (fileItem) {
            console.info('onAfterAddingFile', fileItem);
        };
        uploader.onAfterAddingAll = function (addedFileItems) {
            console.info('onAfterAddingAll', addedFileItems);
        };
        uploader.onBeforeUploadItem = function (item) {
            item.headers = {
                'x-domain-path': $rootScope.clientUrl
             };
            item.formData.push({'encounter_id': $scope.encounter.encounter_id , 'patient_id':$state.params.id});
            console.info('onBeforeUploadItem', item);
        };
        uploader.onProgressItem = function (fileItem, progress) {
            console.info('onProgressItem', fileItem, progress);
        };
        uploader.onProgressAll = function (progress) {
            console.info('onProgressAll', progress);
        };
        uploader.onSuccessItem = function (fileItem, response, status, headers) {
            console.info('onSuccessItem', fileItem, response, status, headers);
        };
        uploader.onErrorItem = function (fileItem, response, status, headers) {
            console.info('onErrorItem', fileItem, response, status, headers);
        };
        uploader.onCancelItem = function (fileItem, response, status, headers) {
            console.info('onCancelItem', fileItem, response, status, headers);
        };
        uploader.onCompleteItem = function (fileItem, response, status, headers) {
            console.info('onCompleteItem', fileItem, response, status, headers);
        };
        uploader.onCompleteAll = function () {
            console.info('onCompleteAll');
        };

        console.info('uploader', uploader);

    }]);