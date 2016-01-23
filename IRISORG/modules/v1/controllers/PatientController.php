<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoPatient;
use common\models\CoResources;
use common\models\PatPatient;
use common\models\PatPatientAddress;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * PatientController implements the CRUD actions for CoTenant model.
 */
class PatientController extends ActiveController {

    public $modelClass = 'common\models\PatPatient';

    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className()
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
            $model = CoPatient::find()->where(['patient_id' => $id])->one();
            $model->remove();

            //Remove all related records
            foreach ($model->room as $room) {
                $room->remove();
            }
            //
            return ['success' => true];
        }
    }

    public function actionRegistration() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post['PatPatient']) || !empty($post['PatPatientAddress'])) {
            $model = new PatPatient();

            if (isset($post['PatPatient'])) {
                $model->attributes = $post['PatPatient'];
                if (isset($post['PatPatient']['patient_dob']) && isset($post['PatPatient']['patient_age']) && $post['PatPatient']['patient_dob'] == '' && $post['PatPatient']['patient_age']) {
                    $newdate = strtotime("-{$post['PatPatient']['patient_age']} year", strtotime(date('Y-m-d')));
                    $model->patient_temp_dob = date('Y-m-d', $newdate);
                }
            }

            $addr_model = new PatPatientAddress();
            if (isset($post['PatPatientAddress'])) {
                $addr_model->attributes = $post['PatPatientAddress'];
            }

            $valid = $model->validate();
            $valid = $addr_model->validate() && $valid;

            if ($valid) {
                $model->save(false);

                $addr_model->patient_id = $model->patient_id;
                $addr_model->save(false);

                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $addr_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

}
