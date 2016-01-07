<?php

namespace common\models;

use common\models\query\CoUsersRolesQuery;
use yii\db\ActiveQuery;
use yii\db\ActiveRecord;

/**
 * This is the model class for table "co_users_roles".
 *
 * @property integer $user_role_id
 * @property integer $tenant_id
 * @property integer $user_id
 * @property integer $role_id
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoUser $user
 * @property CoRole $role
 * @property CoTenant $tenant
 */
class CoUsersRoles extends ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_users_roles';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
//            [['tenant_id', 'user_id', 'role_id'], 'required'],
            [['tenant_id', 'user_id', 'role_id', 'created_by', 'modified_by'], 'integer'],
            [['created_at', 'modified_at'], 'safe']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'user_role_id' => 'User Role ID',
            'tenant_id' => 'Tenant ID',
            'user_id' => 'User ID',
            'role_id' => 'Role ID',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
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
    public function getRole()
    {
        return $this->hasOne(CoRole::className(), ['role_id' => 'role_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }
    
    public static function find() {
        return new CoUsersRolesQuery(get_called_class());
    }
}
