<?php

$params = array_merge(
        require(__DIR__ . '/../../common/config/params.php'), require(__DIR__ . '/../../common/config/params-local.php'), require(__DIR__ . '/params.php'), require(__DIR__ . '/params-local.php')
);

return [
    'id' => 'app-IRISORG',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'controllerNamespace' => 'IRISORG\controllers',
    'modules' => [
        'v1' => [
            'basePath' => '@app/modules/v1',
            'class' => 'IRISORG\modules\v1\Module',
        ],
    ],
    'components' => [
        'user' => [
            'identityClass' => 'common\models\CoLogin',
            'enableSession' => false,
            'loginUrl' => null,
        ],
        'request' => [
            'class' => '\yii\web\Request',
            'enableCookieValidation' => false,
            'enableCsrfValidation' => false,
            'parsers' => [
                'application/json' => 'yii\web\JsonParser',
            ],
        ],
        'urlManager' => [
            'enablePrettyUrl' => true,
            'enableStrictParsing' => false,
            'showScriptName' => false,
            'rules' => [
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/user'], 'extraPatterns' => ['POST login' => 'login', 'POST createuser' => 'createuser', 'POST updateuser' => 'updateuser', 'GET getuser' => 'getuser', 'GET getlogin' => 'getlogin', 'POST updatelogin' => 'updatelogin', 'GET getuserslistbyuser' => 'getuserslistbyuser', 'POST assignroles' => 'assignroles', 'GET getusercredentialsbytoken' => 'getusercredentialsbytoken', 'POST logout' => 'logout']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/role'], 'extraPatterns' => ['POST createrole' => 'createrole', 'POST updaterole' => 'updaterole', 'GET getrole' => 'getrole', 'GET getactiverolesbyuser' => 'getactiverolesbyuser', 'GET getmyroles' => 'getmyroles']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/organization'], 'extraPatterns' => ['GET getorg' => 'getorg', 'GET getorgmodules' => 'getorgmodules', 'POST updaterolerights' => 'updaterolerights', 'POST getorgmodulesbyrole' => 'getorgmodulesbyrole']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roommaintenance'], 'extraPatterns' => ['GET getmaintenancelist' => 'getmaintenancelist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/floor'], 'extraPatterns' => ['POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/ward'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getwardlist' => 'getwardlist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roomchargecategory'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getroomchargecategorylist' => 'getroomchargecategorylist', 'GET getchargelist' => 'getchargelist', 'GET getroomchargelist' => 'getroomchargelist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roomchargesubcategory'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getroomchargesubcategorylist' => 'getroomchargesubcategorylist', 'POST saveallsubcategory' => 'saveallsubcategory', 'POST deleteallsubcategory' => 'deleteallsubcategory']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roomchargeitem'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getroomchargeitemlist' => 'getroomchargeitemlist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roomtype'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getroomtypelist' => 'getroomtypelist', 'GET getroomtypesroomslist' => 'getroomtypesroomslist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/room'], 'extraPatterns' => ['GET getrooms' => 'getrooms', 'GET getroomandroomtypes' => 'getroomandroomtypes', 'POST assignroomtypes' => 'assignroomtypes', 'GET getroomlist' => 'getroomlist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roomcharge'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getroomchargecategorylist' => 'getroomchargecategorylist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/speciality'], 'extraPatterns' => ['GET getspecialitylist' => 'getspecialitylist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/patientcategory'], 'extraPatterns' => ['GET getpatientcategorylist' => 'getpatientcategorylist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/chargepercategory']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/chargepersubcategory'], 'extraPatterns' => ['GET getroomchargesubcategorylist' => 'getroomchargesubcategorylist', 'POST saveallchargecategory' => 'saveallchargecategory']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/internalcode'], 'extraPatterns' => ['GET getinternalcode' => 'getinternalcode']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/doctorschedule'], 'extraPatterns' => ['POST remove' => 'remove', 'POST removeall' => 'removeall', 'POST createschedule' => 'createschedule']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/country'], 'extraPatterns' => ['POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/state'], 'extraPatterns' => ['POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/city'], 'extraPatterns' => ['POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/alert'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getalertlist' => 'getalertlist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/patient'], 'extraPatterns' => ['POST remove' => 'remove', 'POST registration' => 'registration', 'GET getpatientaddress' => 'getpatientaddress', 'GET getpatientlist' => 'getpatientlist', 'POST getpatientbyguid' => 'getpatientbyguid', 'POST getagefromdate' => 'getagefromdate']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/encounter'], 'extraPatterns' => ['POST remove' => 'remove', 'POST createappointment' => 'createappointment', 'POST createadmission' => 'createadmission', 'GET getencounters' => 'getencounters', 'GET inpatients' => 'inpatients', 'GET outpatients' => 'outpatients', 'GET getencounterlistbypatient' => 'getencounterlistbypatient', 'POST patienthaveactiveencounter' => 'patienthaveactiveencounter']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/procedure'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getprocedurebyencounter' => 'getprocedurebyencounter', 'GET getconsultantsbyprocedure' => 'getconsultantsbyprocedure']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/admission'], 'extraPatterns' => ['POST remove' => 'remove', 'POST patientswap' => 'patientswap']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/appointment'], 'extraPatterns' => ['POST changestatus' => 'changestatus', 'POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/patientalert'], 'extraPatterns' => ['POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/patientconsultant'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getpatconsultantsbyencounter' => 'getpatconsultantsbyencounter']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/patientnotes'], 'extraPatterns' => ['GET getpatientnotes' => 'getpatientnotes', 'POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacybrand'], 'extraPatterns' => ['POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacybrandrep'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getallbrands' => 'getallbrands', 'GET getalldivisions' => 'getalldivisions']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacybranddivision'], 'extraPatterns' => ['POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacydrugclass'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getdruglist' => 'getdruglist', 'GET getdrugbygeneric' => 'getdrugbygeneric']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/genericname'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getgenericlist' => 'getgenericlist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacyprodesc'], 'extraPatterns' => ['POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacypacking'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getpackinglist' => 'getpackinglist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacysupplier'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getsupplierlist' => 'getsupplierlist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacyvat'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getvatlist' => 'getvatlist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacydruggeneric'], 'extraPatterns' => ['POST remove' => 'remove', 'POST savedruggeneric' => 'savedruggeneric', 'POST updatedruggeneric' => 'updatedruggeneric']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/patientcasesheet'], 'extraPatterns' => ['POST createcasesheet' => 'createcasesheet']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacyproduct'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getproductlist' => 'getproductlist', 'GET getproductdescriptionlist' => 'getproductdescriptionlist', 'GET getproductlistbyname' => 'getproductlistbyname', 'POST searchbycriteria' => 'searchbycriteria', 'POST adjuststock' => 'adjuststock']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacypurchase'], 'extraPatterns' => ['POST remove' => 'remove', 'POST savepurchase' => 'savepurchase']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacyproductbatch'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getbatchbyproduct' => 'getbatchbyproduct']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacysale'], 'extraPatterns' => ['POST remove' => 'remove', 'POST savesale' => 'savesale']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/pharmacypurchasereturn'], 'extraPatterns' => ['POST remove' => 'remove', 'POST savepurchasereturn' => 'savepurchasereturn']],
            ],
        ],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'errorHandler' => [
            'errorAction' => 'v1/default/error',
        ],
    ],
    'params' => $params,
];
