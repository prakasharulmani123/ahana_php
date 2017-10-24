<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatBillingOtherCharges;
use common\models\CoChargePerCategory;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;
use yii\helpers\Html;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PatientbillingotherchargeController extends ActiveController {

    public $modelClass = 'common\models\PatBillingOtherCharges';

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
            $model = PatBillingOtherCharges::find()->where(['other_charge_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionBulkinsert() {
        $post = Yii::$app->getRequest()->post();
        $model = new PatBillingOtherCharges();
        $model->attributes = $post;
        $model->encounter_id = $post['patient'][0]['encounter_id'];
        $valid = $model->validate();
        if ($valid) {
            foreach ($post['patient'] as $value) {
                $model = new PatBillingOtherCharges();
                $model->attributes = $post;
                $model->encounter_id = $value['encounter_id'];
                $model->patient_id = $value['patient_id'];
                $valid = $model->validate();
                if (!$valid) {
                    $error_message = "The combination has already been taken this patient ".$value['patient_name'];
                    return ['success' => false, 'message' => $error_message];
                }
            }
            foreach ($post['patient'] as $value) {
                $model = new PatBillingOtherCharges();
                $model->attributes = $post;
                $model->encounter_id = $value['encounter_id'];
                $model->patient_id = $value['patient_id'];
                $model->save();
            }
            return ['success' => true];
        } else {
            return ['success' => false, 'message' => Html::errorSummary($model)];
        }
    }
    
    public function actionGetotherchargeamount() {
        $post = Yii::$app->getRequest()->post();
        if($post['encounter_type']=='IP')
            $category = $post['room_category'];
        else
            $category = $post['pat_category'];
        return $charge_amount = CoChargePerCategory::getChargeAmount($post['charge_category'], 'C', $post['charge_sub_category'], $post['encounter_type'], $category);
    } 

}
