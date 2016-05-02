<?php

namespace common\models;

use common\models\query\AppConfigurationQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "app_configuration".
 *
 * @property integer $config_id
 * @property integer $tenant_id
 * @property string $code
 * @property string $key
 * @property string $value
 *
 * @property CoTenant $tenant
 */
class AppConfiguration extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'app_configuration';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['value'], 'required'],
            [['tenant_id'], 'integer'],
            [['key', 'value'], 'string']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'config_id' => 'Config ID',
            'tenant_id' => 'Tenant ID',
            'key' => 'Key',
            'value' => 'Value',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    //Basic configuration for the branches
    public static function getConfigurations() {
        return array(
            'ROOM_CHARGE_CONFIG' => '12',
            'ELAPSED_TIME' => '1'
        );
    }
    
    public static function find() {
        return new AppConfigurationQuery(get_called_class());
    }

}
