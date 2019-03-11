app.controller('PaymentBillController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state) {
    
    //$scope.data = $modalInstance.data.row_data;
    $scope.app = scope.app;
    $scope.patientObj = scope.patientObj;
    $scope.report_generated_date = moment().format('DD/MM/YYYY');
    $scope.data = scope.row_data;
    $scope.payment_bill_type = scope.payment_bill_type;
    
    $scope.open = function ($event) {
        $event.preventDefault();
        $event.stopPropagation();
        $scope.opened = true;
    };
    
    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
    
}]);