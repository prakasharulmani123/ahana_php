<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoChargePerSubcategory;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * SpecialityController implements the CRUD actions for CoTenant model.
 */
class ChargepersubcategoryController extends ActiveController {

    public $modelClass = 'common\models\CoChargePerSubcategory';

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
            'query' => $modelClass::find()->active(),
            'pagination' => false,
        ]);
    }

    public function actionGetchargepersubcategorylist() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        if (isset($get['cat_id']))
            $cat_id = $get['cat_id'];

        return ['subcategoryList' => CoChargePerSubcategory::getChargePerSubCateogrylist($deleted, $cat_id)];
    }

}
