'use strict';

/* Controllers */
// signin controller
app.controller('SigninFormController', SignInForm);

SignInForm.$inject = ['$scope', '$state', 'AuthenticationService', '$http', '$rootScope', '$location', '$timeout'];
function SignInForm($scope, $state, AuthenticationService, $http, $rootScope, $location, $timeout) {
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

    $scope.passwordrequest = function () {
        $http({
            method: "POST",
            url: $rootScope.IRISOrgServiceUrl + '/user/request-password-reset',
            data: {email: $scope.email},
        }).then(
                function (response) {
                    if (response.data.success === true) {
                        $scope.successMessage = response.data.message;
                        $scope.errorData = '';
                        $scope.email = '';
                    } else {
                        $scope.errorData = response.data.message;
                    }
                }
        )
    };

    $scope.resetpassword = function () {
        $http({
            method: "POST",
            url: $rootScope.IRISOrgServiceUrl + '/user/reset-password',
            data: {password: $scope.password, password_reset_token: $location.search().token, repeat_password: $scope.repeat_password},
        }).then(
                function (response) {
                    if (response.data.success === true) {
                        $scope.password = $scope.repeat_password = '';
                        $scope.successMessage = response.data.message;
                        $scope.errorData = '';
                        $timeout(function () {
                            $state.go('access.signin');
                        }, 10000)
                    } else {
                        $scope.errorData = response.data.message;
                    }
                }
        )
    };

}