<?php

namespace common\models;

use common\models\query\CoRoomMaintenanceQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "co_room_maintenance".
 *
 * @property integer $maintain_id
 * @property integer $tenant_id
 * @property string $maintain_name
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoTenant $tenant
 */
class CoRoomMaintenance extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_room_maintenance';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['tenant_id', 'maintain_name', 'created_by'], 'required'],
            [['tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['status'], 'string'],
            [['created_at', 'modified_at'], 'safe'],
            [['maintain_name'], 'string', 'max' => 50],
            [['tenant_id', 'maintain_name'], 'unique', 'targetAttribute' => ['tenant_id', 'maintain_name'], 'message' => 'The combination of Tenant ID and Maintain Name has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'maintain_id' => 'Maintain ID',
            'tenant_id' => 'Tenant ID',
            'maintain_name' => 'Maintain Name',
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
    
    public static function find() {
        return new CoRoomMaintenanceQuery(get_called_class());
    }

}
