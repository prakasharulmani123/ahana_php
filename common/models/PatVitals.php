<?php

namespace common\models;

use common\models\query\PatVitalsQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_vitals".
 *
 * @property integer $vital_id
 * @property integer $tenant_id
 * @property integer $encounter_id
 * @property integer $patient_id
 * @property string $vital_time
 * @property string $temperature
 * @property string $blood_pressure
 * @property string $pulse_rate
 * @property string $weight
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatEncounter $encounter
 * @property PatPatient $patient
 * @property CoTenant $tenant
 */
class PatVitals extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_vitals';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
//            [['tenant_id', 'encounter_id', 'patient_id', 'vital_time', 'created_by'], 'required'],
            [['tenant_id', 'encounter_id', 'patient_id', 'created_by', 'modified_by'], 'integer'],
            [['vital_time', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['status'], 'string'],
            [['temperature', 'blood_pressure', 'pulse_rate'], 'string', 'max' => 20],
            [['weight'], 'string', 'max' => 10]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'vital_id' => 'Vital ID',
            'tenant_id' => 'Tenant ID',
            'encounter_id' => 'Encounter ID',
            'patient_id' => 'Patient ID',
            'vital_time' => 'Vital Time',
            'temperature' => 'Temperature',
            'blood_pressure' => 'Blood Pressure',
            'pulse_rate' => 'Pulse Rate',
            'weight' => 'Weight',
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
    
    public static function find() {
        return new PatVitalsQuery(get_called_class());
    }

}
