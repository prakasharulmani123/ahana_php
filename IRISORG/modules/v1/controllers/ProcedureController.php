<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoUser;
use common\models\PatProcedure;
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
class ProcedureController extends ActiveController {

    public $modelClass = 'common\models\PatProcedure';

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
            $model = PatProcedure::find()->where(['proc_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionGetprocedurebyencounter() {
        $enc_id = Yii::$app->getRequest()->get('enc_id');

        if (!empty($enc_id)) {
            $model = PatProcedure::find()
                    ->tenant()
                    ->status()
                    ->active()
                    ->andWhere(['encounter_id' => $enc_id])
                    ->orderBy([
                        'proc_date' => SORT_DESC,
                    ])
                    ->all();
        }

        return $model;
    }


    public function actionGetconsultantsbyprocedure() {
        $proc_id = Yii::$app->getRequest()->get('proc_id');

        $consultants = [];
        if (!empty($proc_id)) {
            $model = PatProcedure::find()->where(['proc_id' => $proc_id])->one();
            
            if(!empty($model->proc_consultant_ids)){
                foreach ($model->proc_consultant_ids as $key => $id) {
                    $consultants[$key] = CoUser::find()->where(['user_id' => $id])->one();
                }
            }
            
        }

        return $consultants;
    }

}
