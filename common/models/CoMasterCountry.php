<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "co_master_country".
 *
 * @property integer $country_id
 * @property string $country name
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoMasterState[] $coMasterStates
 */
class CoMasterCountry extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_master_country';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['country name', 'created_by'], 'required'],
            [['status'], 'string'],
            [['created_by', 'modified_by'], 'integer'],
            [['created_at', 'modified_at'], 'safe'],
            [['country name'], 'string', 'max' => 50],
            [['country name'], 'unique']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'country_id' => 'Country ID',
            'country name' => 'Country Name',
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
    public function getCoMasterStates()
    {
        return $this->hasMany(CoMasterState::className(), ['country_id' => 'country_id']);
    }
}
