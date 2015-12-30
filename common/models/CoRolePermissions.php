<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "co_roles_resources".
 *
 * @property integer $role_perm_id
 * @property integer $tenant_id
 * @property integer $role_id
 * @property integer $resource_id
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoResources $resource
 * @property CoRole $role
 * @property CoTenant $tenant
 */
class CoRolesResources extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_roles_resources';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'role_id', 'resource_id'], 'required'],
            [['tenant_id', 'role_id', 'resource_id', 'created_by', 'modified_by'], 'integer'],
            [['created_at', 'modified_at'], 'safe']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'role_perm_id' => 'Role Perm ID',
            'tenant_id' => 'Tenant ID',
            'role_id' => 'Role ID',
            'resource_id' => 'Resource ID',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getResource()
    {
        return $this->hasOne(CoResources::className(), ['resource_id' => 'resource_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getRole()
    {
        return $this->hasOne(CoRole::className(), ['role_id' => 'role_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }
}
