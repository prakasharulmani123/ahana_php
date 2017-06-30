<?php

namespace common\models;

use common\models\query\PhaHsnQuery;
use yii\db\ActiveQuery;
use common\models\CoTenant;
use common\models\RActiveRecord;

/**
 * This is the model class for table "pha_hsn".
 *
 * @property integer $hsn_id
 * @property integer $tenant_id
 * @property integer $hsn_no
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 */
class PhaHsn extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pha_hsn';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
                [['hsn_no'], 'required'],
                [['tenant_id', 'hsn_no', 'created_by', 'modified_by'], 'integer'],
                [['status'], 'string'],
                [['created_at', 'modified_at', 'deleted_at'], 'safe'],
                [['hsn_no'], 'unique', 'targetAttribute' => ['tenant_id', 'hsn_no', 'deleted_at'], 'message' => 'The combination of Tenant ID, Hsn No and Deleted At has already been taken.'],
                //[['tenant_id', 'hsn_no', 'deleted_at'], 'exist', 'skipOnError' => true, 'targetClass' => CoTenant::className(), 'targetAttribute' => ['tenant_id' => 'tenant_id', 'hsn_no' => '', 'deleted_at' => '']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'hsn_id' => 'Hsn ID',
            'tenant_id' => 'Tenant ID',
            'hsn_no' => 'Hsn No',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
        ];
    }

    public static function find() {
        return new PhaHsnQuery(get_called_class());
    }

    public static function getHsnCodeList($status = '1', $deleted = false) {
        if (!$deleted)
            $list = self::find()->status($status)->active()->all();
        else
            $list = self::find()->deleted()->all();

        return $list;
    }

}
