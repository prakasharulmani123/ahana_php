<?php

namespace common\models;

use common\models\query\PhaSaleReturnQuery;
use Yii;
use yii\db\ActiveQuery;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "pha_sale_return".
 *
 * @property integer $sale_ret_id
 * @property integer $tenant_id
 * @property string $bill_no
 * @property integer $patient_id
 * @property integer $sale_id
 * @property string $patient_name
 * @property string $mobile_no
 * @property string $sale_date
 * @property string $total_item_vat_amount
 * @property string $total_item_sale_amount
 * @property string $total_item_discount_percent
 * @property string $total_item_discount_amount
 * @property string $total_item_amount
 * @property string $roundoff_amount
 * @property string $bill_amount
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 * @property PatPatient $patient
 * @property PhaSale $sale
 * @property PhaSaleReturnItem[] $phaSaleReturnItems
 */
class PhaSaleReturn extends RActiveRecord {

    public $noitem = false;

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pha_sale_return';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
                [['sale_date'], 'required'],
                [['tenant_id', 'patient_id', 'created_by', 'modified_by'], 'integer'],
                [['sale_date', 'created_at', 'modified_at', 'deleted_at', 'sale_id', 'patient_name', 'total_item_vat_amount'], 'safe'],
                [['total_item_sale_amount', 'total_item_discount_percent', 'total_item_discount_amount', 'total_item_amount', 'roundoff_amount', 'bill_amount', 'total_item_vat_amount'], 'number'],
                [['status'], 'string'],
                [['bill_no', 'mobile_no'], 'string', 'max' => 50],
                [['noitem'], 'validateNoitem'],
        ];
    }

    public function validateNoitem($attribute, $params) {
        if ($this->noitem)
            $this->addError($attribute, "Select atleast one item to return");
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'sale_ret_id' => 'Sale Ret ID',
            'tenant_id' => 'Tenant ID',
            'bill_no' => 'Bill No',
            'patient_id' => 'Patient ID',
            'mobile_no' => 'Mobile No',
            'sale_date' => 'Sale Date',
            'total_item_vat_amount' => 'Total Item VAT Amount',
            'total_item_sale_amount' => 'Total Item Sale Amount',
            'total_item_discount_percent' => 'Total Item Discount Percent',
            'total_item_discount_amount' => 'Total Item Discount Amount',
            'total_item_amount' => 'Total Item Amount',
            'roundoff_amount' => 'Roundoff Amount',
            'bill_amount' => 'Bill Amount',
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
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatient() {
        return $this->hasOne(PatPatient::className(), ['patient_id' => 'patient_id']);
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
    public function getPhaSaleReturnItems() {
        return $this->hasMany(PhaSaleReturnItem::className(), ['sale_ret_id' => 'sale_ret_id']);
    }

    public function beforeSave($insert) {
        if ($insert) {
            $this->bill_no = CoInternalCode::generateInternalCode('SR', 'common\models\PhaSaleReturn', 'bill_no');
        }

        return parent::beforeSave($insert);
    }

    public function afterSave($insert, $changedAttributes) {
        if ($insert) {
            CoInternalCode::increaseInternalCode("B");
        }

        return parent::afterSave($insert, $changedAttributes);
    }

    public static function find() {
        return new PhaSaleReturnQuery(get_called_class());
    }

    public function fields() {
        $extend = [
            'patient' => function ($model) {
                return (isset($model->patient) ? $model->patient : '-');
            },
            'patient_uhid' => function ($model) {
                return (isset($model->patient) ? $model->patient->patient_global_int_code : '-');
            },
            'patient_name' => function ($model) {
                return (isset($model->patient) ? ucwords("{$model->patient->patient_title_code} {$model->patient->patient_firstname}") : '-');
            },
            'items' => function ($model) {
                return (isset($model->phaSaleReturnItems) ? $model->phaSaleReturnItems : '-');
            },
            'sale_date' => function ($model) {
                return (isset($model->sale) ? $model->sale->sale_date : '-');
            },
            'sale_bill_no' => function ($model) {
                return (isset($model->sale) ? $model->sale->bill_no : '-');
            },
        ];
        $parent_fields = parent::fields();
        $addt_keys = [];
        if ($addtField = Yii::$app->request->get('addtfields')) {
            switch ($addtField):
                case 'sale_return_list':
                    $addt_keys = ['patient', 'items','sale_bill_no'];
                    $parent_fields = [
                        'sale_ret_id' => 'sale_ret_id',
                        'sale_id' => 'sale_id',
                        'bill_no' => 'bill_no',
                        'sale_date' => 'sale_date',
                        'created_at' => 'created_at',
                        'total_item_sale_amount' => 'total_item_sale_amount',
                        'total_item_discount_amount' => 'total_item_discount_amount',
                        'roundoff_amount' => 'roundoff_amount',
                        'bill_amount' => 'bill_amount',
                    ];
                    break;
                case 'salereturnreport':
                    $addt_keys = ['patient_name', 'patient_uhid'];
                    $parent_fields = [
                        'bill_no' => 'bill_no',
                        'bill_amount' => 'bill_amount',
                        'sale_date' => 'sale_date',
                    ];
                    break;
            endswitch;
        }
        $extFields = ($addt_keys) ? array_intersect_key($extend, array_flip($addt_keys)) : $extend;
        return array_merge($parent_fields, $extFields);
    }

    public function getSaleReturnItemIds() {
        return ArrayHelper::map($this->phaSaleReturnItems, 'sale_ret_item_id', 'sale_ret_item_id');
    }

}
