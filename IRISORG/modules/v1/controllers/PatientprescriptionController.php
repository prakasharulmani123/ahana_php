<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatPatient;
use common\models\PatPrescription;
use common\models\PatPrescriptionFrequency;
use common\models\PatPrescriptionItems;
use common\models\PatPrescriptionRoute;
use common\models\PhaDescriptionsRoutes;
use common\models\PatDiagnosis;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\db\Query;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PatientprescriptionController extends ActiveController {

    public $modelClass = 'common\models\PatPrescription';

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
            $model = PatPrescription::find()->where(['pres_id' => $id])->one();
            $model->remove();

//            //Remove all related records
//            foreach ($model->room as $room) {
//                $room->remove();
//            }
//            //

            return ['success' => true];
        }
    }

    public function actionSaveprescription() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post) && !empty($post['prescriptionItems'])) {
            $model = new PatPrescription;
            $model->attributes = $post;
            if (!empty($post['diag_text']) && empty($model->diag_id)) {
                $diag_model = new PatDiagnosis();
                $diag_model->diag_description = $post['diag_text'];
                $diag_model->save(false);
                $model->diag_id = $diag_model->diag_id;
            }
            $valid = $model->validate();

            foreach ($post['prescriptionItems'] as $key => $item) {
                $item_model = new PatPrescriptionItems();
                $item_model->scenario = 'saveform';
                $item_model->attributes = $item;
                $valid = $item_model->validate() && $valid;
                if (!$valid)
                    break;
            }

            if ($valid) {
                $model->save(false);

                foreach ($post['prescriptionItems'] as $key => $item) {
                    $item_model = new PatPrescriptionItems();
                    $item_model->pres_id = $model->pres_id;
                    $item_model->consultant_id = $model->consultant_id;
                    $item_model->attributes = $item;
                    $item_model->setFrequencyId();
                    $item_model->setRouteId();
                    $item_model->save(false);
                }

                $consult_name = '';
                if (isset($model->consultant)) {
                    $consult_name = $model->consultant->title_code . $model->consultant->name;
                }
                return ['success' => true, 'pres_id' => $model->pres_id, 'date' => date('d-M-Y H:i'), 'model' => ['consultant_name' => $consult_name, 'consultant_id' => $model->consultant_id]];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $item_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Prescriptions cannot be blank'];
        }
    }

    public function actionGetpreviousprescription() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['patient_id'])) {
            $patient = PatPatient::getPatientByGuid($get['patient_id']);

            if (isset($get['encounter_id'])) {
                $encounter_id = $get['encounter_id'];
                $data = PatPrescription::find()->tenant()->active()->andWhere(['patient_id' => $patient->patient_id, 'encounter_id' => $encounter_id])->orderBy(['created_at' => SORT_DESC])->all();
            } else {

                if (isset($get['date']) && $get['date'] != "") {
                    $pres_date = $get['date'];
                    $data = PatPrescription::find()->tenant()->active()->andWhere(['patient_id' => $patient->patient_id, 'DATE(pres_date)' => $pres_date])->orderBy(['created_at' => SORT_DESC])->all();
                } else {
                    $data = PatPrescription::find()->tenant()->active()->andWhere(['patient_id' => $patient->patient_id])->orderBy(['created_at' => SORT_DESC])->all();
                }
            }
            return ['success' => true, 'prescriptions' => $data];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionGetsaleprescription() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['patient_id'])) {
            $patient = PatPatient::getPatientByGuid($get['patient_id']);
            if (isset($get['encounter_id'])) {
                $encounter_id = $get['encounter_id'];
                $data = PatPrescription::find()
                        ->tenant()
                        ->active()
                        ->andWhere([
                            'patient_id' => $patient->patient_id,
                            'encounter_id' => $encounter_id
                        ])
                        ->orderBy(['created_at' => SORT_DESC])
                        ->one();
            }
            return ['success' => true, 'prescription' => $data];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    /* pharmacy_prodesc.js */

    public function actionGetactiveroutes() {
        $routes = PatPrescriptionRoute::find()->tenant()->active()->status()->all();
        return ['success' => true, 'routes' => $routes];
    }

    public function actionGetdescriptionroutes() {
        $id = Yii::$app->request->get('id');
        if (!empty($id)) {
            $routes = PhaDescriptionsRoutes::find()->tenant()->andWhere(['description_id' => $id])->all();
            return ['success' => true, 'routes' => $routes];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionGetconsultantfreq() {
        $get = Yii::$app->request->get();
        if (!empty($get)) {
            $freq = PatPrescriptionFrequency::find()
                    ->tenant()
                    ->status()
                    ->active()
                    ->andWhere(['consultant_id' => $get['consultant_id']])
                    ->orderBy(['created_at' => SORT_DESC])
                    ->all();
            return ['success' => true, 'freq' => $freq];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionGetconsultantnoofdays() {
        $get = Yii::$app->request->get();
        if (!empty($get)) {
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;
            $connection = Yii::$app->client;
            $command = $connection->createCommand("SELECT pat_prescription_items.number_of_days FROM pat_prescription LEFT JOIN pat_prescription_items ON pat_prescription_items.pres_id = pat_prescription.pres_id WHERE (pat_prescription.tenant_id=:tenant_id) AND (pat_prescription.deleted_at=:deleted_at) AND (pat_prescription.status=:status) AND (pat_prescription.consultant_id=:consultant_id) ORDER BY pat_prescription.created_at DESC ", [':tenant_id' => $tenant_id, ':deleted_at' => '0000-00-00 00:00:00', ':status' => '1', ':consultant_id' => $get['consultant_id']]);
            $result = $command->queryAll();
            $connection->close();
            return ['success' => true, 'noofdays' => $result];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionFrequencyremove() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $frequency = PatPrescriptionFrequency::find()->tenant()->andWhere(['freq_id' => $post['id'], 'consultant_id' => $post['consultant_id']])->one();
            $frequency->status = 0;
            $frequency->save(false);
            return ['success' => true];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionGetdiagnosis() {
        $get = Yii::$app->getRequest()->get();
        $text = $get['diag_description'];
        $Diag = PatDiagnosis::find()
                ->andFilterWhere([
                    'or',
                        ['like', 'diag_name', $text],
                        ['like', 'diag_description', $text],
                ])
                ->limit(25)
                ->all();
        return $Diag;
    }

}
