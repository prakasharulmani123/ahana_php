<?php

namespace common\models;

use common\models\query\PatEncounterQuery;
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
 * @property integer $finalize
 * @property integer $authorize
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatAppointment[] $patAppointments
 * @property PatPatient $patient
 * @property CoTenant $tenant
 */
class PatEncounter extends RActiveRecord {

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
            [['tenant_id', 'patient_id', 'finalize', 'authorize', 'created_by', 'modified_by'], 'integer'],
            [['encounter_date', 'inactive_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['status'], 'string'],
            [['encounter_type'], 'string', 'max' => 5],
        ];
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
        return $this->hasOne(PatAppointment::className(), ['encounter_id' => 'encounter_id'])->andWhere('appt_status = "B"')->orderBy(['created_at'=>SORT_DESC]);
    }
    
    /**
     * @return ActiveQuery
     */
    public function getPatLiveAppointmentArrival() {
        return $this->hasOne(PatAppointment::className(), ['encounter_id' => 'encounter_id'])->andWhere('appt_status = "A"')->orderBy(['created_at'=>SORT_DESC]);
    }
    
    /**
     * @return ActiveQuery
     */
    public function getPatCurrentAdmission() {
        return $this->hasOne(PatAdmission::className(), ['encounter_id' => 'encounter_id'])->orderBy(['created_at' => SORT_DESC]);
    }
    
    public function fields() {
        $extend = [
            'patient' => function ($model) {
                return (isset($model->patient) ? $model->patient : '-');
            },
            'doe' => function ($model) {
                if (isset($model->encounter_date))
                    return date('Y-m-d', strtotime($model->encounter_date));
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
            'room_name' => function ($model) {
                return (isset($model->patLiveAdmission->room->bed_name) ? $model->patLiveAdmission->room->bed_name : '-');
            },
            'liveAppointmentConsultant' => function ($model) {
                return (isset($model->patLiveAppointmentBooking->consultant) ? $model->patLiveAppointmentBooking->consultant : '-');
            },
            'room_type_name' => function ($model) {
                return (isset($model->patLiveAdmission->roomType->room_type_name) ? $model->patLiveAdmission->roomType->room_type_name : '-');
            },
            'floor_name' => function ($model) {
                return (isset($model->patLiveAdmission->floor->floor_name) ? $model->patLiveAdmission->floor->floor_name : '-');
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
    
}
