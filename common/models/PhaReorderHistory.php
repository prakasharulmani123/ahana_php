<?php

namespace common\models;

use yii\db\ActiveQuery;

/**
 * This is the model class for table "pha_reorder_history".
 *
 * @property integer $reorder_id
 * @property integer $tenant_id
 * @property integer $supplier_id
 * @property integer $user_id
 * @property string $reorder_date
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoUser $user
 * @property PhaSupplier $supplier
 * @property CoTenant $tenant
 * @property PhaReorderHistoryItem[] $phaReorderHistoryItems
 */
class PhaReorderHistory extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pha_reorder_history';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'supplier_id', 'user_id', 'created_by'], 'required'],
            [['tenant_id', 'supplier_id', 'user_id', 'created_by', 'modified_by'], 'integer'],
            [['reorder_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['status'], 'string']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'reorder_id' => 'Reorder ID',
            'tenant_id' => 'Tenant ID',
            'supplier_id' => 'Supplier ID',
            'user_id' => 'User ID',
            'reorder_date' => 'Reorder Date',
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
    public function getUser()
    {
        return $this->hasOne(CoUser::className(), ['user_id' => 'user_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getSupplier()
    {
        return $this->hasOne(PhaSupplier::className(), ['supplier_id' => 'supplier_id']);
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
    public function getPhaReorderHistoryItems()
    {
        return $this->hasMany(PhaReorderHistoryItem::className(), ['reorder_id' => 'reorder_id']);
    }
}
