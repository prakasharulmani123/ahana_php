<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatAdmission;
use Yii;
use yii\bootstrap\Html;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class AdmissionController extends ActiveController {

    public $modelClass = 'common\models\PatAdmission';

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
            $model = PatAdmission::find()->where(['city_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionPatientswap() {
        $post = Yii::$app->getRequest()->post();

        $model = new PatAdmission();
        $model->scenario = 'swap';
        $model->attributes = $post;
        $model->isSwapping = true;

        $valid = $model->validate();

        if ($valid) {
            //Swap Patient 1
            $patient_1_model = new PatAdmission();
            $patient_1_model->attributes = [
                'status_date' => $post['status_date'],
                'encounter_id' => $post['encounter_id'],
                'patient_id' => $post['patient_id'],
                'floor_id' => $post['swapFloorId'],
                'ward_id' => $post['swapWardId'],
                'room_id' => $post['swapRoomId'],
                'room_type_id' => $post['swapRoomTypeId'],
                'admission_status' => $post['admission_status'],
            ];
            $patient_1_model->isSwapping = true;
            $valid = $patient_1_model->validate() && $valid;
            
            //Swap Patient 2
            $patient_2_model = new PatAdmission();
            $patient_2_model->attributes = [
                'status_date' => $post['status_date'],
                'encounter_id' => $post['swapEncounterId'],
                'patient_id' => $post['swapPatientId'],
                'floor_id' => $post['floor_id'],
                'ward_id' => $post['ward_id'],
                'room_id' => $post['room_id'],
                'room_type_id' => $post['room_type_id'],
                'admission_status' => $post['admission_status'],
            ];
            $patient_2_model->isSwapping = true;
            $valid = $patient_2_model->validate() && $valid;
            
            if ($valid) {
                $patient_1_model->save();
                $patient_2_model->save();
                
                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$patient_1_model, $patient_2_model])];
            }
        } else {
            return ['success' => false, 'message' => Html::errorSummary([$model])];
        }
    }

}
