<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaDrugClass;
use common\models\PhaDrugGeneric;
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
class PharmacydrugclassController extends ActiveController {

    public $modelClass = 'common\models\PhaDrugClass';

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

    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('id');
        if ($id) {
            $model = PhaDrugClass::find()->where(['drug_class_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionGetdruglist() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['tenant']))
            $tenant = $get['tenant'];

        if (isset($get['status']))
            $status = strval($get['status']);

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        if (isset($get['notUsed']))
            $notUsed = $get['notUsed'] == 'true';

        return ['drugList' => PhaDrugClass::getDruglist($tenant, $status, $deleted, $notUsed)];
    }
    
    public function actionGetdrugbygeneric() {
        $generic_id = Yii::$app->request->get('generic_id');
        if (!empty($generic_id)) {
            $drug = PhaDrugGeneric::find()->tenant()->status()->active()->andWhere(['generic_id' => $generic_id])->one();
            return ['success' => true, 'drug' => $drug];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

}
