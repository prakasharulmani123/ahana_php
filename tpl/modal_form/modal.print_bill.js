app.controller('PrintBillController', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', '$state', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http, $state) {

//        var encounter_id = $modalInstance.data.encounter_id;
//        var column = $modalInstance.data.column;
//        var value = $modalInstance.data.value;
//        
        $scope.report_generated_date = moment().format('DD/MM/YYYY');
        $scope.enc = scope.enc;
        $scope.app = scope.app;
        $scope.billing = scope.billing;
        $scope.recurr_billing = scope.recurr_billing;
        $scope.recurring_charges = scope.recurring_charges;
        $scope.procedures = scope.procedures;
        $scope.consultants = scope.consultants;
        $scope.other_charges = scope.other_charges;

        $scope.detailed_billing = {};
        $scope.detailed_recurr_billing = {};

        $scope.bill_type = 'bill_summary';
        $scope.isShown = function (bill_type) {
//            console.log(bill_type);
            return bill_type === $scope.bill_type;
        };
        
        $scope.getTotalRecurringPrice = function (row) {
            tot = parseFloat(row.total_charge);
            return tot;
        }
        
        $scope.parseFloat = function (row) {
            return parseFloat(row);
        }
        
        $scope.printBill = function () {
            var innerContents = document.getElementById($scope.bill_type).innerHTML;
            var popupWinindow = window.open('', '_blank', 'width=600,height=700,scrollbars=no,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
            popupWinindow.document.open();
            popupWinindow.document.write('<html><head><link href="css/print.css" rel="stylesheet" type="text/css" /></head><body onload="window.print()">' + innerContents + '</html>');
            popupWinindow.document.close();
        }

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };

        
    }]);
  