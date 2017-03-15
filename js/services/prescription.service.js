'use strict';

angular.module('app').factory('PrescriptionService', PrescriptionService);

PrescriptionService.$inject = ['$http', '$cookieStore', '$rootScope', '$window', '$localStorage', '$filter'];
function PrescriptionService($http, $cookieStore, $rootScope, $window, $localStorage, $filter) {
    var prescription_patient_id;
    var items = [];
    
    return {
        setPatientId: function (id) {
            if (prescription_patient_id) {
                if (prescription_patient_id != id) {
                    items.length = 0;
                    prescription_patient_id = id;
                }
            } else {
                prescription_patient_id = id;
            }
        },
        getPrescriptionItems: function () {
            if (items.length > 0) {
                var ordered = $filter('orderBy')(items, "available_quantity");
                angular.forEach(ordered, function (value, key) {
                    value.item_key = key;
                });
                return ordered;
            }
            return items;
        },
        addPrescriptionItem: function (item) {
            items.push(item);
        },
        deletePrescriptionItem: function (item) {
            var index = items.indexOf(item);
            items.splice(index, 1);
        },
        deleteAllPrescriptionItem: function () {
            items = [];
        },
    };
}