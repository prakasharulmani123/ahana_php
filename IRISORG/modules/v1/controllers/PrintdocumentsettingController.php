<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PrintDocumentSetting;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * HsnController implements the CRUD actions for CoTenant model.
 */
class PrintdocumentsettingController extends ActiveController {

    public $modelClass = 'common\models\PrintDocumentSetting';

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
            'query' => $modelClass::find()->active()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }

    public function actionGetprintconfiguration() {
        $get = Yii::$app->request->get();
        $printSetting = PrintDocumentSetting::find()
                ->andWhere(['print_document_id' => $get['print_document_id']])
                ->one();
        return ['success' => true, 'printSetting' => $printSetting, 'logo_path' => \yii\helpers\Url::to("@web/images/uavatar/", true)];
    }

    public function actionGetprintoption() {
        $get = Yii::$app->getRequest()->get();
        $printSetting = PrintDocumentSetting::getPrintOption($get['print_document_id']);
        return ['logo_path' => \yii\helpers\Url::to("@web/images/uavatar/", true), 'printSetting' => $printSetting];
    }

    public function actionUploadimage() {
        $post = Yii::$app->getRequest()->post();

        defined('DS') or define('DS', DIRECTORY_SEPARATOR);
        $gCode = 'sale_bill_logo';

        $filename = "{$gCode}_" . time() . ".jpg";
        $uploadPath = "images" . DS . "uavatar" . DS;
        if (!file_exists($uploadPath)) {
            mkdir($uploadPath, 0777, true);
        }

        $output_file = $uploadPath . $filename;

        $ifp = fopen($output_file, "wb");
        $data = explode(',', $post['file_data']);
        if (isset($data[1])) {
            fwrite($ifp, base64_decode($data[1]));
            fclose($ifp);

            if ($post['old_image']) {
                $oldFile = "images" . DS . "uavatar" . DS . $post['old_image'];
                if (file_exists($oldFile)) {
                    unlink($oldFile);
                }
            }
            return ['success' => true, 'filename' => $filename];
        }
        return false;
    }

}
