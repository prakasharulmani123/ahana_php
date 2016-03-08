<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaPurchase;
use common\models\PhaPurchaseItem;
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
class PharmacypurchaseController extends ActiveController {

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
            $model = PhaPurchase::find()->where(['purchase_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionSavepurchase() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post)) {
            $model = new PhaPurchase;
            $model->attributes = $post;
            $valid = $model->validate();

            foreach ($post['product_items'] as $key => $product_item) {
                $item_model = new PhaPurchaseItem();
                $item_model->attributes = $product_item;
                $valid = $item_model->validate() && $valid;
                if (!$valid)
                    break;
            }

            if ($valid) {
                $model->save(false);

                foreach ($post['product_items'] as $key => $product_item) {
                    $item_model = new PhaPurchaseItem();
                    $item_model->attributes = $product_item;
                    $item_model->purchase_id = $model->purchase_id;
                    $item_model->save(false);
                }
                
//                $model->updatePurchaseRate();
                
                exit;
                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $item_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Fill the Form'];
        }
    }

}
