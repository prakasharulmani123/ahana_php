<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaProductBatch;
use common\models\PhaReorderHistory;
use common\models\PhaReorderHistoryItem;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\ArrayHelper;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PharmacyreorderhistoryController extends ActiveController {

    public $modelClass = 'common\models\PhaReorderHistory';

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
            'query' => $modelClass::find()->tenant()->active()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }

    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('id');
        if ($id) {
            $model = PhaReorderHistory::find()->where(['purchase_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionGetpurchases() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['payment_type'])) {
            $data = PhaReorderHistory::find()->tenant()->active()->andWhere(['payment_type' => $get['payment_type']])->orderBy(['created_at' => SORT_DESC])->all();
            return ['success' => true, 'purchases' => $data];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionSavepurchase() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post)) {
            //Validation
            $model = new PhaReorderHistory;
            if (isset($post['purchase_id'])) {
                $purchase = PhaReorderHistory::find()->tenant()->andWhere(['purchase_id' => $post['purchase_id']])->one();
                if (!empty($purchase))
                    $model = $purchase;
            }

            $model->attributes = $post;
            $valid = $model->validate();

            foreach ($post['product_items'] as $key => $product_item) {
                $item_model = new PhaReorderHistoryItem();
                $item_model->scenario = 'saveform';
                $item_model->attributes = $product_item;
                $valid = $item_model->validate() && $valid;
                if (!$valid)
                    break;
            }
            //End

            if ($valid) {
                $model->save(false);

                $item_ids = [];
                foreach ($post['product_items'] as $key => $product_item) {
                    $item_model = new PhaReorderHistoryItem();

                    //Edit Mode
                    if (isset($product_item['purchase_item_id'])) {
                        $item = PhaReorderHistoryItem::find()->tenant()->andWhere(['purchase_item_id' => $product_item['purchase_item_id']])->one();
                        if (!empty($item))
                            $item_model = $item;
                    }

                    $item_model->attributes = $product_item;
                    $item_model->purchase_id = $model->purchase_id;
                    $item_model->save(false);
                    $item_ids[$item_model->purchase_item_id] = $item_model->purchase_item_id;
                }

                //Delete Product Items
                if (!empty($item_ids)) {
                    $delete_ids = array_diff($model->getProductItemIds(), $item_ids);

                    foreach ($delete_ids as $delete_id) {
                        $item = PhaReorderHistoryItem::find()->tenant()->andWhere(['purchase_item_id' => $delete_id])->one();
                        $item->delete();
                    }
                }

                return ['success' => true, 'model' => $model];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $item_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Fill the Form'];
        }
    }

    public function actionReorder() {
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        $stocks = PhaProductBatch::find()
                ->joinWith('product')
                ->joinWith('phaProductBatchRate')
                ->andWhere(['pha_product.tenant_id' => $tenant_id])
                ->andWhere('available_qty <= pha_product.product_reorder_min')
                ->addSelect([
                    "CONCAT(pha_product.product_name, ' | ', pha_product.product_unit_count, ' | ', pha_product.product_unit) as product_name",
                    'SUM(available_qty) as available_qty',
                    'pha_product.product_id as product_id',
                    'pha_product.product_code as product_code',
                    'pha_product.supplier_id_1 as supplier_id_1',
                    'pha_product.supplier_id_2 as supplier_id_2',
                    'pha_product.supplier_id_3 as supplier_id_3',
                    'pha_product.product_code as product_code',
                    'pha_product_batch_rate.mrp as mrp'
                ])
                ->groupBy(['pha_product.product_id'])
                ->all();

        $reorder_products = ArrayHelper::map(PhaReorderHistoryItem::find()->tenant()->status()->all(), 'product_id', 'product_id');
        $reports = [];

        foreach ($stocks as $key => $purchase) {
            if (!in_array($purchase['product_id'], $reorder_products)) {
                $reports[$key]['product_id'] = $purchase['product_id'];
                $reports[$key]['product_name'] = $purchase['product_name'];
                $reports[$key]['product_code'] = $purchase['product_code'];
                $reports[$key]['mrp'] = $purchase['mrp'];
                $reports[$key]['available_qty'] = $purchase['available_qty'];
                $reports[$key]['stock_value'] = $purchase['mrp'] * $purchase['available_qty'];

                $supplier_id = $purchase['supplier_id_1'];
                if (empty($supplier_id))
                    $supplier_id = $purchase['supplier_id_2'];
                if (empty($supplier_id))
                    $supplier_id = $purchase['supplier_id_3'];

                $reports[$key]['supplier_id'] = intval($supplier_id);
            }
        }

        return ['report' => $reports];
    }

    public function actionAddreorderhistory() {
        $post = Yii::$app->getRequest()->post();

        if (isset($post['records']) && isset($post['user_id']) && !empty($post['records'])) {
            $reorder_history = [];
            foreach ($post['records'] as $key => $record) {
                $reorder_history[$record['supplier_id']]['user_id'] = $post['user_id'];
                $reorder_history[$record['supplier_id']]['supplier_id'] = isset($record['supplier_id']) ? $record['supplier_id'] : '';
                $reorder_history[$record['supplier_id']]['reorder_date'] = date('Y-m-d');
                $reorder_history[$record['supplier_id']]['items'][$key]['product_id'] = isset($record['product_id']) ? $record['product_id'] : '';
                $reorder_history[$record['supplier_id']]['items'][$key]['quantity'] = isset($record['quantity']) ? $record['quantity'] : '';
            }

            //Validation
            foreach ($reorder_history as $history) {
                //Validation
                $model = new PhaReorderHistory;
                $model->attributes = $history;
                $valid = $model->validate();

                foreach ($history['items'] as $history_item) {
                    $item_model = new PhaReorderHistoryItem();
                    $item_model->attributes = $history_item;
                    $valid = $item_model->validate() && $valid;
                    if (!$valid)
                        break;
                }
            }

            if ($valid) {
                foreach ($reorder_history as $history) {
                    $model = new PhaReorderHistory;
                    $model->attributes = $history;
                    $model->save(false);

                    $item_ids = [];
                    foreach ($history['items'] as $key => $history_item) {
                        $item_model = new PhaReorderHistoryItem();
                        $item_model->attributes = $history_item;
                        $item_model->reorder_id = $model->reorder_id;
                        $item_model->save(false);
                    }
                }
                return ['success' => true, 'model' => $model];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $item_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Fill the Form'];
        }
    }

}
