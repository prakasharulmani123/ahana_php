<?php

namespace common\models;

use common\models\query\PhaDrugClassQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pha_drug_class".
 *
 * @property integer $drug_id
 * @property integer $tenant_id
 * @property string $drug_name
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 */
class PhaDrugClass extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pha_drug_class';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['drug_name'], 'required'],
            [['tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['drug_name'], 'string', 'max' => 255],
            [['tenant_id', 'drug_name', 'deleted_at'], 'unique', 'targetAttribute' => ['tenant_id', 'drug_name', 'deleted_at'], 'message' => 'The combination of Tenant ID, Drug Name and Deleted At has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'drug_id' => 'Drug ID',
            'tenant_id' => 'Tenant ID',
            'drug_name' => 'Drug Name',
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
        return new PhaDrugClassQuery(get_called_class());
    }
}
