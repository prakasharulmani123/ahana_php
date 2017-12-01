<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatBillingLog;
use common\models\PatBillingPayment;
use common\models\PatPatient;
use common\models\PhaSale;
use common\models\CoAuditLog;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PatientbillingpaymentController extends ActiveController {

    public $modelClass = 'common\models\PatBillingPayment';

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
            $model = PatBillingPayment::find()->where(['payment_id' => $id])->one();
            $model->remove();
            $activity = 'Billing Deleted Successfully (#' . $model->encounter_id . ' )';
            CoAuditLog::insertAuditLog(PatBillingPayment::tableName(), $id, $activity);
            return ['success' => true];
        }
    }

    public function actionBillinghistory() {
        $GET = Yii::$app->getRequest()->get();

        if (!empty($GET)) {
            $patient = PatPatient::getPatientByGuid($GET['id']);

            $condition['patient_id'] = $patient->patient_id;
            $condition['encounter_id'] = $GET['enc_id'];

            $data = PatBillingLog::find()
                    ->tenant()
                    ->active()
                    ->status()
                    ->andWhere($condition)
                    ->orderBy(['date_time' => SORT_DESC])
                    ->all();

            return ['success' => true, 'result' => $data];
        }
    }

    public function actionSavesettlementbill() {
        $post = Yii::$app->getRequest()->post();
        if (in_array("purchase", $post['bills'])  && $post['pharmacy_paid_amount']!=0)
            PhaSale::billpayment($post['pharmacy_sale_id'], $post['pharmacy_paid_amount'], $post['payment_date']);
        if (in_array("billing", $post['bills']) && $post['billing_paid_amount']!=0) {
            $model = new PatBillingPayment;
            $model->attributes = [
                'encounter_id' => $post['encounter_id'],
                'patient_id' => $post['patient_id'],
                'payment_date' => $post['payment_date'],
                'payment_mode' => $post['payment_mode'],
                'payment_amount' => $post['billing_paid_amount'],
                'category' => 'S',
            ];
            $model->save();
        }
        return ['success' => true];
    }

}
