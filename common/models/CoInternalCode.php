<?php

namespace common\models;

use common\models\query\CoInternalCodeQuery;
use yii\db\ActiveQuery;

/**
 * This is the model class for table "co_internal_code".
 *
 * @property integer $internal_code_id
 * @property integer $tenant_id
 * @property string $code_type
 * @property string $code_prefix
 * @property integer $code
 * @property integer $code_padding
 * @property string $code_suffix
 * @property string $status 
 * @property string $created_at
 * @property integer $created_by
 * @property string $modified_at
 * @property integer $modified_by
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 */
class CoInternalCode extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_internal_code';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['code_prefix', 'code'], 'required'],
            [['tenant_id', 'code', 'code_padding', 'created_by', 'modified_by'], 'integer'],
            [['code_type'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['code_prefix', 'code_suffix'], 'string', 'max' => 10],
            [['tenant_id'], 'unique', 'targetAttribute' => ['tenant_id', 'code_type'], 'message' => 'The combination of Code Type has already been taken.']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'internal_code_id' => 'Internal Code ID',
            'tenant_id' => 'Tenant ID',
            'code_type' => 'Code Type',
            'code_prefix' => 'Code Prefix',
            'code' => 'Code Start No',
            'code_padding' => 'Code Padding',
            'code_suffix' => 'Code Suffix',
            'status' => 'Status',
            'created_at' => 'Created At',
            'created_by' => 'Created By',
            'modified_at' => 'Modified At',
            'modified_by' => 'Modified By',
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
        return new CoInternalCodeQuery(get_called_class());
    }

    public static function getInternalCode($tenant = null, $status = '1', $deleted = false) {
        if (!$deleted)
            $list = self::find()->tenant($tenant)->status($status)->active()->one();
        else
            $list = self::find()->tenant($tenant)->deleted()->one();

        return $list;
    }

    public static function getCodeTypes() {
        //B-Bill, P-Patient, PU-Purchase, PR- , CS-CaseSheet
        return array('B', 'P', 'PU', 'PR', 'CS');
    }

    public function getFullcode() {
        $prefix = $this->code_prefix;
        $int_code = str_pad($this->code, $this->code_padding, '0', STR_PAD_LEFT);
//        $role_suffix = $this->Gen_Suffix;

        return "{$prefix}{$int_code}";
    }
    
    public static function increaseInternalCode($code_type){
        $code = self::find()->tenant()->codeType($code_type)->one();
        if($code){
            $code->code = $code->code + 1;
            $code->save(false);
        }
    }

}
