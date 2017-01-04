app.controller('ipBillStatusController', ['$rootScope', '$scope', '$timeout', '$http', '$state', '$anchorScroll', '$filter', function ($rootScope, $scope, $timeout, $http, $state, $anchorScroll, $filter) {
        
        $scope.initReport = function () {
            $scope.showTable = false;
            $scope.tenants = [];
            $scope.doctors = [];
            $scope.data = {};

            $rootScope.commonService.GetDoctorList('', '1', false, '1', function (response) {
                $scope.doctors = response.doctorsList;
            });
            $rootScope.commonService.GetTenantList(function (response) {
                if (response.success == true) {
                    $scope.tenants = response.tenantList;
                }
            });
        }
        
        $scope.clearReport = function () {
            $scope.showTable = false;
            $scope.data = {};
            $scope.data.consultant_id = '';
            $scope.data.tenant_id = '';
        }
        
        //Index Page
        $scope.loadReport = function () {
            $scope.records = [];
            $scope.isLoading = true;
            $scope.showTable = true;

            $scope.errorData = "";
            $scope.msg.successMessage = "";
            
            var data = {};
            if (typeof $scope.data.consultant_id !== 'undefined' && $scope.data.consultant_id != '')
                angular.extend(data, {consultant_id: $scope.data.consultant_id});

            if (typeof $scope.data.tenant_id !== 'undefined' && $scope.data.tenant_id != '')
                angular.extend(data, {tenant_id: $scope.data.tenant_id});
            
            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + '/myworkreports/ipbillstatus', data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.records = response;
                        $scope.generated_on = moment().format('YYYY-MM-DD hh:mm A');
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured";
                    });
        };
    }]);