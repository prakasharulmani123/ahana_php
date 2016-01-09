<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoMasterCity;
use common\models\CoMasterCountry;
use common\models\CoMasterState;
use common\models\CoTenant;
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
            return ['success' => "ok"];
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

}
