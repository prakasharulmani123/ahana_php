<?php

namespace common\models;

use common\models\query\PhaVatQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pha_vat".
 *
 * @property integer $vat_id
 * @property integer $tenant_id
 * @property string $vat
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 */
class PhaVat extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pha_vat';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['vat'], 'required'],
            [['tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['vat'], 'number'],
            [['status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['tenant_id', 'vat', 'deleted_at'], 'unique', 'targetAttribute' => ['tenant_id', 'vat', 'deleted_at'], 'message' => 'The combination of Tenant ID, Vat and Deleted At has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'vat_id' => 'Vat ID',
            'tenant_id' => 'Tenant ID',
            'vat' => 'Vat',
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
        return new PhaVatQuery(get_called_class());
    }

}
