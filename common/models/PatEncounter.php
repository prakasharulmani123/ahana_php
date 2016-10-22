<?php

namespace common\models;

use common\models\query\PatEncounterQuery;
use DateTime;
use Yii;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_encounter".
 *
 * @property integer $encounter_id
 * @property integer $tenant_id
 * @property integer $patient_id
 * @property string $encounter_type
 * @property string $encounter_date
 * @property string $inactive_date
 * @property string $bill_no
 * @property string $bill_notes
 * @property integer $finalize
 * @property integer $authorize
 * @property integer $discharge
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property string $casesheet_no
 * @property string $concession_amount
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatAppointment[] $patAppointments
 * @property PatPatient $patient
 * @property CoTenant $tenant
 */
class PatEncounter extends RActiveRecord {

    public $sts_date;
    public $sts_time;
    public $sts_status = 'A';
    public $add_casesheet_no = 'A';
    public $total_amount = '';
    public $op_doctor_payment_patient_name;
    public $op_doctor_payment_amount;
    public $op_doctor_payment_consultant_name;
    public $op_doctor_payment_seen_date;
    public $op_doctor_payment_seen_time;
    public $consultant_id;

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_encounter';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['encounter_date'], 'required'],
            [['tenant_id', 'patient_id', 'finalize', 'authorize', 'created_by', 'modified_by', 'discharge'], 'integer'],
            [['encounter_date', 'inactive_date', 'created_at', 'modified_at', 'deleted_at', 'casesheet_no', 'discharge', 'total_amount', 'bill_no', 'bill_notes', 'consultant_id'], 'safe'],
            [['status', 'casesheet_no', 'add_casesheet_no'], 'string'],
            [['concession_amount'], 'number'],
            [['encounter_type'], 'string', 'max' => 5],
            ['concession_amount', 'validateConcessionAmount'],
            ['encounter_date', 'validateAdmissionDate'],
            ['encounter_date', 'validateAppointment'],
        ];
    }

    public function validateConcessionAmount($attribute, $params) {
        if (($this->total_amount > 0) && $this->concession_amount > $this->total_amount)
            $this->addError($attribute, "Concession Amount ({$this->concession_amount}) must be lesser than Total Amount ({$this->total_amount})");
    }

    //Check new admission date is between old admission and discharge date.
    public function validateAdmissionDate($attribute, $params) {
        if ($this->encounter_type == 'IP') {
            $date = date("Y-m-d", strtotime($this->encounter_date));
            $result = PatEncounter::find()
                    ->joinWith('patAdmissions')
                    ->where([
                        'pat_encounter.tenant_id' => $this->tenant_id,
                        'pat_encounter.patient_id' => $this->patient_id,
                        'pat_encounter.status' => '0',
                        'pat_admission.admission_status' => 'D',
                    ])
                    ->encounterType($this->encounter_type)
                    ->andWhere("DATE(pat_encounter.encounter_date) <= '{$date}'")
                    ->andWhere("DATE(pat_admission.status_date) >= '{$date}'")
                    ->one();

            if (!empty($result))
                $this->addError($attribute, "Admission already taken in this date. Kindly choose another date");
        }
    }

    //Check new appointment - Same Tenant, Same Patient, Same Doctor, Active Encounter
    public function validateAppointment($attribute, $params) {
        if ($this->encounter_type == 'OP') {
            $date = date("Y-m-d", strtotime($this->encounter_date));
            $result = PatEncounter::find()
                    ->joinWith('patAppointments')
                    ->where([
                        'pat_encounter.tenant_id' => $this->tenant_id,
                        'pat_encounter.patient_id' => $this->patient_id,
                        'DATE(pat_encounter.encounter_date)' => $date,
                        'pat_encounter.status' => '1',
                        'pat_appointment.consultant_id' => $this->consultant_id,
                    ])
                    ->encounterType('OP')
                    ->one();
            
            if(!empty($result)){
                $this->addError($attribute, 'Booking activity in progress for this patient!');
            }
        }
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'encounter_id' => 'Encounter ID',
            'tenant_id' => 'Tenant ID',
            'patient_id' => 'Patient ID',
            'encounter_type' => 'Encounter Type',
            'encounter_date' => 'Encounter Date',
            'inactive_date' => 'Inactive Date',
            'finalize' => 'Finalize',
            'authorize' => 'Authorize',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
            'concession_amount' => 'Concession Amount',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getPatAppointments() {
        return $this->hasMany(PatAppointment::className(), ['encounter_id' => 'encounter_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatient() {
        return $this->hasOne(PatPatient::className(), ['patient_id' => 'patient_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function find() {
        return new PatEncounterQuery(get_called_class());
    }

    /**
     * @return ActiveQuery
     */
    public function getPatAdmissions() {
        return $this->hasMany(PatAdmission::className(), ['encounter_id' => 'encounter_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatLiveAdmission() {
        return $this->hasOne(PatAdmission::className(), ['encounter_id' => 'encounter_id'])->andWhere(['admission_status' => 'A'])->orderBy(['status_date' => SORT_DESC]);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatLiveAppointmentBooking() {
        return $this->hasOne(PatAppointment::className(), ['encounter_id' => 'encounter_id'])->andWhere('appt_status = "B"')->orderBy(['created_at' => SORT_DESC]);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatLiveAppointmentArrival() {
        return $this->hasOne(PatAppointment::className(), ['encounter_id' => 'encounter_id'])->andWhere('appt_status = "A"')->orderBy(['created_at' => SORT_DESC]);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatAppointmentSeen() {
        return $this->hasOne(PatAppointment::className(), ['encounter_id' => 'encounter_id'])->andWhere('appt_status = "S"')->orderBy(['pat_appointment.created_at' => SORT_DESC]);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatCurrentAdmission() {
        return $this->hasOne(PatAdmission::className(), ['encounter_id' => 'encounter_id'])->andWhere(['NOT IN', 'admission_status', ['C']])->orderBy(['created_at' => SORT_DESC]);
    }

    /**
     * 
     * @return type
     */
    public function getPatCurrentAdmissionExecptClinicalDischarge() {
        return $this->hasOne(PatAdmission::className(), ['encounter_id' => 'encounter_id'])->andWhere(['NOT IN', 'admission_status', ['C', 'CD']])->orderBy(['created_at' => SORT_DESC]);
    }

    /**
     * 
     * @return type
     */
    public function getPatLastRoomAdmission() {
        return $this->hasMany(PatAdmission::className(), ['encounter_id' => 'encounter_id'])->andWhere(['NOT IN', 'admission_status', ['C']])->orderBy(['created_at' => SORT_DESC]);
    }

    /**
     * 
     * @return type
     */
    public function getPatAdmissionDischarge() {
        return $this->hasOne(PatAdmission::className(), ['encounter_id' => 'encounter_id'])->andWhere(['IN', 'admission_status', ['D', 'CD']])->orderBy(['created_at' => SORT_DESC]);
    }

    public function getPatAdmissionCancel() {
        return $this->hasOne(PatAdmission::className(), ['encounter_id' => 'encounter_id'])->andWhere(['IN', 'admission_status', ['AC']])->orderBy(['created_at' => SORT_DESC]);
    }

    public function getPatPrescriptions() {
        return $this->hasMany(PatPrescription::className(), ['encounter_id' => 'encounter_id'])->orderBy(['created_at' => SORT_DESC]);
    }

    /**
     * 
     * @return type
     */
    public function fields() {
        $extend = [
            'patient' => function ($model) {
                return (isset($model->patient) ? $model->patient : '-');
            },
            'doe' => function ($model) {
                if (isset($model->encounter_date))
                    return date('d-M-Y', strtotime($model->encounter_date));
            },
            'doeTimeago' => function ($model) {
                if (isset($model->encounter_date))
                    return self::timeAgo(strtotime($model->encounter_date));
            },
            'liveAdmission' => function ($model) {
                return (isset($model->patLiveAdmission) ? $model->patLiveAdmission : '-');
            },
            'currentAdmission' => function ($model) {
                return (isset($model->patCurrentAdmission) ? $model->patCurrentAdmission : '-');
            },
            'liveAppointmentBooking' => function ($model) {
                return (isset($model->patLiveAppointmentBooking) ? $model->patLiveAppointmentBooking : '-');
            },
            'liveAppointmentArrival' => function ($model) {
                return (isset($model->patLiveAppointmentArrival) ? $model->patLiveAppointmentArrival : '-');
            },
            'appointmentSeen' => function ($model) {
                return (isset($model->patAppointmentSeen) ? $model->patAppointmentSeen : '-');
            },
            'appointmentSeen_amt_inwords' => function ($model) {
                return (isset($model->patAppointmentSeen) ? Yii::$app->hepler->convert_number_to_words((int) ($model->patAppointmentSeen->amount)) . ' Rupees Only' : '-');
            },
            'room_name' => function ($model) {
                return (isset($model->patCurrentAdmission->room->bed_name) ? $model->patCurrentAdmission->room->bed_name : '-');
            },
            'liveAppointmentConsultant' => function ($model) {
                return (isset($model->patLiveAppointmentBooking->consultant) ? $model->patLiveAppointmentBooking->consultant : '-');
            },
            'room_type_name' => function ($model) {
                return (isset($model->patCurrentAdmission->roomType->room_type_name) ? $model->patCurrentAdmission->roomType->room_type_name : '-');
            },
            'floor_name' => function ($model) {
                return (isset($model->patCurrentAdmission->floor->floor_name) ? $model->patCurrentAdmission->floor->floor_name : '-');
            },
            'sts_date' => function ($model) {
                return $this->sts_date;
            },
            'sts_time' => function ($model) {
                return $this->sts_time;
            },
            'sts_status' => function ($model) {
                return !$this->sts_status;
            },
            'discharge_date' => function ($model) {
                if (!empty($model->patAdmissionDischarge))
                    return $model->patAdmissionDischarge->status_date;
            },
            'stay_duration' => function ($model) {
                if (!empty($model->patAdmissionDischarge))
                    $end_date = $model->patAdmissionDischarge->status_date;
                else
                    $end_date = date('Y-m-d');

                $date1 = new DateTime(date('Y-m-d', strtotime($model->encounter_date)));
                $date2 = new DateTime($end_date);

                return $date2->diff($date1)->format("%a") + 1;
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    public static function getEncounterListByPatient($tenant = null, $status = '1', $deleted = false, $patient_id = null) {
        if (!$deleted)
            $list = self::find()->tenant($tenant)->status($status)->active()->andWhere(['patient_id' => $patient_id])->orderBy(['encounter_id' => SORT_DESC])->all();
        else
            $list = self::find()->tenant($tenant)->deleted()->andWhere(['patient_id' => $patient_id])->orderBy(['encounter_id' => SORT_DESC])->all();

        return $list;
    }

    public function beforeSave($insert) {
        if ($insert) {
            if (isset($this->patient->patActiveCasesheetno) && !empty($this->patient->patActiveCasesheetno)) {
                $this->casesheet_no = $this->patient->patActiveCasesheetno->casesheet_no;
            } else if (isset($this->add_casesheet_no) && !empty($this->add_casesheet_no)) {
                $model = new PatPatientCasesheet();

                $model->attributes = [
                    'casesheet_no' => $this->add_casesheet_no,
                    'patient_id' => $this->patient_id,
                    'start_date' => date("Y-m-d"),
                ];
                $model->save(false);
                $this->casesheet_no = $model->casesheet_no;
            }
        } else {
            if ($this->encounter_type == 'IP' && $this->finalize != 0 && $this->bill_no == NULL)
                $this->bill_no = CoInternalCode::generateInternalCode('B', 'common\models\PatEncounter', 'bill_no');
        }

//        if($this->encounter_type == 'IP')
//            $this->status = $this->discharge == 0 ? '1' : '0';

        return parent::beforeSave($insert);
    }

    public function afterSave($insert, $changedAttributes) {
        if ($insert) {
            if ($this->encounter_type == 'IP')
                CoInternalCode::increaseInternalCode("B");
        }

        if ($this->discharge != 0) {
            $model = new PatAdmission;
            $model->attributes = [
                'encounter_id' => $this->encounter_id,
                'patient_id' => $this->patient_id,
                'status_date' => date('Y-m-d H:i:s'),
                'admission_status' => 'D',
            ];
            $model->save(false);
        }

        return parent::afterSave($insert, $changedAttributes);
    }

}
