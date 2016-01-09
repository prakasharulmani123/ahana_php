<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoFloor;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * FloorController implements the CRUD actions for CoTenant model.
 */
class FloorController extends ActiveController {

    public $modelClass = 'common\models\CoFloor';

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
        if($id){
            $model = CoFloor::find()->where(['floor_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }
    
    public function actionGetfloorlist() {
        $tenant = null;
        $status = '1';
        $deleted = false;
        
        $get = Yii::$app->getRequest()->get();
        
        if(isset($get['tenant']))
            $tenant = $get['tenant'];
        
        if(isset($get['status']))
            $status = strval($get['status']);
        
        if(isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';
        
        $list = array();
        $data = CoFloor::getFloorList($tenant, $status, $deleted);
        foreach ($data as $value => $label) {
            $list[] = array('value' => $value, 'label' => $label);
        }
        return ['floorList' => $list];
    }

}
