<?php

namespace IRISORG\modules\v1\controllers;

use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class AppconfigurationController extends ActiveController {

    public $modelClass = 'common\models\AppConfiguration';

    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => QueryParamAuth::className()
        ];
        $behaviors['contentNegotiator'] = [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
            ],
        ];

        return $behaviors;
    }

    public function actions() {
        $actions = parent::actions();
        $actions['index']['prepareDataProvider'] = [$this, 'prepareDataProvider'];

        return $actions;
    }

    public function prepareDataProvider() {
        /* @var $modelClass BaseActiveRecord */
        $modelClass = $this->modelClass;

        return new ActiveDataProvider([
            'query' => $modelClass::find()->tenant()->active()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }
    
    public function actionGetpresstatus() {
        $modelClass = $this->modelClass;
        $get = Yii::$app->getRequest()->get();
        return $modelClass::getConfigurationByKey($get['key']);
    }
    
    public function actionGetpresstatusbycode() {
        $modelClass = $this->modelClass;
        $get = Yii::$app->getRequest()->get();
        return $modelClass::getConfigurationBycode($get['code']);
    }
}
