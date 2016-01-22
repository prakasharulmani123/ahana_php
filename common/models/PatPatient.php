<?php

use common\models\CoTenant;
use common\models\PatPatientAddress;
use common\models\RActiveRecord;
use yii\db\ActiveQuery;

namespace common\models;

/**
 * This is the model class for table "pat_patient".
 *
 * @property integer $patient_id
 * @property integer $tenant_id
 * @property string $patient_reg_date
 * @property string $patient_title_code
 * @property string $patient_firstname
 * @property string $patient_lastname
 * @property string $patient_relation_code
 * @property string $patient_relation_name
 * @property integer $patient_care_taker
 * @property string $patient_care_taker_name
 * @property string $patient_dob
 * @property string $patient_gender
 * @property string $patient_marital_status
 * @property string $patient_occupation
 * @property string $patient_blood_group
 * @property integer $patient_category_id
 * @property string $patient_email
 * @property string $patient_reg_mode
 * @property string $patient_type
 * @property string $patient_ref_hospital
 * @property string $patient_ref_id
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 * @property PatPatientAddress[] $patPatientAddresses
 */
class PatPatient extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pat_patient';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'patient_title_code', 'patient_firstname', 'patient_gender', 'patient_reg_mode', 'patient_ref_id', 'created_by'], 'required'],
            [['tenant_id', 'patient_care_taker', 'patient_category_id', 'created_by', 'modified_by'], 'integer'],
            [['patient_reg_date', 'patient_dob', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['status'], 'string'],
            [['patient_title_code'], 'string', 'max' => 10],
            [['patient_firstname', 'patient_lastname', 'patient_relation_name', 'patient_care_taker_name', 'patient_occupation', 'patient_email', 'patient_ref_id'], 'string', 'max' => 50],
            [['patient_relation_code', 'patient_gender', 'patient_marital_status', 'patient_reg_mode', 'patient_type'], 'string', 'max' => 2],
            [['patient_blood_group'], 'string', 'max' => 5],
            [['patient_ref_hospital'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'patient_id' => 'Patient ID',
            'tenant_id' => 'Tenant ID',
            'patient_reg_date' => 'Patient Reg Date',
            'patient_title_code' => 'Patient Title Code',
            'patient_firstname' => 'Patient Firstname',
            'patient_lastname' => 'Patient Lastname',
            'patient_relation_code' => 'Patient Relation Code',
            'patient_relation_name' => 'Patient Relation Name',
            'patient_care_taker' => 'Patient Care Taker',
            'patient_care_taker_name' => 'Patient Care Taker Name',
            'patient_dob' => 'Patient Dob',
            'patient_gender' => 'Patient Gender',
            'patient_marital_status' => 'Patient Marital Status',
            'patient_occupation' => 'Patient Occupation',
            'patient_blood_group' => 'Patient Blood Group',
            'patient_category_id' => 'Patient Category ID',
            'patient_email' => 'Patient Email',
            'patient_reg_mode' => 'Patient Reg Mode',
            'patient_type' => 'Patient Type',
            'patient_ref_hospital' => 'Patient Ref Hospital',
            'patient_ref_id' => 'Patient Ref ID',
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
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatPatientAddresses()
    {
        return $this->hasMany(PatPatientAddress::className(), ['patient_id' => 'patient_id']);
    }
}
