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
    //Collapse menu
    public $treatment_history = false;
    public $family_history = false;
    public $personal_history = false;
    public $mental_status_examination = false;
    //Treatment History Mandatory Fields
    public $rb_pb_treatmenthistory;
    //Family History Mandatory Fields
    public $RBtypeoffamily;
    public $RBtypeofmarriage;
    //Personal History Mandatory Fields
    public $RBpbprenatal;
    public $RBpbperinatal;
    public $RBpbperinatal2;
    public $RBpbdevelopmentmilestone;
    public $RBpbparentallack;
    public $RBpbbreakstudy;
    public $RBpbfrechangeschool;
    public $RBpbacademicperfor;
    public $RBpbteacherrelation;
    public $RBpbstudentrelation;
    public $RBpbworkrecord;
    public $RBfreqchangeofjob;
    public $txtDurationofMarriage;
    public $txtAgeofMarriage;
    public $RBmaritalsexualsatisfac;
    public $RBknowledgeofspouse;
    public $CBattitudetoself;
    //Mental Status Examination Mandatory Fields
    public $RBAppearance;
    public $RBlevelofgrooming;
    public $RBlevelofcleanliness;
    public $RBeyetoeyecontact;
    public $RBrapport;
    public $CBPsychomotorActivity;
    public $RBReactiontime;
    public $RBtempo;
    public $RBvolume;
    public $RBtone;
    public $CBstreamform;
    public $RBQuality;
    public $RBrangeandreactivity;
    public $affect;
    public $RBAttension;
    public $RBConcentration;
    public $RBOrientation;
    public $memory;
    public $RBImmediate;
    public $RBRecent;
    public $RBRemote;
    public $RBIntelligence;
    public $RBAbstraction;
    public $judgement;
    public $RBPersonal;
    public $RBSocial;
    public $RBTest;
    public $DDLInsight;
    public $RBKnowledgeaboutmentalillness;
    public $RBAttitudeillness;

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
            [['rb_pb_treatmenthistory'], 'required', 'when' => function($model) {
            return $model->treatment_history == 'true';
        }],
            [['RBtypeoffamily', 'RBtypeofmarriage'], 'required', 'when' => function($model) {
            return $model->family_history == 'true';
        }],
            [['RBpbprenatal', 'RBpbperinatal', 'RBpbperinatal2', 'RBpbdevelopmentmilestone', 'RBpbparentallack', 'RBpbbreakstudy', 'RBpbfrechangeschool', 'RBpbacademicperfor', 'RBpbteacherrelation', 'RBpbstudentrelation', 'RBpbworkrecord', 'RBfreqchangeofjob', 'txtDurationofMarriage', 'txtAgeofMarriage', 'RBmaritalsexualsatisfac', 'RBknowledgeofspouse', 'CBattitudetoself'], 'required', 'when' => function($model) {
            return $model->personal_history == 'true';
        }],
            [['RBAppearance', 'RBlevelofgrooming', 'RBlevelofcleanliness', 'RBeyetoeyecontact', 'RBrapport', 'CBPsychomotorActivity', 'RBReactiontime', 'RBtempo', 'RBvolume', 'RBtone', 'CBstreamform', 'RBQuality', 'RBrangeandreactivity', 'RBAttension', 'RBConcentration', 'RBOrientation', 'RBImmediate', 'RBRecent', 'RBRemote', 'RBIntelligence', 'RBAbstraction', 'RBPersonal', 'RBSocial', 'RBTest', 'DDLInsight', 'RBKnowledgeaboutmentalillness', 'RBAttitudeillness'], 'required', 'when' => function($model) {
            return $model->mental_status_examination == 'true';
        }],
            [['created_at', 'modified_at', 'deleted_at', 'treatment_history', 'family_history', 'personal_history', 'mental_status_examination', 'rb_pb_treatmenthistory', 'RBtypeoffamily', 'RBtypeofmarriage', 'RBpbprenatal', 'RBpbperinatal', 'RBpbperinatal2', 'RBpbdevelopmentmilestone', 'RBpbparentallack', 'RBpbbreakstudy', 'RBpbfrechangeschool', 'RBpbacademicperfor', 'RBpbteacherrelation', 'RBpbstudentrelation', 'RBpbworkrecord', 'RBfreqchangeofjob', 'txtDurationofMarriage', 'txtAgeofMarriage', 'RBmaritalsexualsatisfac', 'RBknowledgeofspouse', 'CBattitudetoself', 'RBAppearance', 'RBlevelofgrooming', 'RBlevelofcleanliness', 'RBeyetoeyecontact', 'RBrapport', 'CBPsychomotorActivity', 'RBReactiontime', 'RBtempo', 'RBvolume', 'RBtone', 'CBstreamform', 'RBQuality', 'RBrangeandreactivity', 'affect', 'RBAttension', 'RBConcentration', 'RBOrientation', 'memory', 'RBImmediate', 'RBRecent', 'RBRemote', 'RBIntelligence', 'RBAbstraction', 'judgement', 'RBPersonal', 'RBSocial', 'RBTest', 'DDLInsight', 'RBKnowledgeaboutmentalillness', 'RBAttitudeillness'], 'safe'],
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
            'rb_pb_treatmenthistory' => 'Medication Compliance',
            'RBtypeoffamily' => 'Type of Family',
            'RBtypeofmarriage' => 'Type of Marriage',
            'RBpbprenatal' => 'Prenatal',
            'RBpbperinatal' => 'Perinatal',
            'RBpbperinatal2' => 'Perinatal2',
            'RBpbdevelopmentmilestone' => 'Developmental milestones',
            'RBpbparentallack' => 'Parental Lack',
            'RBpbbreakstudy' => 'Break in Studies',
            'RBpbfrechangeschool' => 'Frequent change of school',
            'RBpbacademicperfor' => 'Academic performance',
            'RBpbteacherrelation' => 'Relationship with teachers',
            'RBpbstudentrelation' => 'Relationship with students',
            'RBpbworkrecord' => 'Work Record',
            'RBfreqchangeofjob' => 'Frequent change of jobs',
            'txtDurationofMarriage' => 'Duration of Marriage',
            'txtAgeofMarriage' => 'Age of Marriage',
            'RBmaritalsexualsatisfac' => 'Marital and Sexual satisfaction',
            'RBknowledgeofspouse' => 'Knowledge of spouse about patient\'s illness prior to marriage',
            'CBattitudetoself' => 'Attitude to self',
            'RBAppearance' => 'Appearance',
            'RBlevelofgrooming' => 'Level of grooming',
            'RBlevelofcleanliness' => 'Level of Cleanliness',
            'RBeyetoeyecontact' => 'Eye to Eye contacat',
            'RBrapport' => 'Rapport',
            'CBPsychomotorActivity' => 'Psychomotor Activity',
            'RBReactiontime' => 'Reaction time',
            'RBtempo' => 'Tempo',
            'RBvolume' => 'Volume',
            'RBtone' => 'Tone',
            'CBstreamform' => 'Stream & Form',
            'RBQuality' => 'Quality',
            'RBrangeandreactivity' => 'Range and reactivity',
            'RBAttension' => 'Attension',
            'RBConcentration' => 'Concentration',
            'RBOrientation' => 'Orientation',
            'RBImmediate' => 'Immediate',
            'RBRecent' => 'Recent',
            'RBRemote' => 'Remote',
            'RBIntelligence' => 'Intelligence',
            'RBAbstraction' => 'Abstraction',
            'RBPersonal' => 'Personal',
            'RBSocial' => 'Social',
            'RBTest' => 'Test',
            'DDLInsight' => 'Insight',
            'RBKnowledgeaboutmentalillness' => 'Knowledge about mental illness',
            'RBAttitudeillness' => 'Attitude towards illness & treatment',
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
