<?php

namespace common\models;

use common\models\query\CoRoomQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "co_room".
 *
 * @property integer $room_id
 * @property integer $tenant_id
 * @property integer $ward_id
 * @property string $bed_name
 * @property integer $maintain_id
 * @property string $occupied_status
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoRoomMaintenance $maintain
 * @property CoTenant $tenant
 */
class CoRoom extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_room';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['ward_id', 'bed_name', 'maintain_id'], 'required'],
            [['tenant_id', 'ward_id', 'maintain_id', 'created_by', 'modified_by'], 'integer'],
            [['occupied_status', 'status'], 'string'],
            [['created_at', 'modified_at'], 'safe'],
            [['bed_name'], 'string', 'max' => 50],
            [['tenant_id', 'ward_id', 'bed_name', 'deleted_at'], 'unique', 'targetAttribute' => ['tenant_id', 'ward_id', 'bed_name', 'deleted_at'], 'message' => 'The combination of Tenant ID and Ward Name has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'room_id' => 'Room ID',
            'tenant_id' => 'Tenant ID',
            'ward_id' => 'Ward Name',
            'bed_name' => 'Room Name',
            'maintain_id' => 'Room Maintain Status',
            'occupied_status' => 'Occupied Status',
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
    public function getMaintain() {
        return $this->hasOne(CoRoomMaintenance::className(), ['maintain_id' => 'maintain_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getWard() {
        return $this->hasOne(CoWard::className(), ['ward_id' => 'ward_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function find() {
        return new CoRoomQuery(get_called_class());
    }

    public function fields() {
        $extend = [
            'ward_name' => function ($model) {
                return (isset($model->ward) ? $model->ward->ward_name : '-');
            },
            'maintain_name' => function ($model) {
                return (isset($model->maintain) ? $model->maintain->maintain_name : '-');
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

}
