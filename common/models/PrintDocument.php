<?php

namespace app\models;

use common\models\query\PrintDocumentQuery;
use yii\db\ActiveQuery;
use common\models\PActiveRecord;

/**
 * This is the model class for table "print_document".
 *
 * @property integer $print_document_id
 * @property string $document_name
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 */
class PrintDocument extends PActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'print_document';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['status'], 'string'],
            [['created_by', 'modified_by'], 'integer'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['document_name'], 'string', 'max' => 50],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'print_document_id' => 'Print Document ID',
            'document_name' => 'Document Name',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
        ];
    }
}
