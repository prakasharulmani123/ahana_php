app.controller('PatientController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        //Encounter Page
        $scope.loadPatientEncounters = function (type) {
            $scope.encounterView = type;
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            $http.get($rootScope.IRISOrgServiceUrl + '/encounter/getencounters?id=' + $state.params.id + '&type=' + type)
                    .success(function (response) {
                        if (response.success == true) {
                            $scope.isLoading = false;
                            $scope.rowCollection = response.encounters;
                            $scope.displayedCollection = [].concat($scope.rowCollection);
                        } else {
                            $scope.error = response.message;
                        }
                    })
                    .error(function () {
                        $scope.error = "An Error has occured while loading encounter!";
                    });
        };
    }]);