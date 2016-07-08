<?php

namespace common\models;

use common\models\query\PhaProductBatchQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pha_product_batch".
 *
 * @property integer $batch_id
 * @property integer $tenant_id
 * @property integer $product_id
 * @property string $batch_no
 * @property string $expiry_date
 * @property integer $total_qty
 * @property integer $available_qty
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PhaProduct $product
 * @property CoTenant $tenant
 * @property PhaProductBatchRate[] $phaProductBatchRates
 */
class PhaProductBatch extends RActiveRecord {
    
    public $product_name;
    public $product_code;
    public $mrp;

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pha_product_batch';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['tenant_id', 'product_id', 'batch_no', 'expiry_date', 'total_qty', 'available_qty', 'created_by'], 'required'],
            [['tenant_id', 'product_id', 'total_qty', 'available_qty', 'created_by', 'modified_by'], 'integer'],
            [['expiry_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['status'], 'string'],
            [['batch_no'], 'string', 'max' => 255],
            [['batch_no'], 'unique', 'targetAttribute' => ['tenant_id', 'product_id', 'batch_no', 'expiry_date', 'deleted_at'], 'message' => 'The combination of Batch NO. & Expiry Date has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'batch_id' => 'Batch ID',
            'tenant_id' => 'Tenant ID',
            'product_id' => 'Product ID',
            'batch_no' => 'Batch No',
            'expiry_date' => 'Expiry Date',
            'total_qty' => 'Total Qty',
            'available_qty' => 'Available Qty',
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
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPhaProductBatchRate() {
        return $this->hasOne(PhaProductBatchRate::className(), ['batch_id' => 'batch_id']);
    }

    public function getPhaProductBatchRates() {
        return $this->hasMany(PhaProductBatchRate::className(), ['batch_id' => 'batch_id'])->orderBy(['created_at' => SORT_DESC]);
    }

    public static function find() {
        return new PhaProductBatchQuery(get_called_class());
    }

    public function fields() {
        $extend = [
            'batch_details' => function ($model) {
                return $model->batch_no . ' (' . date('M Y', strtotime($model->expiry_date)) . ')'. ' / '.$model->available_qty;
            },
            'mrp' => function ($model) {
                return isset($model->phaProductBatchRate) ? $model->phaProductBatchRate->mrp : 0;
            },
            'product' => function ($model) {
                return isset($model->product) ? $model->product : '';
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    public function beforeSave($insert) {
        $this->expiry_date = date('Y-m', strtotime($this->expiry_date)).'-01';
        return parent::beforeSave($insert);
    }
}
