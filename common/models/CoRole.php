<?php

namespace common\models;

use cornernote\linkall\LinkAllBehavior;
use yii\db\ActiveRecord;
/**
 * This is the model class for table "co_role".
 *
 * @property integer $role_id
 * @property integer $tenant_id
 * @property string $description
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoTenant $tenant
 */
class CoRole extends ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_role';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['description'], 'required'],
            [['tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['status'], 'string'],
            [['created_at', 'modified_at'], 'safe'],
            [['description'], 'string', 'max' => 50]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'role_id' => 'Role ID',
            'tenant_id' => 'Tenant ID',
            'description' => 'Role',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }
    
    public function behaviors() { 
        return [
            LinkAllBehavior::className(),
        ];
    }

    public function getRolesResources() {
        return $this->hasMany(CoRolesResources::className(), ['role_id' => 'role_id']);
    }

    public function getResources() {
        return $this->hasMany(CoResources::className(), ['resource_id' => 'resource_id'])->via('rolesResources');
    }
}
