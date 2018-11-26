app.controller('PrinttemplateController', ['$rootScope', '$scope', '$anchorScroll', '$http', '$state', '$filter', '$modal', '$location', '$log', '$timeout', 'IO_BARCODE_TYPES', 'toaster', 'PrescriptionService', '$q', 'hotkeys', 'modalService', '$interval', function ($rootScope, $scope, $anchorScroll, $http, $state, $filter, $modal, $location, $log, $timeout, IO_BARCODE_TYPES, toaster, PrescriptionService, $q, hotkeys, modalService, $interval) {

        $scope.saleBillData = {};
        $scope.data = {};

        $scope.loadData = function () {
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/printdocumentsetting/getprintconfiguration?print_document_id=1",
                method: "GET"
            }).then(
                    function (response) {
                        if (response.data.success === true) {
                            $scope.saleBillData = JSON.parse(response.data.printSetting.value);
                            $scope.data = response.data.printSetting;
                        } else {
                            $scope.errorData = response.data;
                        }
                    }
            )
        };

        $scope.saveSaleBill = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.msg.successMessage = "";
            
            angular.extend($scope.data, {
                value: JSON.stringify($scope.saleBillData),
            });

            post_url = $rootScope.IRISOrgServiceUrl + '/printdocumentsettings/' + _that.data.document_setting_id;
            method = 'PUT';
            succ_msg = 'Print configuration updated successfully';

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.msg.successMessage = succ_msg;
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

    }]);