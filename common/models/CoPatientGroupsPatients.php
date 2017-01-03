<?php

use common\models\CoPatientGroup;
use common\models\PatGlobalPatient;
use common\models\RActiveRecord;
use yii\db\ActiveQuery;

namespace common\models;

/**
 * This is the model class for table "co_patient_groups_patients".
 *
 * @property integer $group_patient_id
 * @property integer $patient_group_id
 * @property integer $global_patient_id
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoPatientGroup $patientGroup
 * @property PatGlobalPatient $globalPatient
 */
class CoPatientGroupsPatients extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_patient_groups_patients';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['patient_group_id', 'global_patient_id', 'created_by'], 'required'],
            [['patient_group_id', 'global_patient_id', 'created_by', 'modified_by'], 'integer'],
            [['status'], 'string'],
            [['created_at', 'modified_at'], 'safe']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'group_patient_id' => 'Group Patient ID',
            'patient_group_id' => 'Patient Group ID',
            'global_patient_id' => 'Global Patient ID',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getPatientGroup()
    {
        return $this->hasOne(CoPatientGroup::className(), ['patient_group_id' => 'patient_group_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getGlobalPatient()
    {
        return $this->hasOne(PatGlobalPatient::className(), ['global_patient_id' => 'global_patient_id']);
    }
}
