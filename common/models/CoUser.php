<?php

namespace common\models;

use common\models\query\CoUserQuery;
use cornernote\linkall\LinkAllBehavior;
use yii\db\ActiveQuery;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "co_user".
 *
 * @property integer $user_id
 * @property integer $tenant_id
 * @property string $title_code
 * @property string $name
 * @property string $designation
 * @property string $address
 * @property integer $city_id
 * @property integer $state_id
 * @property string $zip
 * @property integer $country_id
 * @property string $contact1
 * @property string $contact2
 * @property string $mobile
 * @property string $email
 * @property integer $speciality_id
 * @property string $care_provider
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoLogin[] $coLogins
 * @property CoTenant $tenant
 */
class CoUser extends RActiveRecord {

    const STATUS_ACTIVE = '1';
    const STATUS_INACTIVE = '0';

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_user';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['name'], 'required'],
            [['email'], 'email'],
            [['title_code', 'name', 'designation', 'mobile', 'email'], 'required', 'on' => 'saveorg'],
            [['tenant_id', 'city_id', 'state_id', 'country_id', 'speciality_id', 'created_by', 'modified_by'], 'integer'],
            [['title_code', 'care_provider', 'status'], 'string'],
            [['created_at', 'modified_at'], 'safe'],
            [['name', 'contact1', 'contact2', 'mobile', 'email'], 'string', 'max' => 50],
            [['designation'], 'string', 'max' => 25],
            [['address'], 'string', 'max' => 100],
            [['zip'], 'string', 'max' => 20]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'user_id' => 'User ID',
            'tenant_id' => 'Tenant ID',
            'title_code' => 'Prefix',
            'name' => 'Name',
            'designation' => 'Designation',
            'address' => 'Address',
            'city_id' => 'City ID',
            'state_id' => 'State ID',
            'zip' => 'Zip',
            'country_id' => 'Country ID',
            'contact1' => 'Contact1',
            'contact2' => 'Contact2',
            'mobile' => 'Mobile',
            'email' => 'Email',
            'speciality_id' => 'Speciality ID',
            'care_provider' => 'Care Provider',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getLogin() {
        return $this->hasOne(CoLogin::className(), ['user_id' => 'user_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public function behaviors() {
        $extend = [
            LinkAllBehavior::className(),
        ];

        $behaviour = array_merge(parent::behaviors(), $extend);
        return $behaviour;
    }

    public function getUsersRoles() {
        return $this->hasMany(CoUsersRoles::className(), ['user_id' => 'user_id']);
    }

    public function getRoles() {
        return $this->hasMany(CoRole::className(), ['role_id' => 'role_id'])->via('usersRoles');
    }

    public static function find() {
        return new CoUserQuery(get_called_class());
    }
    
    public static function getMyUserlist() {
        return ArrayHelper::map(self::find()->tenant()->status()->all(), 'user_id', 'name');
    }
    
//    public function fields() {
//        $extend = [
//            'username' => function ($model) {
//                return (isset($model->login) ? $model->login->username : '-');
//            },
//            'activation_date' => function ($model) {
//                return (isset($model->login) ? $model->login->activation_date : '-');
//            },
//            'Inactivation_date' => function ($model) {
//                return (isset($model->login) ? $model->login->Inactivation_date : '-');
//            },
//        ];
//        $fields = array_merge(parent::fields(), $extend);
//        return $fields;
//    }
}
