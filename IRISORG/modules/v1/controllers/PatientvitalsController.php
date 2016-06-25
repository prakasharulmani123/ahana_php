<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoUser;
use common\models\PatPatient;
use common\models\PatVitals;
use common\models\PatVitalsUsers;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\db\Expression;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PatientvitalsController extends ActiveController {

    public $modelClass = 'common\models\PatVitals';

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

    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('id');
        if ($id) {
            $model = PatVitals::find()->where(['vital_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionGetpatientvitals(){
        $get = Yii::$app->getRequest()->get();
        $user_id = Yii::$app->user->identity->user->user_id;
        
        if(!empty($get)){
            $patient = PatPatient::getPatientByGuid($get['patient_id']);
            
            $condition = [
                'patient_id' => $patient->patient_id,
            ];
            
            if (isset($get['date'])) {
                $condition = [
                    'patient_id' => $patient->patient_id,
                    'DATE(created_at)' => $get['date'],
                ];
            }
            
            $model = PatVitals::find()
                    ->tenant()
                    ->active()
                    ->andWhere($condition)
                    ->orderBy(['created_at' => SORT_DESC])
                    ->all();
            
            $uservitals = PatVitalsUsers::find()
                    ->tenant()
                    ->andWhere(['user_id' => $user_id, 'seen' => '0', 'patient_id' => $patient->patient_id])
                    ->all();
            
            return ['success' => true, 'result' => $model, 'uservitals' => $uservitals];
        }
    }
    
    public function actionAssignvitals() {
        $post = Yii::$app->request->post();
        $user_id = Yii::$app->user->identity->user->user_id;
        $tenant_id = Yii::$app->user->identity->user->tenant_id;

        $user = CoUser::find()->where(['user_id' => $user_id])->one();
        $patient = PatPatient::getPatientByGuid($post['patient_guid']);
        $vitals = PatVitals::find()->tenant()->andWhere(['patient_id' => $patient->patient_id])->andWhere("created_by != $user_id")->all();
        
        $extraColumns = ['tenant_id' => $tenant_id, 'modified_by' => Yii::$app->user->identity->user_id, 'modified_at' => new Expression('NOW()'), 'patient_id' => $patient->patient_id]; // extra columns to be saved to the many to many table
        $unlink = true; // unlink tags not in the list
        $delete = true; // delete unlinked tags
        $user->linkAll('vitals', $vitals, $extraColumns, $unlink, $delete);
        return ['success' => true];
    }
    
    public function actionSeenvitals() {
        $post = Yii::$app->request->post();
        $user_id = Yii::$app->user->identity->user->user_id;
        $ids = implode(',', $post['ids']);
        
        $patient = PatPatient::getPatientByGuid($post['patient_guid']);
        $vitals = PatVitals::find()->tenant()->active()->andWhere(['patient_id' => $patient->patient_id])->orderBy(['created_at' => SORT_DESC])->all();
        
        PatVitalsUsers::updateAll(['seen' => '1'], "user_id = :user_id AND vital_id IN ($ids) AND patient_id = :patient_id", [
            ':user_id' => $user_id, 
            ':patient_id' => $patient->patient_id
            ]);
        return ['success' => true];
    }
}
