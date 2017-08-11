<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoAuditLog;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

class AuditlogController extends ActiveController {

    public $modelClass = 'common\models\CoAuditLog';

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
            'query' => $modelClass::find()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }
    
    public function actionGetauditlog() {
        $offset = abs($_REQUEST['pageIndex'] - 1) * $_REQUEST['pageSize'];
        $audit = CoAuditLog::find()->tenant()
                ->limit($_REQUEST['pageSize'])
                ->offset($offset)
                ->orderBy(['created_at' => SORT_DESC])
                ->all();
        $totalCount = CoAuditLog::find()->tenant()->count();
        return ['audit' => $audit, 'totalCount' => $totalCount];
    }

}
