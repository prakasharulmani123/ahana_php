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
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/user'], 'extraPatterns' => ['POST login' => 'login', 'POST createuser' => 'createuser', 'POST updateuser' => 'updateuser', 'GET getuser' => 'getuser', 'GET getlogin' => 'getlogin', 'POST updatelogin' => 'updatelogin', 'GET getuserslistbyuser' => 'getuserslistbyuser', 'POST assignroles' => 'assignroles']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/role'], 'extraPatterns' => ['POST createrole' => 'createrole', 'POST updaterole' => 'updaterole', 'GET getrole' => 'getrole', 'GET getactiverolesbyuser' => 'getactiverolesbyuser', 'GET getmyroles' => 'getmyroles']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/organization'], 'extraPatterns' => ['GET getorg' => 'getorg', 'GET getorgmodules' => 'getorgmodules', 'POST updaterolerights' => 'updaterolerights', 'POST getorgmodulesbyrole' => 'getorgmodulesbyrole']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roommaintenance'], 'extraPatterns' => ['GET getmaintenancelist' => 'getmaintenancelist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/floor'], 'extraPatterns' => ['POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/ward'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getwardlist' => 'getwardlist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roomchargecategory'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getroomchargecategorylist' => 'getroomchargecategorylist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roomchargesubcategory'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getroomchargesubcategorylist' => 'getroomchargesubcategorylist', 'POST saveallsubcategory' => 'saveallsubcategory', 'POST deleteallsubcategory' => 'deleteallsubcategory']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roomchargeitem'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getroomchargeitemlist' => 'getroomchargeitemlist']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/roomtype'], 'extraPatterns' => ['POST remove' => 'remove', 'GET getroomtypelist' => 'getroomtypelist']],
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
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/alert'], 'extraPatterns' => ['POST remove' => 'remove']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/patient'], 'extraPatterns' => ['POST remove' => 'remove', 'POST registration' => 'registration', 'GET getpatientaddress' => 'getpatientaddress']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/encounter'], 'extraPatterns' => ['POST remove' => 'remove', 'POST createappointment' => 'createappointment', 'POST createadmission' => 'createadmission', 'GET getencounters' => 'getencounters', 'GET inpatients' => 'inpatients', 'GET outpatients' => 'outpatients']],
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