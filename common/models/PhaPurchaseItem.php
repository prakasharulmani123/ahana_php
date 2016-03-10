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
 * @property integer $free_quantity_unit
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
    public $batch_no;

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
            [['batch_no'], 'required', 'on' => 'saveform'],
            [['tenant_id', 'purchase_id', 'product_id', 'quantity', 'free_quantity', 'created_by', 'modified_by'], 'integer'],
            [['mrp', 'purchase_rate', 'purchase_amount', 'discount_percent', 'discount_amount', 'total_amount', 'vat_amount', 'vat_percent', 'free_quantity_unit'], 'number'],
            [['status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at', 'vat_percent', 'batch_id', 'expiry_date', 'free_quantity_unit', 'batch_no'], 'safe'],
            [['package_name'], 'string', 'max' => 255],
            ['purchase_rate', 'validateProductRate'],
            [['quantity', 'mrp', 'purchase_rate', 'purchase_amount', 'total_amount'], 'validateAmount'],
        ];
    }

    public function validateProductRate($attribute, $params) {
        if ($this->purchase_rate > $this->mrp)
            $this->addError($attribute, "Product Price ({$this->purchase_rate}) must be lesser than MRP ({$this->mrp}) for {$this->product->fullname}");
    }

    public function validateAmount($attribute, $params) {
        if ($this->$attribute <= 0)
            $this->addError($attribute, "{$this->getAttributeLabel($attribute)} must be greater than 0 for {$this->product->fullname}");
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'purchase_item_id' => 'Purchase Item ID',
            'tenant_id' => 'Tenant ID',
            'purchase_id' => 'Purchase',
            'product_id' => 'Product',
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

    public function getBatch() {
        return $this->hasOne(PhaProductBatch::className(), ['batch_id' => 'batch_id']);
    }

    public static function find() {
        return new PhaPurchaseItemQuery(get_called_class());
    }

    public function fields() {
        $extend = [
            'product' => function ($model) {
                return (isset($model->product) ? $model->product : '-');
            },
            'batch' => function ($model) {
                return (isset($model->batch) ? $model->batch : '-');
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    public function beforeSave($insert) {
        $batch = $insert ? $this->insertBatch() : $this->updateBatch();
        $batch_rate = $this->updateBatchRate($batch->batch_id, $this->mrp);

        $this->batch_id = $batch->batch_id;
        $this->free_quantity = (!empty($this->free_quantity)) ? $this->free_quantity : 0;
        $this->free_quantity_unit = (!empty($this->free_quantity_unit)) ? $this->free_quantity_unit : 0;

        return parent::beforeSave($insert);
    }

    private function getBatchData() {
        return PhaProductBatch::find()->tenant()->andWhere(['product_id' => $this->product_id, 'batch_no' => $this->batch_no, 'expiry_date' => $this->expiry_date])->one();
    }

    //Insert Batch
    private function insertBatch() {
        $batch = $this->getBatchData();
        if (empty($batch)) {
            $batch = new PhaProductBatch;
            $batch->total_qty = $batch->available_qty = $this->quantity;
        } else {
            $batch->total_qty = $batch->total_qty + $this->quantity;
            $batch->available_qty = $batch->available_qty + $this->quantity;
        }
        $batch->attributes = [
            'product_id' => $this->product_id,
            'batch_no' => $this->batch_no,
            'expiry_date' => $this->expiry_date,
        ];
        $batch->save(false);
        return $batch;
    }

    //Update Batch
    private function updateBatch() {
        $batch = $this->getBatchData();
        if (empty($batch)) {
            $batch = new PhaProductBatch;
            $batch->total_qty = $batch->available_qty = $this->quantity;
        } else {
            $old_qty = $this->getOldAttribute('quantity');
            $new_qty = $this->quantity;

            //Add New Quantity
            if ($old_qty < $new_qty) {
                $batch->total_qty = $batch->total_qty + ($new_qty - $old_qty);
                $batch->available_qty = $batch->available_qty + ($new_qty - $old_qty);
            }
            //Subtract New Quantity
            else if ($new_qty < $old_qty) {
                $batch->total_qty = $batch->total_qty - ($old_qty - $new_qty);
                $batch->available_qty = $batch->available_qty - ($old_qty - $new_qty);
            }
        }
        $batch->attributes = [
            'product_id' => $this->product_id,
            'batch_no' => $this->batch_no,
            'expiry_date' => $this->expiry_date,
        ];
        $batch->save(false);
        return $batch;
    }

    //Update Batch
    private function deleteBatch() {
        $batch = PhaProductBatch::find()->tenant()->andWhere(['batch_id' => $this->batch_id])->one();
        if (!empty($batch)) {
            $batch->total_qty = $batch->total_qty - $this->quantity;
            $batch->available_qty = $batch->available_qty - $this->quantity;
            $batch->save(false);
        }
        return;
    }

    //Update Batch Rate
    private function updateBatchRate($batch_id, $mrp) {
        $batch_rate_exists = PhaProductBatchRate::find()->tenant()->andWhere(['batch_id' => $batch_id, 'mrp' => $mrp])->one();
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

    public function afterDelete() {
        $this->deleteBatch($this->batch_id);
        return parent::afterDelete();
    }

}
