app.controller('RolesController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'toaster', function ($rootScope, $scope, $timeout, $http, $state, toaster) {

        //Index Page
        $scope.loadRolesList = function () {
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/role')
                    .success(function (roles) {
                        $scope.rowCollection = roles;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading roles!";
                    });
        };

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/roles/createrole';
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/roles/updaterole';
            }

            $('.butterbar').removeClass('hide').addClass('active');
            $http({
                method: "POST",
                url: post_url,
                data: _that.data,
            }).then(
                    function (response) {
                        $('.butterbar').removeClass('active').addClass('hide');
                        if (response.data.success === true) {

                            if (mode !== 'add') {
                                $scope.successMessage = " Role updated successfully";
                                $timeout(function () {
                                    $state.go('configuration.roles');
                                }, 1000)
                            }
                            else {
                                $scope.successMessage = "Role saved successfully";
                                $scope.data = {};
                                $timeout(function () {
                                    $state.go('configuration.roles');
                                }, 1000)
                            }
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
        };

        //Get Data for update Form
        $scope.loadForm = function () {
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/role/getrole?id=" + $state.params.id,
                method: "GET"
            }).then(
                    function (response) {
                        if (response.data.success === true) {
                            $scope.data = response.data.return;
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
        };

    }]);