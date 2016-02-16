<?php

namespace common\models;

use yii\db\ActiveQuery;
use yii\helpers\ArrayHelper;

/**
 * This is the model class for table "co_country".
 *
 * @property integer $country_id
 * @property integer $tenant_id
 * @property string $country_name
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoState[] $coStates
 */
class CoCountry extends GActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_country';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['country_name', 'created_by'], 'required'],
            [['status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['country_name'], 'string', 'max' => 50],
            [['country_name', 'tenant_id', 'deleted_at'], 'unique', 'targetAttribute' => ['country_name', 'tenant_id', 'deleted_at'], 'message' => 'The combination of Tenant ID, Country Name and Deleted At has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'country_id' => 'Country ID',
            'tenant_id' => 'Tenant ID',
            'country_name' => 'Country Name',
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
    public function getCoStates()
    {
        return $this->hasMany(CoState::className(), ['country_id' => 'country_id']);
    }
    
    public static function getCountrylist() {
        return ArrayHelper::map(self::find()->all(), 'country_id', 'country_name');
    }
}
