app.filter('linebreaks', function () {
    return function (text) {
        return text.replace(/\n/g, "<br>");
    }
});

app.controller('PrinttemplateController', ['$rootScope', '$scope', '$anchorScroll', '$http', '$state', '$filter', '$modal', '$location', '$log', '$timeout', 'IO_BARCODE_TYPES', 'toaster', 'PrescriptionService', '$q', 'hotkeys', 'modalService', '$interval', function ($rootScope, $scope, $anchorScroll, $http, $state, $filter, $modal, $location, $log, $timeout, IO_BARCODE_TYPES, toaster, PrescriptionService, $q, hotkeys, modalService, $interval) {

        $scope.billData = {};
        $scope.data = {};
        $scope.generate = moment().format('DD-MM-YYYY hh:mm A');

        function encodeImageFileAsURL(cb) {
            return function () {
                var file = this.files[0];
                var reader = new FileReader();
                reader.onloadend = function () {
                    cb(reader.result);
                }
                reader.readAsDataURL(file);
            }
        }

        $('#inputFileToLoad').change(encodeImageFileAsURL(function (base64Img) {
            $('.output').find('img').attr('src', '');
            $('.output').find('img').attr('src', base64Img).attr('width', 200).attr('height', 40);
        }));

        $scope.loadData = function (a) {
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/printdocumentsetting/getprintconfiguration?print_document_id=" + a,
                method: "GET"
            }).then(
                    function (response) {
                        if (response.data.success === true) {
                            $scope.billData = JSON.parse(response.data.printSetting.value);
                            $scope.data = response.data.printSetting;
                            $scope.data.logo_path = response.data.logo_path;
                        } else {
                            $scope.errorData = response.data;
                        }
                    }
            )
        };

        $scope.savePrintConfiguration = function () {
            _that = this;

            $scope.errorData = "";
            $scope.msg.successMessage = "";

            var logo_img = $("#logo_image").attr('src');
            if (logo_img) {
                $http({
                    method: "POST",
                    url: $rootScope.IRISOrgServiceUrl + '/printdocumentsetting/uploadimage',
                    data: {file_data: logo_img, old_image: $scope.billData.logo_text},
                }).success(
                        function (response) {
                            if (response.success) {
                                $scope.billData.logo_text = response.filename;
                                $scope.saveData();
                            } else {
                                $scope.saveData();
                            }
                        }
                ).error(function (data, status) {
                    if (status == 422)
                        $scope.errorData = $scope.errorSummary(data);
                    else
                        $scope.errorData = data.message;
                });
            } else {
                $scope.saveData();
            }
        };

        $scope.saveData = function () {

            angular.extend($scope.data, {
                value: JSON.stringify($scope.billData),
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
        }

    }]);