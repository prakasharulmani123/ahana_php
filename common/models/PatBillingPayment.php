<?php

namespace common\models;

use common\models\query\PatBillingPaymentQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_billing_payment".
 *
 * @property integer $payment_id
 * @property integer $tenant_id
 * @property integer $encounter_id
 * @property integer $patient_id
 * @property string $payment_date
 * @property string $payment_amount
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatEncounter $encounter
 * @property CoTenant $tenant
 */
class PatBillingPayment extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_billing_payment';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['payment_date', 'payment_amount'], 'required'],
            [['tenant_id', 'encounter_id', 'patient_id', 'created_by', 'modified_by'], 'integer'],
            [['payment_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['payment_amount'], 'number'],
            [['status'], 'string']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'payment_id' => 'Payment ID',
            'tenant_id' => 'Tenant ID',
            'encounter_id' => 'Encounter ID',
            'patient_id' => 'Patient ID',
            'payment_date' => 'Date of Payment',
            'payment_amount' => 'Amount Paid',
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
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }
    
    public static function find() {
        return new PatBillingPaymentQuery(get_called_class());
    }

}
