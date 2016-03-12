<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaProductBatch;
use common\models\PhaPurchaseItem;
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


        if (isset($post['from']) && isset($post['to'])) {
            $purchases = PhaPurchaseItem::find()
                    ->joinWith('purchase')
                    ->joinWith('product')
                    ->andWhere(['pha_product.tenant_id' => $tenant_id])
                    ->andWhere("pha_purchase.invoice_date between '{$post['from']}' AND '{$post['to']}'")
                    ->addSelect(["CONCAT(pha_product.product_name, ' | ', pha_product.product_unit_count, ' | ', pha_product.product_unit) as product_name", 'SUM(total_amount) as total_purhcase_amount'])
                    ->groupBy(['pha_product.product_id'])
                    ->all();
        }else{
            $purchases = PhaPurchaseItem::find()
                    ->joinWith('purchase')
                    ->joinWith('product')
                    ->andWhere(['pha_product.tenant_id' => $tenant_id])
                    ->addSelect(["CONCAT(pha_product.product_name, ' | ', pha_product.product_unit_count, ' | ', pha_product.product_unit) as product_name", 'SUM(total_amount) as total_purhcase_amount'])
                    ->groupBy(['pha_product.product_id'])
                    ->all();
        }

        $reports = [];

        foreach ($purchases as $key => $purchase) {
            $reports[$key]['product_name'] = $purchase['product_name'];
            $reports[$key]['total_amount'] = $purchase['total_purhcase_amount'];
        }

        return ['report' => $reports];
    }

    public function actionStockreport() {
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        $stocks = PhaProductBatch::find()
                ->joinWith('product')
                ->andWhere(['pha_product.tenant_id' => $tenant_id])
                ->addSelect(["CONCAT(pha_product.product_name, ' | ', pha_product.product_unit_count, ' | ', pha_product.product_unit) as product_name", 'SUM(available_qty) as available_qty', 'pha_product.product_code as product_code'])
                ->groupBy(['pha_product.product_id'])
                ->all();

        $reports = [];

        foreach ($stocks as $key => $purchase) {
            $reports[$key]['product_name'] = $purchase['product_name'];
            $reports[$key]['product_code'] = $purchase['product_code'];
            $reports[$key]['available_qty'] = $purchase['available_qty'];
        }

        return ['report' => $reports];
    }

}
