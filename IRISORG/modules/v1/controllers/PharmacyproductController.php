<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaDrugClass;
use common\models\PhaDrugGeneric;
use common\models\PhaProduct;
use common\models\PhaProductBatch;
use common\models\PhaProductDescription;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\mssql\PDO;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\helpers\Url;
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
        $get = Yii::$app->getRequest()->get();
        $modelClass = $this->modelClass;

        $query = $modelClass::find()->tenant()->status()->active()->orderBy(['created_at' => SORT_DESC]);

        if (isset($get['not_expired'])) {
            $query->not_expired();
        }

        return new ActiveDataProvider([
            'query' => $query,
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

    public function actionGetdrugproductbygeneric() {
        $get = Yii::$app->getRequest()->get();
        $id = $get['generic_id'];

        $drug = PhaDrugGeneric::find()->tenant()->andWhere(['generic_id' => $id])->active()->one();
        $products = PhaProduct::find()->tenant()->andWhere(['generic_id' => $id])->active()->all();

        return ['drug' => $drug, 'productList' => $products];
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

    //Not used for data table model
    public function actionGetbatchdetails() {
        $get = Yii::$app->getRequest()->get();
        $condition = '';
        $filters = '';
        $modelClass = 'common\models\PhaProductBatch';
        $relations = ['product', 'product.productDescription', 'phaProductBatchRate', 'product.salesPackage', 'product.salesVat'];

        $offset = abs($get['pageIndex'] - 1) * $get['pageSize'];

        if (isset($get['s'])) {
            $condition['batch_no'] = $get['s'];
        }

        if (isset($get['text'])) {
            $filters = [
                'OR',
                    ['like', 'pha_product_description.description_name', $get['text']],
                    ['like', 'pha_product.product_name', $get['text']],
                    ['like', 'pha_product.product_unit_count', $get['text']],
                    ['like', 'pha_product.product_unit', $get['text']],
                    ['like', 'pha_product_batch_rate.mrp', $get['text']],
                    ['like', 'pha_package_unit.package_name', $get['text']],
                    ['like', 'pha_vat.vat', $get['text']],
            ];
        }

        //Count batch details value
        $count = $modelClass::find()->joinWith($relations)->tenant()->status();
        if ($condition) {
            $count->andWhere($condition);
        }
        if ($filters) {
            $count->andFilterWhere($filters);
        }
        $totalCount = $count->count();

        //Fetch the batch details result
        $result = $modelClass::find()
                ->joinWith($relations)
                ->tenant()
                ->status();
        if ($condition) {
            $result->andWhere($condition);
        }
        if ($filters) {
            $result->andFilterWhere($filters);
        }
        $result->limit($get['pageSize'])
                ->offset($offset);


        $productLists = $result->all();

        return ['success' => true, 'productLists' => $productLists, 'totalCount' => $totalCount];
    }

    public function actionSearchbycriteria() {
        //print_r($_REQUEST); die;
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        $offset = abs($_REQUEST['pageIndex'] - 1) * $_REQUEST['pageSize'];

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

            $productCount = PhaProductBatch::find()
                    ->addSelect([$having_column])
                    ->joinWith('product')
                    ->joinWith('phaProductBatchRate')
                    ->andWhere(['pha_product.tenant_id' => $tenant_id])
                    ->andHaving("search_column LIKE '$text'")
                    ->count();
            $totalCount = $productCount;
            $products = PhaProductBatch::find()
                    ->addSelect(["*", $having_column])
                    ->joinWith('product')
                    ->joinWith('phaProductBatchRate')
                    ->andWhere(['pha_product.tenant_id' => $tenant_id])
                    ->andHaving("search_column LIKE '$text'")
                    ->limit($_REQUEST['pageSize'])
                    ->offset($offset)
                    ->orderBy($_REQUEST['sortOptions'])
                    ->all();
        } else {
            $products = PhaProductBatch::find()
                    ->joinWith('product')
                    ->tenant()
                    ->limit($_REQUEST['pageSize'])
                    ->offset($offset)
                    ->orderBy($_REQUEST['sortOptions'])
                    ->all();
            $totalCount = PhaProductBatch::find()->tenant()->count();
        }

        return ['productLists' => $products, 'totalCount' => $totalCount];
    }

    public function actionAdjuststock() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post)) {
            $model = PhaProductBatch::find()->tenant()->andWhere(['batch_id' => $post['batch_id']])->one();
            if (!empty($model)) {
                $model->stock_adjust = true;
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

                    return ['success' => true];
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

//            $text_search = str_replace([' ', '(', ')'], ['* ', '', ''], $text);
            $text_search = "+" . str_replace([' ', '(', ')'], [' +', '', ''], $text);

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
                    MATCH(a.product_name) AGAINST (:search_text IN BOOLEAN MODE) AS score,
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
                    WHERE (a.tenant_id = :tenant_id AND MATCH(a.product_name) AGAINST(:search_text IN BOOLEAN MODE))
                    AND (b.tenant_id = :tenant_id AND MATCH(b.generic_name) AGAINST(:search_text IN BOOLEAN MODE))
                    OR (c.tenant_id = :tenant_id AND MATCH(c.drug_name) AGAINST(:search_text IN BOOLEAN MODE))
                    ORDER BY score DESC, a.product_name
                    LIMIT 0,:limit", [':search_text' => $text_search . '*', ':limit' => $limit, ':tenant_id' => $tenant_id]
            );
        }
        $products = $command->queryAll();

        //Below not need
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
                    WHERE (a.tenant_id = :tenant_id AND MATCH(a.product_name) AGAINST(:search_text IN BOOLEAN MODE))
                    OR (b.tenant_id = :tenant_id AND MATCH(b.generic_name) AGAINST(:search_text IN BOOLEAN MODE))
                    OR (c.tenant_id = :tenant_id AND MATCH(c.drug_name) AGAINST(:search_text IN BOOLEAN MODE))
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

        //Nad
        if (empty($new_result))
            return $products;

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

    public function actionGetbatchlists() {
        $list = PhaProductBatch::find()->status()->active()->select('batch_no')->distinct()->all();
        return $list;
//        echo 'asdasa'; die;
    }

    public function actionStockbatchwiseimport() {
        $get = Yii::$app->getRequest()->get();
        $allowed = array('csv');
        $filename = $_FILES['file']['name'];
        $ext = pathinfo($filename, PATHINFO_EXTENSION);
        if (!in_array($ext, $allowed)) {
            return ['success' => false, 'message' => 'Unsupported File Format. CSV Files only accepted'];
        }
        $uploadPath = 'uploads/';
        if (!file_exists($uploadPath)) {
            mkdir($uploadPath, 0777, true);
        }
        $uploadFile = $uploadPath . $filename;
        if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadFile)) {
            $file = Url::to($uploadFile);
            $result = $this->stockimport($file, $get['tenant_id'], $get['import_log']);
            if(!empty($result)){
                            return ['success' => true, 'message' => $result];

            } else {
                return ['success' => false, 'message' => 'Failed to import. Try again later'];
            }
        } else {
            return ['success' => false, 'message' => 'Failed to import. Try again later'];
        }
    }

    public function stockimport($filename, $tenant_id, $log) {
        $connection = Yii::$app->client;
        $connection->open();

        $row = 1;
        if (($handle = fopen($filename, "r")) !== FALSE) {
            while (($data = fgetcsv($handle)) !== FALSE) {
                //skip header row 
                if ($row++ == 1) {
                    continue;
                }

                $sql = "INSERT INTO test_os_batch_wise(tenant_id, Name, Add_Spec1, Batch, ExpiryMy, Total, SelfValCost, SelfValue, mrp, import_log) VALUES('{$tenant_id}', '{$data[0]}','{$data[1]}', '{$data[2]}', '{$data[3]}','{$data[4]}', '{$data[5]}', '{$data[6]}', '{$data[7]}', '{$log}')";

                $command = $connection->createCommand($sql);
                $command->execute();
            }
            // close the file
            fclose($handle);
            // return the messages
            @unlink($filename);
            $command = $connection->createCommand("SELECT COUNT(*) AS 'total_rows', (SELECT MIN(id) FROM test_os_batch_wise WHERE import_log = $log) AS id,
                                            (SELECT MAX(id) FROM test_os_batch_wise WHERE import_log = $log) AS max_id
                                            FROM test_os_batch_wise WHERE import_log = $log");
            $result = $command->queryAll(PDO::FETCH_OBJ);
            $connection->close();
            return $result[0];
        }
    }

    public function expiryDate($date) {
        $expMY = $date;
        $expDate = '01/' . $expMY;
        $expArray = explode('/', $expDate);
        if ($expArray[2]) {
            $dt = date_create_from_format('y', $expArray[2]);
            $expArray[2] = $dt->format('Y');
            $date = implode('-', $expArray);
            return $date = date('Y-m-d', strtotime($date));
        }
        return false;
    }
    
    private function _updateBatchRate($tenant_id, $batch_id, $mrp, $package_unit) {
        $batch_rate_exists = \common\models\PhaProductBatchRate::find()->andWhere([
                    'tenant_id' => $tenant_id,
                    'batch_id' => $batch_id])
                ->one(); //, 'mrp' => $mrp
        if (empty($batch_rate_exists)) {
            $batch_rate = new \common\models\PhaProductBatchRate();
            $batch_rate->mrp = $mrp;
        } else {
            $batch_rate = $batch_rate_exists;
        }
        //Per Unit Price
        $per_unit_price = $mrp / $package_unit;
        $batch_rate->tenant_id = $tenant_id;
        $batch_rate->per_unit_price = $per_unit_price;
        $batch_rate->batch_id = $batch_id;
        $batch_rate->created_by = '-1';
        $batch_rate->save(false);
        return $batch_rate;
    }

    public function actionStockimportstart() {
        $post = Yii::$app->getRequest()->post();
        $id = $post['id'];
        $import_log = $post['import_log'];
        $max_id = $post['max_id'];

        if ($id <= $max_id) {
            $next_id = $id + 1;
            $connection = Yii::$app->client;
            $connection->open();
            $command = $connection->createCommand("SELECT * FROM test_os_batch_wise WHERE id = {$id} AND import_log = $import_log");
            $result = $command->queryAll(PDO::FETCH_OBJ);
            if ($result) {
                $result = $result[0];
                $product_exists = \common\models\PhaProduct::find()->where([
                            'tenant_id' => $result->tenant_id,
                            'product_name' => $result->Name
                        ])
                        ->one();
                if (!empty($product_exists)) {
                    if ($result->Add_Spec1 != '' && $result->mrp != '') {
                        $package_unit = (int) $result->Add_Spec1;
                        if ($package_unit) {
                            if ($result->Batch != '') {
                                if ($expiry_date = $this->expiryDate($result->ExpiryMy)) {
                                    $batch_exists = \common\models\PhaProductBatch::find()
                                            ->andWhere([
                                                'tenant_id' => $result->tenant_id,
                                                'product_id' => $product_exists->product_id,
                                                'batch_no' => $result->Batch,
                                                'expiry_date' => $expiry_date,
                                            ])
                                            ->one();
                                    if (empty($batch_exists)) {
                                        $batch = new \common\models\PhaProductBatch();
                                        $batch->tenant_id = $result->tenant_id;
                                        $batch->product_id = $product_exists->product_id;
                                        $batch->batch_no = $result->Batch;
                                        $batch->expiry_date = $expiry_date;
                                        $batch->package_unit = $package_unit;
                                        $batch->package_name = $result->Add_Spec1;
                                        $batch->total_qty = $result->Total;
                                        $batch->available_qty = $result->Total;
                                        $batch->created_by = -1;
                                        $batch->save(false);

                                        $this->_updateBatchRate($result->tenant_id, $batch->batch_id, $result->mrp, $package_unit);
                                        $return = ['success' => true, 'continue' => $next_id, 'message' => 'success'];
                                    } else {
                                        $return = ['success' => false, 'continue' => $next_id, 'message' => 'Duplicate batch entry'];
                                    }
                                } else {
                                    $return = ['success' => false, 'continue' => $next_id, 'message' => 'Expiry date format is invalid'];
                                }
                            } else {
                                $return = ['success' => false, 'continue' => $next_id, 'message' => 'Batch is empty'];
                            }
                        } else {
                            $return = ['success' => false, 'continue' => $next_id, 'message' => 'Package unit is not integer'];
                        }
                    } else {
                        $return = ['success' => false, 'continue' => $next_id, 'message' => 'Package unit / MRP is empty'];
                    }
                } else {
                    $return = ['success' => false, 'continue' => $next_id, 'message' => 'Product Not exists'];
                }
            } else {
                $return = ['success' => false, 'continue' => $next_id, 'message' => 'Import data not found'];
            }
        } else {
            $return = ['success' => false, 'continue' => 0];
        }

        if ($return['continue']) {
            $status = $return['success'] ? 1 : 0;
            $message = $return['message'];
//            $message = str_replace('<p>Please fix the following errors:</p>', '', $return['message']);
            $sql = "UPDATE test_os_batch_wise SET `status` = '{$status}', response = '{$message}' WHERE id={$id}";
            $command = $connection->createCommand($sql);
            $command->execute();
            $connection->close();
        }
        return $return;
    }

    public function actionImport() {
        $get = Yii::$app->getRequest()->get();
        $allowed = array('csv');
        $filename = $_FILES['file']['name'];
        $ext = pathinfo($filename, PATHINFO_EXTENSION);
        if (!in_array($ext, $allowed)) {
            return ['success' => false, 'message' => 'Unsupported File Format. CSV Files only accepted'];
        }
        $uploadPath = 'uploads/';
        if (!file_exists($uploadPath)) {
            mkdir($uploadPath, 0777, true);
        }
        $uploadFile = $uploadPath . $filename;
        if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadFile)) {
            $file = Url::to($uploadFile);
            $result = $this->import($file, $get['tenant_id'], $get['import_log']);
            return ['success' => true, 'message' => $result];
        } else {
            return ['success' => false, 'message' => 'Failed to import. Try again later'];
        }
    }

    public function import($filename, $tenant_id, $log) {
        $connection = Yii::$app->client;
        $connection->open();

        $row = 1;
        if (($handle = fopen($filename, "r")) !== FALSE) {
            while (($data = fgetcsv($handle)) !== FALSE) {
                //skip header row 
                if ($row++ == 1) {
                    continue;
                }

                $product_name = $data[0];
                $product_desc = $data[1];
                $brand = $data[2];
                $generic = $data[3];
                $drug = $data[4];
                $route = $data[5];
                $purchase_unit = $data[6];
                $sale_unit = $data[7];
                $sale_tax = $data[8];
                $purchase_tax = $data[9];

                $sql = "INSERT INTO test_product_import(tenant_id, product_name, group_name, brand, generic_name, drug_class, route, purchase_unit, sale_unit, purchase_tax, sale_tax, import_log) VALUES('{$tenant_id}','{$product_name}', '{$product_desc}', '{$brand}', '{$generic}', '{$drug}', '{$route}', '{$purchase_unit}', '{$sale_unit}', '{$purchase_tax}', '{$sale_tax}', '{$log}')";
                $command = $connection->createCommand($sql);
                $command->execute();
            }
            // close the file
            fclose($handle);
            // return the messages
            @unlink($filename);
            $command = $connection->createCommand("SELECT COUNT(*) AS 'total_rows', (SELECT MIN(id) FROM test_product_import WHERE import_log = $log) AS id,
                                            (SELECT MAX(id) FROM test_product_import WHERE import_log = $log) AS max_id
                                            FROM test_product_import WHERE import_log = $log");
            $result = $command->queryAll(PDO::FETCH_OBJ);
            $connection->close();
            return $result[0];
        }
    }

    public function actionImportstart() {
        $post = Yii::$app->getRequest()->post();
        $id = $post['id'];
        $import_log = $post['import_log'];
        $max_id = $post['max_id'];

        if ($id <= $max_id) {
            $next_id = $id + 1;
            $connection = Yii::$app->client;
            $connection->open();
            $command = $connection->createCommand("SELECT * FROM test_product_import WHERE id = {$id} AND import_log = $import_log");
            $result = $command->queryAll(PDO::FETCH_OBJ);
            if ($result) {
                $result = $result[0];
                if ($result->product_name != '') {
                    $post_data = [];
                    $post_data['formtype'] = 'add';
                    $post_data['tenant_id'] = $result->tenant_id;
                    $post_data['product_name'] = $result->product_name;
                    $post_data['description_name'] = $result->group_name;
                    $post_data['brand_name'] = $result->brand;
                    $post_data['generic_name'] = $result->generic_name;
                    $post_data['drug_name'] = $result->drug_class;
                    $post_data['route_name'] = $result->route;
                    $post_data['purchase_package'] = $result->purchase_unit;
                    $post_data['sales_package'] = $result->sale_unit;
                    $post_data['purchase_vat'] = $result->purchase_tax;
                    $post_data['sales_vat'] = $result->sale_tax;
                    $post_data['product_reorder'] = 50;
                    $post_data['product_reorder_max'] = 50;
                    $post_data['product_reorder_min'] = 0;

                    //Check & Get Brand
                    $brand_id = $this->getBrand($post_data['tenant_id'], $post_data['brand_name']);
                    if ($brand_id) {
                        //Check combination of Product and brand exists 
                        if (!$this->productExists($post_data['tenant_id'], $brand_id, $post_data['product_name'])) {
                            $product_description_id = $this->getDescription($post_data['tenant_id'], $post_data['description_name']);
                            $generic_id = $this->getGeneric($post_data['tenant_id'], $post_data['generic_name']);
                            $drug_class_id = $this->getDrugclass($post_data['tenant_id'], $post_data['drug_name']);
                            $this->assignDrugGeneric($post_data['tenant_id'], $generic_id, $drug_class_id);
                            $purchase_package_id = $this->getPackageUnit($post_data['tenant_id'], $post_data['purchase_package']);
                            $sales_package_id = $this->getPackageUnit($post_data['tenant_id'], $post_data['sales_package']);
                            $purchase_vat_id = $this->getVat($post_data['tenant_id'], $post_data['purchase_vat']);
                            $sales_vat_id = $this->getVat($post_data['tenant_id'], $post_data['sales_vat']);

                            $new_product = new PhaProduct();
                            $new_product->product_name = $post_data['product_name'];
                            $new_product->product_description_id = $product_description_id;
                            $new_product->product_reorder_min = $post_data['product_reorder_min'];
                            $new_product->product_reorder_max = $post_data['product_reorder_max'];
                            $new_product->brand_id = $brand_id;
                            $new_product->generic_id = $generic_id;
                            $new_product->drug_class_id = $drug_class_id;
                            $new_product->purchase_vat_id = $purchase_vat_id;
                            $new_product->purchase_package_id = $purchase_package_id;
                            $new_product->sales_vat_id = $sales_vat_id;
                            $new_product->sales_package_id = $sales_package_id;
                            $new_product->save(false);

                            $return = ['success' => true, 'continue' => $next_id, 'message' => 'success'];
                        } else {
                            $return = ['success' => false, 'continue' => $next_id, 'message' => 'Product exists'];
                        }
                    }
                } else {
                    $return = ['success' => false, 'continue' => $next_id, 'message' => 'Product name not found'];
                }
            } else {
                $return = ['success' => false, 'continue' => $next_id, 'message' => 'Import data not found'];
            }
        } else {
            $return = ['success' => false, 'continue' => 0];
        }

        if ($return['continue']) {
            $status = $return['success'] ? 1 : 0;
            $message = $return['message'];
//            $message = str_replace('<p>Please fix the following errors:</p>', '', $return['message']);
            $sql = "UPDATE test_product_import SET `status` = '{$status}', response = '{$message}' WHERE id={$id}";
            $command = $connection->createCommand($sql);
            $command->execute();
            $connection->close();
        }
        return $return;
    }

    private function getVat($tenant_id, $vat) {
        $vat = (int) $vat;
        $phavat = \common\models\PhaVat::find()
                ->tenant($tenant_id)
                ->andWhere(['vat' => $vat])
                ->one();

        if (!empty($phavat)) {
            $vat_id = $phavat->vat_id;
        } else {
            $new_vat = new \common\models\PhaVat();
            $new_vat->vat = $vat;
            $new_vat->save(false);
            $vat_id = $new_vat->vat_id;
        }
        return $vat_id;
    }

    private function getPackageUnit($tenant_id, $package_name) {
        $package_unit = \common\models\PhaPackageUnit::find()
                ->tenant($tenant_id)
                ->andWhere(['package_name' => $package_name])
                ->one();

        if (!empty($package_unit)) {
            $package_id = $package_unit->package_id;
        } else {
            $new_package_unit = new \common\models\PhaPackageUnit();
            $new_package_unit->package_name = $package_name;
            $new_package_unit->package_unit = $package_name;
            $new_package_unit->save(false);
            $package_id = $new_package_unit->package_id;
        }
        return $package_id;
    }

    private function assignDrugGeneric($tenant_id, $generic_id, $drug_class_id) {
        $drugGeneric = PhaDrugGeneric::find()
                ->tenant($tenant_id)
                ->andWhere(['generic_id' => $generic_id])
                ->one();
        //Assign only empty
        if (empty($drugGeneric)) {
            $new_drug_generic = new PhaDrugGeneric();
            $new_drug_generic->drug_class_id = $drug_class_id;
            $new_drug_generic->generic_id = $generic_id;
            $new_drug_generic->save(false);
        }
        return true;
    }

    private function getDrugclass($tenant_id, $drug_name) {
        $drug = PhaDrugClass::find()
                ->tenant($tenant_id)
                ->andWhere(['drug_name' => $drug_name])
                ->one();

        if (!empty($drug)) {
            $drug_class_id = $drug->drug_class_id;
        } else {
            $new_drug = new PhaDrugClass();
            $new_drug->drug_name = $drug_name;
            $new_drug->save(false);
            $drug_class_id = $new_drug->drug_class_id;
        }
        return $drug_class_id;
    }

    private function getGeneric($tenant_id, $generic_name) {
        $generic = \common\models\PhaGeneric::find()
                ->tenant($tenant_id)
                ->andWhere(['generic_name' => $generic_name])
                ->one();

        if (!empty($generic)) {
            $generic_id = $generic->generic_id;
        } else {
            $new_generic = new \common\models\PhaGeneric();
            $new_generic->generic_name = $generic_name;
            $new_generic->save(false);
            $generic_id = $new_generic->generic_id;
        }
        return $generic_id;
    }

    private function getDescription($tenant_id, $description_name) {
        $description = PhaProductDescription::find()
                ->tenant($tenant_id)
                ->andWhere(['description_name' => $description_name])
                ->one();

        if (!empty($description)) {
            $description_id = $description->description_id;
        } else {
            $new_description = new PhaProductDescription();
            $new_description->description_name = $description_name;
            $new_description->save(false);
            $description_id = $new_description->description_id;
        }
        return $description_id;
    }

    private function getBrand($tenant_id, $brand_name) {
        $brand = \common\models\PhaBrand::find()
                ->tenant($tenant_id)
                ->andWhere(['brand_name' => $brand_name])
                ->one();
        if (!empty($brand)) {
            $brand_id = $brand->brand_id;
        } else {
            $new_brand = new \common\models\PhaBrand();
            $new_brand->brand_name = $brand_name;
            $new_brand->brand_code = "AH_" . time() . "_" . rand(10, 100);
            $new_brand->save(false);
            $brand_id = $new_brand->brand_id;
        }
        return $brand_id;
    }

    private function productExists($tenant_id, $brand_id, $product_name) {
        $product = PhaProduct::find()
                ->tenant($tenant_id)
                ->andWhere([
                    'brand_id' => $brand_id,
                    'product_name' => $product_name
                ])
                ->one();

        if (!empty($product)) {
            return true;
        } else {
            return false;
        }
    }

    private function productDescriptionRoute($tenant_id, $product_name) {
        
    }

    //Not used for data table model
//public function actionGetbatchdetails() {
//        $requestData = $_REQUEST;
//
//        $modelClass = 'common\models\PhaProductBatch';
//        $totalData = $modelClass::find()->tenant()->status()->count();
//        $totalFiltered = $totalData;
//
//        // Order Records
////        if (isset($requestData['order'])) {
////            if ($requestData['order'][0]['dir'] == 'asc') {
////                $sort_dir = SORT_ASC;
////            } elseif ($requestData['order'][0]['dir'] == 'desc') {
////                $sort_dir = SORT_DESC;
////            }
////            $order_array = [$requestData['columns'][$requestData['order'][0]['column']]['data'] => $sort_dir];
////        }
////        
//        // Search Records
//        if (!empty($requestData['search']['value'])) {
//            $relations = ['product', 'product.productDescription', 'phaProductBatchRate', 'product.salesPackage', 'product.salesVat'];
//            $filters = [
//                'OR',
//                    ['like', 'pha_product_description.description_name', $requestData['search']['value']],
//                    ['like', 'pha_product.product_name', $requestData['search']['value']],
//                    ['like', 'pha_product.product_unit_count', $requestData['search']['value']],
//                    ['like', 'pha_product.product_unit', $requestData['search']['value']],
//                    ['like', 'pha_product_batch.batch_no', $requestData['search']['value']],
//                    ['like', 'pha_product_batch_rate.mrp', $requestData['search']['value']],
//                    ['like', 'pha_package_unit.package_name', $requestData['search']['value']],
//                    ['like', 'pha_vat.vat', $requestData['search']['value']],
//            ];
//            $conditions = [
//                'pha_product_batch.tenant_id' => Yii::$app->user->identity->logged_tenant_id,
//                'pha_product_batch.status' => '1',
//            ];
//            $totalFiltered = $modelClass::find()
//                    ->joinWith($relations)
//                    ->andWhere($conditions)
//                    ->andFilterWhere($filters)
//                    ->count();
//
//            $products = $modelClass::find()
//                    ->joinWith($relations)
//                    ->andWhere($conditions)
//                    ->andFilterWhere($filters)
//                    ->limit($requestData['length'])
//                    ->offset($requestData['start'])
////                    ->orderBy($order_array)
//                    ->all();
//        } else {
//            $products = $modelClass::find()
//                    ->tenant()
//                    ->status()
//                    ->limit($requestData['length'])
//                    ->offset($requestData['start'])
//                    ->orderBy(['created_at' => SORT_DESC])
//                    ->all();
//        }
//
//        $data = array();
//        foreach ($products as $product) {
//            $nestedData = array();
//            $nestedData['description_name'] = $product->product->productDescription->description_name;
//            $nestedData['full_name'] = $product->product->fullName;
//            $nestedData['batch_no'] = $product->batch_no;
//            $nestedData['expiry_date'] = date("M-Y", strtotime($product->expiry_date));
//            $nestedData['mrp'] = $product->phaProductBatchRate->mrp;
//            $nestedData['sales_package_name'] = $product->product->salesPackage->package_name;
//            $nestedData['sale_vat_percent'] = $product->product->salesVat->vat;
//            $nestedData['batch_id'] = $product->batch_id;
//            $data[] = $nestedData;
//        }
//
//        $json_data = array(
//            "draw" => intval($requestData['draw']),
//            "recordsTotal" => intval($totalData),
//            "recordsFiltered" => intval($totalFiltered),
//            "data" => $data   // total data array
//        );
//
//        echo json_encode($json_data);
//    }
}
