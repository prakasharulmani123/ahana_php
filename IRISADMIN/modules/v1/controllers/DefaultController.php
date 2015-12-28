<?php

namespace IRISADMIN\modules\v1\controllers;

use yii\web\Controller;
use yii\filters\ContentNegotiator;
use yii\web\Response;
use yii\web\HttpException;

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

    public function actionGetCityList() {
        return \common\models\CoMasterCity::getCitylist();
    }

}
