<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "pha_product".
 *
 * @property integer $product_id
 * @property integer $tenant_id
 * @property string $product_code
 * @property string $product_name
 * @property string $product_unit
 * @property string $product_unit_count
 * @property integer $product_description_id
 * @property integer $product_reorder
 * @property string $product_price
 * @property string $product_location
 * @property integer $brand_id
 * @property integer $division_id
 * @property integer $generic_id
 * @property integer $drug_class_id
 * @property integer $purchase_vat_id
 * @property integer $purchase_package_id
 * @property integer $sales_vat_id
 * @property integer $sales_package_id
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PhaBrand $brand
 * @property PhaProductDescription $productDescription
 * @property PhaBrandDivision $division
 * @property PhaGeneric $generic
 * @property PhaPackageUnit $purchasePackage
 * @property PhaVat $purchaseVat
 * @property PhaPackageUnit $salesPackage
 * @property PhaVat $salesVat
 * @property CoTenant $tenant
 * @property PhaProductBatch[] $phaProductBatches
 * @property PhaPurchaseItem[] $phaPurchaseItems
 */
class PhaProduct extends \common\models\RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pha_product';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'product_code', 'product_name', 'product_unit', 'product_unit_count', 'product_description_id', 'product_reorder', 'product_price', 'brand_id', 'division_id', 'generic_id', 'purchase_vat_id', 'purchase_package_id', 'sales_vat_id', 'sales_package_id', 'created_by'], 'required'],
            [['tenant_id', 'product_description_id', 'product_reorder', 'brand_id', 'division_id', 'generic_id', 'drug_class_id', 'purchase_vat_id', 'purchase_package_id', 'sales_vat_id', 'sales_package_id', 'created_by', 'modified_by'], 'integer'],
            [['product_price'], 'number'],
            [['status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['product_code'], 'string', 'max' => 50],
            [['product_name', 'product_location'], 'string', 'max' => 255],
            [['product_unit', 'product_unit_count'], 'string', 'max' => 25],
            [['tenant_id', 'product_name'], 'unique', 'targetAttribute' => ['tenant_id', 'product_name'], 'message' => 'The combination of Tenant ID and Product Name has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'product_id' => 'Product ID',
            'tenant_id' => 'Tenant ID',
            'product_code' => 'Product Code',
            'product_name' => 'Product Name',
            'product_unit' => 'Product Unit',
            'product_unit_count' => 'Product Unit Count',
            'product_description_id' => 'Product Description ID',
            'product_reorder' => 'Product Reorder',
            'product_price' => 'Product Price',
            'product_location' => 'Product Location',
            'brand_id' => 'Brand ID',
            'division_id' => 'Division ID',
            'generic_id' => 'Generic ID',
            'drug_class_id' => 'Drug Class ID',
            'purchase_vat_id' => 'Purchase Vat ID',
            'purchase_package_id' => 'Purchase Package ID',
            'sales_vat_id' => 'Sales Vat ID',
            'sales_package_id' => 'Sales Package ID',
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
    public function getBrand()
    {
        return $this->hasOne(PhaBrand::className(), ['brand_id' => 'brand_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getProductDescription()
    {
        return $this->hasOne(PhaProductDescription::className(), ['description_id' => 'product_description_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDivision()
    {
        return $this->hasOne(PhaBrandDivision::className(), ['division_id' => 'division_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getGeneric()
    {
        return $this->hasOne(PhaGeneric::className(), ['generic_id' => 'generic_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPurchasePackage()
    {
        return $this->hasOne(PhaPackageUnit::className(), ['package_id' => 'purchase_package_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPurchaseVat()
    {
        return $this->hasOne(PhaVat::className(), ['vat_id' => 'purchase_vat_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getSalesPackage()
    {
        return $this->hasOne(PhaPackageUnit::className(), ['package_id' => 'sales_package_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getSalesVat()
    {
        return $this->hasOne(PhaVat::className(), ['vat_id' => 'sales_vat_id']);
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
    public function getPhaProductBatches()
    {
        return $this->hasMany(PhaProductBatch::className(), ['product_id' => 'product_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPhaPurchaseItems()
    {
        return $this->hasMany(PhaPurchaseItem::className(), ['product_id' => 'product_id']);
    }
}
