<?php

namespace common\models;

use yii\db\ActiveQuery;
use yii\db\ActiveRecord;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "co_master_country".
 *
 * @property integer $country_id
 * @property string $country_name
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 *
 * @property CoMasterState[] $coMasterStates
 */
class CoMasterCountry extends ActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_master_country';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['country_name', 'created_by'], 'required'],
            [['status'], 'string'],
            [['created_by', 'modified_by'], 'integer'],
            [['created_at', 'modified_at'], 'safe'],
            [['country_name'], 'string', 'max' => 50],
            [['country_name'], 'unique']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'country_id' => 'Country ID',
            'country_name' => 'Country Name',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getCoMasterStates() {
        return $this->hasMany(CoMasterState::className(), ['country_id' => 'country_id']);
    }

    public static function getCountrylist() {
        return ArrayHelper::map(self::find()->all(), 'country_id', 'country_name');
    }
}
