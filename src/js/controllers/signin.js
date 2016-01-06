'use strict';

/* Controllers */
// signin controller
app.controller('SigninFormController', SignInForm);

SignInForm.$inject = ['$scope', '$state', 'AuthenticationService', '$http', '$rootScope'];
function SignInForm($scope, $state, AuthenticationService, $http, $rootScope) {
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
        $scope.authError = null;
        $http({
            method: "POST",
            url: $rootScope.IRISOrgServiceUrl + '/user/request-password-reset',
            data: {email: $scope.email},
        }).then(
                function (response) {
                        console.log(response);
                        if (response.data.success === true) {
                           $scope.successMessage = response.data.message; 
                            $scope.errorData = '';
                        }else{
                            $scope.errorData = response.data.message;
                        }
                }
        )
    };

}