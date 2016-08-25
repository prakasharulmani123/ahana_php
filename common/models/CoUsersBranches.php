<?php

namespace common\models;

use common\models\query\CoUsersBranchesQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "co_users_branches".
 *
 * @property integer $user_branch_id
 * @property integer $tenant_id
 * @property integer $user_id
 * @property integer $branch_id
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoTenant $branch
 * @property CoTenant $tenant
 * @property CoUser $user
 */
class CoUsersBranches extends RActiveRecord {

    public $branch_ids;

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_users_branches';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['tenant_id', 'user_id', 'branch_ids'], 'required', 'on' => 'branchassign'],
            [['tenant_id', 'user_id', 'branch_id', 'created_by', 'modified_by'], 'integer'],
            [['created_at', 'modified_at', 'branch_ids'], 'safe']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'user_branch_id' => 'User Branch ID',
            'tenant_id' => 'Tenant ID',
            'user_id' => 'User',
            'branch_id' => 'Branch ID',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'branch_ids' => 'Branch',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getBranch() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'branch_id']);
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
    public function getUser() {
        return $this->hasOne(CoUser::className(), ['user_id' => 'user_id']);
    }

    public static function find() {
        return new CoUsersBranchesQuery(get_called_class());
    }

}
