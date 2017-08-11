<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaSale;
use common\models\PhaSaleItem;
use common\models\PhaSaleReturn;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use common\models\CoAuditLog;
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

    public function actionGetsalebillno() {
        $get = Yii::$app->getRequest()->get();
        $text = $get['bill_no'];

        $sales = PhaSale::find()
                ->tenant()
                ->active()
                ->leftJoin('pat_patient', 'pha_sale.patient_id=pat_patient.patient_id')
                ->leftJoin('pat_global_patient', 'pat_global_patient.patient_global_guid=pat_patient.patient_global_guid')
                ->andFilterWhere([
                    'or',
                        ['like', 'bill_no', $text],
                        ['like', 'pat_global_patient.patient_global_int_code', $text],
                ])
                ->limit(100)
                ->all();

        return $sales;
    }

    public function actionGetsales() {
        $get = Yii::$app->getRequest()->get();
        $data = [];
        $searchCondition = '';

        if ($get) {

            $offset = abs($get['pageIndex'] - 1) * $get['pageSize'];
            $condition['payment_type'] = $get['payment_type'];

            if (isset($get['dt'])) {
                $condition['sale_date'] = $get['dt'];
            }
            if (isset($get['s']) && !empty($get['s']) && $get['s'] != 'null') {
                $text = $get['s'];
                $searchCondition = [
                    'or',
                        ['like', 'patient_name', $text],
                        ['like', 'encounter_id', $text],];
            }

            $result = PhaSale::find()
                    ->tenant()
                    ->active()
                    ->andWhere($condition);
            if ($searchCondition) {
                $result->andFilterWhere($searchCondition);
            }
            $result->groupBy(['patient_name', 'encounter_id']);
            $result->limit($get['pageSize'])->offset($offset)->orderBy(['created_at' => SORT_DESC]);
            $sales = $result->all();

            $resultCount = PhaSale::find()
                    ->tenant()
                    ->active()
                    ->andWhere($condition);
            if ($searchCondition) {
                $resultCount->andFilterWhere($searchCondition);
            }
            $resultCount->groupBy(['patient_name', 'encounter_id']);
            $totalCount = $resultCount->count();

            foreach ($sales as $key => $sale) {
                $data[$key] = $sale->attributes;

                if (!empty($sale->encounter_id))
                    $sale_item = PhaSale::find()->tenant()->active()->andWhere(['encounter_id' => $sale->encounter_id, 'payment_type' => $get['payment_type']]);
                else
                    $sale_item = PhaSale::find()->tenant()->active()->andWhere(['patient_name' => $sale->patient_name, 'payment_type' => $get['payment_type']]);

                $sale_ids = \yii\helpers\ArrayHelper::map($sale_item->all(), 'sale_id', 'sale_id');
                $sum_paid_amount = \common\models\PhaSaleBilling::find()->tenant()->andWhere(['sale_id' => $sale_ids])->sum('paid_amount');

                $data[$key]['items'] = $sale_item->all();
                $data[$key]['sum_bill_amount'] = $sale_item->sum('bill_amount');
                $data[$key]['sum_paid_amount'] = !is_null($sum_paid_amount) ? $sum_paid_amount : 0;
                $data[$key]['sum_balance_amount'] = $data[$key]['sum_bill_amount'] - $sum_paid_amount;
            }
            return ['success' => true, 'sales' => $data, 'totalCount' => $totalCount];
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

    public function actionCheckdelete() {
        $get = Yii::$app->getRequest()->post();
        $return = PhaSaleReturn::find()->tenant()->andWhere(['sale_id' => $get['id']])->one();
        if (empty($return)) {
            $model = PhaSale::find()->tenant()->where(['sale_id' => $get['id']])->one();
            $model->remove();
            $activity = 'Sale Deleted Successfully (#'. $model->bill_no.' )';
            CoAuditLog::insertAuditLog(PhaSale::tableName(), $get['id'], $activity);
            return ['success' => true];
        } else {
            return ['success' => false,'message'=>"Sorry, you can't delete this bill"];
        }
    }

}
