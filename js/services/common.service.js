'use strict';

angular.module('app').factory('CommonService', CommonService);

CommonService.$inject = ['$http', '$rootScope', '$window', '$q', '$filter', '$localStorage', 'AuthenticationService'];
function CommonService($http, $rootScope, $window, $q, $filter, $localStorage, AuthenticationService) {
    var service = {};

    service.ChangeStatus = ChangeStatus;
    service.GetCountryList = GetCountryList;
    service.GetStateList = GetStateList;
    service.GetCityList = GetCityList;
    service.GetTitleCodes = GetTitleCodes;
    service.GetMaritalStatus = GetMaritalStatus;
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
    service.GetDoctorListForPatient = GetDoctorListForPatient;
    service.GetDayList = GetDayList;
    service.CheckStateAccess = CheckStateAccess;
    service.GetGenderList = GetGenderList;
    service.GetPatientBillingList = GetPatientBillingList;
    service.GetPatientRegisterModelList = GetPatientRegisterModelList;
    service.GetPatientAppointmentStatus = GetPatientAppointmentStatus;
    service.GetRoomList = GetRoomList;
    service.GetChargeCategoryList = GetChargeCategoryList;
    service.GetEncounterListByPatient = GetEncounterListByPatient;
    service.GetEncounterListByPatientAndType = GetEncounterListByPatientAndType;
    service.GetPatientList = GetPatientList;
    service.GetAlertList = GetAlertList;
    service.GetBloodList = GetBloodList;
    service.GetDrugClassList = GetDrugClassList;
    service.GetGenericList = GetGenericList;
    service.GetPaymentType = GetPaymentType;
    service.GetSupplierList = GetSupplierList;
    service.GetProductList = GetProductList;
    service.GetProductListByName = GetProductListByName;
    service.GetPackageUnitList = GetPackageUnitList;
    service.GetBatchListByProduct = GetBatchListByProduct;
    service.GetDrugClassListByName = GetDrugClassListByName;
    service.GetPatientFrequency = GetPatientFrequency;
    service.GetPatientRoute = GetPatientRoute;
    service.GetPatientGroup = GetPatientGroup;

    service.GetLabelFromValue = GetLabelFromValue;
    service.FoundVlaue = FoundVlaue;
    service.GetRoomTypesRoomsList = GetRoomTypesRoomsList;

    service.GetBrandsList = GetBrandsList;
    service.GetDivisionsList = GetDivisionsList;

    service.GetProductUnitsList = GetProductUnitsList;
    service.GetProductDescriptionList = GetProductDescriptionList;
    service.GetVatList = GetVatList;
    service.GetPaymentModes = GetPaymentModes;
    service.GetCardTypes = GetCardTypes;

    service.GetDiagnosisList = GetDiagnosisList;
    service.GetDsmivList = GetDsmivList;

    service.GetCareTaker = GetCareTaker;

    service.GetDischargeTypes = GetDischargeTypes;
    service.CheckAdminAccess = CheckAdminAccess;
    
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

    function GetDiagnosisList(callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/default/get-diagnosis-list')
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetDsmivList(axis, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/default/get-dsmiv?axis=' + axis)
                .success(function (response) {
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
        var response = [{value: 'Mr.', label: 'Mr.'}, {value: 'Mrs.', label: 'Mrs.'}, {value: 'Miss.', label: 'Miss.'}, {value: 'Dr.', label: 'Dr.'}, {value: 'Master.', label: 'Master.'}];
        callback(response);
    }

    function GetMaritalStatus(callback) {
        var response = [
            {value: 'C', label: 'Children'},
            {value: 'U', label: 'Un married'},
            {value: 'M', label: 'Married'},
            {value: 'S', label: 'Separated'},
            {value: 'D', label: 'Divorced'},
            {value: 'W', label: 'Widow'}
        ];
        callback(response);
    }

    function GetCareTaker(callback) {
        var response = [
            {value: 1, label: 'Father'},
            {value: 2, label: 'Mother'},
            {value: 3, label: 'Husband'},
            {value: 4, label: 'Wife'},
            {value: 5, label: 'Son'},
            {value: 6, label: 'Daughter'},
            {value: 7, label: 'Friend'},
            {value: 8, label: 'Other'},
        ];
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

    function GetPatientCateogryList(sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/patientcategory/getpatientcategorylist?status=' + sts + '&deleted=' + del_sts)
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

    function GetDoctorListForPatient(tenant, sts, del_sts, care_provider, patient_guid, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/user/getdoctorslistforpatient?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts + '&care_provider=' + care_provider + '&patient_guid=' + patient_guid)
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

    function CheckStateAccess(url, callback) {
        var splittedStringArray = url.split("(");
        url = splittedStringArray[0];
        callback(AuthenticationService.getCurrentUser().resources.hasOwnProperty(url));
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
        var response = [{value: 'OP', label: 'OP'}, {value: 'IP', label: 'IP'}, {value: 'NO', label: 'None'}];
        callback(response);
    }

    function GetPatientAppointmentStatus(callback) {
        var response = [{value: 'B', label: 'Booked'}, {value: 'A', label: 'Arrived'}];
        callback(response);
    }

    function GetRoomList(tenant, sts, del_sts, occupied_status, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/room/getroomlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts + '&occupied_status=' + occupied_status)
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

    function GetEncounterListByPatientAndType(tenant, sts, del_sts, pat_id, pat_type, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/encounter/getencounterlistbypatient?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts + '&patient_id=' + pat_id + '&encounter_type=' + pat_type)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetChargeCategoryList(tenant, sts, del_sts, code, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/roomchargecategory/getchargelist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts + '&code=' + code)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetPatientList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/patient/getpatientlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetAlertList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/alert/getalertlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetBloodList(callback) {
        var response = [{value: 'O−', label: 'O−'}, {value: 'O+', label: 'O+'}, {value: 'A−', label: 'A−'}, {value: 'A−', label: 'A−'}, {value: 'A+', label: 'A+'}, {value: 'B−', label: 'B−'}, {value: 'B+', label: 'B+'}, {value: 'AB−', label: 'AB−'}, {value: 'AB+', label: 'AB+'}];
        callback(response);
    }

    function GetDrugClassList(tenant, sts, del_sts, notUsed, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacydrugclass/getdruglist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts + '&notUsed=' + notUsed)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetGenericList(tenant, sts, del_sts, notUsed, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/genericname/getgenericlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts + '&notUsed=' + notUsed)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetPaymentType(callback) {
        var response = [{value: 'CA', label: 'Cash'}, {value: 'CR', label: 'Credit'}];
        callback(response);
    }

    function GetSupplierList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacysupplier/getsupplierlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetProductList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getproductlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetProductListByName(name, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getproductlistbyname?name=' + name)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetDrugClassListByName(name, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getdrugclasslistbyname?name=' + name)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetPackageUnitList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacypacking/getpackinglist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetBatchListByProduct(product_id, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproductbatch/getbatchbyproduct?product_id=' + product_id)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetPatientRoute(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/patient/getpatientroutelist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetPatientGroup(sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/patientgroup/getpatientgrouplist?status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetPatientFrequency(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/patient/getpatientfrequencylist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
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
        if (func == 'GetMaritalStatus') {
            $rootScope.commonService.GetMaritalStatus(function (response) {
                $rootScope.commonService.FoundVlaue(val, response, function (response2) {
                    callback(response2);
                });
            });
        }
        if (func == 'GetBloodList') {
            $rootScope.commonService.GetBloodList(function (response) {
                $rootScope.commonService.FoundVlaue(val, response, function (response2) {
                    callback(response2);
                });
            });
        }
        if (func == 'GetCareTaker') {
            $rootScope.commonService.GetCareTaker(function (response) {
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

    function GetRoomTypesRoomsList(tenant, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/roomtype/getroomtypesroomslist?tenant=' + tenant)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetBrandsList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacybrandrep/getallbrands?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetDivisionsList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacybrandrep/getalldivisions?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetProductUnitsList(callback) {
        var response = [
            {value: 'MG', label: 'MG'},
            {value: 'ML', label: 'ML'},
            {value: 'G', label: 'G'}
        ];
        callback(response);
    }

    function GetProductDescriptionList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyproduct/getproductdescriptionlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetVatList(tenant, sts, del_sts, callback) {
        var response;

        $http.get($rootScope.IRISOrgServiceUrl + '/pharmacyvat/getvatlist?tenant=' + tenant + '&status=' + sts + '&deleted=' + del_sts)
                .success(function (response) {
                    callback(response);
                }, function (x) {
                    response = {success: false, message: 'Server Error'};
                    callback(response);
                });
    }

    function GetPaymentModes(callback) {
        var response = [
            {value: 'CA', label: 'Cash'},
            {value: 'CD', label: 'Card'},
            {value: 'ON', label: 'Online'},
            {value: 'CH', label: 'Cheque'},
        ];
        callback(response);
    }

    function GetCardTypes(callback) {
        var response = [
            {value: 'Visa', label: 'Visa'},
            {value: 'MasterCard', label: 'MasterCard'},
            {value: 'Maestro', label: 'Maestro'},
            {value: 'Visa Debit', label: 'Visa Debit'},
            {value: 'MasterCard Debit', label: 'MasterCard Debit'},
        ];
        callback(response);
    }
    
    function GetDischargeTypes(callback) {
        var response = [
            {value: 'DT', label: 'Death'},
            {value: 'DA', label: 'DAMA-Discharge Against Medical Advice'},
            {value: 'AT', label: 'At Request'},
            {value: 'AB', label: 'Abscond'},
        ];
        callback(response);
    }

    function CheckAdminAccess(callback) {
        var ret = false;
        var currentUser = AuthenticationService.getCurrentUser();
        var loggedIn = Boolean(currentUser);
        
        if(loggedIn){
            ret = currentUser.credentials.tenant_id == 0;
        }
        callback(ret);
    }
}