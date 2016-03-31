<?php

namespace common\models;

use common\models\query\PhaProductQuery;
use yii\db\ActiveQuery;

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
class PhaProduct extends RActiveRecord {
    
    public $full_name;

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pha_product';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['product_name', 'product_unit', 'product_unit_count', 'product_description_id', 'product_reorder', 'brand_id', 'division_id', 'generic_id', 'purchase_vat_id', 'purchase_package_id', 'sales_vat_id', 'sales_package_id'], 'required'],
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
    public function attributeLabels() {
        return [
            'product_id' => 'Product ID',
            'tenant_id' => 'Tenant ID',
            'product_code' => 'Product Code',
            'product_name' => 'Product Name',
            'product_unit' => 'Product Unit',
            'product_unit_count' => 'Product Unit Count',
            'product_description_id' => 'Product Description',
            'product_reorder' => 'Product Reorder',
            'product_price' => 'Product Price',
            'product_location' => 'Product Location',
            'brand_id' => 'Brand Name',
            'division_id' => 'Division Name',
            'generic_id' => 'Generic Name',
            'drug_class_id' => 'Drug Class',
            'purchase_vat_id' => 'Purchase Vat',
            'purchase_package_id' => 'Purchase Package Unit',
            'sales_vat_id' => 'Sales Vat',
            'sales_package_id' => 'Sales Package Unit',
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
    public function getBrand() {
        return $this->hasOne(PhaBrand::className(), ['brand_id' => 'brand_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getProductDescription() {
        return $this->hasOne(PhaProductDescription::className(), ['description_id' => 'product_description_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getDivision() {
        return $this->hasOne(PhaBrandDivision::className(), ['division_id' => 'division_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getGeneric() {
        return $this->hasOne(PhaGeneric::className(), ['generic_id' => 'generic_id']);
    }
    /**
     * @return ActiveQuery
     */
    public function getDrugClass() {
        return $this->hasOne(PhaDrugClass::className(), ['drug_class_id' => 'drug_class_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPurchasePackage() {
        return $this->hasOne(PhaPackageUnit::className(), ['package_id' => 'purchase_package_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPurchaseVat() {
        return $this->hasOne(PhaVat::className(), ['vat_id' => 'purchase_vat_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getSalesPackage() {
        return $this->hasOne(PhaPackageUnit::className(), ['package_id' => 'sales_package_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getSalesVat() {
        return $this->hasOne(PhaVat::className(), ['vat_id' => 'sales_vat_id']);
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
    public function getPhaProductBatches() {
        return $this->hasMany(PhaProductBatch::className(), ['product_id' => 'product_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPhaPurchaseItems() {
        return $this->hasMany(PhaPurchaseItem::className(), ['product_id' => 'product_id']);
    }
    
    public function getFullName() {
        return $this->product_name.' | '.$this->product_unit_count. ' | '.$this->product_unit;
    }

    public static function find() {
        return new PhaProductQuery(get_called_class());
    }

    public static function getProductlist($tenant = null, $status = '1', $deleted = false) {
        if (!$deleted) {
            $list = self::find()->tenant($tenant)->status($status)->active()->all();
        } else {
            $list = self::find()->tenant($tenant)->deleted()->all();
        }

        return $list;
    }

    public function fields() {
        $extend = [
            'full_name' => function ($model) {
                return $model->product_name.' | '.$model->product_unit_count. ' | '.$model->product_unit;
            },
            'purchaseVat' => function ($model) {
                return (isset($model->purchaseVat) ? $model->purchaseVat : '-');
            },
            'salesVat' => function ($model) {
                return (isset($model->salesVat) ? $model->salesVat : '-');
            },
            'description_name' => function ($model) {
                return (isset($model->productDescription) ? $model->productDescription->description_name : '-');
            },
            'brand_name' => function ($model) {
                return (isset($model->brand) ? $model->brand->brand_name : '-');
            },
            'division_name' => function ($model) {
                return (isset($model->brand) ? $model->division->division_name : '-');
            },
            'generic_name' => function ($model) {
                return (isset($model->generic) ? $model->generic->generic_name : '-');
            },
            'drug_name' => function ($model) {
                return (isset($model->drugClass) ? $model->drugClass->drug_name : '-');
            },
            'saleVatPercent' => function ($model) {
                return (isset($model->salesVat) ? $model->salesVat->vat : '-');
            },
            'purchaseVatPercent' => function ($model) {
                return (isset($model->purchaseVat) ? $model->purchaseVat->vat : '-');
            },
            'purchasePackageName' => function ($model) {
                return (isset($model->purchasePackage) ? $model->purchasePackage->package_name : '-');
            },
            'salesPackageName' => function ($model) {
                return (isset($model->salesPackage) ? $model->salesPackage->package_name : '-');
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    public function beforeSave($insert) {
        if ($insert) {
            $this->product_code = self::getProductCode();
        }
        return parent::beforeSave($insert);
    }

    public static function getProductCode($length = 6) {
        $new_guid = strtoupper(self::getRandomString($length));
        do {
            $exist_count = self::find()->where(['product_code' => $new_guid])->count();
            if ($exist_count > 0) {
                $old_guid = $new_guid;
                $new_guid = self::getRandomString($length);
            } else {
                break;
            }
        } while ($old_guid != $new_guid);
        return $new_guid;
    }

    public static function getRandomString($length = 6) {
        $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"; //length:36
        $final_rand = '';
        for ($i = 0; $i < $length; $i++) {
            $final_rand .= $chars[rand(0, strlen($chars) - 1)];
        }
        return $final_rand;
    }

}
