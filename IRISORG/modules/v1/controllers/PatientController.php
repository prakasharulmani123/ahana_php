<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoInternalCode;
use common\models\CoPatient;
use common\models\GlPatient;
use common\models\GlPatientShareResources;
use common\models\GlPatientTenant;
use common\models\PatPatient;
use common\models\PatPatientAddress;
use common\models\PatPatientCasesheet;
use common\models\PatPrescriptionFrequency;
use common\models\PatPrescriptionRoute;
use common\models\PatTimeline;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\db\Connection;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\ArrayHelper;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * PatientController implements the CRUD actions for CoTenant model.
 */
class PatientController extends ActiveController {

    public $modelClass = 'common\models\PatPatient';

    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => QueryParamAuth::className(),
            'except' => ['getpatienttimeline2']
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
            $model = CoPatient::find()->where(['patient_id' => $id])->one();
            $model->remove();

            //Remove all related records
            foreach ($model->room as $room) {
                $room->remove();
            }
            //
            return ['success' => true];
        }
    }

    public function actionRegistration() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post['PatPatient']) || !empty($post['PatPatientAddress'])) {
            $model = new PatPatient();
            $addr_model = new PatPatientAddress();

            if (isset($post['PatPatient']['patient_id'])) {
                $patient = PatPatient::find()->where(['patient_id' => $post['PatPatient']['patient_id']])->one();
                if (!empty($patient)) {
                    $model = $patient;

                    if (!empty($patient->patPatientAddress))
                        $addr_model = $patient->patPatientAddress;
                }
            }

            if (isset($post['PatPatient'])) {
                $model->attributes = $post['PatPatient'];
                if (isset($post['PatPatient']['patient_dob']) && isset($post['PatPatient']['patient_age']) && $post['PatPatient']['patient_dob'] == '' && $post['PatPatient']['patient_age']) {
                    $newdate = strtotime("-{$post['PatPatient']['patient_age']} year", strtotime(date('Y-m-d')));
                    $model->patient_dob = date('Y-m-d', $newdate);
                }
            }

            $valid = $model->validate();

            if (isset($post['PatPatientAddress'])) {
                $addr_model->attributes = $post['PatPatientAddress'];
                $valid = $addr_model->validate() && $valid;
            }

            if ($valid) {
                $model->save(false);

                if (isset($post['PatPatientAddress'])) {
                    $addr_model->patient_id = $model->patient_id;
                    $addr_model->save(false);
                }
                
                $updated_patient = PatPatient::find()->where(['patient_id' => $model->patient_id])->one();

                return ['success' => true, 'patient_id' => $model->patient_id, 'patient_guid' => $model->patient_guid, 'patient' => $updated_patient];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $addr_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionSearch() {
        $post = Yii::$app->getRequest()->post();
        $patients = [];
        $limit = 10;

        if (isset($post['search']) && !empty($post['search']) && strlen($post['search']) >= 2) {
            $text = $post['search'];

            $lists = PatPatient::find()
                    ->tenant()
                    ->active()
                    ->orOnCondition("patient_firstname like :search")
                    ->orOnCondition("patient_lastname like :search")
                    ->orOnCondition("patient_mobile like :search")
                    ->orOnCondition("patient_int_code like :search")
                    ->orOnCondition("casesheetno like :search")
                    ->addParams([':search' => "%{$text}%"])
                    ->limit($limit)
                    ->all();

            foreach ($lists as $key => $patient) {
                $patients[$key]['Patient'] = $patient;
                $patients[$key]['PatientAddress'] = $patient->patPatientAddress;
                $patients[$key]['PatientActiveEncounter'] = $patient->patActiveEncounter;
                $patients[$key]['same_branch'] = true;
                $patients[$key]['same_org'] = true;
            }

            //Search from same ORG but different branch
            if (empty($patients)) {
                $tenant_id = Yii::$app->user->identity->logged_tenant_id;
                $lists = PatPatient::find()
                        ->andWhere("status = '1' AND tenant_id != $tenant_id")
                        ->orOnCondition("patient_firstname like :search")
                        ->orOnCondition("patient_lastname like :search")
                        ->orOnCondition("patient_mobile like :search")
                        ->orOnCondition("patient_int_code like :search")
                        ->orOnCondition("casesheetno like :search")
                        ->addParams([':search' => "%{$text}%"])
                        ->limit($limit)
                        ->groupBy('patient_global_guid')
                        ->all();

                foreach ($lists as $key => $patient) {
                    $patients[$key]['Patient'] = $patient;
                    $patients[$key]['same_branch'] = false;
                    $patients[$key]['same_org'] = true;
                }

                //Search from HMS Database
                if (empty($patients)) {
                    $tenant_id = Yii::$app->user->identity->logged_tenant_id;

                    $lists = GlPatient::find()
                            ->andWhere("status = '1' AND tenant_id != $tenant_id")
                            ->orOnCondition("patient_firstname like :search")
                            ->orOnCondition("patient_lastname like :search")
                            ->orOnCondition("patient_mobile like :search")
                            ->orOnCondition("patient_int_code like :search")
                            ->orOnCondition("casesheetno like :search")
                            ->addParams([':search' => "%{$text}%"])
                            ->limit($limit)
                            ->all();

                    foreach ($lists as $key => $patient) {
                        $patients[$key]['Patient'] = $patient;
                        $patients[$key]['same_branch'] = false;
                        $patients[$key]['same_org'] = false;
                    }
                }
            }
        }
        return ['patients' => $patients];
    }

    public function actionGetagefromdate() {
        $post = Yii::$app->request->post();
        $age = '';
        if (isset($post['date'])) {
            $age = PatPatient::getPatientAge($post['date']);
        }

        return ['age' => $age];
    }

    public function actionGetnextvisitdaysfromdate() {
        $post = Yii::$app->request->post();
        $days = '';
        if (isset($post['date'])) {
            $days = PatPatient::getPatientNextVisitDays($post['date']);
        }

        return ['days' => $days];
    }

    public function actionGetdatefromage() {
        $post = Yii::$app->request->post();
        $dob = '';
        if (isset($post['age'])) {
            $dob = PatPatient::getPatientBirthdate($post['age']);
        }

        return ['dob' => $dob];
    }

    public function actionGetdatefromdays() {
        $post = Yii::$app->request->post();
        $date = '';
        if (isset($post['days'])) {
            $date = PatPatient::getPatientNextvisitDate($post['days']);
        }

        return ['date' => $date];
    }

    public function actionGetpatientaddress() {
        $get = Yii::$app->getRequest()->get();
        return ['address' => PatPatientAddress::find()->where(['patient_id' => $get['id']])->one()];
    }

    public function actionGetpatientlist() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['tenant']))
            $tenant = $get['tenant'];

        if (isset($get['status']))
            $status = strval($get['status']);

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        return ['patientlist' => PatPatient::getPatientlist($tenant, $status, $deleted)];
    }

    public function actionGetpatientbyguid() {
        $guid = Yii::$app->getRequest()->post('guid');
        $patient = PatPatient::find()->tenant()->andWhere(['patient_guid' => $guid])->one();
        if (!empty($patient)) {
            if (isset($patient->patActiveCasesheetno)) {
                return $patient;
            } else {
                $model = new PatPatientCasesheet();
                $model->attributes = [
                    'casesheet_no' => CoInternalCode::generateInternalCode('CS', 'common\models\PatPatientCasesheet', 'casesheet_no'),
                    'patient_id' => $patient->patient_id,
                    'start_date' => date("Y-m-d"),
                ];
                $model->save(false);
                CoInternalCode::increaseInternalCode("CS");
                return PatPatient::find()->tenant()->andWhere(['patient_guid' => $guid])->one();
            }
        } else {
            return ['success' => false];
        }
    }

    public function actionGetpatienttimeline() {
        $post = Yii::$app->request->post();
        $guid = $post['guid'];
        $patient = PatPatient::find()->where(['patient_guid' => $guid])->one();
        return ['timeline' => PatTimeline::find()->tenant()->andWhere(['patient_id' => $patient->patient_id])->orderBy(['created_at' => SORT_DESC])->all()];
    }

    public function actionGetpatienttimeline2() {
        $post = Yii::$app->request->post();

        if (!empty($post)) {
            $guid = $post['guid'];

            if ($post['tenant_id'] == 'all') {
                $patient_tenants = GlPatientTenant::find()->where(['patient_global_guid' => $guid])->all();

                $timelines = [];
                foreach ($patient_tenants as $key => $patient_tenant) {
                    $connection = new Connection([
                        'dsn' => "mysql:host={$patient_tenant->org->org_db_host};dbname={$patient_tenant->org->org_database}",
                        'username' => $patient_tenant->org->org_db_username,
                        'password' => $patient_tenant->org->org_db_password,
                    ]);
                    $connection->open();

                    $command = $connection->createCommand("SELECT * FROM pat_patient WHERE patient_global_guid = :guid");
                    $command->bindValue(':guid', $guid);
                    $patient = $command->queryAll();

                    $resource_lists = $this->_getPatientResourceList($patient_tenant->org_id, $patient_tenant->tenant_id, $patient_tenant->patient_global_guid);
                    $in_cond = "'" . implode("','", $resource_lists) . "'";

                    $command = $connection->createCommand("SELECT a.*, concat(b.tenant_name, ' - ', c.org_name) as branch "
                            . "FROM pat_timeline a "
                            . "JOIN co_tenant b "
                            . "ON b.tenant_id = a.tenant_id "
                            . "JOIN co_organization c "
                            . "ON c.org_id = b.org_id "
                            . "WHERE a.patient_id = :id "
                            . "AND a.tenant_id = :tenant_id "
                            . "AND a.resource IN ($in_cond) "
                            . "");
                    $command->bindValues([':id' => $patient[0]['patient_id'], ':tenant_id' => $patient_tenant->tenant_id]);
                    $timeline = $command->queryAll();

                    $connection->close();

                    $timelines = array_merge($timelines, $timeline);
                }
            } else {
                $patient = PatPatient::find()->tenant($post['tenant_id'])->andWhere(['patient_global_guid' => $guid])->one();
                $resource_lists = $this->_getPatientResourceList($patient->tenant->org_id, $post['tenant_id'], $guid);
                $timelines = PatTimeline::find()->tenant($post['tenant_id'])->andWhere([
                            'patient_id' => $patient->patient_id,
                            'resource' => $resource_lists])->orderBy(['created_at' => SORT_DESC])->all();
            }

            return ['timeline' => $timelines];
        }
    }

    protected function _getPatientResourceList($org_id, $tenant_id, $guid) {
        $patient_resources = GlPatientShareResources::find()->where([
                    'org_id' => $org_id,
                    'tenant_id' => $tenant_id,
                    'patient_global_guid' => $guid])->all();

        return ArrayHelper::map($patient_resources, 'resource', 'resource');
    }

    public function actionGetpatientroutelist() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['tenant']))
            $tenant = $get['tenant'];

        if (isset($get['status']))
            $status = strval($get['status']);

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        return ['routelist' => PatPrescriptionRoute::getRoutelist($tenant, $status, $deleted)];
    }

    public function actionGetpatientfrequencylist() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['tenant']))
            $tenant = $get['tenant'];

        if (isset($get['status']))
            $status = strval($get['status']);

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        return ['frequencylist' => PatPrescriptionFrequency::getFrequencylist($tenant, $status, $deleted)];
    }

    public function actionUploadimage() {
        $file = '';
        $post = Yii::$app->getRequest()->post();

        if (!empty($_FILES) && getimagesize($_FILES['file']['tmp_name'])) {
            $file = addslashes($_FILES['file']['tmp_name']);
            $file = file_get_contents($file);
            $file = base64_encode($file);
            $file = "data:{$_FILES['file']['type']};base64,$file";
        }

        if (isset($post['file_data'])) {
            $file = $post['file_data'];
        }

        if ($post['block'] == 'register')
            return ['success' => true, 'file' => $file];

        if ($file) {
            $model = PatPatient::find()->tenant()->andWhere(['patient_guid' => $_GET['patient_id']])->one();
            $model->patient_image = $file;
            $model->save(false);
            return ['success' => true, 'patient' => $model];
        } else {
            return ['success' => false, 'message' => 'Invalid File'];
        }
    }

    public function actionImportpatient() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post)) {
            $model = new PatPatient;

            $unset_attr = [
                'patient_id',
                'patient_guid',
                'patient_int_code',
                'tenant_id',
                'status',
                'created_by',
                'created_at',
                'modified_by',
                'modified_at',
                'fullname',
                'patient_age',
                'tenant_name',
                'org_name',
            ];
            $unset_attr = array_combine($unset_attr, $unset_attr);
            $post = array_diff_key($post, $unset_attr);

            $model->attributes = $post;

            if ($model->save(false)) {
                return ['success' => true, 'patient' => $model];
            } else {
                return ['success' => false, 'message' => 'Failed to import'];
            }
        }
    }
    
    public function actionGetpatient() {
        $post = Yii::$app->getRequest()->post();
        $patients = [];
        $limit = 10;

        if (isset($post['search']) && !empty($post['search']) && strlen($post['search']) >= 2) {
            $text = $post['search'];

            $lists = PatPatient::find()
                    ->tenant()
                    ->active()
                    ->orOnCondition("patient_firstname like :search")
                    ->orOnCondition("patient_lastname like :search")
                    ->orOnCondition("patient_int_code like :search")
                    ->addParams([':search' => "%{$text}%"])
                    ->limit($limit)
                    ->all();

            foreach ($lists as $key => $patient) {
                $patients[$key]['Patient'] = $patient;
                $patients[$key]['PatientAddress'] = $patient->patPatientAddress;
                $patients[$key]['PatientActiveEncounter'] = $patient->patActiveEncounter;
            }
        }
        return ['patients' => $patients];
    }

}
