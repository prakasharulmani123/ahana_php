<?php

use common\models\CoTenant;
use common\models\RActiveRecord;
use yii\db\ActiveQuery;

namespace common\models;

/**
 * This is the model class for table "pat_document_types".
 *
 * @property integer $doc_type_id
 * @property integer $tenant_id
 * @property string $doc_type
 * @property string $document_xml
 * @property string $document_xslt
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoTenant $tenant
 */
class PatDocumentTypes extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pat_document_types';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['doc_type', 'document_xml', 'document_xslt'], 'required'],
            [['tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['document_xml', 'document_xslt', 'status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['doc_type'], 'string', 'max' => 50]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'doc_type_id' => 'Doc Type ID',
            'tenant_id' => 'Tenant ID',
            'doc_type' => 'Doc Type',
            'document_xml' => 'Document Xml',
            'document_xslt' => 'Document Xslt',
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
}
