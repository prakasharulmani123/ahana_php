<?php

namespace common\models;

use common\models\query\PhaDrugClassQuery;
use cornernote\linkall\LinkAllBehavior;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "pha_drug_class".
 *
 * @property integer $drug_class_id
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
class PhaDrugClass extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pha_drug_class';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
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
    public function attributeLabels() {
        return [
            'drug_class_id' => 'Drug ID',
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
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function find() {
        return new PhaDrugClassQuery(get_called_class());
    }

    public static function getDruglist($tenant = null, $status = '1', $deleted = false, $notUsed = false) {
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

    public function behaviors() {
        $extend = [
            LinkAllBehavior::className(),
        ];

        $behaviour = array_merge(parent::behaviors(), $extend);
        return $behaviour;
    }

    public function getDrugsGenerics() {
        return $this->hasMany(PhaDrugGeneric::className(), ['drug_class_id' => 'drug_class_id']);
    }

    public function getGenerics() {
        return $this->hasMany(PhaGeneric::className(), ['generic_id' => 'generic_id'])->via('drugsGenerics');
    }

}
