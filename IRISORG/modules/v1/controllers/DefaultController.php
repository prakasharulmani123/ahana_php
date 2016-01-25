<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoMasterCity;
use common\models\CoMasterCountry;
use common\models\CoMasterState;
use common\models\CoRolesResources;
use common\models\CoTenant;
use common\models\CoUsersRoles;
use Yii;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\ArrayHelper;
use yii\web\Controller;
use yii\web\Response;

class DefaultController extends Controller {

    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className(),
            'only' => ['getnavigation'],
        ];
        $behaviors['contentNegotiator'] = [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
            ],
        ];

        return $behaviors;
    }

    public function actionIndex() {
        echo "AAAAAAA";
        exit;
        return $this->render('index');
    }

    public function actionGetCountryList() {
        $list = array();
        $data = CoMasterCountry::getCountrylist();
        foreach ($data as $value => $label) {
            $list[] = array('value' => $value, 'label' => $label);
        }
        return ['countryList' => $list];
    }

    public function actionGetStateList() {
        $list = array();
        $datas = CoMasterState::find()->all();
        foreach ($datas as $data) {
            $list[] = array('value' => $data->state_id, 'label' => $data->state_name, 'countryId' => $data->country_id);
        }
        return ['stateList' => $list];
    }

    public function actionGetCityList() {
        $list = array();
        $datas = CoMasterCity::find()->all();
        foreach ($datas as $data) {
            $list[] = array('value' => $data->city_id, 'label' => $data->city_name, 'stateId' => $data->state_id);
        }
        return ['cityList' => $list];
    }

    public function actionChangeStatus() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $modelName = $post['model'];
            $primaryKey = $post['id'];
            $modelClass = "common\\models\\$modelName";
            $model = $modelClass::findOne($primaryKey);
            $model->status = 1 - $model->status;
            $model->save(false);
            return ['success' => "ok", 'sts' => $model->status];
        }
    }

    public function actionGetTenantList() {
        $list = array();
        $data = CoTenant::getTenantlist();
        foreach ($data as $value => $label) {
            $list[] = array('value' => $value, 'label' => $label);
        }
        return ['tenantList' => $list];
    }

    public function actionError() {
        $exception = Yii::$app->errorHandler->exception;
        if ($exception !== null) {
            return ['success' => false, 'message' => "Error {$exception->statusCode} : {$exception->getMessage()} !!!"];
        }
    }

    public function actionGetnavigation() {
        $get = Yii::$app->request->get();
        $user_id = Yii::$app->user->identity->user->user_id;
        $tenant_id = Yii::$app->user->identity->user->tenant_id;

        $role_ids = ArrayHelper::map(CoUsersRoles::find()->where(['user_id' => $user_id])->all(), 'role_id', 'role_id');
        $resource_ids = ArrayHelper::map(CoRolesResources::find()->where(['IN', 'role_id', $role_ids])->andWhere(['tenant_id' => $tenant_id])->all(), 'resource_id', 'resource_id');

        $menus = CoRolesResources::getModuleTreeByResourcename($get['resourceName']);

        foreach ($menus as $key => $menu) {
            if (in_array($menu['value'], $resource_ids)) {
                foreach ($menu['children'] as $ckey => $child) {
                    if (in_array($child['value'], $resource_ids)) {
                        foreach ($child['children'] as $ckey2 => $child2) {
                            if (!in_array($child2['value'], $resource_ids)) {
                                unset($menus[$key]['children'][$ckey]['children'][$ckey2]);
                            }
                        }
                    } else {
                        unset($menus[$key]['children'][$ckey]);
                    }
                }
            } else {
                unset($menus[$key]);
            }
        }

        return ['navigation' => $menus[0]['children']];
    }

}
