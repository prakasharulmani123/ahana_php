//app.filter('orderObjectBy', function() {
//  return function(items, field, reverse) {
//    var filtered = [];
//    angular.forEach(items, function(item) {
//      filtered.push(item);
//    });
//    filtered.sort(function (a, b) {
//      return (a[field] > b[field] ? 1 : -1);
//    });
//    if(reverse) filtered.reverse();
//    return filtered;
//  };
//});
app.controller('EncounterController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', 'modalService', function ($rootScope, $scope, $timeout, $http, $state, $filter, modalService) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.more_max = 4;

        //Encounter Page
        $scope.loadPatientEncounters = function (type) {
            $scope.encounterView = type;
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
//            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            $http.get($rootScope.IRISOrgServiceUrl + '/encounter/getencounters?id=' + $state.params.id + '&type=' + type)
                    .success(function (response) {
                        if (response.success == true) {
                            $scope.isLoading = false;
                            $scope.rowCollection = response.encounters;
                            $scope.activeEncounter = response.active_encounter;
                            $scope.displayedCollection = [].concat($scope.rowCollection);
                            $scope.more_li = {};
                        } else {
                            $scope.errorData = response.message;
                        }
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading encounter!";
                    });
        };

//        $scope.max = function (arr) {
//            t = $filter('max')
//                    ($filter('map')(arr, 'id'));
//            return t;
//        }
//
        $scope.ctrl = {};
        $scope.allExpanded = true;
        $scope.expanded = true;
        $scope.ctrl.expandAll = function (expanded) {
            $scope.$broadcast('onExpandAll', {expanded: expanded});
        };

        $scope.moreOptions = function (key, enc_id, type) {
            $scope.more_li = {};

            $('.enc_chk').not('#enc_' + enc_id + key).attr('checked', false);

            if ($('#enc_' + enc_id + key).is(':checked')) {
                if (type == 'IP') {
                    $scope.more_li = [
                        {href: 'patient.transfer({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Transfer', mode: 'sref'},
                        {href: 'patient.discharge({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Discharge', mode: 'sref'},
                        {href: 'patient.swapping({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Swapping', mode: 'sref'},
                    ];
                } else if (type == 'OP') {
                    $scope.more_li = [
                        {href: 'patient.changeStatus({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Change Status', mode: 'sref'},
                        {href: "cancelAppointment(" + enc_id + ")", name: 'Cancel Appointment', mode: 'click'},
                        {href: 'patient.editDoctorFee({id: "' + $state.params.id + '", enc_id: ' + enc_id + '})', name: 'Edit Doctor Fee', mode: 'sref'},
                    ];
                }
            }
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

        $scope.cancelAppointment = function (enc_id) {
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == true) {
                    if (response.model.encounter_id != enc_id) {
                        alert("This is not an active Encounter");
                        $state.go("patient.encounter", {id: $state.params.id});
                    } else {
                        $scope.errorData = "";
                        var modalOptions = {
                            closeButtonText: 'No',
                            actionButtonText: 'Yes',
                            headerText: 'Cancel Appointment?',
                            bodyText: 'Are you sure you want to cancel this appointment?'
                        };
                        modalService.showModal({}, modalOptions).then(function (result) {
                            $scope.loadbar('show');
                            post_url = $rootScope.IRISOrgServiceUrl + '/appointments';
                            method = 'POST';
                            succ_msg = 'Appointment cancelled successfully';
                            var PatAppointment = {
                                appt_status: "C",
                                status_time: moment().format('HH:mm:ss'),
                                status_date: moment().format('YYYY-MM-DD'),
                                patient_id: $scope.app.patientDetail.patientId,
                                encounter_id: enc_id
                            };
                            $http({
                                method: method,
                                url: post_url,
                                data: PatAppointment,
                            }).success(
                                    function (response) {
                                        $scope.loadbar('hide');
                                        $scope.loadPatientEncounters('Current');

//                                        $scope.successMessage = succ_msg;
//                                        $scope.data = {};
//                                        $timeout(function () {
//                                            $state.go("patient.encounter", {id: $state.params.id});
//                                        }, 1000)

                                    }
                            ).error(function (data, status) {
                                $scope.loadbar('hide');
                                if (status == 422)
                                    $scope.errorData = $scope.errorSummary(data);
                                else
                                    $scope.errorData = data.message;
                            });
                        });
                    }
                }
            });
        };
    }]);

app.filter('moment', function () {
    return function (dateString, format) {
        return moment(dateString).format(format);
    };
});