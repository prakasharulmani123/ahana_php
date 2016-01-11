app.controller('RoomController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'toaster', function ($rootScope, $scope, $timeout, $http, $state, toaster) {

        //Index Page
        $scope.loadRoomsList = function () {
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/room')
                    .success(function (room) {
                        $scope.rowCollection = room;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading room!";
                    });
        };

        //For Form
        $scope.initForm = function () {
            $rootScope.commonService.GetWardList('', '1', false, function (response) {
                $scope.wards = response.wardList;
            });

            $rootScope.commonService.GetRoomMaintenanceList('', '1', false, function (response) {
                $scope.maintenances = response.maintenanceList;
            });
        }

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/rooms';
                method = 'POST';
                succ_msg = 'Room saved successfully';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/rooms/' + _that.data.room_id;
                method = 'PUT';
                succ_msg = 'Room updated successfully';
            }

            $('.butterbar').removeClass('hide').addClass('active');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $('.butterbar').removeClass('active').addClass('hide');
                        $scope.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            $state.go('configuration.room');
                        }, 1000)

                    }
            ).error(function (data, status) {
                $('.butterbar').removeClass('active').addClass('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        //Get Data for update Form
        $scope.loadForm = function () {
            $('.butterbar').removeClass('hide').addClass('active');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/rooms/" + $state.params.id,
                method: "GET"
            }).success(
                    function (response) {
                        $('.butterbar').removeClass('active').addClass('hide');
                        $scope.data = response;
                    }
            ).error(function (data, status) {
                $('.butterbar').removeClass('active').addClass('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

    }]);