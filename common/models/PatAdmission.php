<?php

use common\models\CoTenant;
use common\models\PatEncounter;
use common\models\PatPatient;
use common\models\RActiveRecord;
use yii\db\ActiveQuery;

namespace common\models;

/**
 * This is the model class for table "pat_admission".
 *
 * @property integer $admn_id
 * @property integer $tenant_id
 * @property integer $patient_id
 * @property integer $encounter_id
 * @property string $admission_date
 * @property integer $consultant_id
 * @property integer $floor_id
 * @property integer $ward_id
 * @property integer $room_id
 * @property integer $room_type_id
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatEncounter $encounter
 * @property PatPatient $patient
 * @property CoTenant $tenant
 */
class PatAdmission extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_admission';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['tenant_id', 'patient_id'], 'required'],
            [['tenant_id', 'patient_id', 'encounter_id', 'consultant_id', 'floor_id', 'ward_id', 'room_id', 'room_type_id', 'created_by', 'modified_by'], 'integer'],
            [['admission_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['status'], 'string']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'admn_id' => 'Admn ID',
            'tenant_id' => 'Tenant ID',
            'patient_id' => 'Patient ID',
            'encounter_id' => 'Encounter ID',
            'admission_date' => 'Admission Date',
            'consultant_id' => 'Consultant ID',
            'floor_id' => 'Floor ID',
            'ward_id' => 'Ward ID',
            'room_id' => 'Room ID',
            'room_type_id' => 'Room Type ID',
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
    public function getEncounter() {
        return $this->hasOne(PatEncounter::className(), ['encounter_id' => 'encounter_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatient() {
        return $this->hasOne(PatPatient::className(), ['patient_id' => 'patient_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

}
