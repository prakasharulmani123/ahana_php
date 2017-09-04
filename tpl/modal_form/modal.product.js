app.controller('ProductModalInstanceCtrl', ['scope', '$scope', '$modalInstance', '$rootScope', '$timeout', '$http', function (scope, $scope, $modalInstance, $rootScope, $timeout, $http) {
        $scope.data = {};
        //$scope.countries = scope.countries;

        //$scope.data.country_id = country_id;

        $rootScope.commonService.GetProductUnitsList(function (response) {
            $scope.productUnits = response;
        });

        // Product Description list
        $rootScope.commonService.GetProductDescriptionList('', '1', false, function (response) {
            $scope.productDescriptions = response.productDescriptionList;
        });

        // Brand list
        $rootScope.commonService.GetBrandsList('', '1', false, function (response) {
            $scope.brands = response.brandList;
        });

        // Division list
        $rootScope.commonService.GetDivisionsList('', '1', false, function (response) {
            $scope.divisions = response.divisionList;
        });

        // Generic list
        $rootScope.commonService.GetGenericList('', '1', false, false, function (response) {
            $scope.generics = response.genericList;
        });

        // Drug Class list
        $rootScope.commonService.GetDrugClassList('', '1', false, false, function (response) {
            $scope.drugClasses = response.drugList;
        });

        $rootScope.commonService.GetVatList('', '1', false, function (response) {
            $scope.vats = response.vatList;
        });
        $scope.saveForm = function () {
            _that = this;
            _that.data.purchase_vat_id = (typeof($scope.vats[0]) != "undefined" && $scope.vats[0] !== null) ? $scope.vats[0].vat_id : '';
            _that.data.sales_vat_id = (typeof($scope.vats[0]) != "undefined" && $scope.vats[0] !== null) ? $scope.vats[0].vat_id : '';

            $scope.errorData = "";
            scope.msg.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/pharmacyproduct/saveprescriptionproduct';
            method = 'POST';
            succ_msg = 'Product saved successfully';

            scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        scope.loadbar('hide');
                        if (response.success == true) {
                            scope.msg.successMessage = succ_msg;
                            $scope.data = {};
                            $timeout(function () {
                                scope.afterdrugAdded(response.drug,response.generic_id,response.product_id);
                                $modalInstance.dismiss('cancel');
                            }, 1000)
                        } else {
                            $scope.errorData = response.message;
                        }
                    }
            ).error(function (data, status) {
                scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        $scope.showDrugDropdown = false;
        $scope.getDrugByGeneric = function () {
            $scope.errorData = "";
            if ($scope.data.generic_id) {
                $http({
                    url: $rootScope.IRISOrgServiceUrl + '/pharmacydrugclass/getdrugbygeneric?generic_id=' + $scope.data.generic_id,
                    method: "GET",
                }).then(
                        function (response) {
                            if (response.data.drug) {
                                $scope.data.drug_name = response.data.drug.drug_name;
                                $scope.data.drug_class_id = response.data.drug.drug_class_id;
                                $scope.showDrugDropdown = false;
                            } else {
                                $scope.data.drug_name = '';
                                $scope.data.drug_class_id = '';
                                $scope.showDrugDropdown = true;
                            }
                        }
                );
            } else {
                $scope.data.drug_name = '';
                $scope.data.drug_class_id = '';
                $scope.showDrugDropdown = false;
            }
        }

        $scope.cancel = function () {
            $modalInstance.dismiss('cancel');
        };
    }]);
  