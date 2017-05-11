<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoMasterCity;
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
class CityController extends ActiveController {

    public $modelClass = 'common\models\CoMasterCity';

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
            'query' => $modelClass::find()->tenantWithNull()->active()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }
    
    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('id');
        if($id){
            $model = CoMasterCity::find()->where(['city_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }
    
    public function actionGetcities() {
        $requestData = $_REQUEST;

        $modelClass = $this->modelClass;
        $totalData = $modelClass::find()->count();
        $totalFiltered = $totalData;
        
        // Order Records
        if (isset($requestData['order'])) {
            if ($requestData['order'][0]['dir'] == 'asc') {
                $sort_dir = SORT_ASC;
            } elseif ($requestData['order'][0]['dir'] == 'desc') {
                $sort_dir = SORT_DESC;
            }
            $order_array = [$requestData['columns'][$requestData['order'][0]['column']]['data'] => $sort_dir];
        }

        if (!empty($requestData['search']['value'])) {
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;
            $totalFiltered = $modelClass::find()
                    ->andFilterWhere([
                        'OR',
                            ['like', 'city_name', $requestData['search']['value']],
                            ])
                    ->count();

            $cities = $modelClass::find()
                    ->andFilterWhere([
                        'OR',
                            ['like', 'city_name', $requestData['search']['value']],
                            ])
                    ->limit($requestData['length'])
                    ->offset($requestData['start'])
                    ->orderBy($order_array)
                    ->all();
        } else {
            $cities = $modelClass::find()
                    ->limit($requestData['length'])
                    ->offset($requestData['start'])
                    ->orderBy($order_array)
                    ->all();
        }

        $data = array();
        foreach ($cities as $city) {
            $nestedData = array();
            $nestedData['city_id'] = $city->city_id;
            $nestedData['city_name'] = $city->city_name;
            $nestedData['tenant_id'] = $city->tenant_id;
            $nestedData['state_id'] = $city->state_id;
            $nestedData['status'] = $city->status;
            $data[] = $nestedData;
        }

        $json_data = array(
            "draw" => intval($requestData['draw']),
            "recordsTotal" => intval($totalData),
            "recordsFiltered" => intval($totalFiltered),
            "data" => $data   // total data array
        );

        echo json_encode($json_data);
    }
    
}
