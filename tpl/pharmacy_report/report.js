app.controller('reportController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$anchorScroll', '$filter', '$timeout', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $anchorScroll, $filter, $timeout) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        $scope.showTable = false;

        $scope.data = {};

        $scope.initReport = function () {
            $scope.mode = $state.params.mode;
            $scope.date = moment().format('YYYY-MM-DD HH:MM:ss');
        }

        //Index Page
        $scope.loadReport = function () {
            $scope.loadbar('show');
            $scope.showTable = true;

            $scope.errorData = "";
            $scope.successMessage = "";

            var data = {};
            if ($state.params.mode == 'purchase') {
                url = '/pharmacyreport/purchasereport';

                if (typeof $scope.data.from !== 'undefined' && $scope.data.from != '')
                    angular.extend(data, {from: moment($scope.data.from).format('YYYY-MM-DD')});

                if (typeof $scope.data.to !== 'undefined' && $scope.data.to != '')
                    angular.extend(data, {to: moment($scope.data.to).format('YYYY-MM-DD')});
            }

            // Get data's from service
            $http.post($rootScope.IRISOrgServiceUrl + url, data)
                    .success(function (response) {
                        $scope.loadbar('hide');
                        $scope.records = response.report;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading products!";
                    });
        };


        //For Datepicker
        $scope.open = function ($event, mode) {
            $event.preventDefault();
            $event.stopPropagation();

            $scope.opened1 = $scope.opened2 = false;

            switch (mode) {
                case 'opened1':
                    $scope.opened1 = true;
                    break;
                case 'opened2':
                    $scope.opened2 = true;
                    break;
            }
        };
    }]);

app.filter('moment', function () {
    return function (dateString, format) {
        return moment(dateString).format(format);
    };
});
