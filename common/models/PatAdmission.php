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

    public $vacantOldRoomId = null;
    public $isSwapping = false;
    public $swapEncounterId;
    public $swapFloorId;
    public $swapWardId;
    public $swapPatientId;
    public $swapRoom;
    public $swapRoomId;
    public $swapRoomTypeId;

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
            [['consultant_id', 'floor_id', 'ward_id', 'room_id', 'room_type_id', 'status_date'], 'required'],
            [['swapPatientId', 'swapRoomId', 'swapRoomTypeId'], 'required', 'on' => 'swap'],
            [['tenant_id', 'patient_id', 'encounter_id', 'consultant_id', 'floor_id', 'ward_id', 'room_id', 'room_type_id', 'created_by', 'modified_by'], 'integer'],
            [['status_date', 'created_at', 'modified_at', 'deleted_at', 'status_date', 'admission_status'], 'safe'],
            [['status'], 'string'],
            ['admission_status', 'validateAdmissionStatus'],
            ['status_date', 'validateStatusDate'],
        ];
    }

    public function validateAdmissionStatus($attribute, $params) {
        $current_admission = $this->encounter->patCurrentAdmission;

        if ($this->admission_status == 'TR' && !$this->isSwapping) {
            if ($current_admission->room_id == $this->room_id && $current_admission->room_type_id == $this->room_type_id) {
                $this->addError($attribute, "Room can't be same. Change the Room");
            }
        } else if ($this->admission_status == 'TD') {
            if ($current_admission->consultant_id == $this->consultant_id) {
                $this->addError($attribute, "Consultant can't be same. Change the Consultant");
            }
        }
    }

    public function validateStatusDate($attribute, $params) {
        if ($this->isNewRecord) {
            if (!empty($this->admission_status)) {
                if ($this->admission_status != 'A') {
                    $current_admission = $this->encounter->patCurrentAdmission;
                    if ($current_admission->status_date > $this->status_date)
                        $this->addError($attribute, "Date must be greater than {$current_admission->status_date}");
                }
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
            'swapPatientId' => 'Patient',
            'swapRoomId' => 'Room',
            'swapRoomTypeId' => 'Room Type'
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
        if (!empty($this->status_date))
            $this->status_date = date('Y-m-d H:i:s', strtotime($this->status_date));

        if ($insert) {
            $this->setCurrentData();

            //Set Old room status to vacant
            if ($this->admission_status == 'TR' && !$this->isSwapping) {
                $this->vacantOldRoomId = $this->encounter->patCurrentAdmission->room_id;
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
            //Close Encounter when Discharge
            if ($this->admission_status == 'D') {
                $this->encounter->status = '0';
                $this->encounter->save(false);
            }

            //Change Old room status to vacant if Room Transfer
            if (!is_null($this->vacantOldRoomId)) {
                $room = CoRoom::find()->where(['room_id' => $this->vacantOldRoomId])->one();
                $room->occupied_status = 0;
                $room->save(false);
                $this->vacantOldRoomId = null;
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

    public function fields() {
        $extend = [
            'room' => function ($model) {
                return (isset($model->room) ? $model->room : '-');
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

}
