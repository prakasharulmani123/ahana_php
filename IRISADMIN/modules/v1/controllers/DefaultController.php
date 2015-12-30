<?php

namespace IRISADMIN\modules\v1\controllers;

use common\models\CoMasterCity;
use common\models\CoMasterCountry;
use common\models\CoMasterState;
use common\models\CoResources;
use common\models\CoRolesResources;
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
        return ['moduleList' => CoRolesResources::getModuleTree()];
    }

    public function actionTesting() {
        $user = new \common\models\CoUser;
        $user->tenant_id = 18;
        $user->name = 'Nadesh';
        $user->save(false);

        $role = new \common\models\CoRole;
        $role->tenant_id = 18;
        $role->description = 'Nadesh_role';
        $role->save(false);

        $user->link('roles', $role);
        return ['success' => 'Ok'];
    }

    public function actionExample() {
        $user = \common\models\CoUser::findOne(10);
        $roles = [\common\models\CoRole::findOne(8)];

        $extraColumns = ['tenant_id' => '18']; // extra columns to be saved to the many to many table
        $unlink = true; // unlink tags not in the list
        $delete = true; // delete unlinked tags

        $user->linkAll('roles', $roles, $extraColumns, $unlink, $delete);
    }

}
