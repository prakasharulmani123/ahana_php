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
            $data = PhaSale::find()->tenant()->active()->andWhere(['payment_type' => $get['payment_type']])->all();
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
                return ['success' => true, 'model' => $model];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $item_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Fill the Form'];
        }
    }

}
