<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatAdmission;
use common\models\PatAppointment;
use common\models\PatEncounter;
use common\models\PatPatient;
use common\models\VBillingAdvanceCharges;
use common\models\VBillingOtherCharges;
use common\models\VBillingProcedures;
use common\models\VBillingProfessionals;
use common\models\VBillingRecurring;
use common\models\VEncounter;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * EncounterController implements the CRUD actions for CoTenant model.
 */
class EncounterController extends ActiveController {

    public $modelClass = 'common\models\PatEncounter';

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
            $model = CoEncounter::find()->where(['patient_id' => $id])->one();
            $model->remove();

            //Remove all related records
            foreach ($model->room as $room) {
                $room->remove();
            }
            //
            return ['success' => true];
        }
    }

    public function actionCreateappointment() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            $model = new PatEncounter();
            $appt_model = new PatAppointment();

            $model_attr = array(
                'patient_id' => (isset($post['patient_id']) ? $post['patient_id'] : ''),
                'encounter_type' => 'OP',
                'encounter_date' => $post['status_date'],
            );
            $model->attributes = $model_attr;

            $appt_model->attributes = $post;

            $valid = $model->validate();
            $valid = $appt_model->validate() && $valid;

            if ($valid) {
                $model->save(false);

                $appt_model->encounter_id = $model->encounter_id;

                //If appointment status is A (Arrived), then save first B (Booked) record 
                if ($appt_model->appt_status == "A") {
                    $appt_model->appt_status = "B";
                    $appt_model->save(false);

                    $appt_model = new PatAppointment();
                    $appt_model->attributes = $post;
                    $appt_model->encounter_id = $model->encounter_id;
                    $appt_model->appt_status = "A";
                }

                $appt_model->save(false);

                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $appt_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionCreateadmission() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            $model = new PatEncounter();
            $admission_model = new PatAdmission();

            if (isset($post['PatEncounter'])) {
                $model->encounter_type = "IP";
                $model->attributes = $post['PatEncounter'];
            }

            if (isset($post['PatAdmission'])) {
                $admission_model->attributes = $post['PatAdmission'];
                if (isset($post['PatEncounter']['encounter_date']))
                    $admission_model->status_date = $post['PatEncounter']['encounter_date'];
            }

            $valid = $model->validate();
            $valid = $admission_model->validate() && $valid;

            if ($valid) {
                $model->save(false);

                $admission_model->encounter_id = $model->encounter_id;
                $admission_model->save(false);

                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $admission_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionGetencounters() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['id'])) {
            $data = VEncounter::find()->where(['patient_guid' => $get['id']])->groupBy('encounter_id')->orderBy(['encounter_id' => SORT_DESC])->asArray()->all();
            foreach ($data as $key => $value) {
                $details = VEncounter::find()->where(['patient_guid' => $get['id'], 'encounter_id' => $value['encounter_id']])->orderBy(['id' => SORT_ASC])->asArray()->all();
                $data[$key]['all'] = $details;
            }

            $activeEncounter = PatPatient::getActiveEncounterByPatientGuid($get['id']);

            return ['success' => true, 'encounters' => $data, 'active_encounter' => $activeEncounter];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionInpatients() {
        $model = PatEncounter::find()
                ->tenant()
                ->status()
                ->encounterType("IP")
                ->orderBy([
                    'encounter_date' => SORT_DESC,
                ])
                ->all();

        return $model;
    }

    public function actionOutpatients() {
        $get = Yii::$app->getRequest()->get();

        $date = date('Y-m-d');

        //Default Current OP
        $query = "DATE(encounter_date) = '{$date}'";
        if (isset($get['type'])) {
            if ($get['type'] == 'Previous')
                $query = "DATE(encounter_date) < '{$date}'";
            else if ($get['type'] == 'Future')
                $query = "DATE(encounter_date) > '{$date}'";
        }

        $model = PatEncounter::find()
                ->tenant()
                ->status()
                ->encounterType("OP")
                ->andWhere($query)
                ->orderBy([
                    'encounter_date' => SORT_DESC,
                ])
                ->all();

        return $model;
    }

    public function actionGetencounterlistbypatient() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['tenant']))
            $tenant = $get['tenant'];

        if (isset($get['status']))
            $status = strval($get['status']);

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        if (isset($get['patient_id']))
            $patient_id = $get['patient_id'];

        $model = PatEncounter::getEncounterListByPatient($tenant, $status, $deleted, $patient_id);

        return $model;
    }

    public function actionPatienthaveactiveencounter() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            $patient = PatPatient::find()->where(['patient_guid' => $post['patient_id']])->one();
            $model = PatEncounter::find()
                    ->tenant()
                    ->status()
                    ->andWhere(['patient_id' => $patient->patient_id])
                    ->one();

            if (!empty($model)) {
                return ['success' => true, 'model' => $model];
            } else {
                return ['success' => false];
            }
        }
    }

    public function actionPatienthaveunfinalizedencounter() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            $patient = PatPatient::find()->where(['patient_guid' => $post['patient_id']])->one();
            $model = PatEncounter::find()
                    ->tenant()
                    ->unfinalized()
                    ->andWhere(['patient_id' => $patient->patient_id, 'encounter_id' => $post['encounter_id']])
                    ->one();

            if (!empty($model)) {
                return ['success' => true, 'model' => $model];
            } else {
                return ['success' => false];
            }
        }
    }

    public function actionAppointmentseenencounter() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            $patient = PatPatient::find()->where(['patient_guid' => $post['patient_id']])->one();
            $model = PatEncounter::find()
                    ->tenant()
                    ->status('0')
                    ->andWhere(['patient_id' => $patient->patient_id])
                    ->andWhere(['encounter_id' => $post['enc_id']])
                    ->one();

            if (!empty($model)) {
                return ['success' => true, 'model' => $model];
            } else {
                return ['success' => false];
            }
        }
    }

    public function actionGetnonrecurringbilling() {
        $get = Yii::$app->getRequest()->get();

        $data = [];
        if (!empty($get) && $get['encounter_id']) {
            $encounter_id = $get['encounter_id'];
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;
            
            $data['Procedure'] = VBillingProcedures::find()->where(['encounter_id' => $encounter_id, 'tenant_id' => $tenant_id])->all();
            $data['Consults'] = VBillingProfessionals::find()->where(['encounter_id' => $encounter_id, 'tenant_id' => $tenant_id])->all();
            $data['OtherCharge'] = VBillingOtherCharges::find()->where(['encounter_id' => $encounter_id, 'tenant_id' => $tenant_id])->all();
            $data['Advance'] = VBillingAdvanceCharges::find()->where(['encounter_id' => $encounter_id, 'tenant_id' => $tenant_id])->all();
        }
        return $data;
    }
    
    public function actionGetrecurringbilling() {
        $get = Yii::$app->getRequest()->get();

        $data = [];
        if (!empty($get) && $get['encounter_id']) {
            $encounter_id = $get['encounter_id'];
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;
            
            $data['recurring'] = VBillingRecurring::find()->where(['encounter_id' => $encounter_id, 'tenant_id' => $tenant_id])->all();
        }
        return $data;
    }

}
