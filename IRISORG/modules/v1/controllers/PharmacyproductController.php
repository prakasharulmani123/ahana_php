<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaDrugClass;
use common\models\PhaDrugGeneric;
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

    public function actionGetdrugclasslistbyname() {
        $get = Yii::$app->getRequest()->get();
        $name = $get['name'];
        return ['drugclassList' => PhaDrugClass::find()->tenant()->nameLike($name)->active()->all()];
    }

    public function actionGetgenericlistbydrugclass() {
        $get = Yii::$app->getRequest()->get();
        $id = $get['drug_class_id'];

        return ['genericList' => PhaDrugGeneric::find()->tenant()->andWhere(['drug_class_id' => $id])->active()->all()];
    }

    public function actionGetproductlistbygeneric() {
        $get = Yii::$app->getRequest()->get();
        $id = $get['generic_id'];

        return ['productList' => PhaProduct::find()->tenant()->andWhere(['generic_id' => $id])->active()->all()];
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
                    ->joinWith('phaProductBatchRate')
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

    public function actionGetprescription() {
        $post = Yii::$app->getRequest()->post();

        $products = [];
        if (isset($post['search']) && !empty($post['search']) && strlen($post['search']) > 1) {
            $text = $post['search'];
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;

            $connection = Yii::$app->client;
            $limit = 10;

            $text_search = str_replace(' ', '* ', $text);
            
            //Get Products
            $command = $connection->createCommand("
                SELECT a.product_id, a.product_name, b.generic_id, b.generic_name, c.drug_class_id, c.drug_name, 
                CONCAT(b.generic_name, ' // ', a.product_name, ' | ', a.product_unit_count, ' | ', a.product_unit) AS prescription
                FROM pha_product a
                JOIN pha_generic b
                ON b.generic_id = a.generic_id
                LEFT OUTER JOIN pha_drug_class c
                ON c.drug_class_id = a.drug_class_id
                WHERE 
                MATCH(a.product_name) AGAINST(:search_text IN BOOLEAN MODE)
                OR MATCH(b.generic_name) AGAINST(:search_text IN BOOLEAN MODE)
                OR MATCH(c.drug_name) AGAINST(:search_text IN BOOLEAN MODE)
                AND a.tenant_id = :tenant_id
                ORDER BY  a.product_name
                LIMIT 0,:limit", [':search_text' => $text_search . '*', ':limit' => $limit, ':tenant_id' => $tenant_id]
            );
            $products = $command->queryAll();
            
            //Get Routes
            $command = $connection->createCommand("
                SELECT route_id, route_name as route
                FROM pat_prescription_route
                WHERE MATCH(route_name) AGAINST(:search_text IN BOOLEAN MODE)
                AND tenant_id = :tenant_id
                ORDER BY  route_name
                LIMIT 0,:limit", [':search_text' => $text_search . '*', ':limit' => $limit, ':tenant_id' => $tenant_id]
            );
            $routes = $command->queryAll();

            if (!empty($routes)) {
                $products = $this->_mergeArrayWithProducts($products, $routes, 'route');
            }

            $strings = $this->_getFrquenceyMatchStrings($text);
            
            if (!empty($strings)) {
                //Get Frequencies
                $query = "SELECT freq_id, freq_name as frequency 
                    FROM pat_prescription_frequency 
                    WHERE";
                foreach ($strings as $key => $string) {
                    $query .= " freq_name like '%$string%' OR";
                }
                $query = rtrim($query, ' OR');
                $query .= "AND tenant_id = :tenant_id
                    ORDER BY  freq_name
                    LIMIT 0,:limit";

                $command = $connection->createCommand($query, [':limit' => $limit, ':tenant_id' => $tenant_id]);
                $frequencies = $command->queryAll();

                if (!empty($frequencies)) {
                    $products = $this->_mergeArrayWithProducts($products, $frequencies, 'frequency');
                }
            }
        }

        return ['prescription' => $products];
    }

    private function _getFrquenceyMatchStrings($string) {
        $words = explode(' ', $string);

        $match_words = [];
        foreach ($words as $key => $word) {
            if (substr_count($word, '-') >= 1)
                $match_words[] = $word;
        }
        return $match_words;
    }

    private function _mergeArrayWithProducts($products, $array, $pres_string) {
        $new_result = [];
        foreach ($array as $rkey => $val) {
            foreach ($products as $pkey => $product) {
                $prescription = ['prescription' => $product['prescription'] . ' // ' . $val[$pres_string]];
                $new_result[] = array_merge($product, $val, $prescription);
            }
        }
        return $new_result;
    }

}
