<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatConsultant;
use common\models\PatPatient;
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
class PatientconsultantController extends ActiveController {

    public $modelClass = 'common\models\PatConsultant';

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
            $model = PatConsultant::find()->where(['pat_consult_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

//    public function actionGetpatconsultantsbyencounter() {
//        $enc_id = Yii::$app->getRequest()->get('enc_id');
//
//        if (!empty($enc_id)) {
//            $model = PatConsultant::find()
//                    ->tenant()
//                    ->status()
//                    ->active()
//                    ->andWhere(['encounter_id' => $enc_id])
//                    ->orderBy([
//                        'consult_date' => SORT_DESC,
//                    ])
//                    ->all();
//        }
//
//        return $model;
//    }

    public function actionGetpatconsultantsbyencounter() {
        $get = Yii::$app->getRequest()->get();
        if (!empty($get)) {
            $patient = PatPatient::getPatientByGuid($get['patient_id']);
            $result = [];
            $data = PatConsultant::find()
                    ->tenant()
                    ->active()
                    ->status()
                    ->andWhere(['patient_id' => $patient->patient_id])
                    ->groupBy('encounter_id')
                    ->orderBy(['encounter_id' => SORT_DESC])
                    ->all();

            foreach ($data as $key => $value) {
                $details = PatConsultant::find()
                        ->where(['patient_id' => $patient->patient_id, 'encounter_id' => $value->encounter_id])
                        ->orderBy(['consult_date' => SORT_DESC])
                        ->all();

                $result[$key] = ['data' => $value, 'all' => $details];
            }
            return ['success' => true, 'result' => $result];
        }
    }

}
