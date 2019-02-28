<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PhaProductBatch;
use common\models\PhaPurchase;
use common\models\PhaSale;
use common\models\PhaSaleReturn;
use common\models\PhaSaleReturnItem;
use common\models\PhaPurchaseItem;
use Yii;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\ArrayHelper;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PharmacyreportController extends ActiveController {

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

    public function actionPurchasereport() {
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        $model = PhaPurchase::find()
                ->andWhere("pha_purchase.invoice_date between '{$post['from']}' AND '{$post['to']}'");
        if (isset($post['payment_type'])) {
            $model->andWhere(['pha_purchase.payment_type' => $post['payment_type']]);
        }
        if (isset($post['tenant_id'])) {
            $tenant_ids = join("','", $post['tenant_id']);
            $model->andWhere("pha_purchase.tenant_id IN ( '$tenant_ids' )");
        }
        $reports = $model->all();

        return ['report' => $reports];
    }

    public function actionNewpurchasereport() {
        $post = Yii::$app->getRequest()->post();

        $model = PhaPurchaseItem::find()->active()
                ->tenant()
                ->joinWith(['purchase'])
                ->andWhere("pha_purchase.invoice_date between '{$post['from']}' AND '{$post['to']}'");
        if (isset($post['payment_type'])) {
            $model->andWhere(['pha_purchase.payment_type' => $post['payment_type']]);
        }
        $reports = $model->all();

        return ['report' => $reports];
    }

    public function actionPurchasegstreport() {
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
        return $this->_get_gst_report($post, $tenant_id);
    }
    
    public function _get_gst_report($params , $tenant_id) {
        $sql = "SELECT
                a.purchase_id,
                a.purchase_code,
                a.invoice_no,
                a.invoice_date,
                a.payment_type,
                c.supplier_name,
                (cgst_percent+sgst_percent) AS tax_rate,
                SUM(b.taxable_value)      AS taxable_value,
                SUM(b.cgst_amount)        AS cgst_amount,
                b.cgst_percent        AS cgst_percent,
                SUM(b.sgst_amount)        AS sgst_amount,
                b.sgst_percent        AS sgst_percent,
                a.roundoff_amount,
                a.net_amount
              FROM `pha_purchase` `a`
                LEFT JOIN `pha_purchase_item` `b`
                  ON `a`.`purchase_id` = `b`.`purchase_id`
                LEFT JOIN `pha_supplier` c
                  ON `c`.`supplier_id` = `a`.`supplier_id`
              WHERE ((`a`.`tenant_id` = '" . $tenant_id . "')
                     AND (a.invoice_date BETWEEN '" . $params['from'] . "'
                          AND '" . $params['to'] . "') AND (`a`.`payment_type` = '" . $params['payment_type'] . "'))
                  AND (b.deleted_at = '0000-00-00 00:00:00')
                  AND (a.deleted_at = '0000-00-00 00:00:00')
              GROUP BY `b`.`purchase_id`,`b`.`cgst_percent`";
        $command = Yii::$app->client_pharmacy->createCommand($sql);
        $reports = $command->queryAll();
        return ['report' => $reports];
    }

    //Sale Report
    public function actionSalereport() {
        $post = Yii::$app->getRequest()->post();

        $model = PhaSale::find()->active()
                ->joinWith(['encounter'])
                ->tenant()
                ->andWhere("pha_sale.sale_date between '{$post['from']}' AND '{$post['to']}'");


        if (isset($post['encounter_type'])) {

            if (count($post['encounter_type']) == '1') {
                if (in_array("NO", $post['encounter_type'])) {
                    $model->andWhere(['pha_sale.encounter_id' => null]);
                } else {
                    $model->andWhere(['pat_encounter.encounter_type' => $post['encounter_type']]);
                }
            } else if (count($post['encounter_type']) == '2') {
                if (in_array("NO", $post['encounter_type'])) {
                    $model->andWhere(['or',
                        ['pat_encounter.encounter_type' => $post['encounter_type'][0]],
                        ['pha_sale.encounter_id' => null]
                    ]);
                } else {
                    $model->andWhere(['or',
                        ['pat_encounter.encounter_type' => 'OP'],
                        ['pat_encounter.encounter_type' => 'IP']
                    ]);
                }
            } else {
                $model->andWhere(['or',
                    ['pat_encounter.encounter_type' => 'OP'],
                    ['pat_encounter.encounter_type' => 'IP'],
                    ['pha_sale.encounter_id' => null]
                ]);
            }
        } else {
            $model->andWhere(['or',
                ['pat_encounter.encounter_type' => 'OP'],
                ['pat_encounter.encounter_type' => 'IP'],
                ['pha_sale.encounter_id' => null]
            ]);
        }

//        if (isset($post['encounter_type']) && $post['encounter_type'] != 'NO') {
//            $model->andWhere(['pat_encounter.encounter_type' => $post['encounter_type']]);
//        } else if (isset($post['encounter_type']) && $post['encounter_type']=='NO') {
//            $model->andWhere(['pha_sale.encounter_id' => null]);
//        } 

        if (isset($post['patient_group_name'])) {
            $patient_group_names = join("','", $post['patient_group_name']);
            $model->andWhere("pha_sale.patient_group_name IN ( '$patient_group_names' )");
        }

        $reports = $model->all();

        return ['report' => $reports];
    }

    //Sale Vat Report
    public function actionSalevatreport() {
        $dbname = Yii::$app->client->createCommand("SELECT DATABASE()")->queryScalar();
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
        $current_database = Yii::$app->db->createCommand("SELECT DATABASE()")->queryScalar();
        $sql = "SELECT
                    a.sale_id,a.bill_no,a.sale_date,
                    d.patient_global_int_code, a.patient_name,
                    (cgst_percent+sgst_percent) AS tax_rate,
                    SUM(b.taxable_value) AS taxable_value,  
                    SUM(b.cgst_amount) AS cgst_amount,
                    SUM(b.sgst_amount) AS sgst_amount,
                    a.roundoff_amount,
                    a.bill_amount
                FROM `pha_sale` `a`
                    LEFT JOIN `pha_sale_item` `b`
                    ON `a`.`sale_id` = `b`.`sale_id`
                    LEFT JOIN " . $dbname . ".pat_patient c
                    ON c.patient_id = a.patient_id
                    LEFT JOIN $current_database.gl_patient d
                    ON c.patient_global_guid = d.patient_global_guid
                    WHERE ((`a`.`tenant_id` = '" . $tenant_id . "')
                    AND (a.sale_date BETWEEN '" . $post['from'] . "' AND '" . $post['to'] . "'))
                    AND (b.deleted_at = '0000-00-00 00:00:00')
                    AND (a.deleted_at = '0000-00-00 00:00:00')
                    GROUP BY `b`.`sale_id`,`b`.`cgst_percent` ";
        //$command = Yii::$app->client->createCommand($sql);
        $command = Yii::$app->client_pharmacy->createCommand($sql);
        $reports = $command->queryAll();
        return ['report' => $reports];
    }

    //Sale Return Report
    public function actionSalereturnreport() {
        $post = Yii::$app->getRequest()->post();
        if (isset($post['encounter_type'])) {
            if (count($post['encounter_type']) == '1') {
                if (in_array("NO", $post['encounter_type'])) {
                    $encounter_condition = "AND ((e.encounter_id IS NULL))";
                } else {
                    $encounter_condition = "AND ((f.encounter_type =  " . $post['encounter_type'] . "))";
                }
            } else if (count($post['encounter_type']) == '2') {
                if (in_array("NO", $post['encounter_type'])) {
                    $encounter_condition = "AND ((f.encounter_type = 'OP') OR (e.encounter_id IS NULL))";
                } else {
                    $encounter_condition = "AND ((f.encounter_type = 'OP') OR (f.encounter_type = 'IP'))";
                }
            } else {
                $encounter_condition = "AND ((f.encounter_type = 'OP') OR (f.encounter_type = 'IP') OR (e.encounter_id IS NULL))";
            }
        } else {
            $encounter_condition = "AND ((f.encounter_type = 'OP') OR (f.encounter_type = 'IP') OR (e.encounter_id IS NULL))";
        }
        if (isset($post['patient_group_name'])) {
            $patient_group_names = join("','", $post['patient_group_name']);
            $group_name = "AND e.patient_group_name IN ( '$patient_group_names' )";
        } else {
            $group_name = '';
        }
        $dbname = Yii::$app->client->createCommand("SELECT DATABASE()")->queryScalar();
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
        $current_database = Yii::$app->db->createCommand("SELECT DATABASE()")->queryScalar();
        $sql = "SELECT
                    a.sale_ret_id,a.bill_no,a.sale_date,
                    a.sale_return_date,e.bill_no AS sale_bill_no,
                    d.patient_global_int_code, a.patient_name,
                    (cgst_percent+sgst_percent) AS tax_rate,
                    SUM(b.taxable_value) AS taxable_value,  
                    SUM(b.cgst_amount) AS cgst_amount,
                    SUM(b.sgst_amount) AS sgst_amount,
                    a.roundoff_amount,
                    f.encounter_id, f.encounter_type,
                    a.bill_amount
                FROM `pha_sale_return` `a`
                    LEFT JOIN `pha_sale_return_item` `b`
                    ON `a`.`sale_ret_id` = `b`.`sale_ret_id`
                    LEFT JOIN `pha_sale` `e`
                    ON `a`.`sale_id` = `e`.`sale_id`
                    Left JOIN " . $dbname . ". pat_encounter f
                    ON `f`.`encounter_id` = `e`.`encounter_id`
                    LEFT JOIN " . $dbname . ".pat_patient c
                    ON c.patient_id = a.patient_id
                    LEFT JOIN $current_database.gl_patient d
                    ON c.patient_global_guid = d.patient_global_guid
                    WHERE ((`a`.`tenant_id` = '" . $tenant_id . "')
                    AND (a.sale_return_date BETWEEN '" . $post['from'] . "' AND '" . $post['to'] . "'))
                    $group_name $encounter_condition
                    AND (b.deleted_at = '0000-00-00 00:00:00')
                    AND (a.deleted_at = '0000-00-00 00:00:00')
                    GROUP BY `b`.`sale_ret_id`,`b`.`cgst_percent` ";
        //$command = Yii::$app->client->createCommand($sql);
        $command = Yii::$app->client_pharmacy->createCommand($sql);
        $reports = $command->queryAll();
        return ['report' => $reports];
        /* Comments : Sale Return report need to group by cgst percent like sale gst report so hide this coding */
//        $model = PhaSaleReturnItem::find()->active()
//                ->tenant()
//                ->joinWith('saleRet')
//                ->joinWith('saleRet.sale')
//                ->joinWith('saleRet.sale.encounter')
//                ->andWhere("pha_sale_return.sale_return_date between '{$post['from']}' AND '{$post['to']}'");
//
//        if (isset($post['encounter_type'])) {
//            if (count($post['encounter_type']) == '1') {
//                if (in_array("NO", $post['encounter_type'])) {
//                    $model->andWhere(['pha_sale.encounter_id' => null]);
//                } else {
//                    $model->andWhere(['pat_encounter.encounter_type' => $post['encounter_type']]);
//                }
//            } else if (count($post['encounter_type']) == '2') {
//                if (in_array("NO", $post['encounter_type'])) {
//                    $model->andWhere(['or',
//                        ['pat_encounter.encounter_type' => $post['encounter_type'][0]],
//                        ['pha_sale.encounter_id' => null]
//                    ]);
//                } else {
//                    $model->andWhere(['or',
//                        ['pat_encounter.encounter_type' => 'OP'],
//                        ['pat_encounter.encounter_type' => 'IP']
//                    ]);
//                }
//            } else {
//                $model->andWhere(['or',
//                    ['pat_encounter.encounter_type' => 'OP'],
//                    ['pat_encounter.encounter_type' => 'IP'],
//                    ['pha_sale.encounter_id' => null]
//                ]);
//            }
//        } else {
//            $model->andWhere(['or',
//                ['pat_encounter.encounter_type' => 'OP'],
//                ['pat_encounter.encounter_type' => 'IP'],
//                ['pha_sale.encounter_id' => null]
//            ]);
//        }
//
//        if (isset($post['patient_group_name'])) {
//            $patient_group_names = join("','", $post['patient_group_name']);
//            $model->andWhere("pha_sale.patient_group_name IN ( '$patient_group_names' )");
//        }
//
//        $reports = $model->all();


        return ['report' => $reports];
    }

    //Prescriptionregister Report
    public function actionPrescriptionregisterreport() {
        $post = Yii::$app->getRequest()->post();

//        $model = PhaSale::find()
//                ->andWhere(['not', ['pha_sale.patient_id' => null]]);
//
//        if (isset($post['from']) && isset($post['consultant_id']) && isset($post['tenant_id'])) {
//            $consultant_ids = join("','", $post['consultant_id']);
//            $tenant_ids = join("','", $post['tenant_id']);
//            $model->andWhere(["pha_sale.sale_date" => $post['from']]);
//            $model->andWhere("pha_sale.consultant_id IN ( '$consultant_ids' )");
//            $model->andWhere("pha_sale.tenant_id IN ( '$tenant_ids' )");
//        }
//
//        $reports = $model->all();
        //Valli requirement, report depends on prescription not sales
        $model = \common\models\PatPrescription::find();
        if (isset($post['from']) && isset($post['consultant_id']) && isset($post['tenant_id'])) {
            $consultant_ids = join("','", $post['consultant_id']);
            $tenant_ids = $post['tenant_id'];
            $model->andWhere(["date(pres_date)" => $post['from']]);
            $model->andWhere("pat_prescription.consultant_id IN ( '$consultant_ids' )");
            $model->andWhere("pat_prescription.tenant_id IN ( '$tenant_ids' )");
        }
        $reports = $model->all();
        return ['report' => $reports];
    }

    public function actionGetsalegrouplist() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['tenant']))
            $tenant = $get['tenant'];

        if (isset($get['status']))
            $status = strval($get['status']);

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        $saleGroups = PhaSale::find()
                ->tenant($tenant)
                ->status($status)
                ->active()
                ->andWhere("patient_group_name != ''")
                ->groupBy('patient_group_name')
                ->all();

        $saleGroupsList = [];
        if (!empty($saleGroups)) {
            $saleGroupsList = ArrayHelper::map($saleGroups, 'patient_group_name', 'patient_group_name');
        }

        return ['saleGroupsList' => $saleGroupsList];
    }

    public function actionStockasonreport() {
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
        $conncection = Yii::$app->client;
        $command = $conncection->createCommand("
            SELECT
                pha_product.product_name,  
                pha_product_batch.batch_no,
                pha_product_batch.available_qty, 
                pha_purchase_item.purchase_rate, 
                pha_product_batch.available_qty * pha_purchase_item.purchase_rate AS TotalRate,
                pha_purchase_item.discount_percent, 
                FORMAT((SELECT TotalRate) * (pha_purchase_item.discount_percent / 100), 2) AS disAmount,
                IFNULL(FORMAT((SELECT TotalRate) - (SELECT disAmount), 2),(SELECT TotalRate)) AS `selfValue`
            FROM `pha_product_batch`
                LEFT JOIN `pha_product`
                  ON `pha_product_batch`.`product_id` = `pha_product`.`product_id`
                LEFT JOIN `pha_purchase_item`
                  ON `pha_product_batch`.`batch_id` = `pha_purchase_item`.`batch_id`
            WHERE `pha_product_batch`.`tenant_id` = {$tenant_id}
               AND pha_purchase_item.tenant_id = {$tenant_id}
               AND pha_purchase_item.purchase_item_id =  (SELECT MAX(purchase_item_id) FROM pha_purchase_item WHERE batch_id = pha_product_batch.batch_id)
            ORDER BY `product_name` DESC
           
        ");
        $stock_report = $command->queryAll();
        return ['stock_report' => $stock_report];
    }

    public function actionStockreport() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            //$conncection = Yii::$app->client;
            $conncection = Yii::$app->client_pharmacy;
            $command = $conncection->createCommand("CALL pha_stock_report_by_date({$post['tenant_id']}, '{$post['from']}');");
            $stock_report = $command->queryAll();
            return ['stock_report' => $stock_report];
        }
    }

    //Not using now 
//    public function actionStockreport() {
//        $post = Yii::$app->getRequest()->post();
//        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
//
//        $stocks = PhaProductBatch::find()
//                ->joinWith('product')
//                ->joinWith('phaProductBatchRate')
//                ->andWhere(['pha_product.tenant_id' => $tenant_id])
//                ->addSelect([
//                    "CONCAT(
//                        IF(pha_product.product_name IS NULL OR pha_product.product_name = '', ' ', pha_product.product_name),
//                        IF(pha_product.product_unit_count IS NULL OR pha_product.product_unit_count = '', ' ', CONCAT(' | ', pha_product.product_unit_count)),
//                        IF(pha_product.product_unit IS NULL OR pha_product.product_unit = '', ' ', CONCAT(' | ', pha_product.product_unit))
//                    ) as product_name",
//                    'SUM(available_qty) as available_qty',
//                    'pha_product.product_code as product_code',
//                    'pha_product_batch_rate.mrp as mrp'])
//                ->groupBy(['pha_product.product_id'])
//                ->all();
//
//        $reports = [];
//
//        foreach ($stocks as $key => $purchase) {
//            $reports[$key]['product_name'] = $purchase['product_name'];
//            $reports[$key]['product_code'] = $purchase['product_code'];
//            $reports[$key]['mrp'] = $purchase['mrp'];
//            $reports[$key]['available_qty'] = $purchase['available_qty'];
//            $reports[$key]['stock_value'] = $purchase['mrp'] * $purchase['available_qty'];
//        }
//
//        return ['report' => $reports];
//    }
}
