<?php

namespace IRISORG\modules\v1\controllers;

use yii\web\Controller;

class DefaultController extends Controller
{
    public function actionIndex()
    {
        echo "AAAAAAA"; exit;
        return $this->render('index');
    }
}
