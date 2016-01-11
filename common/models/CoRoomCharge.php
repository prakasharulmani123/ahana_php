<?php

namespace common\models;

use common\models\query\CoRoomChargeQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "co_room_charge".
 *
 * @property integer $charge_id
 * @property integer $tenant_id
 * @property integer $charge_item_id
 * @property integer $room_type_id
 * @property string $charge
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoRoomType $roomType
 * @property CoTenant $tenant
 */
class CoRoomCharge extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_room_charge';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['charge_item_id', 'room_type_id', 'charge'], 'required'],
            [['tenant_id', 'charge_item_id', 'room_type_id', 'created_by', 'modified_by'], 'integer'],
            [['charge'], 'number'],
            [['status'], 'string'],
            [['created_at', 'modified_at'], 'safe'],
            [['tenant_id', 'charge_item_id', 'room_type_id', 'deleted_at'], 'unique', 'targetAttribute' => ['tenant_id', 'charge_item_id', 'room_type_id', 'deleted_at'], 'message' => 'The combination of has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'charge_id' => 'Charge ID',
            'tenant_id' => 'Tenant ID',
            'charge_item_id' => 'Charge Item',
            'room_type_id' => 'Room Type',
            'charge' => 'Charge',
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
    public function getRoomType() {
        return $this->hasOne(CoRoomType::className(), ['room_type_id' => 'room_type_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getRoomChargeItem() {
        return $this->hasOne(CoRoomChargeItem::className(), ['charge_item_id' => 'charge_item_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function find() {
        return new CoRoomChargeQuery(get_called_class());
    }

    public function fields() {
        $extend = [
            'charge_item' => function ($model) {
                return (isset($model->roomChargeItem) ? $model->roomChargeItem->charge_item_name : '-');
            },
            'room_type' => function ($model) {
                return (isset($model->roomType) ? $model->roomType->room_type_name : '-');
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }
}
