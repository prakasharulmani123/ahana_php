<?php

namespace common\models;

use common\models\query\PatBillingExtraConcessionQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_billing_extra_concession".
 *
 * @property integer $ec_id
 * @property integer $tenant_id
 * @property integer $encounter_id
 * @property integer $patient_id
 * @property string $ec_type
 * @property integer $link_id
 * @property string $extra_amount
 * @property string $concession_amount
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
class PatBillingExtraConcession extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_billing_extra_concession';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['encounter_id', 'patient_id', 'ec_type', 'link_id'], 'required'],
            [['tenant_id', 'encounter_id', 'patient_id', 'link_id', 'created_by', 'modified_by'], 'integer'],
            [['ec_type', 'status'], 'string'],
            [['extra_amount', 'concession_amount'], 'number'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['extra_amount', 'concession_amount'], 'validateAmount'],
        ];
    }

    public function validateAmount($attribute, $params) {
        if ($this->extra_amount < 1 && $this->concession_amount < 1) {
            $this->addError($attribute, "Amount can not be empty");
        }
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'ec_id' => 'Ec ID',
            'tenant_id' => 'Tenant ID',
            'encounter_id' => 'Encounter ID',
            'patient_id' => 'Patient ID',
            'ec_type' => 'Ec Type',
            'link_id' => 'Link ID',
            'extra_amount' => 'Extra Amount',
            'concession_amount' => 'Concession Amount',
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
        return new PatBillingExtraConcessionQuery(get_called_class());
    }

}
