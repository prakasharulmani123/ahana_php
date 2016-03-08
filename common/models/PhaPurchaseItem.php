<?php

namespace common\models;

use common\models\query\PhaPurchaseItemQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pha_purchase_item".
 *
 * @property integer $purchase_item_id
 * @property integer $tenant_id
 * @property integer $purchase_id
 * @property integer $product_id
 * @property integer $batch_id
 * @property integer $quantity
 * @property integer $free_quantity
 * @property string $mrp
 * @property string $purchase_rate
 * @property string $purchase_amount
 * @property string $discount_percent
 * @property string $discount_amount
 * @property string $total_amount
 * @property string $package_name
 * @property string $vat_amount
 * @property string $vat_percent
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PhaProduct $product
 * @property PhaPurchase $purchase
 * @property CoTenant $tenant
 */
class PhaPurchaseItem extends RActiveRecord {

    public $expiry_date;

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pha_purchase_item';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['product_id', 'quantity', 'mrp', 'purchase_rate', 'purchase_amount', 'package_name', 'vat_amount'], 'required'],
            [['tenant_id', 'purchase_id', 'product_id', 'quantity', 'free_quantity', 'created_by', 'modified_by'], 'integer'],
            [['mrp', 'purchase_rate', 'purchase_amount', 'discount_percent', 'discount_amount', 'total_amount', 'vat_amount', 'vat_percent'], 'number'],
            [['status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at', 'vat_percent', 'batch_id', 'expiry_date'], 'safe'],
            [['package_name'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'purchase_item_id' => 'Purchase Item ID',
            'tenant_id' => 'Tenant ID',
            'purchase_id' => 'Purchase ID',
            'product_id' => 'Product ID',
            'quantity' => 'Quantity',
            'free_quantity' => 'Free Quantity',
            'mrp' => 'Mrp',
            'purchase_rate' => 'Purchase Rate',
            'purchase_amount' => 'Purchase Amount',
            'discount_percent' => 'Discount Percent',
            'discount_amount' => 'Discount Amount',
            'total_amount' => 'Total Amount',
            'package_name' => 'Package Name',
            'vat_amount' => 'Vat Amount',
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
    public function getProduct() {
        return $this->hasOne(PhaProduct::className(), ['product_id' => 'product_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPurchase() {
        return $this->hasOne(PhaPurchase::className(), ['purchase_id' => 'purchase_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function find() {
        return new PhaPurchaseItemQuery(get_called_class());
    }

    public function beforeSave($insert) {
        $batch = $this->updateBatch();
        $batch_rate = $this->updateBatchRate($batch->batch_id);
        
        $this->batch_id = $batch->batch_id;
        return parent::beforeSave($insert);
    }

    private function updateBatch() {
        $batch_exists = PhaProductBatch::find()->tenant()->andWhere(['product_id' => $this->product_id, 'batch_no' => $this->batch_id])->one();
        if (empty($batch_exists)) {
            $batch = new PhaProductBatch;
            $batch->total_qty = $batch->available_qty = $this->quantity;
        } else {
            $batch = $batch_exists;
        }
        $batch->attributes = [
            'product_id' => $this->product_id,
            'batch_no' => $this->batch_id,
            'expiry_date' => $this->expiry_date,
        ];
        $batch->save(false);
        return $batch;
    }

    private function updateBatchRate($batch_id) {
        $batch_rate_exists = PhaProductBatchRate::find()->tenant()->andWhere(['batch_id' => $batch_id])->one();
        if (empty($batch_rate_exists)) {
            $batch_rate = new PhaProductBatchRate();
            $batch_rate->mrp = $this->mrp;
        } else {
            $batch_rate = $batch_rate_exists;
        }
        $batch_rate->batch_id = $batch_id;
        $batch_rate->save(false);
        return $batch_rate;
    }

}
