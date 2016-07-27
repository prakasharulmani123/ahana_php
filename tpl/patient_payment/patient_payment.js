app.controller('BillingPaymentController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.isPatientHaveActiveEncounter = function (callback) {
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveunfinalizedencounter', {patient_id: $state.params.id, encounter_id: $state.params.enc_id})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        $scope.initCanAddPayment = function () {
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == false) {
                    alert("Sorry, you can't add payment");
                    $state.go("patient.billing", {id: $state.params.id});
                } else {
                    $rootScope.commonService.GetPaymentModes(function (response) {
                        $scope.paymentModes = response;
                    });

                    $rootScope.commonService.GetCardTypes(function (response) {
                        $scope.cardTypes = response;
                    });

                    $scope.encounter = response.model;
                    $scope.data = {};
                    $scope.data.payment_date = moment().format('YYYY-MM-DD HH:mm:ss');
                    $scope.data.formtype = 'add';
                    $scope.data.payment_mode = 'CA';
                    $scope.data.bank_date = moment().format('YYYY-MM-DD HH:mm:ss');
                }
            });
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;
            
            _that.data.payment_date = moment(_that.data.payment_date).format('YYYY-MM-DD HH:mm:ss');
            _that.data.bank_date = moment(_that.data.bank_date).format('YYYY-MM-DD HH:mm:ss');
            
            if(_that.data.payment_mode != 'CD'){
                _that.data.card_type = '';
                _that.data.card_number = '';
            }
            
            if(_that.data.payment_mode != 'CH'){
                _that.data.bank_name = '';
                _that.data.bank_number = '';
                _that.data.bank_date = '';
            }
            
            $scope.errorData = "";
            $scope.msg.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientbillingpayments';
                method = 'POST';
                succ_msg = 'Billing payment saved successfully';

                angular.extend(_that.data, {
                    patient_id: $scope.patientObj.patient_id,
                    encounter_id: $scope.encounter.encounter_id
                });
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientbillingpayments/' + _that.data.payment_id;
                method = 'PUT';
                succ_msg = 'Billing payment updated successfully';
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
                            $state.go('patient.billing', {id: $state.params.id});
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
            $rootScope.commonService.GetPaymentModes(function (response) {
                $scope.paymentModes = response;
            });

            $rootScope.commonService.GetCardTypes(function (response) {
                $scope.cardTypes = response;
            });
            
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientbillingpayments/" + $state.params.payment_id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;
                        if(response.bank_date == null){
                            $scope.data.bank_date = moment().format('YYYY-MM-DD HH:mm:ss');
                        }
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
                                    $scope.msg.successMessage = 'Patient Note Deleted Successfully';
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