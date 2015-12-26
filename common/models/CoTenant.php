<?php

namespace common\models;

use Yii;
use yii\db\ActiveRecord;
/**
 * This is the model class for table "co_tenant".
 *
 * @property integer $tenant_id
 * @property string $tenant_guid
 * @property string $tenant_name
 * @property string $tenant_address
 * @property integer $tenant_city
 * @property integer $tenant_state
 * @property integer $tenant_country
 * @property string $tenant_contact1
 * @property string $tenant_contact2
 * @property string $tenant_fax
 * @property string $tenant_mobile
 * @property string $tenant_email
 * @property string $tenant_url
 * @property string $slug
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoRole[] $coRoles
 * @property CoUserProfile[] $coUserProfiles
 */
class CoTenant extends ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_tenant';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_name'], 'required'],
            [['tenant_city', 'tenant_state', 'tenant_country', 'created_by', 'modified_by'], 'integer'],
            [['status'], 'string'],
            [['created_at', 'modified_at'], 'safe'],
            [['tenant_guid', 'tenant_name', 'tenant_fax', 'tenant_email', 'tenant_url', 'slug'], 'string', 'max' => 50],
            [['tenant_address'], 'string', 'max' => 100],
            [['tenant_contact1', 'tenant_contact2', 'tenant_mobile'], 'string', 'max' => 20],
            [['tenant_name'], 'unique']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'tenant_id' => 'Tenant ID',
            'tenant_guid' => 'Tenant Guid',
            'tenant_name' => 'Tenant Name',
            'tenant_address' => 'Tenant Address',
            'tenant_city' => 'Tenant City',
            'tenant_state' => 'Tenant State',
            'tenant_country' => 'Tenant Country',
            'tenant_contact1' => 'Tenant Contact1',
            'tenant_contact2' => 'Tenant Contact2',
            'tenant_fax' => 'Tenant Fax',
            'tenant_mobile' => 'Tenant Mobile',
            'tenant_email' => 'Tenant Email',
            'tenant_url' => 'Tenant Url',
            'slug' => 'Slug',
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
    public function getCoRoles()
    {
        return $this->hasMany(CoRole::className(), ['tenant_id' => 'tenant_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCoUserProfiles()
    {
        return $this->hasMany(CoUserProfile::className(), ['tenant_id' => 'tenant_id']);
    }
}
