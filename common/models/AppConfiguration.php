<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "app_configuration".
 *
 * @property integer $config_id
 * @property integer $tenant_id
 * @property string $key
 * @property string $value
 *
 * @property CoTenant $tenant
 */
class AppConfiguration extends \common\models\RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'app_configuration';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'key', 'value'], 'required'],
            [['tenant_id'], 'integer'],
            [['key', 'value'], 'string']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'config_id' => 'Config ID',
            'tenant_id' => 'Tenant ID',
            'key' => 'Key',
            'value' => 'Value',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }
}
