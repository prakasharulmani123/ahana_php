<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaProduct;
use common\models\PhaProductBatch;
use common\models\PhaProductDescription;
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
class PharmacyproductController extends ActiveController {

    public $modelClass = 'common\models\PhaProduct';

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
            $model = PhaProduct::find()->where(['product_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionGetproductlist() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['tenant']))
            $tenant = $get['tenant'];

        if (isset($get['status']))
            $status = strval($get['status']);

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        return ['productList' => PhaProduct::getProductlist($tenant, $status, $deleted)];
    }

    public function actionGetproductlistbyname() {
        $get = Yii::$app->getRequest()->get();
        $name = $get['name'];
        return ['productList' => PhaProduct::find()->tenant()->nameLike($name)->active()->all()];
    }

    public function actionGetproductdescriptionlist() {
        $tenant = null;
        $status = '1';
        $deleted = false;

        $get = Yii::$app->getRequest()->get();

        if (isset($get['tenant']))
            $tenant = $get['tenant'];

        if (isset($get['status']))
            $status = strval($get['status']);

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        return ['productDescriptionList' => PhaProductDescription::getProductDescriptionList($tenant, $status, $deleted)];
    }

    public function actionSearchbycriteria() {
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        if (isset($post['search_text'])) {
            switch ($post['search_type']) {
                case 'B':
                    $text = $post['search_text'] . '%';
                    break;
                case 'C':
                    $text = '%' . $post['search_text'] . '%';
                    break;
                case 'E':
                    $text = '%' . $post['search_text'];
                    break;
            }

            if ($post['search_by'] == 'pha_product.product_name') {
                $having_column = "CONCAT(pha_product.product_name, ' | ', pha_product.product_unit_count, ' | ', pha_product.product_unit) AS search_column";
            } else {
                $having_column = $post['search_by'] . ' AS search_column';
            }

            $products = PhaProductBatch::find()
                    ->addSelect(["*", $having_column])
                    ->joinWith('product')
                    ->andWhere(['pha_product.tenant_id' => $tenant_id])
                    ->andHaving("search_column LIKE '$text'")
                    ->all();
        } else {
            $products = PhaProductBatch::find()->tenant()->all();
        }


        return ['productLists' => $products];
    }

    public function actionAdjuststock() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post)) {
            $model = PhaProductBatch::find()->tenant()->andWhere(['batch_id' => $post['batch_id']])->one();
            if (!empty($model)) {
                $model->total_qty = $model->total_qty + $post['adjust_qty'];
                $model->available_qty = $model->available_qty + $post['adjust_qty'];

                if ($model->save())
                    return ['success' => true, 'batch' => $model];
                else
                    return ['success' => false, 'message' => Html::errorSummary([$model])];
            }
        }else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionUpdatebatch() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post)) {
            $model = PhaProductBatch::find()->tenant()->andWhere(['batch_id' => $post['batch_id']])->one();

            if (!empty($model)) {
                $model->expiry_date = $post['expiry_date'];
                $model->batch_no = $post['batch_no'];

                $rate = $model->phaProductBatchRate;
                $rate->mrp = $post['mrp'];

                $valid = $model->validate();
                $valid = $rate->validate() && $valid;

                if ($valid) {
                    $model->save(false);
                    $rate->save(false);
                    
                    return ['success' => true, 'batch' => $model];
                } else {
                    return ['success' => false, 'message' => Html::errorSummary([$model, $rate])];
                }
            }
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

}
