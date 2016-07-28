<?php
namespace IRISORG\modules\v1\controllers;

use common\models\PatDocuments;
use common\models\PatDocumentTypes;
use common\models\PatPatient;
use common\models\PatScannedDocuments;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PatientscanneddocumentsController extends ActiveController {

    public $modelClass = 'common\models\PatScannedDocuments';

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

    public function actionGetscanneddocument() {
        $get = Yii::$app->getRequest()->get();
        if (!empty($get)) {
            $result = PatScannedDocuments::find()->tenant()->andWhere(['scanned_doc_id' => $get['doc_id']])->one();
            return ['success' => true, 'result' => $result];
        }
    }

    //Delete Function
    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('scanned_doc_id');
        if ($id) {
            $model = PatScannedDocuments::find()->where(['scanned_doc_id' => $id])->one();
            $model->delete();
            return ['success' => true];
        }
    }

    //Index Function
    public function actionGetscanneddocuments() {
        $get = Yii::$app->getRequest()->get();
        
        if (!empty($get)) {
            $patient = PatPatient::getPatientByGuid($get['patient_id']);
            $result = [];
            $data = PatScannedDocuments::find()->tenant()->andWhere(['patient_id' => $patient->patient_id])->groupBy('encounter_id')->orderBy(['encounter_id' => SORT_DESC])->all();
            foreach ($data as $key => $value) {
                $details = PatScannedDocuments::find()->tenant()->andWhere(['patient_id' => $patient->patient_id, 'encounter_id' => $value->encounter_id])->orderBy(['scanned_doc_id' => SORT_DESC])->all();
                $result[$key] = ['data' => $value, 'all' => $details];
            }
            return ['success' => true, 'result' => $result];
        }
    }

    //Save Create / Update
    public function actionSavedocument() {
        $post = Yii::$app->getRequest()->post();
        
        $patient      = PatPatient::getPatientByGuid($post['patient_id']);
        $patient_id   = $patient->patient_id;
        $encounter_id = $post['encounter_id'];
        
        if ( !empty( $_FILES ) ) {
            $tempPath = $_FILES[ 'file' ][ 'tmp_name' ];
            $filename = time()."_".$_FILES[ 'file' ][ 'name' ];
            $filepath = \Yii::$app->request->BaseUrl.'/uploads/'.$filename;
            $uploadPath = \Yii::$app->basePath.'/uploads/'.$filename;
            move_uploaded_file( $tempPath, $uploadPath );

//            $answer = array( 'answer' => 'File transfer completed' );
//            $json = json_encode( $answer );
//            echo $json;
            
                $patient_scndocument = new PatScannedDocuments;
                $attr = [
                    'patient_id' => $patient->patient_id,
                    'encounter_id' => $post['encounter_id'],
                    'file_name' => $filename,
                    'file_path' => $filepath,
                    'status'    => '1',
                ];
                $attr = array_merge($post, $attr);
                $patient_scndocument->attributes = $attr;

                if ($patient_scndocument->validate()) {           
                    $patient_scndocument->save(false);
                    return ['success' => true, 'message' => "Upload success!!!"];
                } else {
                    return ['success' => false, 'message' => Html::errorSummary([$patient_scndocument])];
                }
        }else{
            return ['success' => false, 'message' => "Please upload Files."];
        }
        
        
    }

}
