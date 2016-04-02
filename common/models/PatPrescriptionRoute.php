<?php

namespace common\models;

use common\models\query\PatPrescriptionRouteQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_prescription_route".
 *
 * @property integer $route_id
 * @property integer $tenant_id
 * @property string $route_name
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatPrescriptionItems[] $patPrescriptionItems
 * @property CoTenant $tenant
 */
class PatPrescriptionRoute extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pat_prescription_route';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'route_name', 'created_by'], 'required'],
            [['tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['route_name'], 'string', 'max' => 50]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'route_id' => 'Route ID',
            'tenant_id' => 'Tenant ID',
            'route_name' => 'Route Name',
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
    public function getPatPrescriptionItems()
    {
        return $this->hasMany(PatPrescriptionItems::className(), ['route_id' => 'route_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }
    
    public static function find() {
        return new PatPrescriptionRouteQuery(get_called_class());
    }
    
    public static function getRoutelist($tenant = null, $status = '1', $deleted = false) {
        if (!$deleted)
            $list = self::find()->tenant($tenant)->status($status)->active()->all();
        else
            $list = self::find()->tenant($tenant)->deleted()->all();

        return $list;
    }
}
