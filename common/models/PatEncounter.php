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
 * @property string $casesheetno
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatAppoinment[] $patAppoinments
 * @property PatPatient $patient
 * @property CoTenant $tenant
 */
class PatEncounter extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pat_encounter';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['patient_id', 'encounter_type'], 'required'],
            [['tenant_id', 'patient_id', 'finalize', 'authorize', 'created_by', 'modified_by'], 'integer'],
            [['encounter_date', 'inactive_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['status'], 'string'],
            [['encounter_type'], 'string', 'max' => 5],
            [['casesheetno'], 'string', 'max' => 200]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'encounter_id' => 'Encounter ID',
            'tenant_id' => 'Tenant ID',
            'patient_id' => 'Patient ID',
            'encounter_type' => 'Encounter Type',
            'encounter_date' => 'Encounter Date',
            'inactive_date' => 'Inactive Date',
            'finalize' => 'Finalize',
            'authorize' => 'Authorize',
            'casesheetno' => 'Casesheetno',
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
    public function getPatAppoinments()
    {
        return $this->hasMany(PatAppoinment::className(), ['encounter_id' => 'encounter_id']);
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
    
    public static function find() {
        return new PatEncounterQuery(get_called_class());
    }
}
