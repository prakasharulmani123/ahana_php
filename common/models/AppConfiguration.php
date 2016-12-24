<?php

namespace common\models;

use common\models\query\AppConfigurationQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "app_configuration".
 *
 * @property integer $config_id
 * @property integer $tenant_id
 * @property string $key
 * @property string $value
 * @property string $notes
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
            [['key', 'value', 'notes'], 'string']
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
//            'ROOM_CHARGE_CONFIG' => '12',
            'ELAPSED_TIME' => [
                'code' => 'ET',
                'value' => '3600',
                'notes' => 'seconds',
            ],
            'SHARE_ENCOUNTER' => [
                'code' => 'ENCOUNTER',
                'value' => '1',
                'notes' => 'Share Encounter',
            ],
            'SHARE_NOTES' => [
                'code' => 'NOTES',
                'value' => '1',
                'notes' => 'Share Notes',
            ],
            'SHARE_CONSULTANT' => [
                'code' => 'CONSULTANT',
                'value' => '1',
                'notes' => 'Share Consultant',
            ],
            'SHARE_ALERT' => [
                'code' => 'ALERT',
                'value' => '1',
                'notes' => 'Share Alert',
            ],
            'SHARE_VITALS' => [
                'code' => 'VITALS',
                'value' => '1',
                'notes' => 'Share Vitals',
            ],
            'SHARE_PRESCRIPTION' => [
                'code' => 'PRESCRIPTION',
                'value' => '1',
                'notes' => 'Share Prescription',
            ],
            'SHARE_BILLING' => [
                'code' => 'BILLING',
                'value' => '0',
                'notes' => 'Share Billing',
            ],
            'SHARE_PROCEDURE' => [
                'code' => 'PROCEDURE',
                'value' => '1',
                'notes' => 'Share Procedure',
            ],
            'SHARE_BASIC_DATA' => [
                'code' => 'BASIC',
                'value' => '1',
                'notes' => 'Share Basic Data',
            ],
        );
    }
    
    public static function find() {
        return new AppConfigurationQuery(get_called_class());
    }
    
    public static function getConfigurationByKey($key){
        $result = self::find()->tenant()->active()->andWhere(['key' => $key])->one();
        return $result;
    }

}
