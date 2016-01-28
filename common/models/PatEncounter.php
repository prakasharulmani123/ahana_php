<?php

namespace common\models;

use common\models\query\PatEncounterQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_encounter".
 *
 * @property integer $encounter_id
 * @property integer $tenant_id
 * @property integer $patient_id
 * @property string $encounter_type
 * @property string $encounter_date
 * @property string $inactive_date
 * @property integer $finalize
 * @property integer $authorize
 * @property string $casesheetno
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatAppoinment[] $patAppoinments
 * @property PatPatient $patient
 * @property CoTenant $tenant
 */
class PatEncounter extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_encounter';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['patient_id', 'encounter_type', 'casesheetno'], 'required'],
            [['tenant_id', 'patient_id', 'finalize', 'authorize', 'created_by', 'modified_by'], 'integer'],
            [['encounter_date', 'inactive_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['status'], 'string'],
            [['encounter_type'], 'string', 'max' => 5],
            [['casesheetno'], 'string', 'max' => 200]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'encounter_id' => 'Encounter ID',
            'tenant_id' => 'Tenant ID',
            'patient_id' => 'Patient ID',
            'encounter_type' => 'Encounter Type',
            'encounter_date' => 'Encounter Date',
            'inactive_date' => 'Inactive Date',
            'finalize' => 'Finalize',
            'authorize' => 'Authorize',
            'casesheetno' => 'Casesheetno',
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
    public function getPatAppoinments() {
        return $this->hasMany(PatAppoinment::className(), ['encounter_id' => 'encounter_id']);
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

    public static function find() {
        return new PatEncounterQuery(get_called_class());
    }

    /**
     * @return ActiveQuery
     */
    public function getPatAdmissions() {
        return $this->hasMany(PatAdmission::className(), ['encounter_id' => 'encounter_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatLiveAdmission() {
        return $this->hasOne(PatAdmission::className(), ['encounter_id' => 'encounter_id'])->andWhere(['admission_status' => 'A'])->orderBy(['status_date' => SORT_DESC]);
    }

    public function fields() {
        $extend = [
            'patent' => function ($model) {
                return (isset($model->patient) ? $model->patient : '-');
            },
            'doe' => function ($model) {
                if (isset($model->encounter_date))
                    return date('Y-m-d', strtotime($model->encounter_date));
            },
            'doeTimeago' => function ($model) {
                if (isset($model->encounter_date))
                    return self::timeAgo(strtotime($model->encounter_date));
            },
            'liveAdmission' => function ($model) {
                return (isset($model->patLiveAdmission) ? $model->patLiveAdmission : '-');
            },
            'room_name' => function ($model) {
                return (isset($model->patLiveAdmission->room->bed_name) ? $model->patLiveAdmission->room->bed_name : '-');
            },
            'room_type_name' => function ($model) {
                return (isset($model->patLiveAdmission->roomType->room_type_name) ? $model->patLiveAdmission->roomType->room_type_name : '-');
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

}
