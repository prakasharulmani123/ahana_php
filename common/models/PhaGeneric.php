<?php

namespace common\models;

use common\models\query\PhaGenericQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pha_generic".
 *
 * @property integer $generic_id
 * @property integer $tenant_id
 * @property string $generic_name
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 */
class PhaGeneric extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pha_generic';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['generic_name'], 'required'],
            [['tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['generic_name'], 'string', 'max' => 255],
            [['tenant_id', 'generic_name', 'deleted_at'], 'unique', 'targetAttribute' => ['tenant_id', 'generic_name', 'deleted_at'], 'message' => 'The combination of Tenant ID, Generic Name and Deleted At has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'generic_id' => 'Generic ID',
            'tenant_id' => 'Tenant ID',
            'generic_name' => 'Generic Name',
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
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function find() {
        return new PhaGenericQuery(get_called_class());
    }

    public static function getGenericlist($tenant = null, $status = '1', $deleted = false, $notUsed = false) {
        if (!$deleted) {
            if($notUsed)
                $list = self::find()->tenant($tenant)->status($status)->active()->notUsed()->all();
            else
                $list = self::find()->tenant($tenant)->status($status)->active()->all();
        } else {
            $list = self::find()->tenant($tenant)->deleted()->all();
        }

        return $list;
    }

}
