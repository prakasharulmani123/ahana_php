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
 * @property integer $tenant_city_id
 * @property integer $tenant_state_id
 * @property integer $tenant_country_id
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
            [['tenant_city_id', 'tenant_state_id', 'tenant_country_id', 'tenant_address'], 'required', 'on' => 'create'],
            [['tenant_city_id', 'tenant_state_id', 'tenant_country_id', 'created_by', 'modified_by'], 'integer'],
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
            'tenant_id' => 'ID',
            'tenant_guid' => 'Guid',
            'tenant_name' => 'Name',
            'tenant_address' => 'Address',
            'tenant_city_id' => 'City',
            'tenant_state_id' => 'State',
            'tenant_country_id' => 'Country',
            'tenant_contact1' => 'Contact1',
            'tenant_contact2' => 'Contact2',
            'tenant_fax' => 'Fax',
            'tenant_mobile' => 'Mobile',
            'tenant_email' => 'Email',
            'tenant_url' => 'Url',
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
    
    public function getCoMasterCity() {
        return $this->hasOne(CoMasterCity::className(), ['city_id' => 'tenant_city_id']);
    }
    
    public function getCoMasterState() {
        return $this->hasOne(CoMasterState::className(), ['state_id' => 'tenant_state_id']);
    }
    
    public function getCoMasterCountry() {
        return $this->hasOne(CoMasterCountry::className(), ['country_id' => 'tenant_country_id']);
    }

    public function fields() {
        return [
            'tenant_id',
            'tenant_name',
            'tenant_address',
            'tenant_city_id',
            'tenant_state_id',
            'tenant_country_id',
            'tenant_city_name' => function ($model) {
                return (isset($model->coMasterCity) ? $model->coMasterCity->city_name : '-');
            },
            'tenant_state_name' => function ($model) {
                return (isset($model->coMasterState) ? $model->coMasterState->state_name : '-');
            },
            'tenant_country_name' => function ($model) {
                return (isset($model->coMasterCountry) ? $model->coMasterCountry->country_name : '-');
            }
        ];
    }
    
//    public function extraFields() {
//        parent::extraFields();
//        return ['tenant_city_name' => function ($model) {
//                return $model->coMasterCity->city_name;
//            }
//        ];
//    }
}
