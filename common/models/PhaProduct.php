<?php

namespace common\models;

use common\models\query\PhaProductQuery;
use Yii;
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
 * @property integer $product_reorder_min
 * @property integer $product_reorder_max
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
    public $supplier_ids = false;

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
            [['product_name', 'product_description_id', 'product_reorder_min', 'product_reorder_max', 'brand_id', 'purchase_vat_id', 'sales_vat_id'], 'required'],
            [['tenant_id', 'product_description_id', 'product_reorder_min', 'product_reorder_max', 'brand_id', 'division_id', 'generic_id', 'drug_class_id', 'purchase_vat_id', 'purchase_package_id', 'sales_vat_id', 'sales_package_id', 'created_by', 'modified_by'], 'integer'],
            [['product_price'], 'number'],
            [['status'], 'string'],
            [['product_reorder_max'], 'validateReorderchck'],
            //[['supplier_ids'], 'validateSupplieronetime'],
            [['supplier_id_1', 'supplier_id_2', 'supplier_id_3'], 'validateSupplieronetime'],
            [['created_at', 'modified_at', 'deleted_at', 'supplier_id_1', 'supplier_id_2', 'supplier_id_3', 'supplier_ids'], 'safe'],
            [['product_code'], 'string', 'max' => 50],
            [['product_name', 'product_location'], 'string', 'max' => 255],
            [['product_unit', 'product_unit_count'], 'string', 'max' => 25],
            [['tenant_id', 'product_name', 'brand_id'], 'unique', 'targetAttribute' => ['tenant_id', 'product_name', 'brand_id'], 'message' => 'The combination of Tenant ID and Product Name and Brand Name has already been taken.']
        ];
    }

    public function validateReorderchck($attribute, $params) {
        if ($this->product_reorder_max < $this->product_reorder_min) {
            $this->addError($attribute, "Re-Order Level (Min) value is lower than Re-Order Level (Max) value.");
        }
    }

    public function validateSupplieronetime($attribute, $params) {
        $count = 0;
        $str_arr = [];

        for ($i = 1; $i <= 3; $i++) {
            $col = "supplier_id_$i";
            if (isset($this->$col) && $this->$col != "") {
                $str_arr[] = $this->$col;
                $count++;
            }
        }

        if (count(array_unique($str_arr)) != $count) {
            $this->addError('supplier_id_1', "Please choose different suppliers.");
            $this->supplier_ids = true;
        }
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
            'product_reorder_min' => 'Product Reorder Min',
            'product_reorder_max' => 'Product Reorder Max',
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
            'supplier_id_1' => 'Supplier 1',
            'supplier_id_2' => 'Supplier 2',
            'supplier_id_3' => 'Supplier 3',
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

    public function getPhaLatestBatch() {
        return $this->hasOne(PhaProductBatch::className(), ['product_id' => 'product_id'])->andWhere('available_qty > 0')->orderBy(['expiry_date' => SORT_ASC]);
    }

    public function getPhaProductBatchesAvailableQty() {
        return $this->hasMany(PhaProductBatch::className(), ['product_id' => 'product_id'])->sum('available_qty');
    }

    /**
     * @return ActiveQuery
     */
    public function getPhaPurchaseItems() {
        return $this->hasMany(PhaPurchaseItem::className(), ['product_id' => 'product_id']);
    }

    public function getFullName() {
        $fullname = '';

        if ($this->product_name)
            $fullname .= $this->product_name;
        if ($this->product_unit_count)
            $fullname .= ' | ' . $this->product_unit_count;
        if ($this->product_unit)
            $fullname .= ' | ' . $this->product_unit;

        return $fullname;
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
                $fullname = $model->fullname;
                if(Yii::$app->request->get('full_name_with_stock')){
                    $avl = (isset($model->phaProductBatchesAvailableQty) ? $model->phaProductBatchesAvailableQty : 0);
                    $fullname .= " ({$avl})";
                }
                return $fullname;
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
            'brand_code' => function ($model) {
                return (isset($model->brand) ? $model->brand->brand_code : '-');
            },
            'division_name' => function ($model) {
                return (isset($model->division) ? $model->division->division_name : '-');
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
            'availableQuantity' => function ($model) {
                return (isset($model->phaProductBatchesAvailableQty) ? $model->phaProductBatchesAvailableQty : 0);
            },
            'description_routes' => function ($model) {
                return (isset($model->productDescription) ? $model->productDescription->routes : '-');
            },
            'latest_price' => function ($model) {
                return (isset($model->phaLatestBatch) ? $model->phaLatestBatch->phaProductBatchRate->per_unit_price : 0);
            },
            'product_batches' => function ($model) {
                return $model->getPhaProductBatches()->andWhere('available_qty > 0')->all();
            },
            'product_batches_count' => function ($model) {
                return $model->getPhaProductBatches()->andWhere('available_qty > 0')->count();
            },
        ];

        $parent_fields = parent::fields();
        $addt_keys = $extFields = [];
        if ($addtField = Yii::$app->request->get('addtfields')) {
            switch ($addtField):
                case 'pharm_sale_alternateprod':
                    $addt_keys = ['full_name', 'product_batches_count'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                    ];
                    break;
                 case 'sale_update':
                    $addt_keys = ['full_name'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                    ];
                    break;
                 case 'sale_print':
                    $addt_keys = ['full_name', 'brand_name', 'brand_code'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                    ];
                    break;
                case 'purchase_update':
                    $addt_keys = ['full_name'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                    ];
                    break;
                case 'viewlist':
                    $addt_keys = ['full_name'];
                    $pFields = ['product_id'];
                    $parent_fields = array_combine($pFields, $pFields);
                    break;
                case 'reorderhistory':
                    $addt_keys = ['full_name'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                    ];
                    break;
                case 'purchase_print':
                    $addt_keys = ['full_name'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                    ];
                    break;
                case 'prescregister':
                    $addt_keys = ['full_name', 'brand_name', 'brand_code'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                    ];
                    break;
                case 'sale_return':
                    $addt_keys = ['full_name'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                    ];
                    break;
                case 'sale_return_list':
                    $addt_keys = ['full_name'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                    ];
                    break;
                case 'prev_presc':
                    $addt_keys = ['full_name', 'description_routes', 'latest_price', 'availableQuantity'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                        'product_description_id' => 'product_description_id',
                    ];
                    break;
                case 'presc_search':
                    $addt_keys = ['full_name', 'description_routes', 'latest_price', 'availableQuantity'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                        'generic_id' => 'generic_id',
                        'product_description_id' => 'product_description_id',
                    ];
                    break;
                case 'stock_details':
                    $addt_keys = ['full_name','salesPackageName','purchasePackageName','saleVatPercent','description_name'];
                    $parent_fields = [
                        'product_id' => 'product_id',
                        'product_code' => 'product_code',
                        'product_price' => 'product_price',
                    ];
                    break;
            endswitch;
        }

        if ($addt_keys !== false)
            $extFields = ($addt_keys) ? array_intersect_key($extend, array_flip($addt_keys)) : $extend;

        return array_merge($parent_fields, $extFields);
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
