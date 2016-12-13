<?php

namespace common\models;

use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "pat_global_patient".
 *
 * @property integer $global_patient_id
 * @property string $patient_global_guid
 * @property string $parent_id
 * @property integer $migration_created_by
 * @property integer $casesheetno
 * @property string $patient_global_int_code
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
 * @property string $patient_email
 * @property string $patient_reg_mode
 * @property string $patient_type
 * @property string $patient_ref_hospital
 * @property string $patient_ref_doctor
 * @property string $patient_ref_id
 * @property string $patient_mobile
 * @property string $patient_secondary_contact
 * @property string $patient_bill_type
 * @property resource $patient_image
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 */
class PatGlobalPatient extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_global_patient';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['patient_global_guid', 'patient_global_int_code', 'patient_title_code', 'patient_firstname', 'patient_gender', 'created_by'], 'required'],
            [['migration_created_by', 'casesheetno', 'patient_care_taker', 'created_by', 'modified_by'], 'integer'],
            [['patient_reg_date', 'patient_dob', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['patient_image', 'status'], 'string'],
            [['patient_global_guid', 'parent_id', 'patient_firstname', 'patient_lastname', 'patient_relation_name', 'patient_care_taker_name', 'patient_occupation', 'patient_email', 'patient_ref_id', 'patient_mobile', 'patient_secondary_contact'], 'string', 'max' => 50],
            [['patient_global_int_code'], 'string', 'max' => 30],
            [['patient_title_code'], 'string', 'max' => 10],
            [['patient_relation_code', 'patient_gender', 'patient_marital_status', 'patient_reg_mode', 'patient_type', 'patient_bill_type'], 'string', 'max' => 2],
            [['patient_blood_group'], 'string', 'max' => 5],
            [['patient_ref_hospital', 'patient_ref_doctor'], 'string', 'max' => 255],
            [['patient_global_guid', 'deleted_at'], 'unique', 'targetAttribute' => ['patient_global_guid', 'deleted_at'], 'message' => 'The combination of Patient Global Guid and Deleted At has already been taken.'],
            [['patient_global_int_code', 'deleted_at'], 'unique', 'targetAttribute' => ['patient_global_int_code', 'deleted_at'], 'message' => 'The combination of Patient Global Int Code and Deleted At has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'global_patient_id' => 'Global Patient ID',
            'patient_global_guid' => 'Patient Global Guid',
            'parent_id' => 'Parent ID',
            'casesheetno' => 'Casesheetno',
            'patient_global_int_code' => 'Patient Global Int Code',
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
            'patient_email' => 'Patient Email',
            'patient_reg_mode' => 'Patient Reg Mode',
            'patient_type' => 'Patient Type',
            'patient_ref_hospital' => 'Patient Ref Hospital',
            'patient_ref_doctor' => 'Patient Ref Doctor',
            'patient_ref_id' => 'Patient Ref ID',
            'patient_mobile' => 'Patient Mobile',
            'patient_secondary_contact' => 'Patient Secondary Contact',
            'patient_bill_type' => 'Patient Bill Type',
            'patient_image' => 'Patient Image',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
        ];
    }
    
    public function getPatPatient() {
        return $this->hasMany(PatPatient::className(), ['patient_global_guid' => 'patient_global_guid']);
    }
    
    public function getPatPatientChildrens() {
        return $this->hasMany(self::className(), ['parent_id' => 'patient_global_guid']);
    }
    
    public function getPatPatientChildrensCount() {
        return $this->getPatPatientChildrens()->count();
    }
    
    public function getPatPatientChildrensGlobalIds() {
        return ArrayHelper::map($this->getPatPatientChildrens()->all(), 'patient_global_guid', 'patient_global_int_code');
    }

}
