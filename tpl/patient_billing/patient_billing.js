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

app.controller('BillingController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', function ($rootScope, $scope, $timeout, $http, $state, $filter) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.more_max = 4;
        $scope.total_billing = 0;

        $scope.initPatBillingIndex = function () {
            $scope.data = {};
        }

        $scope.$watch('enc.selected.encounter_id', function (newValue, oldValue) {
            if (newValue != '' && typeof newValue != 'undefined') {
                $scope.loadBillingCharges(newValue);
            }
        }, true);

        $scope.moreOptions = function (key, type, pk_id, link_id, concession_amount, extra_amount) {
            var row_id = '#enc_' + type + '_' + key;
            $scope.more_li = {};

            $('.enc_chk').not(row_id).attr('checked', false);

            if ($(row_id).is(':checked')) {
                if (type == 'other') {
                    $scope.more_li = [
                        {href: 'patient.editOtherCharge({id: "' + $state.params.id + '", other_charge_id: ' + pk_id + '})', name: 'Modify Other Charge', mode: 'sref'},
                    ];
                } else if (type == 'advance') {
                    $scope.more_li = [
                        {href: 'patient.editPayment({id: "' + $state.params.id + '", payment_id: ' + pk_id + '})', name: 'Modify Payment', mode: 'sref'},
                    ];
                } else if (type == 'procedure' || type == 'consultant') {
                    var ec_type = '';
                    if(type == 'procedure'){
                        ec_type = 'P';
                    }
                    if(type == 'consultant'){
                        ec_type = 'C';
                    }
                    
                    if (extra_amount == '0.00') {
                        $scope.more_li = [
                            {href: 'patient.addExtraAmount({id: "' + $state.params.id + '", ec_type: "' + ec_type + '", link_id: "' + link_id + '"})', name: 'Add Extra Amount', mode: 'sref'},
                        ];
                    } else {
                        $scope.more_li = [
                            {href: 'patient.editExtraAmount({id: "' + $state.params.id + '", ec_id: "' + pk_id + '"})', name: 'Edit Extra Amount', mode: 'sref'},
                        ];
                    }

                    if (concession_amount == '0.00') {
                        $scope.more_li.push(
                                {href: 'patient.addConcessionAmount({id: "' + $state.params.id + '", ec_type: "' + ec_type + '", link_id: "' + link_id + '"})', name: 'Add Concession Amount', mode: 'sref'}
                        );
                    } else {
                        $scope.more_li.push(
                                {href: 'patient.editConcessionAmount({id: "' + $state.params.id + '", ec_id: "' + pk_id + '"})', name: 'Edit Concession Amount', mode: 'sref'}
                        );
                    }
                }
            }
        }


        $scope.loadBillingCharges = function (enc_id) {
            $http({
                method: 'GET',
                url: $rootScope.IRISOrgServiceUrl + '/encounter/getnonrecurringbilling?encounter_id=' + enc_id,
            }).success(
                    function (response) {
                        $scope.procedures = null;
                        $scope.consultants = null;
                        $scope.other_charges = null;
                        $scope.advances = null;

                        if (typeof response.Procedure != 'undefined')
                            $scope.procedures = response.Procedure;

                        if (typeof response.Consults != 'undefined')
                            $scope.consultants = response.Consults;

                        if (Object.keys(response.OtherCharge).length)
                            $scope.other_charges = response.OtherCharge;

                        if (Object.keys(response.Advance).length)
                            $scope.advances = response.Advance;

                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.getTotalPrice = function (row) {
            tot = parseFloat(row.total_charge) + parseFloat(row.extra_amount) - parseFloat(row.concession_amount);
            return tot;
        }

        $scope.parseFloat = function (row) {
            return parseFloat(row);
        }

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

        $scope.ctrl = {};
        $scope.allExpanded = true;
        $scope.expanded = true;
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        $scope.enc = {};
        $scope.$watch('app.patientDetail.patientId', function (newValue, oldValue) {
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
                $scope.loadPatConsultantsList(newValue);
            }
        }, true);

        $scope.loadPatConsultantsList = function (enc_id) {
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/patientconsultant/getpatconsultantsbyencounter?enc_id=' + enc_id)
                    .success(function (patientconsultants) {
                        $scope.isLoading = false;
                        $scope.rowCollection = patientconsultants;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patient consultants!";
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

        $scope.beforeRender = function ($view, $dates, $leftDate, $upDate, $rightDate) {
            $http.post($rootScope.IRISOrgServiceUrl + '/user/getuser')
                    .success(function (response) {
                        if (response.return.tenant_id != 0) {
                            var d = new Date();
                            var n = d.getDate();
                            var m = d.getMonth();
                            var y = d.getFullYear();
                            var current = (new Date(y, m, n)).valueOf();

                            var today_date = new Date();
                            var upto_date = (today_date.setDate(today_date.getDate() + 3)).valueOf();

                            angular.forEach($dates, function (date, key) {
                                if (current > date.utcDateValue || upto_date < date.utcDateValue) {
                                    $dates[key].selectable = false;
                                }
                            });
                        }
                    }, function (x) {
                        $scope.errorData = 'Error while authorize the user';
                    });
        }
    }]);