app.controller('AlertsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$filter', '$anchorScroll', 'modalService', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $filter, $anchorScroll, modalService) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        //Notifications
        $scope.assignNotifications();
        
        $scope.checkName = function (data) {
            if (!data) {
                return "Value should not empty";
            }
        };

        $scope.showStatus = function (row) {
            var selected = [];
            if (row && row.alert_type) {
                selected = $filter('filter')($scope.alerts, {alert_name: row.alert_type});
            }
            return selected.length ? selected[0].alert_name : 'Not set';
        };

        //Index Page
        $scope.loadAlertsList = function () {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/patientalert')
                    .success(function (alerts) {
                        $scope.isLoading = false;
                        $scope.rowCollection = alerts;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                        
                        if($scope.rowCollection.length == 0){
                            $scope.$emit('patient_alert', {hasalert: false, alert: ''});
                        }
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patientalert!";
                    });
        };

        //For Form
        $scope.initForm = function () {
            $rootScope.commonService.GetAlertList('', '1', false, function (response) {
                $scope.alerts = response.alertList;
            });
        }

        $scope.updateAlert = function ($data, pat_alert_id) {
            $scope.errorData = "";
            $scope.successMessage = "";
            
            $scope.loadbar('show');
            $http({
                method: 'PUT',
                url: $rootScope.IRISOrgServiceUrl + '/patientalerts/' + pat_alert_id,
                data: $data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.successMessage = response.alert_description + ' (Alert) updated successfully';
                        $anchorScroll();
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientalerts';
                method = 'POST';
                succ_msg = 'Alert saved successfully';

                angular.extend(_that.data, {patient_id: $scope.patientObj.patient_id});
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientalerts/' + _that.data.pat_alert_id;
                method = 'PUT';
                succ_msg = 'Alert updated successfully';
            }

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
                        $scope.data.formtype = 'add';
                        $scope.$emit('patient_alert', {hasalert: true, alert: response.alert_description});
                        $timeout(function () {
                            $scope.loadAlertsList();
                            $anchorScroll();
//                            $state.go('patient.alert', {id: $state.params.id});
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
                url: $rootScope.IRISOrgServiceUrl + "/patientalerts/" + $state.params.alert_id,
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
            var modalOptions = {
                closeButtonText: 'No',
                actionButtonText: 'Yes',
                headerText: 'Delete Alert?',
                bodyText: 'Are you sure you want to delete this alert?'
            };

            modalService.showModal({}, modalOptions).then(function (result) {
                $scope.loadbar('show');
                $http({
                    method: 'POST',
                    url: $rootScope.IRISOrgServiceUrl + "/patientalert/remove",
                    data: {id: row.pat_alert_id},
                }).then(
                        function (response) {
                            $scope.loadbar('hide');
                            if (response.data.success === true) {
                                $scope.loadAlertsList();
                                $scope.successMessage = 'Alert deleted successfully';
                            }
                            else {
                                $scope.errorData = response.data.message;
                            }
                        }
                );
            });
        };
    }]);