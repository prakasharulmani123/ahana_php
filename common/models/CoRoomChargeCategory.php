<?php

namespace common\models;

use common\models\query\CoRoomChargeCategoryQuery;
use yii\db\ActiveQuery;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "co_room_charge_category".
 *
 * @property integer $charge_cat_id
 * @property integer $tenant_id
 * @property string $charge_cat_name
 * @property string $charge_cat_code
 * @property string $charge_cat_description
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoTenant $tenant
 * @property CoRoomChargeItem[] $coRoomChargeItems
 */
class CoRoomChargeCategory extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_room_charge_category';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['charge_cat_name', 'charge_cat_description'], 'required'],
            [['tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['charge_cat_description', 'status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['charge_cat_name'], 'string', 'max' => 50],
            [['charge_cat_code'], 'string', 'max' => 10],
            [['tenant_id', 'charge_cat_name'], 'unique', 'targetAttribute' => ['tenant_id', 'charge_cat_name'], 'message' => 'The combination of Tenant ID and Charge Cat Name has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'charge_cat_id' => 'Charge Cat ID',
            'tenant_id' => 'Tenant ID',
            'charge_cat_name' => 'Charge Cat Name',
            'charge_cat_code' => 'Charge Cat Code',
            'charge_cat_description' => 'Charge Cat Description',
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
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getCoRoomChargeItems() {
        return $this->hasMany(CoRoomChargeItem::className(), ['charge_cat_id' => 'charge_cat_id']);
    }

    public static function find() {
        return new CoRoomChargeCategoryQuery(get_called_class());
    }
    
    public static function getRoomChargeCateogrylist($tenant = null, $status = '1', $deleted = false) {
        if(!$deleted)
            $list = self::find()->tenant($tenant)->status($status)->active()->all();
        else
            $list = self::find()->tenant($tenant)->deleted()->all();
        
        return $list;
    }
}
