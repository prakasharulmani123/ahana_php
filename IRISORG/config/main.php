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
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/user'], 'extraPatterns' => ['POST login' => 'login', 'POST createuser' => 'createuser', 'POST updateuser' => 'updateuser', 'GET getuser' => 'getuser', 'GET getlogin' => 'getlogin', 'POST updatelogin' => 'updatelogin', 'GET getusernamebytenant' => 'getusernamebytenant', 'POST assignroles' => 'assignroles']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/role'], 'extraPatterns' => ['POST createrole' => 'createrole', 'POST updaterole' => 'updaterole', 'GET getrole' => 'getrole', 'GET getactiverolesbytenant' => 'getactiverolesbytenant', 'GET getmyroles' => 'getmyroles']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/organization'], 'extraPatterns' => ['GET getorg' => 'getorg', 'GET getorgmodules' => 'getorgmodules', 'POST updaterolerights' => 'updaterolerights', 'POST getorgmodulesbyrole' => 'getorgmodulesbyrole']],
                ['class' => 'yii\rest\UrlRule', 'controller' => ['v1/floor'], 'extraPatterns' => ['POST remove' => 'remove']],
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