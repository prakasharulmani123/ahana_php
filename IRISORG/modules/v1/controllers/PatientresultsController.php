<?php

namespace IRISORG\modules\v1\controllers;

use Yii;
use common\models\PatResult;
use common\models\PatPatient;
use common\models\CoAuditLog;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PatientresultsController extends ActiveController {

    public $modelClass = 'common\models\PatResult';

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

    public function actionGetpatientresults() {
        $get = Yii::$app->getRequest()->get();
        $user_id = Yii::$app->user->identity->user->user_id;

        if (!empty($get)) {
            $patient = PatPatient::getPatientByGuid($get['patient_id']);
            $condition = [
                'patient_id' => $patient->patient_id,
            ];

            if (isset($get['date'])) {
                $condition = [
                    'patient_id' => $patient->patient_id,
                    'DATE(created_at)' => $get['date'],
                ];
            }
            $result = PatResult::find()
                    ->tenant()
                    ->active()
                    ->andWhere($condition)
                    ->orderBy(['encounter_id' => SORT_DESC])
                    ->all();

            return ['success' => true, 'result' => $result];
        }
    }

    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('id');
        if ($id) {
            $model = PatResult::find()->where(['pat_result_id' => $id])->one();
            $model->remove();
            $activity = 'Patient Results Deleted Successfully (#' . $model->encounter_id . ' )';
            CoAuditLog::insertAuditLog(PatResult::tableName(), $id, $activity);
            return ['success' => true];
        }
    }

}
