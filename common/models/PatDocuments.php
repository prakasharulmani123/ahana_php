<?php

use common\models\CoTenant;
use common\models\PatDocumentTypes;
use common\models\PatEncounter;
use common\models\PatPatient;
use common\models\RActiveRecord;
use yii\db\ActiveQuery;

namespace common\models;

/**
 * This is the model class for table "pat_documents".
 *
 * @property integer $doc_id
 * @property integer $tenant_id
 * @property integer $patient_id
 * @property integer $doc_type_id
 * @property integer $encounter_id
 * @property string $document_xml
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatDocumentTypes $docType
 * @property PatEncounter $encounter
 * @property PatPatient $patient
 * @property CoTenant $tenant
 */
class PatDocuments extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pat_documents';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['tenant_id', 'patient_id', 'doc_type_id', 'encounter_id', 'created_by'], 'required'],
            [['tenant_id', 'patient_id', 'doc_type_id', 'encounter_id', 'created_by', 'modified_by'], 'integer'],
            [['document_xml', 'status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'doc_id' => 'Doc ID',
            'tenant_id' => 'Tenant ID',
            'patient_id' => 'Patient ID',
            'doc_type_id' => 'Doc Type ID',
            'encounter_id' => 'Encounter ID',
            'document_xml' => 'Document Xml',
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
    public function getDocType()
    {
        return $this->hasOne(PatDocumentTypes::className(), ['doc_type_id' => 'doc_type_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getEncounter()
    {
        return $this->hasOne(PatEncounter::className(), ['encounter_id' => 'encounter_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatient()
    {
        return $this->hasOne(PatPatient::className(), ['patient_id' => 'patient_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant()
    {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }
}
