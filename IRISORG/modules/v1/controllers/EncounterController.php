<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatAdmission;
use common\models\PatAppoinment;
use common\models\PatEncounter;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\HttpBearerAuth;
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
            $appt_model = new PatAppoinment();

            $model_attr = array(
                'patient_id' => (isset($post['patient_id']) ? $post['patient_id'] : ''),
                'encounter_type' => 'OP',
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

                    $appt_model = new PatAppoinment();
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
                $model->encounter_date = $post['PatAdmission']['status_date'];
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
            $query = "Select * ";
            $query .= "From v_encounter ";
            $query .= "Where patient_id = {$get['id']} ";

            if (isset($get['type'])) {
                $date = date('Y-m-d');
                $separtor = $get['type'] == 'Current' ? "=" : '<>';
                $query .= "And date {$separtor} '{$date}' ";
            }

            $command = Yii::$app->db->createCommand($query);
            $data = $command->queryAll();

            return ['success' => true, 'encounters' => $data];
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
            $patient_id = $post['patient_id'];
            $model = PatEncounter::find()
                    ->tenant()
                    ->status()
                    ->andWhere(["patient_id" => $patient_id])
                    ->one();
            
            if(!empty($model)){
                return ['success' => true];
            } else {
                return ['success' => false];
            }
        }
    }

}
