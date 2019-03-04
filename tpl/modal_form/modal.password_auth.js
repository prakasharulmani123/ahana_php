app.controller('PasswordAuthController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state) {

        $scope.data = {};
        var encounter_id = $modalInstance.data.encounter_id;
        var column = $modalInstance.data.column;
        var value = $modalInstance.data.value;

        $scope.title = $modalInstance.data.title;
        $scope.column = $modalInstance.data.column;
        $scope.backdateDischarge = $modalInstance.data.backdateDischarge;
        $scope.minDate = $modalInstance.data.clinical_finalize_date;
        $scope.maxDate = moment().format('YYYY-MM-DD');
        $scope.data.discharge_date = moment().format('YYYY-MM-DD HH:mm:ss');
        $scope.data.finalize_date = moment().format('YYYY-MM-DD');

        $scope.getTitle = function () {
            return $modalInstance.data.title;
        };

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.saveForm = function () {
            _that = this;

            angular.extend(_that.data, {
                encounter_id: encounter_id,
                column: column,
                value: value
            });

            $scope.errorData = "";
            scope.msg.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/user/passwordauth';
            method = 'POST';
            succ_msg = 'Status updated successfully';

            scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        if (response.success == false) {
                            scope.loadbar('hide');
                            if (status == 422)
                                $scope.errorData = scope.errorSummary(data);
                            else
                                $scope.errorData = response.message;
                        } else {
                            scope.loadbar('hide');
                            scope.msg.successMessage = succ_msg;
                            $scope.data = {};
                            $timeout(function () {
                                $modalInstance.dismiss('cancel');
                                $state.go($state.current, {}, {reload: true});
//                                scope.enc.selected = response.encounter;
//                                scope.loadBillingCharges(encounter_id);
//                                scope.loadRoomConcession(encounter_id);
                            }, 1000)
                        }
                    }
            ).error(function (data, status) {
                scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };

        $scope.beforeRender = function ($view, $dates, $leftDate, $upDate, $rightDate) {
            var d = new Date($scope.minDate);
            var n = d.getDate();
            var m = d.getMonth();
            var y = d.getFullYear();
            var today_date = (new Date(y, m, n)).valueOf(); //19
            
            var d = new Date($scope.maxDate);
            var n = d.getDate();
            var m = d.getMonth();
            var y = d.getFullYear();
            var max_date = (new Date(y, m, n)).valueOf(); //19
            
            angular.forEach($dates, function (date, key) {
                var calender = new Date(date.localDateValue());
                var calender_n = calender.getDate();
                var calender_m = calender.getMonth();
                var calender_y = calender.getFullYear();
                var calender_date = (new Date(calender_y, calender_m, calender_n)).valueOf();

                if (today_date > calender_date) { 
                    $dates[key].selectable = false;
                }
                
                if (max_date < calender_date) {  //hidden calendar Future date
                    $dates[key].selectable = false;
                }
                
            });
                        
        }
    }]);
  