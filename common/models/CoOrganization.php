<?php

namespace common\models;

use yii\db\ActiveQuery;

/**
 * This is the model class for table "co_organization".
 *
 * @property integer $org_id
 * @property string $org_name
 * @property string $org_description
 * @property string $org_db_host
 * @property string $org_db_username
 * @property string $org_db_password
 * @property string $org_database
 * @property string $org_domain
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoLogin[] $coLogins
 * @property CoTenant[] $coTenants
 */
class CoOrganization extends GActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_organization';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['org_name', 'org_database', 'org_domain', 'created_by'], 'required'],
            [['org_description', 'status'], 'string'],
            [['created_by', 'modified_by'], 'integer'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['org_name'], 'string', 'max' => 100],
            [['org_db_host', 'org_db_username', 'org_db_password', 'org_database', 'org_domain'], 'string', 'max' => 255],
            [['org_name'], 'unique']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'org_id' => 'Org ID',
            'org_name' => 'Org Name',
            'org_description' => 'Org Description',
            'org_db_host' => 'Org Db Host',
            'org_db_username' => 'Org Db Username',
            'org_db_password' => 'Org Db Password',
            'org_database' => 'Org Database',
            'org_domain' => 'Org Domain',
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
    public function getCoLogins()
    {
        return $this->hasMany(CoLogin::className(), ['org_id' => 'org_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getCoTenants()
    {
        return $this->hasMany(CoTenant::className(), ['org_id' => 'org_id']);
    }
}
