<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoPatient;
use common\models\PatPatient;
use common\models\PatPatientAddress;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * PatientController implements the CRUD actions for CoTenant model.
 */
class PatientController extends ActiveController {

    public $modelClass = 'common\models\PatPatient';

    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className()
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

    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('id');
        if ($id) {
            $model = CoPatient::find()->where(['patient_id' => $id])->one();
            $model->remove();

            //Remove all related records
            foreach ($model->room as $room) {
                $room->remove();
            }
            //
            return ['success' => true];
        }
    }

    public function actionRegistration() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post['PatPatient']) || !empty($post['PatPatientAddress'])) {
            $model = new PatPatient();
            $addr_model = new PatPatientAddress();

            if (isset($post['PatPatient'])) {
                $model->attributes = $post['PatPatient'];
                if (isset($post['PatPatient']['patient_dob']) && isset($post['PatPatient']['patient_age']) && $post['PatPatient']['patient_dob'] == '' && $post['PatPatient']['patient_age']) {
                    $newdate = strtotime("-{$post['PatPatient']['patient_age']} year", strtotime(date('Y-m-d')));
                    $model->patient_dob = date('Y-m-d', $newdate);
                }
            }

            if (isset($post['PatPatientAddress'])) {
                $addr_model->attributes = $post['PatPatientAddress'];
            }

            $valid = $model->validate();
            $valid = $addr_model->validate() && $valid;

            if ($valid) {
                $model->save(false);

                $addr_model->patient_id = $model->patient_id;
                $addr_model->save(false);

                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $addr_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }
    
    public function actionSearch() {
        $post = Yii::$app->getRequest()->post();
        $patients = [];
        $limit = 10;
        
        if(isset($post['search']) && !empty($post['search'])){
            $lists = PatPatient::find()->tenant()->active()->andWhere("patient_firstname like :search")->addParams([':search'=> "%{$post['search']}%"])->limit($limit)->all();
            
            foreach ($lists as $key => $patient) {
                $patients[$key]['Patient'] = $patient;
                $patients[$key]['PatientAddress'] = $patient->patPatientAddress;
            }
        }
        return ['patients' => $patients];
    }
    
    public function actionGetagefromdate() {
        $post = Yii::$app->request->post();
        $age = '';
        if (isset($post['date'])) {
            $age = PatPatient::getPatientAge($post['date']);
        }
        
        return ['age' => $age];
    }
    
    public function actionGetdatefromage() {
        $post = Yii::$app->request->post();
        $dob = '';
        if (isset($post['age'])) {
            $dob = PatPatient::getPatientBirthdate($post['age']);
        }
        
        return ['dob' => $dob];
    }

    public function actionGetpatientaddress() {
        $get = Yii::$app->getRequest()->get();
        return ['address' => PatPatientAddress::find()->where(['patient_id' => $get['id']])->one()];
    }
}
