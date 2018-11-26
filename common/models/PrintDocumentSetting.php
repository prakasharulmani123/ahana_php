<?php

namespace common\models;

use common\models\query\PrintDocumentSettingQuery;
use yii\db\ActiveQuery;
use Yii;

/**
 * This is the model class for table "print_document_setting".
 *
 * @property integer $document_setting_id
 * @property integer $print_document_id
 * @property integer $tenant_id
 * @property string $value
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 */
class PrintDocumentSetting extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'print_document_setting';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['print_document_id', 'tenant_id'], 'required'],
            [['print_document_id', 'tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['value', 'status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'document_setting_id' => 'Document Setting ID',
            'print_document_id' => 'Print Document ID',
            'tenant_id' => 'Tenant ID',
            'value' => 'Value',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
        ];
    }
    
    public static function find() {
        return new PrintDocumentSettingQuery(get_called_class());
    }
    
    public static function getPrintOption($code) {
        $result = self::find()->tenant()->andWhere(['print_document_id' => $code])->one();
        return $result;
    }
    
    public static function getPrintConfigurations() {
        return array(
            'sale_bill_print' => [
                'print_document_id' => '1',
                'value' => '{"header":"1","footer":"1","logo":"1","dl_nos":"1","dl_no_text":"MDU/5454/20","gst_no":"0","gst_no_text":"33AAQFA999IEIZI"}',
            ],
        );
    }
}
