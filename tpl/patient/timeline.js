app.controller('PatientTimelineController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.loadTimeline = function () {
            $http.post($rootScope.IRISOrgServiceUrl + '/patient/getpatienttimeline', {guid: $state.params.id})
                    .success(function (resp) {
                        $scope.timeline = resp.timeline;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patient!";
                    });
        }
        
    }]);


app.filter('moment', function () {
    return function (dateString, format) {
        return moment(dateString).format(format);
    };
});