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
            [['status'], 'string']
        ];
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

}
