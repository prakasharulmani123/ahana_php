<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaProductBatch;
use common\models\PhaPurchase;
use common\models\PhaSale;
use Yii;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PharmacyreportController extends ActiveController {

    public $modelClass = 'common\models\PhaPurchase';

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

    public function actionPurchasereport() {
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        $reports = PhaPurchase::find()
                ->tenant()
                ->andWhere("pha_purchase.invoice_date between '{$post['from']}' AND '{$post['to']}'")
                ->all();

        return ['report' => $reports];
    }

    //Sale Report
    public function actionSalereport() {
        $post = Yii::$app->getRequest()->post();

        $model = PhaSale::find()
                ->tenant()
                ->andWhere("pha_sale.sale_date between '{$post['from']}' AND '{$post['to']}'");
                
        if (isset($post['payment_type'])) {
            $model->andWhere(['pha_sale.payment_type' => $post['payment_type']]);
        }

        $reports = $model->all();

        return ['report' => $reports];
    }

    public function actionStockreport() {
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        $stocks = PhaProductBatch::find()
                ->joinWith('product')
                ->joinWith('phaProductBatchRate')
                ->andWhere(['pha_product.tenant_id' => $tenant_id])
                ->addSelect([
                    "CONCAT(
                        IF(pha_product.product_name IS NULL OR pha_product.product_name = '', ' ', pha_product.product_name),
                        IF(pha_product.product_unit_count IS NULL OR pha_product.product_unit_count = '', ' ', CONCAT(' | ', pha_product.product_unit_count)),
                        IF(pha_product.product_unit IS NULL OR pha_product.product_unit = '', ' ', CONCAT(' | ', pha_product.product_unit))
                    ) as product_name",
                    'SUM(available_qty) as available_qty',
                    'pha_product.product_code as product_code',
                    'pha_product_batch_rate.mrp as mrp'])
                ->groupBy(['pha_product.product_id'])
                ->all();

        $reports = [];

        foreach ($stocks as $key => $purchase) {
            $reports[$key]['product_name'] = $purchase['product_name'];
            $reports[$key]['product_code'] = $purchase['product_code'];
            $reports[$key]['mrp'] = $purchase['mrp'];
            $reports[$key]['available_qty'] = $purchase['available_qty'];
            $reports[$key]['stock_value'] = $purchase['mrp'] * $purchase['available_qty'];
        }

        return ['report' => $reports];
    }

}
