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
 * @property string $deleted_at
 *
 * @property CoLogin[] $coLogins
 * @property CoTenant $tenant
 */
class CoUser extends RActiveRecord {

//    public $logged_tenant_id = null;

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
            [['email'], 'email', 'message' => 'Invalid Email Format'],
            [['title_code', 'name', 'designation', 'mobile', 'email', 'address', 'country_id', 'state_id', 'city_id', 'zip'], 'required', 'on' => 'saveorg'],
            [['tenant_id', 'city_id', 'state_id', 'country_id', 'speciality_id', 'created_by', 'modified_by'], 'integer'],
            [['title_code', 'care_provider', 'status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
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
            'city_id' => 'City',
            'state_id' => 'State',
            'zip' => 'Zip',
            'country_id' => 'Country',
            'contact1' => 'Contact1',
            'contact2' => 'Contact2',
            'mobile' => 'Mobile',
            'email' => 'Email',
            'speciality_id' => 'Speciality',
            'care_provider' => 'Care Provider',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
        ];
    }

    public function behaviors() {
        $extend = [
            LinkAllBehavior::className(),
        ];

        $behaviour = array_merge(parent::behaviors(), $extend);
        return $behaviour;
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

    /**
     * @return ActiveQuery
     */
    public function getOrganization() {
        return $this->hasOne(CoOrganization::className(), ['org_id' => 'org_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getUsersRoles() {
        return $this->hasMany(CoUsersRoles::className(), ['user_id' => 'user_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getRoles() {
        return $this->hasMany(CoRole::className(), ['role_id' => 'role_id'])->via('usersRoles');
    }

    /**
     * @return ActiveQuery
     */
    public function getUsersVitals() {
        return $this->hasMany(PatVitalsUsers::className(), ['user_id' => 'user_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getVitals() {
        return $this->hasMany(PatVitals::className(), ['vital_id' => 'vital_id'])->via('usersVitals');
    }
    
    /**
     * @return ActiveQuery
     */
    public function getUsersNotes() {
        return $this->hasMany(PatNotesUsers::className(), ['user_id' => 'user_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getNotes() {
        return $this->hasMany(PatNotes::className(), ['pat_note_id' => 'note_id'])->via('usersNotes');
    }
    
    /**
     * @return ActiveQuery
     */
    public function getSpeciality() {
        return $this->hasOne(CoSpeciality::className(), ['speciality_id' => 'speciality_id']);
    }

    public static function find() {
        return new CoUserQuery(get_called_class());
    }

    public function fields() {
        $extend = [
            'speciality_name' => function ($model) {
                return (isset($model->speciality) ? $model->speciality->speciality_name : '-');
            },
            'fullname' => function ($model) {
                return $model->title_code . ucfirst($model->name);
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    public static function getMyUserlist() {
        return ArrayHelper::map(self::find()->tenant()->status()->all(), 'user_id', 'name');
    }

    public static function getDoctorsList($tenant = null, $care_provider = '1', $status = '1', $deleted = false) {
        if (!$deleted)
            $list = self::find()->tenant($tenant)->status($status)->active()->careprovider($care_provider)->all();
        else
            $list = self::find()->tenant($tenant)->deleted()->careprovider($care_provider)->all();

        return $list;
    }

    public function getFirst_tenant_id() {
        return $this->organization->coTenants[0]->tenant_id;
    }

}
