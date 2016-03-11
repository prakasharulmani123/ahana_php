<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaPurchaseReturn;
use common\models\PhaPurchaseReturnItem;
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
class PharmacypurchasereturnController extends ActiveController {

    public $modelClass = 'common\models\PhaPurchaseReturn';

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
            $model = PhaPurchaseReturn::find()->where(['purchase_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionSavepurchase() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post)) {
            //Validation
            $model = new PhaPurchaseReturn;
            if (isset($post['purchase_id'])) {
                $purchase = PhaPurchaseReturn::find()->tenant()->andWhere(['purchase_id' => $post['purchase_id']])->one();
                if (!empty($purchase))
                    $model = $purchase;
            }

            $model->attributes = $post;
            $valid = $model->validate();

            foreach ($post['product_items'] as $key => $product_item) {
                $item_model = new PhaPurchaseReturnItem();
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
                    $item_model = new PhaPurchaseReturnItem();
                    
                    //Edit Mode
                    if (isset($product_item['purchase_item_id'])) {
                        $item = PhaPurchaseReturnItem::find()->tenant()->andWhere(['purchase_item_id' => $product_item['purchase_item_id']])->one();
                        if (!empty($item))
                            $item_model = $item;
                    }

                    $item_model->attributes = $product_item;
                    $item_model->purchase_id = $model->purchase_id;
                    $item_model->save(false);
                    $item_ids[$item_model->purchase_item_id] = $item_model->purchase_item_id;
                }
                
                //Delete Product Items
                if(!empty($item_ids)){
                    $delete_ids = array_diff($model->getProductItemIds(), $item_ids);
                    
                    foreach ($delete_ids as $delete_id) {
                        $item = PhaPurchaseReturnItem::find()->tenant()->andWhere(['purchase_item_id' => $delete_id])->one();
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

}
