'use strict';

/* Controllers */
// signin controller
app.controller('SigninFormController', ['$scope', '$http', '$state', 'AuthenticationService', function ($scope, $http, $state, AuthenticationService) {
        $scope.user = {};
        $scope.authError = null;
        $scope.login = function () {
            $scope.authError = null;
            // Try to login
            AuthenticationService.Login($scope.user.username, $scope.user.password, function (response) {
                if (response.success) {
                    AuthenticationService.SetCredentials(response.access_token);
                    $state.go('app.org_list');
                } else {
                    $scope.authError = response.message;
                }
            });
        };

    }]);