<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaSaleReturn;
use common\models\PhaSaleReturnItem;
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
class PharmacysalereturnController extends ActiveController {

    public $modelClass = 'common\models\PhaSaleReturn';

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
            $model = PhaSaleReturn::find()->where(['sale_ret_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionSavesalereturn() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post)) {
            //Validation
            $model = new PhaSaleReturn;
            if (isset($post['sale_ret_id'])) {
                $salereturn = PhaSaleReturn::find()->tenant()->andWhere(['sale_ret_id' => $post['sale_ret_id']])->one();
                if (!empty($salereturn))
                    $model = $salereturn;
            }

            $model->attributes = $post;
            $valid = $model->validate();

            foreach ($post['product_items'] as $key => $product_item) {
                if($product_item['quantity'] > 0){
                    $item_model = new PhaSaleReturnItem();
                    if (isset($product_item['sale_ret_item_id'])) {
                        $item_model = PhaSaleReturnItem::find()->tenant()->andWhere(['sale_ret_item_id' => $product_item['sale_ret_item_id']])->one();
                    }
                    $item_model->scenario = 'saveform';
                    $item_model->attributes = $product_item;
                    $valid = $item_model->validate() && $valid;
                    if (!$valid)
                        break;
                }else{
                    unset($post['product_items'][$key]);
                }
            }
            //End
            
            if(!$post['product_items']){
                $model->noitem = true;
                $valid = $model->validate();
                $item_model = new PhaSaleReturnItem();
            }

            if ($valid) {
                $model->save(false);

                $item_ids = [];
                foreach ($post['product_items'] as $key => $product_item) {
                    $item_model = new PhaSaleReturnItem();

                    //Edit Mode
                    if (isset($product_item['sale_ret_item_id'])) {
                        $item = PhaSaleReturnItem::find()->tenant()->andWhere(['sale_ret_item_id' => $product_item['sale_ret_item_id']])->one();
                        if (!empty($item))
                            $item_model = $item;
                    }

                    $item_model->attributes = $product_item;
                    $item_model->sale_ret_id = $model->sale_ret_id;
                    $item_model->save(false);
                    $item_ids[$item_model->sale_ret_item_id] = $item_model->sale_ret_item_id;
                }

                //Delete Product Items
                if (!empty($item_ids)) {
                    $delete_ids = array_diff($model->getSaleReturnItemIds(), $item_ids);

                    foreach ($delete_ids as $delete_id) {
                        $item = PhaSaleReturnItem::find()->tenant()->andWhere(['sale_ret_item_id' => $delete_id])->one();
                        $item->delete();
                    }
                }

                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $item_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Fill the Form'];
        }
    }
    
    public function actionGetsalereturn()
    {
        $get = Yii::$app->getRequest()->get();
        $offset = abs($get['pageIndex'] - 1) * $get['pageSize'];
        $result = PhaSaleReturn::find()->tenant()->active()->orderBy(['created_at' => SORT_DESC])->limit($get['pageSize'])->offset($offset)->all();
        $totalCount = PhaSaleReturn::find()->tenant()->active()->count();
        return ['success' => true, 'result' => $result, 'totalCount' => $totalCount];
    }

}
