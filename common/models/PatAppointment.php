<?php

namespace common\models;

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
class PatAppointment extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pat_appointment';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['status_date', 'status_time', 'consultant_id', 'appt_status'], 'required'],
            [['tenant_id', 'patient_id', 'encounter_id', 'consultant_id', 'created_by', 'modified_by'], 'integer'],
            [['status_date', 'status_time', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['status'], 'string'],
            [['appt_status'], 'string', 'max' => 1]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'appt_id' => 'Appt',
            'tenant_id' => 'Tenant',
            'patient_id' => 'Patient',
            'encounter_id' => 'Encounter',
            'status_date' => 'Appointment Date',
            'status_time' => 'Appointment Time',
            'consultant_id' => 'Consultant',
            'appt_status' => 'Appt Status',
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
    public function getConsultant()
    {
        return $this->hasOne(CoUser::className(), ['user_id' => 'consultant_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getEncounter()
    {
        return $this->hasOne(PatEncounter::className(), ['encounter_id' => 'encounter_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatient()
    {
        return $this->hasOne(PatPatient::className(), ['patient_id' => 'patient_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }
    
    public function beforeSave($insert) {
        if(!empty($this->status_time))
            $this->status_time = date('H:i:s', strtotime ($this->status_time));
        
        if ($insert) {
            $this->setCurrentData();
        }
        
        return parent::beforeSave($insert);
    }
    
    public function setCurrentData() {
        if ($this->admission_status == 'TD' || $this->admission_status == 'D') {
            $this->floor_id = $this->encounter->patCurrentAdmission->floor_id;
            $this->ward_id = $this->encounter->patCurrentAdmission->ward_id;
            $this->room_id = $this->encounter->patCurrentAdmission->room_id;
            $this->room_type_id = $this->encounter->patCurrentAdmission->room_type_id;

            if ($this->admission_status == 'D') {
                $this->consultant_id = $this->encounter->patCurrentAdmission->consultant_id;
            }
        } else if ($this->admission_status == 'TR') {
            $this->consultant_id = $this->encounter->patCurrentAdmission->consultant_id;
        }
    }
}
