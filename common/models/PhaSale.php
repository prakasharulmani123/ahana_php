<?php

namespace common\models;

use common\models\query\PhaSaleQuery;
use Yii;
use yii\db\ActiveQuery;
use yii\db\Expression;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "pha_sale".
 *
 * @property integer $sale_id
 * @property integer $tenant_id
 * @property integer $bill_no
 * @property integer $patient_id
 * @property string $mobile_no
 * @property integer $consultant_id
 * @property string $sale_date
 * @property string $payment_type
 * @property string $total_item_vat_amount
 * @property string $total_item_sale_amount
 * @property string $total_item_discount_percent
 * @property string $total_item_discount_amount
 * @property string $total_item_amount
 * @property string $welfare_amount
 * @property string $roundoff_amount
 * @property string $bill_amount
 * @property string $amount_received
 * @property string $balance
 * @property string $payment_status
 * @property string $status
 * @property string $patient_name
 * @property integer $patient_group_id
 * @property string $patient_group_name
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatConsultant $patConsult
 * @property PatPatient $patient
 * @property CoTenant $tenant
 * @property PhaSaleBilling[] $phaSaleBillings
 * @property PhaSaleItem[] $phaSaleItems
 */
class PhaSale extends RActiveRecord {

    public $after_save = true;

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pha_sale';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['sale_date'], 'required'],
            [['tenant_id', 'patient_id', 'consultant_id', 'created_by', 'modified_by'], 'integer'],
            [['sale_date', 'created_at', 'modified_at', 'deleted_at', 'encounter_id', 'patient_name', 'patient_group_id', 'patient_group_name'], 'safe'],
            [['payment_type', 'payment_status', 'status'], 'string'],
            [['total_item_vat_amount', 'total_item_sale_amount', 'total_item_discount_percent', 'total_item_discount_amount', 'total_item_amount', 'welfare_amount', 'roundoff_amount', 'bill_amount', 'amount_received', 'balance'], 'number'],
            [['mobile_no'], 'string', 'max' => 50],
            [['amount_received'], 'compare', 'compareAttribute' => 'bill_amount', 'operator' => '>=', 'type' => 'number', 'when' => function($model) {
            if ($model->payment_type == 'CA')
                return true;
        }],
            [['balance'], 'compare', 'compareValue' => 0, 'operator' => '>=', 'type' => 'number', 'when' => function($model) {
            if ($model->payment_type == 'CA')
                return true;
        }],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'sale_id' => 'Sale ID',
            'tenant_id' => 'Tenant ID',
            'bill_no' => 'Bill No',
            'patient_id' => 'Patient',
            'mobile_no' => 'Mobile No',
            'consultant_id' => 'Consultant',
            'sale_date' => 'Sale Date',
            'payment_type' => 'Payment Type',
            'total_item_vat_amount' => 'Total Item Vat Amount',
            'total_item_sale_amount' => 'Total Item Sale Amount',
            'total_item_discount_percent' => 'Total Item Discount Percent',
            'total_item_discount_amount' => 'Total Item Discount Amount',
            'total_item_amount' => 'Total Item Amount',
            'welfare_amount' => 'Welfare Amount',
            'roundoff_amount' => 'Roundoff Amount',
            'bill_amount' => 'Bill Amount',
            'payment_status' => 'Payment Status',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
        ];
    }

    public function beforeSave($insert) {
        if ($insert) {
            $this->bill_no = CoInternalCode::generateInternalCode('SA', 'common\models\PhaSale', 'bill_no');

            //Payment Type - Credit, COD - Then payment status is pending.
            if ($this->payment_type != 'CA') {
                $this->payment_status = 'P';
            }
        }

        //Patient Grouping
        if ($this->patient_group_id && $this->patient_id) {
            $patient = PatPatient::findOne(['patient_id' => $this->patient_id]);
            PatGlobalPatient::syncPatientGroup($patient->patGlobalPatient->global_patient_id, [$this->patient_group_id]);
        }

        return parent::beforeSave($insert);
    }

    public function afterSave($insert, $changedAttributes) {
        if ($insert) {
            CoInternalCode::increaseInternalCode("B");
        }

        if ($this->after_save) {
            //Sale Billing - Payment Type - CASH
            if ($this->payment_type == 'CA') {
                if ($insert) {
                    $sale_billing_model = new PhaSaleBilling();
                } else {
                    $sale_billing_model = PhaSaleBilling::find()->where(['sale_id' => $this->sale_id])->one();
                    if (empty($sale_billing_model))
                        $sale_billing_model = new PhaSaleBilling();
                }

                $sale_billing_model->sale_id = $this->sale_id;
                $sale_billing_model->paid_date = $this->sale_date;
                $sale_billing_model->paid_amount = $this->bill_amount;
                $sale_billing_model->save(false);
            }
        }

        return parent::afterSave($insert, $changedAttributes);
    }

    /**
     * @return ActiveQuery
     */
    public function getConsultant() {
        return $this->hasOne(CoUser::className(), ['user_id' => 'consultant_id']);
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
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPhaSaleBillings() {
        return $this->hasMany(PhaSaleBilling::className(), ['sale_id' => 'sale_id']);
    }

    public function getPhaSaleBillingsTotalPaidAmount() {
        return $this->hasMany(PhaSaleBilling::className(), ['sale_id' => 'sale_id'])->sum('paid_amount');
    }

    /**
     * @return ActiveQuery
     */
    public function getPhaSaleItems() {
        return $this->hasMany(PhaSaleItem::className(), ['sale_id' => 'sale_id']);
    }

    public static function find() {
        return new PhaSaleQuery(get_called_class());
    }

    public function fields() {
        $extend = [
            'bill_no_with_patient' => function ($model) {
                $bill_no = (isset($model->bill_no) ? $model->bill_no : '-');
                $bill_no .= (isset($model->patient_id) ? ' (' . $model->patient->patGlobalPatient->patient_global_int_code . ')' : '');
                return $bill_no;
            },
            'patient' => function ($model) {
                return (isset($model->patient) ? $model->patient : '-');
            },
            'items' => function ($model) {
                return (isset($model->phaSaleItems) ? $model->phaSaleItems : '-');
            },
            'billings_total_paid_amount' => function ($model) {
                return (isset($model->phaSaleBillingsTotalPaidAmount) ? $model->phaSaleBillingsTotalPaidAmount : '0');
            },
            'billings_total_balance_amount' => function ($model) {
                $paid_amount = 0;
                if (isset($model->phaSaleBillingsTotalPaidAmount)) {
                    $paid_amount = $model->phaSaleBillingsTotalPaidAmount;
                }

                $balance = $model->bill_amount - $paid_amount;
                return number_format($balance, '2');
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    public function getSaleItemIds() {
        return ArrayHelper::map($this->phaSaleItems, 'sale_item_id', 'sale_item_id');
    }

}
