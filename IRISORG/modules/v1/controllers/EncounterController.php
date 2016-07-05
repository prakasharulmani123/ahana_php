<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatAdmission;
use common\models\PatAppointment;
use common\models\PatBillingRecurring;
use common\models\PatBillingRoomChargeHistory;
use common\models\PatEncounter;
use common\models\PatPatient;
use common\models\PatPatientCasesheet;
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
            $case_model = new PatPatientCasesheet();

            $model_attr = [
                'patient_id' => (isset($post['patient_id']) ? $post['patient_id'] : ''),
                'encounter_type' => 'OP',
                'encounter_date' => $post['status_date'],
                'add_casesheet_no' => (isset($post['PatEncounter']['add_casesheet_no']) ? $post['PatEncounter']['add_casesheet_no'] : '')
            ];
            $model->attributes = $model_attr;

            $appt_model->attributes = $post;

            $valid = $model->validate();
            $valid = $appt_model->validate() && $valid;

            if (isset($post['validate_casesheet']) && $post['validate_casesheet']) {
                $case_model->attributes = [
                    'patient_id' => (isset($post['patient_id']) ? $post['patient_id'] : ''),
                    'casesheet_no' => (isset($post['PatEncounter']['add_casesheet_no']) ? $post['PatEncounter']['add_casesheet_no'] : '')
                ];

                $valid = $case_model->validate() && $valid;
            }

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
                return ['success' => false, 'message' => Html::errorSummary([$model, $appt_model, $case_model])];
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
            $case_model = new PatPatientCasesheet();

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

            if ($post['validate_casesheet']) {
                $case_model->attributes = [
                    'patient_id' => (isset($post['PatAdmission']['patient_id']) ? $post['PatAdmission']['patient_id'] : ''),
                    'casesheet_no' => (isset($post['PatEncounter']['add_casesheet_no']) ? $post['PatEncounter']['add_casesheet_no'] : '')
                ];

                $valid = $case_model->validate() && $valid;
            }

            if ($valid) {

                $model->save(false);

                $admission_model->encounter_id = $model->encounter_id;
                $admission_model->save(false);

                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $admission_model, $case_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionUpdateadmission() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            $model = PatEncounter::find()->where(['encounter_id' => $post['PatEncounter']['encounter_id']])->one();
            $admission_model = PatAdmission::find()->where(['admn_id' => $post['PatAdmission']['admn_id']])->one();

            $admission_model->attributes = $post['PatAdmission'];
            if (isset($post['PatEncounter']['encounter_date']))
                $model->encounter_date = $admission_model->status_date = $post['PatEncounter']['encounter_date'];

            $valid = $model->validate();
            $valid = $admission_model->validate() && $valid;

            if ($valid) {
                $model->save(false);
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
            $condition = [
                'patient_guid' => $get['id'],
            ];

            if (isset($get['date'])) {
                $condition = [
                    'patient_guid' => $get['id'],
                    'DATE(date)' => $get['date'],
                ];
            }

            $data = VEncounter::find()
                    ->where($condition)
                    ->groupBy('encounter_id')
                    ->orderBy(['encounter_id' => SORT_DESC])
                    ->asArray()
                    ->all();

            foreach ($data as $key => $value) {
                $details = VEncounter::find()
                        ->where(['encounter_id' => $value['encounter_id']])
                        ->andWhere($condition)
                        ->orderBy(['id' => SORT_ASC])
                        ->asArray()
                        ->all();

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

        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
        $result = [];

        $data = PatEncounter::find()
                ->joinWith('patAppointments')
                ->where([
                    'pat_encounter.status' => '1',
                    'pat_encounter.tenant_id' => $tenant_id
                ])
                ->encounterType("OP")
                ->andWhere($query)
                ->groupBy('pat_appointment.consultant_id')
                ->orderBy([
                    'encounter_id' => SORT_ASC,
                ])
                ->all();

        foreach ($data as $key => $value) {
            $details = PatEncounter::find()
                    ->joinWith('patAppointments')
                    ->where([
                        'pat_encounter.status' => '1',
                        'pat_encounter.tenant_id' => $tenant_id,
                        'pat_appointment.consultant_id' => $value->patAppointments[0]->consultant_id,
                    ])
                    ->encounterType("OP")
                    ->andWhere($query)
                    ->orderBy([
                        'encounter_date' => SORT_DESC,
                    ])
                    ->all();

            $result[$key] = ['data' => $value, 'all' => $details];
        }
        return ['success' => true, 'result' => $result];
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
                    ->andWhere(['patient_id' => $patient->patient_id])
                    ->orderBy(['encounter_id' => SORT_DESC])
                    ->one();

            if (!empty($model) && ((empty($model->patAdmissionDischarge) && empty($model->patAdmissionCancel) && $model->encounter_type == 'IP') || $model->status == '1')) {
                return ['success' => true, 'model' => $model];
            } else {
                return ['success' => false];
            }

//            $model = PatEncounter::find()
//                    ->tenant()
//                    ->status()
//                    ->andWhere(['patient_id' => $patient->patient_id])
//                    ->one();
//
//            if (!empty($model)) {
//                return ['success' => true, 'model' => $model];
//            } else {
//                return ['success' => false];
//            }
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

            $procedure = VBillingProcedures::find()->where(['encounter_id' => $encounter_id, 'tenant_id' => $tenant_id])->all();
            $consults = VBillingProfessionals::find()->where(['encounter_id' => $encounter_id, 'tenant_id' => $tenant_id])->all();
            $otherCharge = VBillingOtherCharges::find()->where(['encounter_id' => $encounter_id, 'tenant_id' => $tenant_id])->all();
            $advance = VBillingAdvanceCharges::find()->where(['encounter_id' => $encounter_id, 'tenant_id' => $tenant_id])->all();

            $data = array_merge($data, $this->_addNetAmount($procedure, 'Procedure', 'total_charge'), $this->_addNetAmount($consults, 'Consults', 'total_charge'), $this->_addNetAmount($otherCharge, 'OtherCharge', 'total_charge'), $this->_addNetAmount($advance, 'Advance', 'total_charge')
            );
        }
        return $data;
    }

    private function _addNetAmount($bills, $name, $charge_column) {
        $data[$name] = [];
        foreach ($bills as $key => $bill) {
            $prev_amount = $key == 0 ? 0 : $bills[$key - 1]->$charge_column;
            $data[$name][$key] = $bill->attributes;
            $data[$name][$key]['net_amount'] = $prev_amount + $bill->$charge_column;
        }
        return $data;
    }

    public function actionGetrecurringbilling() {
        $get = Yii::$app->getRequest()->get();

        $data = [];
        if (!empty($get) && $get['encounter_id']) {
            $encounter_id = $get['encounter_id'];
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;

            $recurrings = $this->_getBillingRecurring($encounter_id, $tenant_id);
            $data = $this->_addNetAmount($recurrings, 'recurring', 'charge_amount');
        }
        return $data;
    }

    public function actionGetroomchargehistory() {
        $get = Yii::$app->getRequest()->get();

        $data = [];
        if (!empty($get) && $get['encounter_id']) {
            $encounter_id = $get['encounter_id'];
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;

            $data['history'] = PatBillingRoomChargeHistory::find()->tenant()->status()->andWhere(['encounter_id' => $encounter_id])->all();
        }
        return $data;
    }

    public function actionUpdaterecurringroomcharge() {
        $post = Yii::$app->getRequest()->post();

        $data = [];
        if (!empty($post)) {
            $charge_hist = PatBillingRoomChargeHistory::find()->tenant()->andWhere(['charge_hist_id' => $post['charge_hist_id']])->one();

            if (empty($charge_hist))
                return;

            $tenant_id = Yii::$app->user->identity->logged_tenant_id;

            $recurring_charges = PatBillingRecurring::find()
                    ->tenant()
                    ->status()
                    ->andWhere(['encounter_id' => $charge_hist->encounter_id, 'room_type_id' => $charge_hist->room_type_id, 'charge_item_id' => $charge_hist->charge_item_id])
                    ->andWhere(['between', 'recurr_date', $charge_hist->from_date, $charge_hist->org_to_date])
                    ->all();

            foreach ($recurring_charges as $key => $recurring_charge) {
                $recurring_charge->charge_amount = $charge_hist->charge;
                $recurring_charge->save(false);
            }

            $data['recurring'] = $this->_getBillingRecurring($charge_hist->encounter_id, $tenant_id);
            $charge_hist->delete();
        }
        return $data;
    }

    public function actionCancelroomchargehistory() {
        $post = Yii::$app->getRequest()->post();

        $data = [];
        if (!empty($post)) {
            $charge_hist = PatBillingRoomChargeHistory::find()->tenant()->andWhere(['charge_hist_id' => $post['charge_hist_id']])->one();

            if (empty($charge_hist))
                return;

            $tenant_id = Yii::$app->user->identity->logged_tenant_id;

            $data['recurring'] = $this->_getBillingRecurring($charge_hist->encounter_id, $tenant_id);
            $charge_hist->delete();
        }
        return $data;
    }

    private function _getBillingRecurring($encounter_id, $tenant_id) {
        return VBillingRecurring::find()->where(['encounter_id' => $encounter_id, 'tenant_id' => $tenant_id])->orderBy(['from_date' => SORT_ASC, 'charge_item' => SORT_ASC])->all();
    }

    public function actionGetnonrecurringprocedures() {
        $get = Yii::$app->getRequest()->get();

        $data = [];
        if (!empty($get) && $get['encounter_id']) {
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;
            $encounter_id = $get['encounter_id'];
            $category_id = $get['category_id'];
            $patient_id = $get['patient_id'];

            $data = VBillingProcedures::find()->where([
                        'encounter_id' => $encounter_id,
                        'tenant_id' => $tenant_id,
                        'category_id' => $category_id,
                        'patient_id' => $patient_id
                    ])->one();
        }
        return $data;
    }

    public function actionGetnonrecurringprofessionals() {
        $get = Yii::$app->getRequest()->get();

        $data = [];
        if (!empty($get) && $get['encounter_id']) {
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;
            $encounter_id = $get['encounter_id'];
            $category_id = $get['category_id'];
            $patient_id = $get['patient_id'];

            $data = VBillingProfessionals::find()->where([
                        'encounter_id' => $encounter_id,
                        'tenant_id' => $tenant_id,
                        'category_id' => $category_id,
                        'patient_id' => $patient_id
                    ])->one();
        }
        return $data;
    }

    public function actionSavebillnote() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post) && $post['bill_notes'] != '') {
            $model = PatEncounter::find()->where(['encounter_id' => $post['encounter_id']])->one();
            if (!empty($model)) {
                $model->bill_notes = $post['bill_notes'];
                $model->save(false);
                return ['success' => true];
            } else {
                return ['success' => false, 'message' => 'Wrong entry'];
            }
        } else {
            return ['success' => false, 'message' => 'Please enter notes'];
        }
    }

}
