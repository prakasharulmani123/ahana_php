app.controller('InPatientsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', '$modal', '$log', function ($rootScope, $scope, $timeout, $http, $state, $filter, $modal, $log) {

        $scope.app.settings.patientTopBar = false;
        $scope.app.settings.patientSideMenu = false;
        $scope.app.settings.patientContentClass = 'app-content app-content3';
        $scope.app.settings.patientFooterClass = 'app-footer app-footer3';

        //Checkbox initialize
        $scope.checkboxes = {'checked': false, items: []};
        $scope.currentAdmissionSelectedItems = [];
        $scope.currentAdmissionSelected = 0;
        
        //Index page height
        $scope.css = {'style': ''};

        //Index Page
        $scope.loadInPatientsList = function () {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/encounter/inpatients')
                    .success(function (inpatients) {
                        $scope.isLoading = false;
                        $scope.rowCollection = inpatients;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                        
                        if($scope.displayedCollection.length > 6){
                            $scope.css = {
                                'style': 'height:550px; overflow-y: auto; overflow-x: hidden;',
                            };
                        }

                        //Checkbox initialize
                        $scope.checkboxes = {'checked': false, items: []};
                        $scope.currentAdmissionSelectedItems = [];
                        $scope.currentAdmissionSelected = 0;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading floors!";
                    });
        };

        $scope.moreOptions = function (ip_key, row) {
            admission_exists = $filter('filter')($scope.checkboxes.items, {admission_id: row.currentAdmission.admn_id});
            if ($("#iplist_" + ip_key).is(':checked')) {
                $("#iplist_" + ip_key).closest("tr").addClass("selected_row");
                if (admission_exists.length == 0) {
                    $scope.checkboxes.items.push({
                        admission_id: row.currentAdmission.admn_id,
                        row: row
                    });
                }
            } else {
                $("#iplist_" + ip_key).closest("tr").removeClass("selected_row");
                if (admission_exists.length > 0) {
                    $scope.checkboxes.items.splice($scope.checkboxes.items.indexOf(admission_exists[0]), 1);
                }
            }

            $scope.prepareMoreOptions();
        }

        $scope.prepareMoreOptions = function () {
            $scope.currentAdmissionSelectedItems = [];
            angular.forEach($scope.checkboxes.items, function (item) {
                $scope.currentAdmissionSelectedItems.push(item.row);
            });

            $scope.currentAdmissionSelected = $scope.currentAdmissionSelectedItems.length;
        }

        //
        $scope.addConsultantVisit = function () {
            var modalInstance = $modal.open({
                templateUrl: 'tpl/modal_form/modal.patient_consultant_visit.html',
                controller: 'ConsultantVisitController',
                resolve: {
                    scope: function () {
                        return $scope;
                    }
                }
            });
            modalInstance.data = $scope.currentAdmissionSelectedItems;

            modalInstance.result.then(function (selectedItem) {
                $scope.selected = selectedItem;
            }, function () {
                $scope.loadInPatientsList();
                $log.info('Modal dismissed at: ' + new Date());
            });
        }

        //
        $scope.addProcedures = function () {
            var modalInstance = $modal.open({
                templateUrl: 'tpl/modal_form/modal.patient_procedures.html',
                controller: 'PatientProcedureController',
                resolve: {
                    scope: function () {
                        return $scope;
                    }
                }
            });
            modalInstance.data = $scope.currentAdmissionSelectedItems;

            modalInstance.result.then(function (selectedItem) {
                $scope.selected = selectedItem;
            }, function () {
                $scope.loadInPatientsList();
                $log.info('Modal dismissed at: ' + new Date());
            });
        }


    }]);