<?php

namespace common\models;

use yii\db\ActiveQuery;
use yii\db\ActiveRecord;

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
class CoRolesResources extends ActiveRecord {

    public $resource_ids;
    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_roles_resources';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['tenant_id', 'role_id', 'resource_id'], 'required'],
            [['tenant_id', 'role_id', 'resource_id', 'created_by', 'modified_by'], 'integer'],
            [['created_at', 'modified_at'], 'safe']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
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
     * @return ActiveQuery
     */
    public function getResource() {
        return $this->hasOne(CoResources::className(), ['resource_id' => 'resource_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getRole() {
        return $this->hasOne(CoRole::className(), ['role_id' => 'role_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function getModuletreeByRole($tenant_id, $role_id) {
        $tree = self::getModuleTree();
        $role_resources_ids = CoRolesResources::find()->select(['GROUP_CONCAT(resource_id) AS resource_ids'])->where(['tenant_id' => $tenant_id, 'role_id' => $role_id])->one();
        $role_resources_ids = explode(',', $role_resources_ids->resource_ids);
        
        foreach ($tree as $key => $parent) {
            if(in_array($parent['value'], $role_resources_ids)){
//                $tree[$key]['isSelected'] = true;
                
                foreach ($parent['items'] as $cKey => $child) {
                    if(in_array($child['value'], $role_resources_ids)){
                        $tree[$key]['items'][$cKey]['isSelected'] = true;
                    }else{
                        $tree[$key]['items'][$cKey]['isSelected'] = false;
                    }
                }
            }else{
//                $tree[$key]['isSelected'] = false;
            }
        }
        return $tree;
    }

    public static function getModuleTree() {
        $tree = array();
        $parents = CoResources::find()->where(['parent_id' => null])->orderBy(['resource_name' => 'ASC'])->all();
        foreach ($parents as $key => $parent) {
            $tree[$key] = array('label' => $parent->resource_name, 'value' => $parent->resource_id);

            foreach ($parent->child as $cKey => $child) {
                $tree[$key]['items'][$cKey] = array('label' => $child->resource_name, 'value' => $child->resource_id);
            }
        }
        return $tree;
    }
}
