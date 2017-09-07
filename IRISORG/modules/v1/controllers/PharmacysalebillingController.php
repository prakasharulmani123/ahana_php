<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaSale;
use common\models\PhaSaleBilling;
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
class PharmacysalebillingController extends ActiveController {

    public $modelClass = 'common\models\PhaSaleBilling';

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
            $model = PhaSaleBilling::find()->where(['sale_billing_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionMakepayment() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post) && !empty($post['sale_ids'])) {
            $model = new PhaSaleBilling;
            $model->attributes = $post;
            $valid = $model->validate();
            if ($post['total_select_bill_amount'] < $post['paid_amount'])
                return ['success' => false, 'message' => 'Kindly check amount'];

            if ($valid) {
                $sales = PhaSale::find()->tenant()->andWhere(['sale_id' => $post['sale_ids']])->all();
                $paid_amount = $post['paid_amount'];

                foreach ($sales as $key => $sale) {
                    if ($paid_amount > 0) {
                        $model = new PhaSaleBilling;

                        $total_bill_amount = $sale->bill_amount - $sale->PhaSaleBillingsTotalPaidAmount;

                        if ($paid_amount >= $total_bill_amount) {
                            $paid = $total_bill_amount;
                        } else if ($paid_amount < $total_bill_amount) {
                            $paid = $paid_amount;
                        }

                        $model->attributes = [
                            'paid_date' => $post['paid_date'],
                            'sale_id' => $sale->sale_id,
                            'paid_amount' => $paid,
                        ];
                        $paid_amount = $paid_amount - $paid;

                        $model->save(false);
                    }
                }

                //$search = ['encounter_id' => $post['encounter_id'], 'payment_type' => $post['payment_type'], 'patient_id' => $sales[0]->patient_id];

                $data = [];
                //$sales = PhaSale::find()->tenant()->active()->andWhere($search)->groupBy(['encounter_id'])->all();
//                foreach ($sales as $key => $sale) {
//                    $data[$key] = $sale->attributes;
//
//                    $sale_item = PhaSale::find()->tenant()->andWhere($search);
//
//                    $sale_ids = ArrayHelper::map($sale_item->all(), 'sale_id', 'sale_id');
//                    $sum_paid_amount = PhaSaleBilling::find()->tenant()->andWhere(['sale_id' => $sale_ids])->sum('paid_amount');
//
//                    $data[$key]['items'] = $sale_item->all();
//                    $data[$key]['sum_bill_amount'] = $sale_item->sum('bill_amount');
//                    $data[$key]['sum_paid_amount'] = !is_null($sum_paid_amount) ? $sum_paid_amount : 0;
//                    $data[$key]['sum_balance_amount'] = $data[$key]['sum_bill_amount'] - $sum_paid_amount;
//                }

                return ['success' => true, 'sales' => $data];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model])];
            }
        } else {
            return ['success' => false, 'message' => 'Fill the Form'];
        }
    }

}
