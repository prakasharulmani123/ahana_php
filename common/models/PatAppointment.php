<?php

namespace common\models;

use common\models\query\PatAppointmentQuery;
use DateTime;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_appointment".
 *
 * @property integer $appt_id
 * @property integer $tenant_id
 * @property integer $patient_id
 * @property integer $encounter_id
 * @property string $status_date
 * @property string $status_time
 * @property integer $consultant_id
 * @property string $appt_status
 * @property string $status
 * @property string $amount
 * @property string $notes
 * @property integer $patient_cat_id
 * @property string $patient_bill_type
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoUser $consultant
 * @property PatEncounter $encounter
 * @property PatPatient $patient
 * @property CoTenant $tenant
 */
class PatAppointment extends RActiveRecord {

    public $consultant_perday_appt_count;

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_appointment';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['status_date', 'status_time', 'consultant_id', 'appt_status', 'patient_id'], 'required'],
            [['patient_cat_id', 'amount'], 'required', 'on' => 'seen_status'],
            [['tenant_id', 'patient_id', 'encounter_id', 'consultant_id', 'created_by', 'modified_by'], 'integer'],
            [['status_date', 'status_time', 'amount', 'notes', 'patient_cat_id', 'created_at', 'modified_at', 'deleted_at', 'patient_bill_type'], 'safe'],
            [['status', 'patient_bill_type'], 'string'],
            [['appt_status'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'appt_id' => 'Appt',
            'tenant_id' => 'Tenant',
            'patient_id' => 'Patient',
            'encounter_id' => 'Encounter',
            'status_date' => 'Status Date',
            'status_time' => 'Status Time',
            'consultant_id' => 'Consultant',
            'appt_status' => 'Appt Status',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
            'patient_cat_id' => 'Charge category',
            'amount' => 'Amount',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getConsultant() {
        return $this->hasOne(CoUser::className(), ['user_id' => 'consultant_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getEncounter() {
        return $this->hasOne(PatEncounter::className(), ['encounter_id' => 'encounter_id']);
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

    public function beforeValidate() {
        $this->setCurrentData();
        return parent::beforeValidate();
    }

    public function beforeSave($insert) {
        if (!empty($this->status_time))
            $this->status_time = date('H:i:s', strtotime($this->status_time));

        if (!empty($this->status_date))
            $this->status_date = date('Y-m-d', strtotime($this->status_date));

        if ($insert) {
            $this->setCurrentData();
        }

        return parent::beforeSave($insert);
    }

    public function afterSave($insert, $changedAttributes) {
        if ($insert) {
            //Close Encounter
            if ($this->appt_status == 'S' || $this->appt_status == 'C') {
                $this->encounter->status = '0';
                $this->encounter->save(false);
            }
        }

        $this->_insertTimeline();
        return parent::afterSave($insert, $changedAttributes);
    }

    private function _insertTimeline() {
        $header_sub = "Encounter # {$this->encounter_id}";
        $consultant = "<br />Consultant : <b>{$this->consultant->title_code} {$this->consultant->name}</b>";

        switch ($this->appt_status) {
            case 'B':
                $header = "Appoinment Booked";
                $message = "Appoinment Booked. $consultant";
                break;
            case 'A':
                $header = "Patient Arrived";
                $message = "Patient Arrived. $consultant";
                break;
            case 'S':
                $header = "Doctor Seen";
                $message = "Seen by Consultant. $consultant";
                break;
            case 'C':
                $header = "Appointment Cancel";
                $message = "Appointment Cancelled. $consultant";
                break;
        }
        PatTimeline::insertTimeLine($this->patient_id, $this->status_date . ' ' . $this->status_time, $header, $header_sub, $message);
    }

    public function setCurrentData() {
        if (isset($this) && isset($this->encounter) && isset($this->encounter->patLiveAppointmentBooking))
            $this->consultant_id = $this->encounter->patLiveAppointmentBooking->consultant_id;
    }

    public function fields() {
        $extend = [
            'status_datetime' => function ($model) {
                return $model->status_date . ' ' . $model->status_time;
            },
            'waiting_elapsed' => function ($model) {
                $date = date('Y-m-d', strtotime($model->status_date)) . ' ' . date('H:i:s', strtotime($model->status_time));
                $start_date = new DateTime($date);
                $since_start = $start_date->diff(new DateTime(date('Y-m-d H:i:s')));

                $default_elapsed_time = 1;
                $get_elapsed_time = AppConfiguration::getConfigurationByKey('ELAPSED_TIME');
                if (isset($get_elapsed_time))
                    $default_elapsed_time = $get_elapsed_time->value;

                return ($since_start->h >= $default_elapsed_time);
            },
            'consultant_name' => function ($model) {
                if (isset($model->consultant))
                    return $model->consultant->title_code . $model->consultant->name;
                else
                    return '-';
            },
            'consultant_perday_appt_count' => function ($model) {
                return isset($model->consultant_perday_appt_count) ? $model->consultant_perday_appt_count : '-';
            },
            'patient_name' => function ($model) {
                if (isset($model->patient))
                    return $model->patient->patient_title_code . $model->patient->patient_firstname;
                else
                    return '-';
            },
            'patient_mobile' => function ($model) {
                if (isset($model->patient))
                    return $model->patient->patient_mobile;
                else
                    return '-';
            },
            'patient_guid' => function ($model) {
                if (isset($model->patient))
                    return $model->patient->patient_guid;
                else
                    return '-';
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    public static function find() {
        return new PatAppointmentQuery(get_called_class());
    }

    public static function checkAvailableSlot($consultant_id, $schedule_date, $schedule_time) {
        $is_available = self::find()->joinWith('encounter')->where(['status_date' => $schedule_date, 'status_time' => $schedule_time, 'consultant_id' => $consultant_id, 'appt_status' => 'B', 'pat_encounter.status' => '1'])->count();
        return ($is_available == 0 ? true : false);
    }

    public static function getFutureAppointments() {
        $future_appointments = self::find()
                ->joinWith('encounter')
                ->where(['>', 'status_date', date("Y-m-d")])
                ->andWhere(['appt_status' => 'B', 'pat_encounter.status' => '1'])
                ->addSelect(["*", 'COUNT(*) AS consultant_perday_appt_count'])
                ->groupBy(['consultant_id', 'status_date'])
                ->all();
        return $future_appointments;
    }

}
