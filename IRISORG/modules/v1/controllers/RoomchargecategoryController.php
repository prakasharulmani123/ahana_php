<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoRoomChargeCategory;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * RoomChargeCategoryController implements the CRUD actions for CoTenant model.
 */
class RoomchargecategoryController extends ActiveController {

    public $modelClass = 'common\models\CoRoomChargeCategory';

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
            $model = CoRoomChargeCategory::find()->where(['charge_cat_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionGetroomchargecategorylist() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['tenant']))
            $tenant = $get['tenant'];

        if (isset($get['status']))
            $status = strval($get['status']);

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        $list = array();
        $data = CoRoomChargeCategory::getRoomChargeCateogrylist($tenant, $status, $deleted);
        foreach ($data as $value => $label) {
            $list[] = array('value' => $value, 'label' => $label);
        }
        return ['categoryList' => $list];
    }

}
