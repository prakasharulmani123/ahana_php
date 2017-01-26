<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaSale;
use common\models\PhaSaleItem;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PharmacysaleController extends ActiveController {

    public $modelClass = 'common\models\PhaSale';

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
            $model = PhaSale::find()->where(['sale_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }
    
    public function actionGetsales() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['payment_type'])) {
            $data = [];
            $sales = PhaSale::find()
                    ->tenant()
                    ->active()
                    ->andWhere(['payment_type' => $get['payment_type']])
                    ->groupBy(['patient_name', 'encounter_id'])
                    ->all();
            
            foreach ($sales as $key => $sale) {
                $data[$key] = $sale->attributes;
                
                if(!empty($sale->encounter_id))
                    $sale_item = PhaSale::find()->tenant()->andWhere(['encounter_id' => $sale->encounter_id, 'payment_type' => $get['payment_type']]);
                else
                    $sale_item = PhaSale::find()->tenant()->andWhere(['patient_name' => $sale->patient_name, 'payment_type' => $get['payment_type']]);
                
                $sale_ids = \yii\helpers\ArrayHelper::map($sale_item->all(), 'sale_id', 'sale_id');
                $sum_paid_amount = \common\models\PhaSaleBilling::find()->tenant()->andWhere(['sale_id' => $sale_ids])->sum('paid_amount');
                
                $data[$key]['items'] = $sale_item->all();
                $data[$key]['sum_bill_amount'] = $sale_item->sum('bill_amount');
                $data[$key]['sum_paid_amount'] = !is_null($sum_paid_amount) ? $sum_paid_amount : 0;
                $data[$key]['sum_balance_amount'] = $data[$key]['sum_bill_amount'] - $sum_paid_amount;
            }
            return ['success' => true, 'sales' => $data];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionSavesale() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post)) {
            //Validation
            $model = new PhaSale;
            if (isset($post['sale_id'])) {
                $sale = PhaSale::find()->tenant()->andWhere(['sale_id' => $post['sale_id']])->one();
                if (!empty($sale))
                    $model = $sale;
            }

            $model->attributes = $post;
            $valid = $model->validate();

            foreach ($post['product_items'] as $key => $product_item) {
                $item_model = new PhaSaleItem();
                $item_model->scenario = 'saveform';
                $item_model->attributes = $product_item;
                $valid = $item_model->validate() && $valid;
                if (!$valid)
                    break;
            }

            if ($valid) {
                $model->save(false);

                $item_ids = [];
                foreach ($post['product_items'] as $key => $product_item) {
                    $item_model = new PhaSaleItem();

                    //Edit Mode
                    if (isset($product_item['sale_item_id'])) {
                        $item = PhaSaleItem::find()->tenant()->andWhere(['sale_item_id' => $product_item['sale_item_id']])->one();
                        if (!empty($item))
                            $item_model = $item;
                    }

                    $item_model->attributes = $product_item;
                    $item_model->sale_id = $model->sale_id;
                    $item_model->save(false);
                    $item_ids[$item_model->sale_item_id] = $item_model->sale_item_id;
                }

                //Delete Product Items
                if (!empty($item_ids)) {
                    $delete_ids = array_diff($model->getSaleItemIds(), $item_ids);

                    foreach ($delete_ids as $delete_id) {
                        $item = PhaSaleItem::find()->tenant()->andWhere(['sale_item_id' => $delete_id])->one();
                        $item->delete();
                    }
                }
                return ['success' => true, 'bill_no' => $model->bill_no, 'saleId' => $model->sale_id];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $item_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Fill the Form'];
        }
    }

}
