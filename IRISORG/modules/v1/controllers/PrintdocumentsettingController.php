<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PrintDocumentSetting;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * HsnController implements the CRUD actions for CoTenant model.
 */
class PrintdocumentsettingController extends ActiveController {

    public $modelClass = 'common\models\PrintDocumentSetting';

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
            'query' => $modelClass::find()->active()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }
    
    public function actionGetprintconfiguration() {
        $get = Yii::$app->request->get();
        $printSetting = PrintDocumentSetting::find()->tenant()
                        ->andWhere(['print_document_id' => $get['print_document_id']])
                        ->one();
        return ['success' => true, 'printSetting' => $printSetting];
    }
    
    public function actionGetprintoption() {
        $get = Yii::$app->getRequest()->get();
        return PrintDocumentSetting::getPrintOption($get['print_document_id']);
    }
    

}
