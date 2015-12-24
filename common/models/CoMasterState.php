<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "co_master_state".
 *
 * @property integer $state_id
 * @property integer $country_id
 * @property string $state_name
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoMasterCity[] $coMasterCities
 * @property CoMasterCountry $country
 */
class CoMasterState extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_master_state';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['country_id', 'state_name', 'created_by'], 'required'],
            [['country_id', 'created_by', 'modified_by'], 'integer'],
            [['status'], 'string'],
            [['created_at', 'modified_at'], 'safe'],
            [['state_name'], 'string', 'max' => 50]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'state_id' => 'State ID',
            'country_id' => 'Country ID',
            'state_name' => 'State Name',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCoMasterCities()
    {
        return $this->hasMany(CoMasterCity::className(), ['state_id' => 'state_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCountry()
    {
        return $this->hasOne(CoMasterCountry::className(), ['country_id' => 'country_id']);
    }
}
