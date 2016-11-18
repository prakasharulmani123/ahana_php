<?php

namespace common\models;

use common\models\query\PatPatientQuery;
use p2made\helpers\Uuid\UuidHelpers;
use Yii;
use yii\db\ActiveQuery;
use yii\db\Connection;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "pat_patient".
 *
 * @property integer $patient_id
 * @property string $patient_global_guid
 * @property string $patient_guid
 * @property integer $casesheetno
 * @property string $patient_global_int_code
 * @property string $patient_int_code
 * @property integer $tenant_id
 * @property string $patient_reg_date
 * @property string $patient_title_code
 * @property string $patient_firstname
 * @property string $patient_lastname
 * @property string $patient_relation_code
 * @property string $patient_relation_name
 * @property integer $patient_care_taker
 * @property string $patient_care_taker_name
 * @property string $patient_dob
 * @property string $patient_gender
 * @property string $patient_marital_status
 * @property string $patient_occupation
 * @property string $patient_blood_group
 * @property integer $patient_category_id
 * @property string $patient_email
 * @property string $patient_reg_mode
 * @property string $patient_type
 * @property string $patient_ref_hospital
 * @property string $patient_ref_doctor
 * @property string $patient_ref_id
 * @property string $patient_mobile
 * @property string $patient_secondary_contact
 * @property string $patient_bill_type
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 * @property PatPatientAddress[] $patPatientAddresses
 */
class PatPatient extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_patient';
    }

//    public function init() {
//        parent::init();
//        if ($this->isNewRecord) {
//            $this->patient_int_code = CoInternalCode::find()->tenant()->codeType("P")->one()->Fullcode;
//        }
//    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['patient_title_code', 'patient_firstname', 'patient_gender', 'patient_reg_mode', 'patient_mobile', 'patient_dob'], 'required'],
            [['patient_firstname'], 'string', 'min' => '2'],
            [['casesheetno', 'tenant_id', 'patient_care_taker', 'patient_category_id', 'created_by', 'modified_by'], 'integer'],
            [['patient_reg_date', 'patient_dob', 'created_at', 'modified_at', 'deleted_at', 'patient_mobile', 'patient_bill_type', 'patient_guid', 'patient_image', 'patient_global_guid', 'patient_global_int_code', 'patient_int_code', 'patient_secondary_contact'], 'safe'],
            [['status'], 'string'],
            [['patient_title_code'], 'string', 'max' => 10],
            [['patient_firstname', 'patient_lastname', 'patient_relation_name', 'patient_care_taker_name', 'patient_occupation', 'patient_email', 'patient_ref_id'], 'string', 'max' => 50],
            [['patient_relation_code', 'patient_gender', 'patient_marital_status', 'patient_reg_mode', 'patient_type'], 'string', 'max' => 2],
            [['patient_blood_group'], 'string', 'max' => 5],
            [['patient_ref_hospital', 'patient_ref_doctor'], 'string', 'max' => 255],
            ['patient_mobile', 'match', 'pattern' => '/^[0-9]{10}$/', 'message' => 'Mobile must be 10 digits only'],
            ['patient_secondary_contact', 'match', 'pattern' => '/^[0-9]{10}$/', 'message' => 'Secondary contact must be 10 digits only'],
            ['patient_email', 'email'],
//            ['patient_image', 'file', 'extensions'=> 'jpg, gif, png'],
            [['tenant_id'], 'unique', 'targetAttribute' => ['tenant_id', 'casesheetno'], 'message' => 'The combination of Casesheetno has already been taken.', 'on' => 'casesheetunique'],
            [['tenant_id'], 'unique', 'targetAttribute' => ['tenant_id', 'patient_int_code'], 'message' => 'The combination of Patient Internal Code has already been taken.'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'patient_id' => 'Patient ID',
            'tenant_id' => 'Tenant ID',
            'patient_reg_date' => 'Registration Date',
            'patient_title_code' => 'Title Code',
            'patient_firstname' => 'Firstname',
            'patient_lastname' => 'Lastname',
            'patient_relation_code' => 'Relation Code',
            'patient_relation_name' => 'Relation Name',
            'patient_care_taker' => 'Care Taker',
            'patient_care_taker_name' => 'Care Taker Name',
            'patient_dob' => 'Dob',
            'patient_gender' => 'Gender',
            'patient_marital_status' => 'Marital Status',
            'patient_occupation' => 'Occupation',
            'patient_blood_group' => 'Blood Group',
            'patient_category_id' => 'Category ID',
            'patient_email' => 'Email',
            'patient_reg_mode' => 'Reg Mode',
            'patient_type' => 'Type',
            'patient_ref_hospital' => 'Ref Hospital',
            'patient_ref_doctor' => 'Ref Doctor',
            'patient_ref_id' => 'Ref ID',
            'patient_mobile' => 'Mobile',
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
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatPatientAddress() {
        return $this->hasOne(PatPatientAddress::className(), ['patient_id' => 'patient_id']);
    }

    public function getPatientCategory() {
        return $this->hasOne(CoPatientCategory::className(), ['patient_cat_id' => 'patient_category_id']);
    }

    public function getActivePatientAlert() {
        return $this->hasMany(PatAlert::className(), ['patient_id' => 'patient_id'])->active()->orderBy(['created_at' => SORT_DESC]);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatActiveEncounter() {
        return $this->hasOne(PatEncounter::className(), ['patient_id' => 'patient_id'])->status()->orderBy(['encounter_date' => SORT_DESC]);
    }

    public function getPatLastAppointment() {
        return $this->hasOne(PatAppointment::className(), ['patient_id' => 'patient_id'])->status()->orderBy(['created_at' => SORT_DESC]);
    }

    public function getPatLastSeenAppointment() {
        return $this->hasOne(PatAppointment::className(), ['patient_id' => 'patient_id'])
                        ->status()
                        ->andWhere(['appt_status' => 'S'])
                        ->orderBy(['created_at' => SORT_DESC]);
    }

    public function getPatActiveIp() {
        return $this->hasOne(PatEncounter::className(), ['patient_id' => 'patient_id'])->status()->encounterType()->orderBy(['encounter_date' => SORT_DESC]);
    }

    public function getPatActiveOp() {
        return $this->hasOne(PatEncounter::className(), ['patient_id' => 'patient_id'])->status()->encounterType('OP')->orderBy(['encounter_date' => SORT_DESC]);
    }

    //Last completed encounter so status is 0
    public function getPatPreviousEncounter() {
        return $this->hasOne(PatEncounter::className(), ['patient_id' => 'patient_id'])->status('0')->orderBy(['encounter_date' => SORT_DESC]);
    }

    public function getPatHaveOneEncounter() {
        return $this->hasOne(PatEncounter::className(), ['patient_id' => 'patient_id'])->orderBy(['encounter_date' => SORT_DESC]);
    }

    public function getPatHaveEncounter() {
        return $this->hasOne(PatEncounter::className(), ['patient_id' => 'patient_id'])->status('1')->orderBy(['encounter_id' => SORT_DESC]);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatActiveCasesheetno() {
        return $this->hasOne(PatPatientCasesheet::className(), ['patient_id' => 'patient_id'])->tenant()->status()->active();
    }
    
    public function getPatGlobalPatient() {
        return $this->hasOne(PatGlobalPatient::className(), ['patient_global_guid' => 'patient_global_guid']);
    }

    public function beforeSave($insert) {
        if (!empty($this->patient_dob))
            $this->patient_dob = date('Y-m-d', strtotime($this->patient_dob));

        if ($insert) {
            $this->patient_guid = UuidHelpers::uuid();

            if (empty($this->patient_reg_date))
                $this->patient_reg_date = date('Y-m-d H:i:s');

            $this->patient_int_code = CoInternalCode::generateInternalCode('P', 'common\models\PatPatient', 'patient_int_code');

            //If Global ID empty means we will generate otherwise it could be imported data
            if (empty($this->patient_global_guid))
                $this->patient_global_guid = self::guid();

            if (empty($this->patient_global_int_code)) {
                $org_id = Yii::$app->user->identity->user->org_id;
                $this->patient_global_int_code = GlInternalCode::generateInternalCode($org_id, 'PG', 'common\models\GlPatient', 'patient_global_int_code');
            }
        }

        return parent::beforeSave($insert);
    }

    public static function guid() {
        $guid = UuidHelpers::uuid();
        do {
            $patient = GlPatient::find()->where(['patient_global_guid' => $guid])->one();

            if (!empty($patient)) {
                $old_guid = $guid;
                $guid = UuidHelpers::uuid();
            } else {
                break;
            }
        } while ($old_guid != $guid);
        return $guid;
    }

    public function afterSave($insert, $changedAttributes) {
        if (is_object($this->patient_guid))
            $this->patient_guid = $this->patient_guid->toString();

        if (is_object($this->patient_global_guid))
            $this->patient_global_guid = $this->patient_global_guid->toString();

        if ($insert) {
            CoInternalCode::increaseInternalCode("P");

            $model = new PatPatientCasesheet();
            $model->attributes = [
                'casesheet_no' => CoInternalCode::generateInternalCode('CS', 'common\models\PatPatientCasesheet', 'casesheet_no'),
                'patient_id' => $this->patient_id,
                'start_date' => date("Y-m-d"),
            ];
            $model->save(false);
            CoInternalCode::increaseInternalCode("CS");

            $header = "Patient Registration";
            $message = "{$this->patient_title_code} {$this->patient_firstname} Registered Successfully.";
            $date = $this->patient_reg_date;
        } else {
            $header = "Patient Update";
            $message = "Patient Details Updated Successfully.";
            $date = date('Y-m-d H:i:s');
        }

        $this->savetoHms($insert);

        $encounter_id = !empty($this->patActiveEncounter) ? $this->patActiveEncounter->encounter_id : null;

        if (is_null($encounter_id)) {
            $encounter_id = !empty($this->patPreviousEncounter) ? $this->patPreviousEncounter->encounter_id : null;
        }
        PatTimeline::insertTimeLine($this->patient_id, $date, $header, '', $message, 'BASIC', $encounter_id);

        return parent::afterSave($insert, $changedAttributes);
    }

    public function getUnsetcols() {
        $unset_cols = ['patient_id', 'created_at', 'modified_at', 'status'];
        return array_combine($unset_cols, $unset_cols);
    }

    /* Use to prevent the save to HMS */

    public $saveHms = true;

    /* Save to HMS Database */

    protected function savetoHms($insert) {
        if ($this->saveHms) {
            $unset_cols = $this->getUnsetcols();

            $patient = GlPatient::find()->where(['patient_global_guid' => $this->patient_global_guid])->one();

            $save = false;
            if ($insert) {
                if (empty($patient)) {
                    $model = new GlPatient;
                    $save = true;
                    $gl_patient_insert = true;
                }
            } else {
                if (!empty($patient)) {
                    $model = $patient;
                    $save = true;
                    $gl_patient_insert = false;
                    $this->updateAllPatient($patient);
                }
            }

            if ($save) {
                $attr = array_diff_key($this->attributes, $unset_cols);
                $model->attributes = $attr;
                $model->save(false);
                if ($gl_patient_insert) {
                    $org_id = Yii::$app->user->identity->user->org_id;
                    GlInternalCode::increaseInternalCode($org_id, "PG");
                }
            }

            // Link Patient and Tenant
            $this->updatePatientTenant();

            if ($insert) {
                // Link Patient and Share
                $this->insertPatientResource();
            }
        }
    }

    /* Update Patient details to all Database */

    protected function updateAllPatient($patient) {
        $unset_cols = $this->getUnsetcols();

        $newAttrs = $this->getAttributes();
        $oldAttrs = $this->oldAttributes;

        $result = array_diff_assoc($newAttrs, $oldAttrs);
        $attr = array_diff_key($result, $unset_cols);

        if (!empty($attr)) {
            $tenants = GlPatientTenant::find()->where(['patient_global_guid' => $this->patient_global_guid])->all();
            foreach ($tenants as $key => $tenant) {
                $connection = new Connection([
                    'dsn' => "mysql:host={$tenant->org->org_db_host};dbname={$tenant->org->org_database}",
                    'username' => $tenant->org->org_db_username,
                    'password' => $tenant->org->org_db_password,
                ]);
                $connection->open();

                $query = "UPDATE pat_patient SET";
                foreach ($attr as $col => $value) {
                    $query .= " $col = '$value',";
                }
                $query = rtrim($query, ',');
                $query .= " WHERE patient_global_guid = '{$this->patient_global_guid}' ";

                $command = $connection->createCommand($query);
                $command->execute();
                $connection->close();
            }
        }
    }

    protected function updatePatientTenant() {
        $pat_ten_attr = [
            'tenant_id' => $this->tenant_id,
            'org_id' => $this->tenant->org_id,
            'patient_global_guid' => $this->patient_global_guid,
            'patient_guid' => $this->patient_guid
        ];

        $patient_tenant = GlPatientTenant::find()->where($pat_ten_attr)->one();

        if (empty($patient_tenant)) {
            $model = new GlPatientTenant;
            $model->attributes = $pat_ten_attr;
            $model->save(false);
        }
    }

    public function insertPatientResource() {
        $pat_share_attr = [
            'tenant_id' => $this->tenant_id,
            'org_id' => $this->tenant->org_id,
            'patient_global_guid' => $this->patient_global_guid
        ];

        GlPatientShareResources::deleteAll($pat_share_attr);

        $share_config = AppConfiguration::find()->tenant($this->tenant_id)->andWhere("`key` like '%SHARE_%' AND `value` = '1'")->all();
        $share_resources = ArrayHelper::map($share_config, 'key', 'code');

        foreach ($share_resources as $key => $share_resource) {
            $patient_share = new GlPatientShareResources;
            $pat_share_attr['resource'] = $share_resource;
            $patient_share->attributes = $pat_share_attr;
            $patient_share->save(false);
        }
    }

    public static function find() {
        return new PatPatientQuery(get_called_class());
    }

    public function fields() {
        $extend = [
            'fullname' => function ($model) {
                return $model->patient_title_code . ucfirst($model->patient_firstname);
            },
            'patient_age' => function ($model) {
                $age = '';
                if ($model->patient_dob != '' && $model->patient_dob != "0000-00-00")
                    $age = self::getPatientAge($model->patient_dob);
                return $age;
            },
            'org_name' => function ($model) {
                if (isset($this->tenant->tenant_name))
                    return $this->tenant->tenant_name;
            },
            'sex' => function ($model) {
                if (isset($model->patient_reg_date))
                    return date('Y-m-d', strtotime($model->patient_reg_date));
            },
            'patient_category' => function ($model) {
                if (isset($model->patientCategory->patient_short_code)) {
                    return $model->patientCategory->patient_short_code;
                }
            },
            'patient_category_fullname' => function ($model) {
                if (isset($model->patientCategory->patient_cat_name)) {
                    $category_name = $model->patientCategory->patient_cat_name;
                    return $category_name;
                }
            },
            'patient_category_color' => function ($model) {
                if (isset($model->patientCategory->patient_cat_color) && strtolower($model->patientCategory->patient_cat_color) != '#ffffff') {
                    return $model->patientCategory->patient_cat_color;
                } else {
                    return "#19A9D5";
                }
            },
            'address' => function ($model) {
                if (isset($model->patPatientAddress))
                    return $model->patPatientAddress;
            },
            'hasalert' => function ($model) {
                return (!empty($this->activePatientAlert)) ? true : false;
            },
            'alert' => function ($model) {
                if (!empty($this->activePatientAlert)) {
                    return $this->activePatientAlert[0]->alert_description;
                }
            },
            'billing_type' => function ($model) {
                if (isset($model->patient_bill_type) && $model->patient_bill_type != '') {
                    return $model->patient_bill_type;
                }
            },
            'fullcurrentaddress' => function ($model) {
                if (isset($model->patPatientAddress)) {
                    $result = '';
                    if ($model->patPatientAddress->addr_current_address != '') {
                        $result .= $model->patPatientAddress->addr_current_address;
                    }

                    if ($model->patPatientAddress->addr_city_id != '') {
                        $result .= ' ' . $model->patPatientAddress->addrCity->city_name;
                    }

                    if ($model->patPatientAddress->addr_state_id != '') {
                        $result .= ' ' . $model->patPatientAddress->addrState->state_name;
                    }

                    if ($model->patPatientAddress->addr_country_id != '') {
                        $result .= ' ' . $model->patPatientAddress->addrCountry->country_name;
                    }

                    return $result;
                }
            },
            'fullpermanentaddress' => function ($model) {
                if (isset($model->patPatientAddress)) {
                    $result = '';
                    if ($model->patPatientAddress->addr_perm_address != '') {
                        $result .= $model->patPatientAddress->addr_perm_address;
                    }

                    if ($model->patPatientAddress->addr_perm_city_id != '') {
                        $result .= ' ' . $model->patPatientAddress->addrPermCity->city_name;
                    }

                    if ($model->patPatientAddress->addr_perm_state_id != '') {
                        $result .= ' ' . $model->patPatientAddress->addrPermState->state_name;
                    }

                    if ($model->patPatientAddress->addr_perm_country_id != '') {
                        $result .= ' ' . $model->patPatientAddress->addrPermCountry->country_name;
                    }
                    return $result;
                }
            },
            'activeCasesheetno' => function ($model) {
                if (isset($model->patActiveCasesheetno))
                    return $model->patActiveCasesheetno->casesheet_no;
            },
            'patActiveIp' => function ($model) {
                return isset($model->patActiveIp);
            },
            'doa' => function ($model) {
                return isset($model->patActiveIp) ? date('d/m/Y', strtotime($model->patActiveIp->encounter_date)) : '';
            },
            'current_room' => function ($model) {
                if (isset($model->patActiveIp)) {
                    $admission = $model->patActiveIp->patCurrentAdmission;
                    return "{$admission->floor->floor_name} > {$admission->ward->ward_name} > {$admission->room->bed_name} ({$admission->roomType->room_type_name})";
                } else {
                    return '-';
                }
            },
            'last_consultant_id' => function ($model) {
                return isset($model->patLastAppointment) ? $model->patLastAppointment->consultant_id : '';
            },
            'last_patient_cat_id' => function ($model) {
                return isset($model->patLastSeenAppointment) ? $model->patLastSeenAppointment->patient_cat_id : '';
            },
            'consultant_name' => function ($model) {
                if (isset($model->patActiveIp)) {
                    $consultant = $model->patActiveIp->patCurrentAdmission->consultant;
                    return $consultant->title_code . $consultant->name;
                } else if (isset($model->patActiveOp)) {
                    $consultant = $model->patActiveOp->patLiveAppointmentBooking->consultant;
                    return $consultant->title_code . $consultant->name;
                } else {
                    return '-';
                }
            },
            'have_encounter' => function($model) {
                return (isset($model->patHaveEncounter));
            },
            'have_atleast_encounter' => function($model) {
                return (isset($model->patHaveOneEncounter));
            },
            'encounter_type' => function($model) {
                return (isset($model->patHaveEncounter)) ? $model->patHaveEncounter->encounter_type : '';
            },
            'incomplete_profile' => function($model) {
                if (!isset($model->patPatientAddress))
                    return true;
                else
                    return $model->patPatientAddress->isIncompleteProfile();
            },
            'name_with_casesheet' => function($model) {
                $name = ucfirst($model->patient_firstname);
                if (isset($model->patActiveCasesheetno))
                    $name .= ' (' . $model->patActiveCasesheetno->casesheet_no . ')';
                return $name;
            },
            'active_op_current_status' => function($model) {
                if (isset($model->patActiveOp->patLiveAppointmentArrival)) {
                    return 'Arrived';
                } elseif (isset($model->patActiveOp->patLiveAppointmentBooking)) {
                    return 'Booked';
                } else {
                    return '-';
                }
            },
            'new_user' => function($model) {
                $today = date("Y-m-d");
                $reg_date = date('Y-m-d', strtotime($model->patient_reg_date));
                $active_encounter = $model->patActiveEncounter;
                if (isset($active_encounter)) {
                    $encounter_date = date('Y-m-d', strtotime($active_encounter->encounter_date));
                    if ($encounter_date == $reg_date) {
                        return true;
                    }
                } elseif ($reg_date == $today) {
                    return true;
                }
            },
            'name_with_int_code' => function($model) {
                $name = ucfirst($model->patient_firstname);

                if ($model->patient_lastname != '')
                    $name .= ' ' . $model->patient_lastname . ' ';

                if ($model->patient_global_int_code != '')
                    $name .= ' (' . $model->patient_global_int_code . ')';
                return $name;
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    public static function getPatientAge($date) {
        $birthDate = date('m/d/Y', strtotime($date));
        $birthDate = explode("/", $birthDate);
        return (date("md", date("U", mktime(0, 0, 0, $birthDate[0], $birthDate[1], $birthDate[2]))) > date("md") ? ((date("Y") - $birthDate[2]) - 1) : (date("Y") - $birthDate[2]));
    }

    public static function getPatientBirthdate($age) {
        return date('Y-m-d', strtotime($age . ' years ago'));
    }

    public static function getPatientlist($tenant = null, $status = '1', $deleted = false) {
        if (!$deleted)
            $list = self::find()->tenant($tenant)->status($status)->active()->all();
        else
            $list = self::find()->tenant($tenant)->deleted()->all();

        return $list;
    }

    public static function getPatientByGuid($patient_guid) {
        $patient = self::find()->where(['patient_guid' => $patient_guid])->one();
        return $patient;
    }

    public static function getActiveEncounterByPatientId($patient_id) {
        return PatEncounter::find()->status()->active()->andWhere(['patient_id' => $patient_id])->one();
    }

    public static function getActiveEncounterByPatientGuid($patient_guid) {
        $patient = self::find()->where(['patient_guid' => $patient_guid])->one();
        return self::getActiveEncounterByPatientId($patient->patient_id);
    }

    protected $oldAttributes;

    public function afterFind() {
        if (is_object($this->patient_guid))
            $this->patient_guid = $this->patient_guid->toString();

        $this->oldAttributes = $this->attributes;
        return parent::afterFind();
    }

    public static function getPatientNextVisitDays($date) {
        $now = strtotime(date('Y-m-d'));
        $date = strtotime($date);
        $datediff = abs($now - $date);
        return floor($datediff / (60 * 60 * 24));
    }

    public static function getPatientNextvisitDate($days) {
        $date = date('Y-m-d');
        return date('Y-m-d', strtotime($date . "+$days days"));
    }

}
