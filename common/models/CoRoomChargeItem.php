<?php

namespace common\models;

use yii\db\ActiveQuery;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "co_room_charge_item".
 *
 * @property integer $charge_item_id
 * @property integer $tenant_id
 * @property string $charge_item_name
 * @property string $charge_item_code
 * @property string $charge_item_description
 * @property integer $charge_cat_id
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoTenant $tenant
 * @property CoRoomChargeCategory $chargeCat
 */
class CoRoomChargeItem extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_room_charge_item';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'charge_item_name', 'charge_item_code', 'charge_cat_id', 'created_by'], 'required'],
            [['tenant_id', 'charge_cat_id', 'created_by', 'modified_by'], 'integer'],
            [['charge_item_description', 'status'], 'string'],
            [['created_at', 'modified_at'], 'safe'],
            [['charge_item_name'], 'string', 'max' => 50],
            [['charge_item_code'], 'string', 'max' => 10],
            [['charge_item_name', 'tenant_id', 'charge_cat_id'], 'unique', 'targetAttribute' => ['charge_item_name', 'tenant_id', 'charge_cat_id'], 'message' => 'The combination of Tenant ID, Charge Item Name and Charge Cat ID has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'charge_item_id' => 'Charge Item ID',
            'tenant_id' => 'Tenant ID',
            'charge_item_name' => 'Charge Item Name',
            'charge_item_code' => 'Charge Item Code',
            'charge_item_description' => 'Charge Item Description',
            'charge_cat_id' => 'Charge Cat ID',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
        ];
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
    public function getChargeCat()
    {
        return $this->hasOne(CoRoomChargeCategory::className(), ['charge_cat_id' => 'charge_cat_id']);
    }
}
