app.controller('PatientController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content';

        $scope.$watch('app.patientDetail.patientId', function (newValue, oldValue) {
            if (newValue != '' && newValue != oldValue) {
                $rootScope.commonService.GetEncounterListByPatient('', '1', false, $scope.patientObj.patient_id, function (response) {
                    $scope.encounters = response;
                });
            }
        }, true);

        $scope.initForm = function () {
            $rootScope.commonService.GetProcedureList('', '1', false, function (response) {
                $scope.procedures = response.categoryList;
            });

            $scope.doctors = [];
            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });
            $scope.doctor = {};
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";
            
            docIds = [];
            angular.forEach($scope.data.proc_consultant_ids, function(list){
                docIds.push(list.user_id);
            });
            $scope.data.proc_consultant_ids = docIds;
            $scope.data.encounter_id = $state.params.enc_id;

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/procedures';
                method = 'POST';
                succ_msg = 'Procedure Added successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/cities/' + _that.data.city_id;
                method = 'PUT';
                succ_msg = 'City updated successfully';
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
//                        $scope.data = {};
//                        $timeout(function () {
//                            $state.go('configuration.cities');
//                        }, 1000)

                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
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