<?php

namespace common\models;

use common\models\query\PatPatientCasesheetQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_patient_casesheet".
 *
 * @property integer $casesheet_id
 * @property integer $tenant_id
 * @property integer $patient_id
 * @property string $casesheet_no
 * @property string $start_date
 * @property string $end_date
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatPatient $patient
 * @property CoTenant $tenant
 */
class PatPatientCasesheet extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_patient_casesheet';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['casesheet_no'], 'required'],
            [['tenant_id', 'patient_id', 'created_by', 'modified_by'], 'integer'],
            [['start_date', 'end_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['status'], 'string'],
            [['casesheet_no'], 'string', 'max' => 50],
            [['casesheet_no'], 'unique', 'targetAttribute' => ['tenant_id', 'patient_id', 'casesheet_no'], 'message' => 'The combination of Casesheet No has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'casesheet_id' => 'Casesheet ID',
            'tenant_id' => 'Tenant ID',
            'patient_id' => 'Patient ID',
            'casesheet_no' => 'Casesheet No',
            'start_date' => 'Start Date',
            'end_date' => 'End Date',
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
        return new PatPatientCasesheetQuery(get_called_class());
    }

    public function afterSave($insert, $changedAttributes) {
        if($insert){
            PatTimeline::insertTimeLine($this->patient_id, $this->created_at, 'Casesheet No.', '', "Casesheet No.: {$this->casesheet_no} Added.");
        }
        return parent::afterSave($insert, $changedAttributes);
    }
}
