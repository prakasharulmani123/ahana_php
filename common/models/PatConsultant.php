<?php

namespace common\models;

use common\models\query\PatConsultantQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_consultant".
 *
 * @property integer $pat_consult_id
 * @property integer $tenant_id
 * @property integer $encounter_id
 * @property integer $patient_id
 * @property integer $consultant_id
 * @property string $consult_date
 * @property string $notes
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
 * @property CoUser $consultant
 */
class PatConsultant extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pat_consultant';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['encounter_id', 'patient_id', 'consultant_id'], 'required'],
            [['tenant_id', 'encounter_id', 'patient_id', 'consultant_id', 'created_by', 'modified_by'], 'integer'],
            [['consult_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['notes', 'status'], 'string']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'pat_consult_id' => 'Pat Consult ID',
            'tenant_id' => 'Tenant ID',
            'encounter_id' => 'Encounter ID',
            'patient_id' => 'Patient ID',
            'consultant_id' => 'Consultant ID',
            'consult_date' => 'Consult Date',
            'notes' => 'Notes',
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

    /**
     * @return ActiveQuery
     */
    public function getConsultant()
    {
        return $this->hasOne(CoUser::className(), ['user_id' => 'consultant_id']);
    }
    
    public static function find() {
        return new PatConsultantQuery(get_called_class());
    }

    public function fields() {
        $extend = [
            'consultant_name' => function ($model) {
                return (isset($model->consultant->name)) ? $model->consultant->name : '-';
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }
}
