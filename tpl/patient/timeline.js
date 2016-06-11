app.controller('PatientTimelineController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$filter', function ($rootScope, $scope, $timeout, $http, $state, $filter) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.loadTimeline = function () {
            $scope.data = {};

            $http.get($rootScope.IRISOrgServiceUrl + '/organization/getpatientsharetenants?patient_id=' + $state.params.id)
                    .success(function (resp) {
                        $scope.tenants = resp.tenants;
                        if ($scope.tenants.length > 0)
                            $scope.tenants.push({tenant_id: 'all', branch_name: 'ALL', patient_global_guid: $scope.tenants[0].patient_global_guid});

                        $scope.data.tenant_id = resp.tenant_id;
                        $scope.data.pat_tenant_id = resp.tenant_id;

                        $scope.getTimeline($rootScope.IRISOrgServiceUrl + '/patient/getpatienttimeline', {guid: $state.params.id}, '');
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patient!";
                    });
        }

        $scope.switchBranch = function () {
            result = $filter('filter')($scope.tenants, {tenant_id: $scope.data.tenant_id});

            if (result.length > 0) {
                if ($scope.data.pat_tenant_id == $scope.data.tenant_id) {
                    $scope.getTimeline($rootScope.IRISOrgServiceUrl + '/patient/getpatienttimeline', {guid: $state.params.id}, '');
                } else {
                    $scope.getTimeline($rootScope.IRISOrgServiceUrl + '/patient/getpatienttimeline2', {guid: result[0].patient_global_guid, tenant_id: result[0].tenant_id}, result[0].org_domain);
                }
            }
        }

        $scope.getTimeline = function (url, data, domain_path) {
            $scope.loadbar('hide');
            $http.post(url, data, {headers: {'x-domain-path': domain_path}})
                    .success(function (resp) {
                        $scope.loadbar('hide');
                        $scope.timeline = resp.timeline;
                    })
                    .error(function () {
                        $scope.loadbar('hide');
                        $scope.errorData = "An Error has occured while loading patient!";
                    });
        }

    }]);


//app.filter('moment', function () {
//    return function (dateString, format) {
//        return moment(dateString).format(format);
//    };
//});