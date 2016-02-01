<?php

namespace common\models;

use yii\db\ActiveQuery;

/**
 * This is the model class for table "pat_admission".
 *
 * @property integer $admn_id
 * @property integer $tenant_id
 * @property integer $patient_id
 * @property integer $encounter_id
 * @property string $status_date
 * @property integer $consultant_id
 * @property integer $floor_id
 * @property integer $ward_id
 * @property integer $room_id
 * @property integer $room_type_id
 * @property string $admission_status
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

    public $changeOldRoomStatusId = null;

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
            [['consultant_id', 'floor_id', 'ward_id', 'room_id', 'room_type_id'], 'required'],
            [['tenant_id', 'patient_id', 'encounter_id', 'consultant_id', 'floor_id', 'ward_id', 'room_id', 'room_type_id', 'created_by', 'modified_by'], 'integer'],
            [['status_date', 'created_at', 'modified_at', 'deleted_at', 'status_date', 'admission_status'], 'safe'],
            [['status'], 'string'],
            ['admission_status', 'validateAdmissionStatus'],
        ];
    }

    public function validateAdmissionStatus($attribute, $params) {
        if ($this->admission_status == 'TR') {
            if ($this->encounter->patCurrentAdmission->room_id == $this->room_id && $this->encounter->patCurrentAdmission->room_type_id == $this->room_type_id) {
                $this->addError($attribute, "Room can't be same. Change the Room");
            }
        } else if ($this->admission_status == 'TD') {
            if ($this->encounter->patCurrentAdmission->consultant_id == $this->consultant_id) {
                $this->addError($attribute, "Consultant can't be same. Change the Consultant");
            }
        }
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
            'status_date' => 'Admission Date',
            'consultant_id' => 'Consultant',
            'floor_id' => 'Floor',
            'ward_id' => 'Ward',
            'room_id' => 'Room',
            'room_type_id' => 'Room Type',
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

    public function getConsultant() {
        return $this->hasOne(CoUser::className(), ['user_id' => 'consultant_id']);
    }

    public function getFloor() {
        return $this->hasOne(CoFloor::className(), ['floor_id' => 'floor_id']);
    }

    public function getWard() {
        return $this->hasOne(CoWard::className(), ['ward_id' => 'ward_id']);
    }

    public function getRoom() {
        return $this->hasOne(CoRoom::className(), ['room_id' => 'room_id']);
    }

    public function getRoomType() {
        return $this->hasOne(CoRoomType::className(), ['room_type_id' => 'room_type_id']);
    }

    public function beforeValidate() {
        $this->setCurrentData();
        return parent::beforeValidate();
    }

    public function beforeSave($insert) {
        $this->status_date = date('Y-m-d H:i:s', strtotime($this->status_date));

        if ($insert) {
            $this->setCurrentData();

            //Set Old room status to vacant
            if ($this->admission_status == 'TR') {
                $this->changeOldRoomStatusId = $this->encounter->patCurrentAdmission->room_id;
            }
        }
        return parent::beforeSave($insert);
    }

    public function afterSave($insert, $changedAttributes) {
        //Change room occupied status
        if ($this->room_id) {
            $room = CoRoom::find()->where(['room_id' => $this->room_id])->one();
            $room->occupied_status = 1;
            $room->save(false);
        }

        if ($insert) {
            //Close Encounter
            if ($this->admission_status == 'D') {
                $this->encounter->status = '0';
                $this->encounter->save(false);
            }

            //Change Old room status to vacant
            if (!is_null($this->changeOldRoomStatusId)) {
                $room = CoRoom::find()->where(['room_id' => $this->changeOldRoomStatusId])->one();
                $room->occupied_status = 0;
                $room->save(false);
                $this->changeOldRoomStatusId = null;
            }
        }

        return parent::afterSave($insert, $changedAttributes);
    }

    public function setCurrentData() {
        if ($this->admission_status == 'TD' || $this->admission_status == 'D') {
            $this->floor_id = $this->encounter->patCurrentAdmission->floor_id;
            $this->ward_id = $this->encounter->patCurrentAdmission->ward_id;
            $this->room_id = $this->encounter->patCurrentAdmission->room_id;
            $this->room_type_id = $this->encounter->patCurrentAdmission->room_type_id;

            if ($this->admission_status == 'D') {
                $this->consultant_id = $this->encounter->patCurrentAdmission->consultant_id;
            }
        } else if ($this->admission_status == 'TR') {
            $this->consultant_id = $this->encounter->patCurrentAdmission->consultant_id;
        }
    }

}
