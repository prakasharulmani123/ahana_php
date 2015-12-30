<?php

namespace IRISADMIN\modules\v1\controllers;

use app\models\CoResources;
use common\models\CoMasterCity;
use common\models\CoMasterCountry;
use common\models\CoMasterState;
use Yii;
use yii\filters\ContentNegotiator;
use yii\web\Controller;
use yii\web\Response;

class DefaultController extends Controller {

    public function behaviors() {
        $behaviors = parent::behaviors();

        $behaviors['contentNegotiator'] = [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
            ],
        ];

        return $behaviors;
    }

    public function actionIndex() {
        echo "Ahana IRISAdmin Web Service V1";
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
        if (!empty(Yii::$app->request->post())) {
            $post = Yii::$app->request->post();
            $modelName = $post['model'];
            $primaryKey = $post['id'];
            $modelClass = "common\\models\\$modelName";
            $model = $modelClass::findOne($primaryKey);
            $model->status = 1 - $model->status;
            $model->save(false);
            return ['success' => "ok"];
        }
    }

    public function actionGetModuleTree() {
        $list = array();
        $parents = CoResources::find()->where(['parent_id' => null])->orderBy(['resource_name' => 'ASC'])->all();
        foreach ($parents as $key => $parent) {
            $list[$key] = array('label' => $parent->resource_name, 'value' => $parent->resource_id);

            $childs = CoResources::find()->where(['parent_id' => $parent->resource_id])->orderBy(['resource_name' => 'ASC'])->all();
            foreach ($childs as $cKey => $child) {
                $list[$key]['items'][$cKey] = array('label' => $child->resource_name, 'value' => $child->resource_id);
            }
        }
        return ['moduleList' => $list];
    }

}
