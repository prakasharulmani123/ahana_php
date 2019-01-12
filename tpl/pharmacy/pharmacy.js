app.controller('PharmacyController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', '$filter', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, $filter) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';
        
}]);