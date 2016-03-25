<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "pat_billing_recurring".
 *
 * @property integer $recurr_id
 * @property integer $tenant_id
 * @property integer $encounter_id
 * @property integer $patient_id
 * @property integer $room_type_id
 * @property string $room_type
 * @property integer $charge_item_id
 * @property string $charge_item
 * @property string $from_date
 * @property string $to_date
 * @property integer $duration
 * @property string $charge_amount
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoRoomChargeItem $chargeItem
 * @property PatEncounter $encounter
 * @property PatPatient $patient
 * @property CoRoomType $roomType
 * @property CoTenant $tenant
 */
class PatBillingRecurring extends \common\models\RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pat_billing_recurring';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'encounter_id', 'patient_id', 'room_type_id', 'room_type', 'charge_item_id', 'charge_item', 'from_date', 'created_by'], 'required'],
            [['tenant_id', 'encounter_id', 'patient_id', 'room_type_id', 'charge_item_id', 'duration', 'created_by', 'modified_by'], 'integer'],
            [['from_date', 'to_date', 'created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['charge_amount'], 'number'],
            [['status'], 'string'],
            [['room_type', 'charge_item'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'recurr_id' => 'Recurr ID',
            'tenant_id' => 'Tenant ID',
            'encounter_id' => 'Encounter ID',
            'patient_id' => 'Patient ID',
            'room_type_id' => 'Room Type ID',
            'room_type' => 'Room Type',
            'charge_item_id' => 'Charge Item ID',
            'charge_item' => 'Charge Item',
            'from_date' => 'From Date',
            'to_date' => 'To Date',
            'duration' => 'Duration',
            'charge_amount' => 'Charge Amount',
            'status' => 'Status',
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
    public function getChargeItem()
    {
        return $this->hasOne(CoRoomChargeItem::className(), ['charge_item_id' => 'charge_item_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getEncounter()
    {
        return $this->hasOne(PatEncounter::className(), ['encounter_id' => 'encounter_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getPatient()
    {
        return $this->hasOne(PatPatient::className(), ['patient_id' => 'patient_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getRoomType()
    {
        return $this->hasOne(CoRoomType::className(), ['room_type_id' => 'room_type_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }
}
