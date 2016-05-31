<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatDocuments;
use common\models\PatDocumentTypes;
use common\models\PatPatient;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PatientdocumentsController extends ActiveController {

    public $modelClass = 'common\models\PatDocuments';

    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => QueryParamAuth::className()
        ];
        $behaviors['contentNegotiator'] = [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
            ],
        ];

        return $behaviors;
    }

    public function actions() {
        $actions = parent::actions();
        $actions['index']['prepareDataProvider'] = [$this, 'prepareDataProvider'];

        return $actions;
    }

    public function prepareDataProvider() {
        /* @var $modelClass BaseActiveRecord */
        $modelClass = $this->modelClass;

        return new ActiveDataProvider([
            'query' => $modelClass::find()->tenant()->active()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }

    public function actionGetdocumenttype() {
        $get = Yii::$app->getRequest()->get();
        if (!empty($get)) {
            $result = PatDocumentTypes::getDocumentType($get['doc_type']);
            return ['success' => true, 'result' => $result];
        }
    }

    public function actionGetdocument() {
        $get = Yii::$app->getRequest()->get();
        if (!empty($get)) {
            $result = PatDocuments::find()->tenant()->andWhere(['doc_id' => $get['doc_id']])->one();
            return ['success' => true, 'result' => $result];
        }
    }

    public function actionSavedocument() {
        $post = Yii::$app->getRequest()->post();

        $patient = PatPatient::getPatientByGuid($post['patient_id']);

        $case_history_xml = PatDocumentTypes::getDocumentType('CH');
        $xml = $case_history_xml->document_xml;

        $xmlLoad = simplexml_load_string($xml);
        $postKeys = array_keys($post);

        foreach ($xmlLoad->children() as $x) {
            foreach ($post as $key => $value) {
                if ($key == $x->attributes()) {
                    $x->value = $value;
                }
            }
        }

        $xml = $xmlLoad->asXML();

        $patient_document = new PatDocuments;
        $patient_document->attributes = [
            'patient_id' => $patient->patient_id,
            'encounter_id' => $post['encounter_id'],
            'doc_type_id' => $case_history_xml->doc_type_id,
            'document_xml' => $xml,
        ];
        $patient_document->save(false);
        return ['success' => true, 'xml' => $xml];
    }

}
