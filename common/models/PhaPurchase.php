<?php

namespace common\models;

use common\models\query\PhaPurchaseQuery;
use yii\db\ActiveQuery;

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
 * @property string $discount_percent
 * @property string $discount_amount
 * @property string $roundoff_amount
 * @property string $net_amount
 * @property string $before_disc_amount
 * @property string $after_disc_amount
 * @property string $net_amount
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
class PhaPurchase extends RActiveRecord
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
            [['invoice_date', 'invoice_no', 'supplier_id'], 'required'],
            [['tenant_id', 'supplier_id', 'created_by', 'modified_by'], 'integer'],
            [['invoice_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['payment_type', 'status'], 'string'],
            [['total_item_purchase_amount', 'total_item_vat_amount', 'total_item_discount_amount', 'discount_percent', 'discount_amount', 'roundoff_amount', 'net_amount', 'before_disc_amount', 'after_disc_amount'], 'number'],
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
            'supplier_id' => 'Supplier',
            'total_item_purchase_amount' => 'Total Item Purchase Amount',
            'total_item_vat_amount' => 'Total Item Vat Amount',
            'total_item_discount_amount' => 'Total Item Discount Amount',
            'discount_percent' => 'Discount Percent',
            'discount_amount' => 'Discount Amount',
            'roundoff_amount' => 'Roundoff Amount',
            'net_amount' => 'Net Amuont',
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
    public function getSupplier()
    {
        return $this->hasOne(PhaSupplier::className(), ['supplier_id' => 'supplier_id']);
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
    public function getPhaPurchaseItems()
    {
        return $this->hasMany(PhaPurchaseItem::className(), ['purchase_id' => 'purchase_id']);
    }
    
    public static function find() {
        return new PhaPurchaseQuery(get_called_class());
    }
    
    public function beforeSave($insert) {
        if($insert){
            $this->purchase_code = CoInternalCode::find()->tenant()->codeType("PU")->one()->Fullcode;
        }
        return parent::beforeSave($insert);
    }
    
    public function fields() {
        $extend = [
            'supplier' => function ($model) {
                return (isset($model->supplier) ? $model->supplier : '-');
            },
            'items' => function ($model) {
                return (isset($model->phaPurchaseItems) ? $model->phaPurchaseItems : '-');
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }
    
    public function afterSave($insert, $changedAttributes) {
        if ($insert) {
            CoInternalCode::increaseInternalCode("PU");
        }
        return parent::afterSave($insert, $changedAttributes);
    }
}
