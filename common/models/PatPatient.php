<?php

namespace common\models;

use common\models\query\PatPatientQuery;
use p2made\helpers\Uuid\UuidHelpers;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_patient".
 *
 * @property integer $patient_id
 * @property string $patient_guid
 * @property integer $casesheetno
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
 * @property string $patient_ref_id
 * @property string $patient_mobile
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
            [['casesheetno', 'tenant_id', 'patient_care_taker', 'patient_category_id', 'created_by', 'modified_by'], 'integer'],
            [['patient_reg_date', 'patient_dob', 'created_at', 'modified_at', 'deleted_at', 'patient_mobile', 'patient_bill_type', 'patient_guid'], 'safe'],
            [['status'], 'string'],
            [['patient_title_code'], 'string', 'max' => 10],
            [['patient_firstname', 'patient_lastname', 'patient_relation_name', 'patient_care_taker_name', 'patient_occupation', 'patient_email', 'patient_ref_id'], 'string', 'max' => 50],
            [['patient_relation_code', 'patient_gender', 'patient_marital_status', 'patient_reg_mode', 'patient_type'], 'string', 'max' => 2],
            [['patient_blood_group'], 'string', 'max' => 5],
            [['patient_ref_hospital'], 'string', 'max' => 255],
            ['patient_mobile', 'match', 'pattern' => '/^[0-9]{10}$/', 'message' => 'Mobile must be 10 digits only'],
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

    /**
     * @return ActiveQuery
     */
    public function getPatActiveCasesheetno() {
        return $this->hasOne(PatPatientCasesheet::className(), ['patient_id' => 'patient_id'])->tenant()->status()->active();
    }

    public function beforeSave($insert) {
        if (!empty($this->patient_dob))
            $this->patient_dob = date('Y-m-d', strtotime($this->patient_dob));

        if ($insert) {
            $this->patient_guid = UuidHelpers::uuid();
            $this->patient_reg_date = date('Y-m-d H:i:s');

            $this->patient_int_code = CoInternalCode::find()->tenant()->codeType("P")->one()->Fullcode;
        }

        return parent::beforeSave($insert);
    }

    public function afterSave($insert, $changedAttributes) {
        if ($insert) {
            CoInternalCode::increaseInternalCode("P");

            $header = "Patient Registration";
            $message = "{$this->patient_title_code} {$this->patient_firstname} Registered Successfully.";
        } else {
            $header = "Patient Update";
            $message = "Patient Details Updated Successfully.";
        }

        PatTimeline::insertTimeLine($this->patient_id, $this->patient_reg_date, $header, '', $message);

        if (is_object($this->patient_guid))
            $this->patient_guid = $this->patient_guid->toString();

        return parent::afterSave($insert, $changedAttributes);
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
                if ($model->patient_dob != '')
                    $age = self::getPatientAge($model->patient_dob);
                return $age;
            },
            'org_name' => function ($model) {
                if (isset($this->tenant->tenant_name))
                    return $this->tenant->tenant_name;
            },
//            'doa' => function ($model) {
//                if (isset($model->patient_reg_date))
//                    return date('Y-m-d', strtotime($model->patient_reg_date));
//            },
            'sex' => function ($model) {
                if (isset($model->patient_reg_date))
                    return date('Y-m-d', strtotime($model->patient_reg_date));
            },
            'patient_category' => function ($model) {
                if (isset($model->patientCategory->patient_cat_name)) {
                    $category_name = $model->patientCategory->patient_cat_name;
                    return $category_name[0];
                }
            },
            'patient_category_color' => function ($model) {
                if (isset($model->patientCategory->patient_cat_color) && $model->patientCategory->patient_cat_color != '#ffffff') {
                    return $model->patientCategory->patient_cat_color;
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
                    if ($model->patPatientAddress->addr_current_address != '' && $model->patPatientAddress->addr_country_id != '' && $model->patPatientAddress->addr_state_id != '' && $model->patPatientAddress->addr_city_id != '') {
                        $country = $model->patPatientAddress->addrCountry->country_name;
                        $state = $model->patPatientAddress->addrState->state_name;
                        $city = $model->patPatientAddress->addrCity->city_name;
                        $address = $model->patPatientAddress->addr_current_address;
                        return $address . ' ' . $city . ' ' . $state . ' ' . $country;
                    }
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
            }
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

    public function afterFind() {
        if (is_object($this->patient_guid))
            $this->patient_guid = $this->patient_guid->toString();

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
