<?php

namespace common\models;

use common\models\query\CoChargePerCategoryQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "co_charge_per_category".
 *
 * @property integer $charge_id
 * @property integer $tenant_id
 * @property string $charge_cat_type
 * @property integer $charge_cat_id
 * @property integer $charge_code_id
 * @property string $charge_default
 * @property string $created_at
 * @property integer $created_by
 * @property string $modified_at
 * @property integer $modified_by
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 */
class CoChargePerCategory extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_charge_per_category';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['charge_code_id', 'charge_cat_id'], 'required'],
            [['tenant_id', 'charge_cat_id', 'charge_code_id', 'created_by', 'modified_by'], 'integer'],
            [['charge_cat_type'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['charge_default'], 'string', 'max' => 255],
//            [['charge_cat_id', 'charge_code_id', 'tenant_id'], 'unique', 'message' => 'The combination has already been taken.'],
            [['charge_cat_id'], 'unique', 'targetAttribute' => ['charge_cat_id', 'charge_code_id', 'tenant_id'], 'message' => 'The combination has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'charge_id' => 'Charge ID',
            'tenant_id' => 'Tenant ID',
            'charge_cat_type' => 'Charge Cat Type',
            'charge_cat_id' => 'Category',
            'charge_code_id' => 'Code/Names',
            'charge_default' => 'Default',
            'created_at' => 'Created At',
            'created_by' => 'Created By',
            'modified_at' => 'Modified At',
            'modified_by' => 'Modified By',
            'deleted_at' => 'Deleted At',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function find() {
        return new CoChargePerCategoryQuery(get_called_class());
    }

    /**
     * @return ActiveQuery
     */
    public function getRoomchargecategory() {
        return $this->hasOne(CoRoomChargeCategory::className(), ['charge_cat_id' => 'charge_cat_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getRoomchargesubcategory() {
        return $this->hasOne(CoRoomChargeSubcategory::className(), ['charge_subcat_id' => 'charge_code_id']);
    }

    public function getUser() {
        return $this->hasOne(CoUser::className(), ['user_id' => 'charge_code_id']);
    }

    public function getCoChargePerSubcategories() {
        return $this->hasMany(CoChargePerSubcategory::className(), ['charge_id' => 'charge_id']);
    }
    
    public function getOpCoChargePerSubcategories() {
        return $this->hasMany(CoChargePerSubcategory::className(), ['charge_id' => 'charge_id'])->andWhere(['charge_type' => 'OP']);
    }
    
    public function getIpCoChargePerSubcategories() {
        return $this->hasMany(CoChargePerSubcategory::className(), ['charge_id' => 'charge_id'])->andWhere(['charge_type' => 'IP']);
    }

    public function fields() {
        $extend = [
            'charge_cat_name' => function ($model) {
                if ($model->charge_cat_type == 'C')
                    return (isset($model->roomchargecategory) ? $model->roomchargecategory->charge_cat_name : '-');
                if ($model->charge_cat_type == 'P' && $model->charge_cat_id == -1)
                    return 'Professional Charge';
            },
            'charge_code_name' => function ($model) {
                if ($model->charge_cat_type == 'C')
                    return (isset($model->roomchargesubcategory) ? $model->roomchargesubcategory->charge_subcat_name : '-');
                if ($model->charge_cat_type == 'P' && $model->charge_cat_id == -1)
                    return (isset($model->user) ? $model->user->name : '-');
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    /* charge_code_id - consultant_id (user_id) */

    public static function getConsultantCharges($charge_code_id) {
        if ($charge_code_id) {
            $response = self::find()->tenant()->chargeCatType()->chargeCatId()->andWhere(['charge_code_id' => $charge_code_id])->one();
            if(!empty($response)){
                return $response->opCoChargePerSubcategories;
            }
        }
    }

}
