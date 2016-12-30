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
                'encounter_date' => @$post['status_date'],
                'add_casesheet_no' => (isset($post['PatEncounter']['add_casesheet_no']) ? $post['PatEncounter']['add_casesheet_no'] : ''),
                'consultant_id' => @$post['consultant_id']
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
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        if (isset($get['id'])) {
            $condition['patient_guid'][$get['id']] = $get['id'];
            
            if(isset($get['date'])){
                $condition['DATE(date)'] = $get['date'];
            }

//            $patient = PatPatient::getPatientByGuid($get['id']);

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

            return ['success' => true, 'encounters' => $data, 'active_encounter' => $activeEncounter ? : null];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionGetallbilling() {
        $get = Yii::$app->getRequest()->get();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        if (isset($get['id'])) {
            $condition['patient_guid'][$get['id']] = $get['id'];
            
            if(isset($get['date'])){
                $condition['DATE(date)'] = $get['date'];
            }
            
            $encounters = VEncounter::find()
                    ->where($condition)
                    ->groupBy('encounter_id')
                    ->orderBy(['encounter_id' => SORT_DESC])
                    ->all();
            
            $data = [];
            foreach ($encounters as $k => $e) {
                if($e->encounter_type == 'IP' || ($e->encounter_type == 'OP' && $e->encounter->patAppointmentSeen)){
                    $data[$k] = $e->toArray();
                    $data[$k]['view_calculation'] = $e->encounter->viewChargeCalculation;
                    
                    if($e->encounter_type == 'OP')
                        $data[$k]['seen'] = $e->encounter->patAppointmentSeen;
                }
            }

            return ['success' => true, 'encounters' => array_values($data)];
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

    //Reducing query for speed up. In-Progress
    public function actionOutpatients() {
        $get = Yii::$app->getRequest()->get();
        $date = date('Y-m-d');
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        //Default Current OP
        $query = "DATE(encounter_date) = '{$date}'";
        if (isset($get['type'])) {
            if ($get['type'] == 'Previous')
                $query = "DATE(encounter_date) < '{$date}'";
            else if ($get['type'] == 'Future')
                $query = "DATE(encounter_date) > '{$date}'";
        }

        //Check "View logged in doctor appointments".
        $condition = [
            'pat_encounter.tenant_id' => $tenant_id,
            'pat_appointment.consultant_id' => Yii::$app->user->identity->user->user_id,
            'pat_appointment.status' => '1',
        ];
        //Check "View all doctors appointments".
        if (isset($get['all'])) {
            if ($get['all']) {
                $condition = [
                    'pat_encounter.tenant_id' => $tenant_id,
                    'pat_appointment.status' => '1',
                ];
            }
        }

        $result = [];

        $connection = Yii::$app->client;
        $command = $connection->createCommand("SELECT a.consultant_id,
                (
                    SELECT COUNT(*)
                    FROM pat_appointment c
                    JOIN pat_encounter d
                    ON d.encounter_id = c.encounter_id
                    WHERE d.tenant_id = :tid
                    AND d.status = '1'
                    AND c.appt_status = 'B'
                    AND d.encounter_type = :ptype
                    AND DATE(d.encounter_date) = :enc_date
                    AND c.consultant_id = a.consultant_id
                ) AS booking,
                (
                    SELECT COUNT(*)
                    FROM pat_appointment c
                    JOIN pat_encounter d
                    ON d.encounter_id = c.encounter_id
                    WHERE d.tenant_id = :tid
                    AND d.status = '1'
                    AND c.appt_status = 'A'
                    AND d.encounter_type = :ptype
                    AND DATE(d.encounter_date) = :enc_date
                    AND c.consultant_id = a.consultant_id
                ) AS arrival,
                (
                    SELECT COUNT(*)
                    FROM pat_appointment c
                    JOIN pat_encounter d
                    ON d.encounter_id = c.encounter_id
                    WHERE d.tenant_id = :tid
                    AND d.status = '0'
                    AND c.appt_status = 'S'
                    AND d.encounter_type = :ptype
                    AND DATE(d.encounter_date) = :enc_date
                    AND c.consultant_id = a.consultant_id
                ) AS seen,
                (SELECT booking)-(SELECT arrival) AS booked
                FROM pat_appointment a
                JOIN pat_encounter b
                ON b.encounter_id = a.encounter_id
                WHERE a.tenant_id = :tid
                AND b.encounter_type = :ptype
                AND DATE(b.encounter_date) = :enc_date
                GROUP BY a.consultant_id",[':enc_date' =>  $date,':tid' => $tenant_id,':ptype' => 'OP']);

        $counts = $command->queryAll(\PDO::FETCH_OBJ);
        $consultants = [];
        if($counts){
            foreach($counts as $v)
                $consultants[$v->consultant_id] = ['booked' => $v->booked,'arrival' => $v->arrival,'seen' => $v->seen];
        }

        $details = PatEncounter::find()
                ->joinWith('patAppointments')
                ->addSelect([
                    '{{pat_encounter}}.*'
                ])
                ->where($condition)
                ->encounterType("OP")
                ->andWhere($query)
                ->orderBy([
                    '{{pat_appointment}}.appt_status' => SORT_ASC,
                    '{{pat_appointment}}.status_time' => SORT_ASC,
                ])
                ->all();

        return ['success' => true, 'result' => $details,'consultants' => $consultants];
    }

    public function actionOutpatientsold() {
        $get = Yii::$app->getRequest()->get();

        $date = date('Y-m-d');
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        //Default Current OP
        $query = "DATE(encounter_date) = '{$date}'";
        if (isset($get['type'])) {
            if ($get['type'] == 'Previous')
                $query = "DATE(encounter_date) < '{$date}'";
            else if ($get['type'] == 'Future')
                $query = "DATE(encounter_date) > '{$date}'";
        }

        $condition = [
//            'pat_encounter.status' => '1',
            'pat_encounter.tenant_id' => $tenant_id,
            'pat_appointment.consultant_id' => Yii::$app->user->identity->user->user_id,
            'pat_appointment.status' => '1',
        ];

        $seen_condition = [
            'pat_encounter.status' => '0',
            'pat_encounter.tenant_id' => $tenant_id,
            'pat_appointment.consultant_id' => Yii::$app->user->identity->user->user_id,
            'pat_appointment.appt_status' => 'S',
        ];

        //Check "View all doctors appointments".
        if (isset($get['all'])) {
            if ($get['all']) {
                $condition = [
//                    'pat_encounter.status' => '1',
                    'pat_encounter.tenant_id' => $tenant_id,
                    'pat_appointment.status' => '1',
                ];

                $seen_condition = [
                    'pat_encounter.status' => '0',
                    'pat_encounter.tenant_id' => $tenant_id,
                    'pat_appointment.appt_status' => 'S',
                ];
            }
        }

        $result = [];

        $data = PatEncounter::find()
                ->joinWith('patAppointments')
                ->where($condition)
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
                    ->where($condition)
                    ->encounterType("OP")
                    ->andWhere($query)
                    ->andWhere(['pat_appointment.consultant_id' => $value['patAppointments'][0]['consultant_id']])
                    ->orderBy([
                        'encounter_date' => SORT_DESC,
                    ])
                    ->all();

            $seen_encounters = PatEncounter::find()
                    ->joinWith('patAppointments')
                    ->where($seen_condition)
                    ->encounterType("OP")
                    ->andWhere($query)
                    ->andWhere(['pat_appointment.consultant_id' => $value['patAppointments'][0]['consultant_id']])
                    ->orderBy([
                        'encounter_date' => SORT_DESC,
                    ])
                    ->count();

            $result[$key] = ['data' => $value, 'all' => $details, 'seen_count' => $seen_encounters];
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

        $encounter_type = 'IP,OP';
        if (isset($get['encounter_type']))
            $encounter_type = $get['encounter_type'];

        $model = PatEncounter::getEncounterListByPatient($tenant, $status, $deleted, $patient_id, $encounter_type);

        return $model;
    }

    public function actionPatienthaveactiveencounter() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            $patient = PatPatient::find()->where(['patient_guid' => $post['patient_id']])->one();
            $enc_type = isset($post['encounter_type']) ? $post['encounter_type'] : ['IP', 'OP'];
            $encounter = PatEncounter::find()
                    ->tenant()
                    ->andWhere(['encounter_type' => $enc_type])
                    ->andWhere(['patient_id' => $patient->patient_id])
                    ->orderBy(['encounter_id' => SORT_DESC]);
            
            $model = $encounter->one();

            if (!empty($model) && $model->isActiveEncounter()) {
                return ['success' => true, 'model' => $model, 'encounters' => $encounter->andWhere(['status' => '1'])->all()];
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
