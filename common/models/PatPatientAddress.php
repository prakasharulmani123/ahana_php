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
 * @property PatPatient $patient
 */
class PatPatientAddress extends \common\models\RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pat_patient_address';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
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
    public function attributeLabels()
    {
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
    public function getPatient()
    {
        return $this->hasOne(PatPatient::className(), ['patient_id' => 'patient_id']);
    }
}
