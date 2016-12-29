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

        $generics = PhaDrugGeneric::find()->tenant()->andWhere(['drug_class_id' => $id])->active()->all();
        $products = PhaProduct::find()->tenant()->andWhere(['drug_class_id' => $id])->active()->all();

        return ['genericList' => $generics, 'productList' => $products];
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
                $having_column = "CONCAT(
                    IF(pha_product.product_name IS NULL OR pha_product.product_name = '', ' ', pha_product.product_name),
                    IF(pha_product.product_unit IS NULL OR pha_product.product_unit = '', ' ', CONCAT(' | ', pha_product.product_unit)),
                    IF(pha_product.product_unit_count IS NULL OR pha_product.product_unit_count = '', ' ', CONCAT(' | ', pha_product.product_unit_count))
                ) AS search_column";
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

    private $_connection;

    public function actionGetprescription() {
        $post = Yii::$app->getRequest()->post();

        $products = [];
        if (isset($post['search']) && !empty($post['search']) && strlen($post['search']) > 1) {
            $text = rtrim($post['search'], '-');
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;

            $this->_connection = Yii::$app->client;
            $limit = 10;

            $text_search = str_replace(' ', '* ', $text);

            //Get Products
            $products = $this->_getProducts($text_search, $tenant_id, $limit);

            //Get Routes
            $routes = $this->_getRoutes($products, $text_search, $tenant_id, $limit);

            if (!empty($routes)) {
                $products = $this->_mergeArrayWithProducts($products, $routes, 'route');
            }

            //Get Frequencies
            $frequencies = $this->_getFrequencies($text, $tenant_id, $limit);

            if (!empty($frequencies)) {
                $products = $this->_mergeArrayWithProducts($products, $frequencies, 'frequency');
            }
        }

        return ['prescription' => $products];
    }

    private function _getProducts($text_search, $tenant_id, $limit) {
        $post = Yii::$app->getRequest()->post();
        $products = [];

        if (isset($post['product_id'])) {
            //Retrieve One product
            $command = $this->_connection->createCommand("
                    SELECT a.product_id, a.product_name, b.generic_id, b.generic_name, c.drug_class_id, c.drug_name, 
                    CONCAT(
                        IF(b.generic_name IS NOT NULL, b.generic_name, ''),
                        IF(a.product_name IS NOT NULL, CONCAT(' // ', a.product_name), ''),
                        IF(a.product_unit_count IS NOT NULL, CONCAT(' | ', a.product_unit_count), ''),
                        IF(a.product_unit IS NOT NULL, CONCAT(' | ', a.product_unit), '')
                    ) AS prescription, '' as selected, a.product_description_id,
                    (
                        SELECT IF(SUM(d.available_qty) IS NOT NULL, SUM(d.available_qty), 0)
                        FROM pha_product_batch d
                        WHERE d.tenant_id = a.tenant_id
                        AND d.product_id = a.product_id
                    ) as available_quantity
                    FROM pha_product a
                    LEFT OUTER JOIN pha_generic b
                    ON b.generic_id = a.generic_id
                    LEFT OUTER JOIN pha_drug_class c
                    ON c.drug_class_id = a.drug_class_id
                    WHERE a.tenant_id = :tenant_id
                    AND a.product_id = :product_id
                    ORDER BY a.product_name
                    LIMIT 0,:limit", [':limit' => $limit, ':tenant_id' => $tenant_id, ':product_id' => $post['product_id']]
            );
        } else {
            //Retrieve (product && generic || drug)
            $command = $this->_connection->createCommand("
                    SELECT a.product_id, a.product_name, b.generic_id, b.generic_name, c.drug_class_id, c.drug_name, 
                    CONCAT(
                        IF(b.generic_name IS NOT NULL, b.generic_name, ''),
                        IF(a.product_name IS NOT NULL, CONCAT(' // ', a.product_name), ''),
                        IF(a.product_unit_count IS NOT NULL, CONCAT(' | ', a.product_unit_count), ''),
                        IF(a.product_unit IS NOT NULL, CONCAT(' | ', a.product_unit), '')
                    ) AS prescription, '' as selected, a.product_description_id,
                    (
                        SELECT IF(SUM(d.available_qty) IS NOT NULL, SUM(d.available_qty), 0)
                        FROM pha_product_batch d
                        WHERE d.tenant_id = a.tenant_id
                        AND d.product_id = a.product_id
                    ) as available_quantity
                    FROM pha_product a
                    LEFT OUTER JOIN pha_generic b
                    ON b.generic_id = a.generic_id
                    LEFT OUTER JOIN pha_drug_class c
                    ON c.drug_class_id = a.drug_class_id
                    WHERE a.tenant_id = :tenant_id
                    AND MATCH(a.product_name) AGAINST(:search_text IN BOOLEAN MODE)
                    AND (MATCH(b.generic_name) AGAINST(:search_text IN BOOLEAN MODE)
                    OR MATCH(c.drug_name) AGAINST(:search_text IN BOOLEAN MODE))
                    ORDER BY a.product_name
                    LIMIT 0,:limit", [':search_text' => $text_search . '*', ':limit' => $limit, ':tenant_id' => $tenant_id]
            );
        }
        $products = $command->queryAll();

        if (empty($products) && !isset($post['product_id'])) {
            //Retrieve (product || generic || drug)
            $command = $this->_connection->createCommand("
                    SELECT a.product_id, a.product_name, b.generic_id, b.generic_name, c.drug_class_id, c.drug_name, 
                    CONCAT(
                        IF(b.generic_name IS NOT NULL, b.generic_name, ''),
                        IF(a.product_name IS NOT NULL, CONCAT(' // ', a.product_name), ''),
                        IF(a.product_unit_count IS NOT NULL, CONCAT(' | ', a.product_unit_count), ''),
                        IF(a.product_unit IS NOT NULL, CONCAT(' | ', a.product_unit), '')
                    ) AS prescription, '' as selected, a.product_description_id,
                    (
                        SELECT IF(SUM(d.available_qty) IS NOT NULL, SUM(d.available_qty), 0)
                        FROM pha_product_batch d
                        WHERE d.tenant_id = a.tenant_id
                        AND d.product_id = a.product_id
                    ) as available_quantity
                    FROM pha_product a
                    LEFT OUTER JOIN pha_generic b
                    ON b.generic_id = a.generic_id
                    LEFT OUTER JOIN pha_drug_class c
                    ON c.drug_class_id = a.drug_class_id
                    WHERE a.tenant_id = :tenant_id
                    AND MATCH(a.product_name) AGAINST(:search_text IN BOOLEAN MODE)
                    OR MATCH(b.generic_name) AGAINST(:search_text IN BOOLEAN MODE)
                    OR MATCH(c.drug_name) AGAINST(:search_text IN BOOLEAN MODE)
                    ORDER BY a.product_name
                    LIMIT 0,:limit", [':search_text' => $text_search . '*', ':limit' => $limit, ':tenant_id' => $tenant_id]
            );
            $products = $command->queryAll();
        }
        return $products;
    }

    private function _getRoutes($products, $text_search, $tenant_id, $limit) {
        $post = Yii::$app->getRequest()->post();
        $routes = [];

        //If product has been selected
        if (isset($post['product_id']) && !empty($products)) {
            $description_id = $products[0]['product_description_id'];

            if (isset($post['route_id'])) {
                //Retrieve One route
                $command = $this->_connection->createCommand("
                        SELECT a.route_id, a.route_name AS route
                        FROM pat_prescription_route a
                        WHERE a.route_id= :route_id
                        AND a.tenant_id = :tenant_id
                        ORDER BY a.route_name
                        LIMIT 0,:limit", [':limit' => $limit, ':tenant_id' => $tenant_id, ':route_id' => $post['route_id']]
                );
            } else {
                //Retrieve routes based on description
                $command = $this->_connection->createCommand("
                        SELECT a.route_id, a.route_name AS route
                        FROM pat_prescription_route a
                        JOIN pha_descriptions_routes b
                        ON a.route_id = b.route_id
                        WHERE b.description_id = :desc_id
                        AND a.tenant_id = :tenant_id
                        ORDER BY a.route_name
                        LIMIT 0,:limit", [':limit' => $limit, ':tenant_id' => $tenant_id, ':desc_id' => $description_id]
                );
            }
            $routes = $command->queryAll();
        }

        //If product has not been selected
        if (!isset($post['product_id']) && !empty($products)) {
            //Retrieve related routes
            $command = $this->_connection->createCommand("
                    SELECT a.route_id, a.route_name as route,
                    (
                        SELECT GROUP_CONCAT(c.description_id) 
                        FROM  pha_descriptions_routes c
                        WHERE c.route_id = a.route_id
                        AND c.tenant_id = a.tenant_id
                    ) AS description_ids
                    FROM pat_prescription_route a
                    JOIN pha_descriptions_routes b
                    ON a.route_id = b.route_id
                    WHERE MATCH(a.route_name) AGAINST(:search_text IN BOOLEAN MODE)
                    AND a.tenant_id = :tenant_id
                    GROUP BY a.route_name
                    ORDER BY a.route_name
                    LIMIT 0,:limit", [':search_text' => $text_search . '*', ':limit' => $limit, ':tenant_id' => $tenant_id]
            );
            $routes = $command->queryAll();
        }
        return $routes;
    }

    private function _getFrequencies($text, $tenant_id, $limit) {
        $post = Yii::$app->getRequest()->post();
        $frequencies = [];

        $strings = $this->_getFrquenceyMatchStrings($text);

        if (!empty($strings)) {
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

            $command = $this->_connection->createCommand($query, [':limit' => $limit, ':tenant_id' => $tenant_id]);
            $frequencies = $command->queryAll();
        } else if (isset($post['route_id'])) {
            $command = $this->_connection->createCommand("
                    SELECT freq_id, freq_name as frequency 
                    FROM pat_prescription_frequency
                    WHERE tenant_id = :tenant_id
                    ORDER BY  freq_name
                    LIMIT 0,:limit", [':limit' => $limit, ':tenant_id' => $tenant_id]
            );
            $frequencies = $command->queryAll();
        }
        return $frequencies;
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
                //Validation for Route with description
                if ($pres_string == 'route' && isset($val['description_ids'])) {
                    $ids = explode(',', $val['description_ids']);
                    if (!in_array($product['product_description_id'], $ids)) {
                        continue;
                    }
                }
                //End

                $prescription = ['prescription' => $product['prescription'] . ' // ' . $val[$pres_string]];
                $new_result[] = array_merge($product, $val, $prescription);
            }
        }
        return $new_result;
    }

    //Pharmacy Products Index
    public function actionGetproducts() {
        $requestData = $_REQUEST;

        $modelClass = $this->modelClass;
        $totalData = $modelClass::find()->tenant()->active()->count();
        $totalFiltered = $totalData;

        if (!empty($requestData['search']['value'])) {
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;
            $totalFiltered = $modelClass::find()
                    ->joinWith(['productDescription', 'brand'])
                    ->andWhere([
                        'pha_product.tenant_id' => $tenant_id,
                        'pha_product.status' => '1',
                    ])
                    ->andFilterWhere([
                        'OR',
                        ['like', 'pha_product.product_name', $requestData['search']['value']],
                        ['like', 'pha_product_description.description_name', $requestData['search']['value']],
                        ['like', 'pha_brand.brand_name', $requestData['search']['value']],
                    ])
                    ->count();

            $products = $modelClass::find()
                    ->joinWith(['productDescription', 'brand'])
                    ->andWhere([
                        'pha_product.tenant_id' => $tenant_id,
                        'pha_product.status' => '1',
                    ])
                    ->andFilterWhere([
                        'OR',
                        ['like', 'pha_product.product_name', $requestData['search']['value']],
                        ['like', 'pha_product_description.description_name', $requestData['search']['value']],
                        ['like', 'pha_brand.brand_name', $requestData['search']['value']],
                    ])
                    ->limit($requestData['length'])
                    ->offset($requestData['start'])
                    ->orderBy(['created_at' => SORT_DESC])
                    ->all();
        } else {
            $products = $modelClass::find()
                    ->tenant()
                    ->active()
                    ->limit($requestData['length'])
                    ->offset($requestData['start'])
                    ->orderBy(['created_at' => SORT_DESC])
                    ->all();
        }

        $data = array();
        foreach ($products as $product) {
            $nestedData = array();
            $nestedData['product_id'] = $product->product_id;
            $nestedData['product_name'] = $product->product_name;
            $nestedData['product_code'] = $product->product_code;
            $nestedData['product_type'] = $product->productDescription->description_name;
            $nestedData['product_brand'] = $product->brand->brand_name;
            $data[] = $nestedData;
        }

        $json_data = array(
            "draw" => intval($requestData['draw']),
            "recordsTotal" => intval($totalData),
            "recordsFiltered" => intval($totalFiltered),
            "data" => $data   // total data array
        );

        echo json_encode($json_data);
    }

}
