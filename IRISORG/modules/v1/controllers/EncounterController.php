<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatAdmission;
use common\models\PatAppointment;
use common\models\PatBillingExtraConcession;
use common\models\PatBillingOtherCharges;
use common\models\PatBillingPayment;
use common\models\PatConsultant;
use common\models\PatEncounter;
use common\models\PatPatient;
use common\models\PatProcedure;
use common\models\VEncounter;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\ArrayHelper;
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

        $return = [];
        if (!empty($get) && $get['encounter_id']) {
            $encounter_id = $get['encounter_id'];

            $procedure_charges = $this->_getProcedureCharges($encounter_id);
            $consultant_charges = $this->_getConsultantCharges($encounter_id);
            $allied_charges = $this->_getOtherCharges($encounter_id);
            $advanced_charges = $this->_getAdvancedCharges($encounter_id);

            $return = array_merge($return, $procedure_charges, $consultant_charges, ['other_charges' => $allied_charges], $advanced_charges);
        }
        return $return;
    }

    private function _getProcedureCharges($encounter_id) {
        $procedures = PatProcedure::find()->tenant()->status()->active()->andWhere(['encounter_id' => $encounter_id])->all();
        $extra_concessions = PatBillingExtraConcession::find()->tenant()->status()->active()->ectype('P')->andWhere(['encounter_id' => $encounter_id])->all();

        $extras = ArrayHelper::map($extra_concessions, 'link_id', 'extra_amount');
        $concessions = ArrayHelper::map($extra_concessions, 'link_id', 'concession_amount');

        $return = [];
        foreach ($procedures as $key => $procedure) {
            $return['Procedures'][$procedure->charge_subcat_id]['name'] = $procedure->chargeCat->charge_subcat_name;

            $charge_amount = $procedure->charge_amount;

            if (!isset($return['Procedures'][$procedure->charge_subcat_id]['count']))
                $return['Procedures'][$procedure->charge_subcat_id]['count'] = 0;

            if (!isset($return['Procedures'][$procedure->charge_subcat_id]['total_charge']))
                $return['Procedures'][$procedure->charge_subcat_id]['total_charge'] = 0;

            $return['Procedures'][$procedure->charge_subcat_id]['count'] = $return['Procedures'][$procedure->charge_subcat_id]['count'] + 1;
            $return['Procedures'][$procedure->charge_subcat_id]['total_charge'] = $return['Procedures'][$procedure->charge_subcat_id]['total_charge'] + $charge_amount;
        }

        if (isset($return['Procedures'])) {
            foreach ($return['Procedures'] as $link_id => $value) {
                //Extra
                if (!empty($extras) && array_key_exists($link_id, $extras)) {
                    $return['Procedures'][$link_id]['extra_amount'] = $extras[$link_id];
                } else {
                    $return['Procedures'][$link_id]['extra_amount'] = 0;
                }

                //Concession
                if (!empty($concessions) && array_key_exists($link_id, $concessions)) {
                    $return['Procedures'][$link_id]['concession_amount'] = $concessions[$link_id];
                } else {
                    $return['Procedures'][$link_id]['concession_amount'] = 0;
                }

                $charge_amount = round(($value['total_charge'] / $value['count']), 0);
                $final_price = $value['total_charge'] + $return['Procedures'][$link_id]['extra_amount'] - $return['Procedures'][$link_id]['concession_amount'];

                $return['Procedures'][$link_id]['charge_amount'] = $charge_amount;
                $return['Procedures'][$link_id]['final_charge_amount'] = $final_price;
            }
        }
        return $return;
    }

    private function _getConsultantCharges($encounter_id) {
        $consultants = PatConsultant::find()->tenant()->status()->active()->andWhere(['encounter_id' => $encounter_id])->all();
        $extra_concessions = PatBillingExtraConcession::find()->tenant()->status()->active()->ectype('C')->andWhere(['encounter_id' => $encounter_id])->all();

        $extras = ArrayHelper::map($extra_concessions, 'link_id', 'extra_amount');
        $concessions = ArrayHelper::map($extra_concessions, 'link_id', 'concession_amount');

        $return = [];
        foreach ($consultants as $key => $consultant) {
            $return['Consults'][$consultant->consultant_id]['name'] = $consultant->consultant->name;

            $charge_amount = $consultant->charge_amount;

            if (!isset($return['Consults'][$consultant->consultant_id]['count']))
                $return['Consults'][$consultant->consultant_id]['count'] = 0;

            if (!isset($return['Consults'][$consultant->consultant_id]['total_charge']))
                $return['Consults'][$consultant->consultant_id]['total_charge'] = 0;

            $return['Consults'][$consultant->consultant_id]['count'] = $return['Consults'][$consultant->consultant_id]['count'] + 1;
            $return['Consults'][$consultant->consultant_id]['total_charge'] = $return['Consults'][$consultant->consultant_id]['total_charge'] + $charge_amount;
        }

        if (isset($return['Consults'])) {
            foreach ($return['Consults'] as $link_id => $value) {
                //Extra
                if (!empty($extras) && array_key_exists($link_id, $extras)) {
                    $return['Consults'][$link_id]['extra_amount'] = $extras[$link_id];
                } else {
                    $return['Consults'][$link_id]['extra_amount'] = 0;
                }

                //Concession
                if (!empty($concessions) && array_key_exists($link_id, $concessions)) {
                    $return['Consults'][$link_id]['concession_amount'] = $concessions[$link_id];
                } else {
                    $return['Consults'][$link_id]['concession_amount'] = 0;
                }

                $charge_amount = round(($value['total_charge'] / $value['count']), 0);
                $final_price = $value['total_charge'] + $return['Consults'][$link_id]['extra_amount'] - $return['Consults'][$link_id]['concession_amount'];

                $return['Consults'][$link_id]['charge_amount'] = $charge_amount;
                $return['Consults'][$link_id]['final_charge_amount'] = $final_price;
            }
        }
        return $return;
    }

    private function _getOtherCharges($encounter_id) {
        $other_charges = PatBillingOtherCharges::find()->tenant()->status()->active()->andWhere(['encounter_id' => $encounter_id])->all();

        $return = [];
        foreach ($other_charges as $key => $other_charge) {

            $cat_name = $other_charge->chargeCat->charge_cat_name;

            $return[$cat_name][$other_charge->charge_subcat_id]['charge_subcat_id'] = $other_charge->charge_subcat_id;
            $return[$cat_name][$other_charge->charge_subcat_id]['name'] = $other_charge->chargeSubcat->charge_subcat_name;

            $charge_amount = $other_charge->charge_amount;

            if (!isset($return[$cat_name][$other_charge->charge_subcat_id]['count']))
                $return[$cat_name][$other_charge->charge_subcat_id]['count'] = 0;

            if (!isset($return[$cat_name][$other_charge->charge_subcat_id]['total_charge']))
                $return[$cat_name][$other_charge->charge_subcat_id]['total_charge'] = 0;

            $return[$cat_name][$other_charge->charge_subcat_id]['count'] = $return[$cat_name][$other_charge->charge_subcat_id]['count'] + 1;
            $return[$cat_name][$other_charge->charge_subcat_id]['total_charge'] = $return[$cat_name][$other_charge->charge_subcat_id]['total_charge'] + $charge_amount;
        }

        if (!empty($return)) {
            foreach ($return as $charge_name => $row) {
                foreach ($row as $link_id => $value) {
                    //Extra
                    $return[$charge_name][$link_id]['extra_amount'] = 0;

                    //Concession
                    $return[$charge_name][$link_id]['concession_amount'] = 0;

                    $charge_amount = round(($value['total_charge'] / $value['count']), 0);
                    $final_price = $value['total_charge'] + $return[$charge_name][$link_id]['extra_amount'] - $return[$charge_name][$link_id]['concession_amount'];

                    $return[$charge_name][$link_id]['charge_amount'] = $charge_amount;
                    $return[$charge_name][$link_id]['final_charge_amount'] = $final_price;
                }
            }
        }
        
        return $return;
    }

    private function _getAdvancedCharges($encounter_id) {
        $advances = PatBillingPayment::find()->tenant()->status()->active()->andWhere(['encounter_id' => $encounter_id])->all();

        $return = [];
        foreach ($advances as $key => $advance) {

            $return['Advanced'][$advance->payment_id]['payment_id'] = $advance->payment_id;
            $return['Advanced'][$advance->payment_id]['name'] = 'Payment';

            $charge_amount = $advance->payment_amount;

            $return['Advanced'][$advance->payment_id]['count'] = 0;
            $return['Advanced'][$advance->payment_id]['extra_amount'] = 0;
            $return['Advanced'][$advance->payment_id]['concession_amount'] = 0;
            $return['Advanced'][$advance->payment_id]['total_charge'] = $charge_amount;
            $return['Advanced'][$advance->payment_id]['final_charge_amount'] = $charge_amount;
        }

        return $return;
    }

}
