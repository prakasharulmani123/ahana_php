<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "pat_patient_address".
 *
 * @property integer $addr_id
 * @property integer $patient_id
 * @property string $addr_current_address
 * @property integer $addr_country_id
 * @property integer $addr_state_id
 * @property integer $addr_city_id
 * @property string $addr_zip
 * @property string $addr_perm_address
 * @property integer $addr_perm_country_id
 * @property integer $addr_perm_state_id
 * @property integer $addr_perm_city_id
 * @property string $addr_perm_zip
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoMasterCity $addrPermCity
 * @property PatPatient $patient
 * @property CoMasterCity $addrCity
 * @property CoMasterCountry $addrCountry
 * @property CoMasterCountry $addrPermCountry
 * @property CoMasterState $addrPermState
 * @property CoMasterState $addrState
 */
class PatPatientAddress extends \common\models\RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_patient_address';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['patient_id', 'addr_country_id', 'addr_state_id', 'addr_city_id', 'addr_perm_country_id', 'addr_perm_state_id', 'addr_perm_city_id', 'created_by', 'modified_by'], 'integer'],
            [['addr_current_address', 'addr_perm_address'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['addr_zip', 'addr_perm_zip'], 'string', 'max' => 10]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'addr_id' => 'Addr ID',
            'patient_id' => 'Patient ID',
            'addr_current_address' => 'Addr Current Address',
            'addr_country_id' => 'Addr Country ID',
            'addr_state_id' => 'Addr State ID',
            'addr_city_id' => 'Addr City ID',
            'addr_zip' => 'Addr Zip',
            'addr_perm_address' => 'Addr Perm Address',
            'addr_perm_country_id' => 'Addr Perm Country ID',
            'addr_perm_state_id' => 'Addr Perm State ID',
            'addr_perm_city_id' => 'Addr Perm City ID',
            'addr_perm_zip' => 'Addr Perm Zip',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAddrPermCity() {
        return $this->hasOne(CoMasterCity::className(), ['city_id' => 'addr_perm_city_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPatient() {
        return $this->hasOne(PatPatient::className(), ['patient_id' => 'patient_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAddrCity() {
        return $this->hasOne(CoMasterCity::className(), ['city_id' => 'addr_city_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAddrCountry() {
        return $this->hasOne(CoMasterCountry::className(), ['country_id' => 'addr_country_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAddrPermCountry() {
        return $this->hasOne(CoMasterCountry::className(), ['country_id' => 'addr_perm_country_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAddrPermState() {
        return $this->hasOne(CoMasterState::className(), ['state_id' => 'addr_perm_state_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getAddrState() {
        return $this->hasOne(CoMasterState::className(), ['state_id' => 'addr_state_id']);
    }

    public function fields() {
        $extend = [
            'country_name' => function ($model) {
                return (isset($model->addrCountry->country) ? $model->addrCountry->country->country_name : '-');
            },
            'state_name' => function ($model) {
                return (isset($model->addrState) ? $model->addrState->state_name : '-');
            },
            'city_name' => function ($model) {
                return (isset($model->addrCity) ? $model->addrCity->city_name : '-');
            },
            'perm_country_name' => function ($model) {
                return (isset($model->addrPermCountry->country) ? $model->addrPermCountry->country->country_name : '-');
            },
            'perm_state_name' => function ($model) {
                return (isset($model->addrPermState) ? $model->addrPermState->state_name : '-');
            },
            'perm_city_name' => function ($model) {
                return (isset($model->addrPermCity) ? $model->addrPermCity->city_name : '-');
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

}
