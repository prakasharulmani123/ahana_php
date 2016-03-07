<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "pha_purchase".
 *
 * @property integer $purchase_id
 * @property integer $tenant_id
 * @property string $purchase_code
 * @property string $invoice_date
 * @property string $invoice_no
 * @property string $payment_type
 * @property integer $supplier_id
 * @property string $total_item_purchase_amount
 * @property string $total_item_vat_amount
 * @property string $total_item_discount_amount
 * @property string $total_item_amount
 * @property string $discount_percent
 * @property string $discount_amount
 * @property string $roundoff_amount
 * @property string $net_amuont
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PhaSupplier $supplier
 * @property CoTenant $tenant
 * @property PhaPurchaseItem[] $phaPurchaseItems
 */
class PhaPurchase extends \common\models\RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pha_purchase';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'purchase_code', 'invoice_date', 'invoice_no', 'supplier_id', 'created_by'], 'required'],
            [['tenant_id', 'supplier_id', 'created_by', 'modified_by'], 'integer'],
            [['invoice_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['payment_type', 'status'], 'string'],
            [['total_item_purchase_amount', 'total_item_vat_amount', 'total_item_discount_amount', 'total_item_amount', 'discount_percent', 'discount_amount', 'roundoff_amount', 'net_amuont'], 'number'],
            [['purchase_code', 'invoice_no'], 'string', 'max' => 50]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'purchase_id' => 'Purchase ID',
            'tenant_id' => 'Tenant ID',
            'purchase_code' => 'Purchase Code',
            'invoice_date' => 'Invoice Date',
            'invoice_no' => 'Invoice No',
            'payment_type' => 'Payment Type',
            'supplier_id' => 'Supplier ID',
            'total_item_purchase_amount' => 'Total Item Purchase Amount',
            'total_item_vat_amount' => 'Total Item Vat Amount',
            'total_item_discount_amount' => 'Total Item Discount Amount',
            'total_item_amount' => 'Total Item Amount',
            'discount_percent' => 'Discount Percent',
            'discount_amount' => 'Discount Amount',
            'roundoff_amount' => 'Roundoff Amount',
            'net_amuont' => 'Net Amuont',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getSupplier()
    {
        return $this->hasOne(PhaSupplier::className(), ['supplier_id' => 'supplier_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPhaPurchaseItems()
    {
        return $this->hasMany(PhaPurchaseItem::className(), ['purchase_id' => 'purchase_id']);
    }
}
