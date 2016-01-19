<?php

namespace common\models;

use yii\db\ActiveQuery;
use common\models\query\CoDoctorScheduleQuery;

/**
 * This is the model class for table "co_doctor_schedule".
 *
 * @property integer $schedule_id
 * @property integer $tenant_id
 * @property integer $user_id
 * @property string $schedule_day
 * @property string $schedule_time_in
 * @property string $schedule_time_out
 * @property string $created_at
 * @property integer $created_by
 * @property string $modified_at
 * @property integer $modified_by
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 * @property CoUser $user
 */
class CoDoctorSchedule extends RActiveRecord
{
    public $time_in;
    public $time_out;
    public $custom_day;
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_doctor_schedule';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'user_id', 'custom_day', 'time_in', 'time_out'], 'required'],
            [['tenant_id', 'user_id', 'created_by', 'modified_by'], 'integer'],
            [['schedule_day'], 'string'],
            [['schedule_time_in', 'schedule_time_out', 'created_at', 'modified_at', 'deleted_at', 'time_in', 'time_out', 'custom_day'], 'safe']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'schedule_id' => 'Schedule ID',
            'tenant_id' => 'Tenant',
            'user_id' => 'Doctor',
            'schedule_day' => 'Schedule Day',
            'schedule_time_in' => 'Schedule Time In',
            'schedule_time_out' => 'Schedule Time Out',
            'created_at' => 'Created At',
            'created_by' => 'Created By',
            'modified_at' => 'Modified At',
            'modified_by' => 'Modified By',
            'deleted_at' => 'Deleted At',
            'time_in' => 'Schedule Time In',
            'time_out' => 'Schedule Time Out',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(CoUser::className(), ['user_id' => 'user_id']);
    }

    public static function find() {
        return new CoDoctorScheduleQuery(get_called_class());
    }
}
