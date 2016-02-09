<?php

namespace common\models;

use common\models\query\PhaProductDescriptionQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pha_product_description".
 *
 * @property integer $description_id
 * @property integer $tenant_id
 * @property string $description_name
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 */
class PhaProductDescription extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pha_product_description';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['description_name'], 'required'],
            [['tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['description_name'], 'string', 'max' => 255],
            [['tenant_id', 'description_name', 'deleted_at'], 'unique', 'targetAttribute' => ['tenant_id', 'description_name', 'deleted_at'], 'message' => 'The combination of Tenant ID, Description Name and Deleted At has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'description_id' => 'Description ID',
            'tenant_id' => 'Tenant ID',
            'description_name' => 'Description Name',
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
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function find() {
        return new PhaProductDescriptionQuery(get_called_class());
    }
}
