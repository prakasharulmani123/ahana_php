<?php

namespace common\models;

use common\models\query\PhaSaleBillingQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pha_sale_billing".
 *
 * @property integer $sale_billing_id
 * @property integer $sale_id
 * @property integer $tenant_id
 * @property string $paid_date
 * @property string $paid_amount
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PhaSale $sale
 * @property CoTenant $tenant
 */
class PhaSaleBilling extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pha_sale_billing';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['paid_date', 'paid_amount'], 'required'],
            [['sale_id', 'tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['paid_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['paid_amount'], 'number'],
            [['status'], 'string'],
            ['paid_amount', 'validateBillAmount'],
        ];
    }

    public function validateBillAmount($attribute, $params) {
        if ($this->paid_amount > $this->sale->bill_amount) {
            $this->addError($attribute, "Amount ({$this->paid_amount}) must be lesser than or equal to Bill Amount ({$this->sale->bill_amount})");
        }
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'sale_billing_id' => 'Sale Billing ID',
            'sale_id' => 'Sale ID',
            'tenant_id' => 'Tenant ID',
            'paid_date' => 'Paid Date',
            'paid_amount' => 'Paid Amount',
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
    public function getSale() {
        return $this->hasOne(PhaSale::className(), ['sale_id' => 'sale_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function find() {
        return new PhaSaleBillingQuery(get_called_class());
    }

    public function afterSave($insert, $changedAttributes) {
        $sale_bill_amount = $this->sale->bill_amount;
        $sale_billings_total = $this->find()->where(['sale_id' => $this->sale_id])->sum('paid_amount');

        $sale_model = $this->sale;
        if ($sale_bill_amount == $sale_billings_total) {
            $sale_model->payment_status = 'C';
        } elseif ($sale_billings_total > 0) {
            $sale_model->payment_status = 'PC';
        }
        $sale_model->after_save = false;
        $sale_model->save(false);

        return parent::afterSave($insert, $changedAttributes);
    }

}
