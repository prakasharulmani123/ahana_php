'use strict';

angular.module('app').factory('CommonService', CommonService);

CommonService.$inject = ['$http', '$rootScope', '$window', '$q', '$filter'];
function CommonService($http, $rootScope, $window, $q, $filter) {
    var service = {};

    service.ChangeStatus = ChangeStatus;
    service.GetCountryList = GetCountryList;
    service.GetStateList = GetStateList;
    service.GetCityList = GetCityList;
    service.GetTitleCodes = GetTitleCodes;
    service.GetPasswordResetAccess = GetPasswordResetAccess;
    service.GetTenantList = GetTenantList;
    service.GetFloorList = GetFloorList;
    service.GetRoomChargeCategoryList = GetRoomChargeCategoryList;
    service.GetRoomChargeSubCategoryList = GetRoomChargeSubCategoryList;
    service.GetRoomChargeItemList = GetRoomChargeItemList;
    service.GetRoomTypeList = GetRoomTypeList;
    service.GetWardList = GetWardList;
    service.GetRoomMaintenanceList = GetRoomMaintenanceList;
    service.GetPatientCateogryList = GetPatientCateogryList;
    service.GetChargePerSubCategoryList = GetChargePerSubCategoryList;
    service.GetSpecialityList = GetSpecialityList;
    service.GetInternalCodeList = GetInternalCodeList;
    service.GetDoctorList = GetDoctorList;
    service.GetDayList = GetDayList;
    service.CheckStateAccess = CheckStateAccess;
    service.GetGenderList = GetGenderList;
    service.GetPatientBillingList = GetPatientBillingList;
    service.GetPatientRegisterModelList = GetPatientRegisterModelList;
    service.GetPatientAppointmentStatus = GetPatientAppointmentStatus;
    service.GetRoomList = GetRoomList;
    service.GetProcedureList = GetProcedureList;
    service.GetEncounterListByPatient = GetEncounterListByPatient;

    service.GetLabelFromValue = GetLabelFromValue;
    service.FoundVlaue = FoundVlaue;

    return service;

    function ChangeStatus(modelName, primaryKey, callback) {
        var response;
        $('.butterbar').removeClass('hide').addClass('active');
        $http.post($rootScope.IRISOrgServiceUrl + '/default/change-status', {model: modelName, id: primaryKey})
                .success(function (response) {
                    $('.butterbar').removeClass('active').addClass('hide');
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetCountryList(callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/default/get-country-list')
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetStateList(callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/default/get-state-list')
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetCityList(callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/default/get-city-list')
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetPasswordResetAccess(token, callback) {
        var response;

        $http.post($rootScope.IRISOrgServiceUrl + '/user/check-reset-password', {'token': token})
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetTitleCodes(callback) {
        var response = [{value: 'Mr.', label: 'Mr.'}, {value: 'Mrs.', label: 'Mrs.'}, {value: 'Miss.', label: 'Miss.'}, {value: 'Dr.', label: 'Dr.'}];
        callback(response);
    }

    function GetTenantList(callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/default/get-tenant-list')
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetFloorList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/floor/getfloorlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetRoomChargeCategoryList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/roomchargecategory/getroomchargecategorylist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetRoomChargeSubCategoryList(tenant, sts, del_sts, cat_id, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/roomchargesubcategory/getroomchargesubcategorylist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts + '&cat_id=' + cat_id)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetRoomChargeItemList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/roomchargeitem/getroomchargeitemlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetRoomTypeList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/roomtype/getroomtypelist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetWardList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/ward/getwardlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetRoomMaintenanceList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/roommaintenance/getmaintenancelist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetPatientCateogryList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/patientcategory/getpatientcategorylist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetChargePerSubCategoryList(del_sts, cat_id, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/chargepersubcategory/getchargepersubcategorylist?deleted=' + del_sts + '&cat_id=' + cat_id)
//        $http.get($rootScope.IRISOrgServiceUrl + '/chargepersubcategory/getroomchargesubcategorylist?deleted=' + del_sts + '&cat_id=' + cat_id)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetSpecialityList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/speciality/getspecialitylist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetInternalCodeList(tenant, code_type, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/internalcode/getinternalcode?tenant=' + tenant + '&code_type=' + code_type + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetDoctorList(tenant, sts, del_sts, care_provider, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/user/getdoctorslist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts + '&care_provider=' + care_provider)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetDayList(callback) {
        var response = [{value: '1', label: 'Monday'}, {value: '2', label: 'Tuesday'}, {value: '3', label: 'Wednesday'}, {value: '4', label: 'Thursday'}, {value: '5', label: 'Friday'}, {value: '6', label: 'Saturday'}, {value: '7', label: 'Sunday'}];
        callback(response);
    }

    function CheckStateAccess(stateName, callback) {
        var response;

        $http.post($rootScope.IRISOrgServiceUrl + '/user/checkstateaccess', {'stateName': stateName})
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetGenderList(callback) {
        var response = [{value: 'M', label: 'Male'}, {value: 'F', label: 'Female'}, {value: 'O', label: 'Other'}];
        callback(response);
    }

    function GetPatientBillingList(callback) {
        var response = [{value: 'N', label: 'Normal'}, {value: 'F', label: 'Free'}];
        callback(response);
    }

    function GetPatientRegisterModelList(callback) {
        var response = [{value: 'NO', label: 'None'}, {value: 'OP', label: 'OP'}, {value: 'IP', label: 'IP'}];
        callback(response);
    }

    function GetPatientAppointmentStatus(callback) {
        var response = [{value: 'B', label: 'Booked'}, {value: 'A', label: 'Arrived'}];
        callback(response);
    }

    function GetRoomList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/room/getroomlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetEncounterListByPatient(tenant, sts, del_sts, pat_id, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/encounter/getencounterlistbypatient?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts + '&patient_id=' + pat_id)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetProcedureList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/roomchargecategory/getchargelist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts + '&code=PRC')
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetLabelFromValue(val, func, callback) {
        if (func == 'GetGenderList') {
            $rootScope.commonService.GetGenderList(function (response) {
                $rootScope.commonService.FoundVlaue(val, response, function (response2) {
                    callback(response2);
                });
            });
        }
        if (func == 'GetPatientBillingList') {
            $rootScope.commonService.GetPatientBillingList(function (response) {
                $rootScope.commonService.FoundVlaue(val, response, function (response2) {
                    callback(response2);
                });
            });
        }
        if (func == 'GetPatientRegisterModelList') {
            $rootScope.commonService.GetPatientRegisterModelList(function (response) {
                $rootScope.commonService.FoundVlaue(val, response, function (response2) {
                    callback(response2);
                });
            });
        }
    }

    function FoundVlaue(val, response, callback) {
        var result;
        var found = $filter('filter')(response, {value: val}, true);
        if (found.length) {
            result = found[0].label;
        }
        callback(result);
    }
}