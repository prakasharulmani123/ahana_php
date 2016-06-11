<?php

namespace common\models;

use common\models\query\PatDocumentsQuery;
use yii\db\ActiveQuery;

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
class PatDocuments extends RActiveRecord {

    public $name;
    public $age;
    public $gender;
    public $address;
    public $education;
    public $martial_status;
    public $relationship;
    public $primary_care_giver;
    public $information;
    public $total_duration;
    public $mode_of_onset;
    public $course_type;
    public $nature;

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_documents';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['patient_id', 'doc_type_id', 'encounter_id'], 'required'],
            [['name', 'age', 'gender', 'address', 'education', 'martial_status', 'relationship'], 'required', 'on' => 'CH'],
            [['information', 'total_duration', 'mode_of_onset', 'course_type', 'nature'], 'required', 'on' => 'CH'],
            [['tenant_id', 'patient_id', 'doc_type_id', 'encounter_id', 'created_by', 'modified_by'], 'integer'],
            [['document_xml', 'status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
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
    public function getDocType() {
        return $this->hasOne(PatDocumentTypes::className(), ['doc_type_id' => 'doc_type_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getEncounter() {
        return $this->hasOne(PatEncounter::className(), ['encounter_id' => 'encounter_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getPatient() {
        return $this->hasOne(PatPatient::className(), ['patient_id' => 'patient_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public static function find() {
        return new PatDocumentsQuery(get_called_class());
    }

    public function fields() {
        $extend = [
            'document_name' => function ($model) {
                if (isset($model->docType))
                    return $model->docType->doc_type_name;
                else
                    return '-';
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

}
