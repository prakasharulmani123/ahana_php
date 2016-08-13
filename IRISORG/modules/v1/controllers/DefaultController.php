<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoChargePerCategory;
use common\models\CoLogin;
use common\models\CoMasterCity;
use common\models\CoMasterCountry;
use common\models\CoMasterState;
use common\models\CoOrganization;
use common\models\CoRolesResources;
use common\models\CoUsersRoles;
use common\models\PatAppointment;
use common\models\PatDiagnosis;
use common\models\PatEncounter;
use Yii;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\ArrayHelper;
use yii\web\Controller;
use yii\web\Response;

class DefaultController extends Controller {

    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => QueryParamAuth::className(),
            'only' => ['getnavigation', 'getconsultantcharges'],
        ];
        $behaviors['contentNegotiator'] = [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
            ],
        ];

        return $behaviors;
    }

    public function actionIndex() {
        echo "AAAAAAA";
        exit;
        return $this->render('index');
    }

    public function actionGetCountryList() {
        $list = array();
        $data = CoMasterCountry::getCountrylist();
        foreach ($data as $value => $label) {
            $list[] = array('value' => $value, 'label' => $label);
        }
        return ['countryList' => $list];
    }

    public function actionGetStateList() {
        $list = array();
        $datas = CoMasterState::find()->all();
        foreach ($datas as $data) {
            $list[] = array('value' => $data->state_id, 'label' => $data->state_name, 'countryId' => $data->country_id);
        }
        return ['stateList' => $list];
    }

    public function actionGetCityList() {
        $list = array();
        $datas = CoMasterCity::find()->all();
        foreach ($datas as $data) {
            $list[] = array('value' => $data->city_id, 'label' => $data->city_name, 'stateId' => $data->state_id);
        }
        return ['cityList' => $list];
    }

    public function actionChangeStatus() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $modelName = $post['model'];
            $primaryKey = $post['id'];
            $modelClass = "common\\models\\$modelName";
            $model = $modelClass::findOne($primaryKey);
            $model->status = 1 - $model->status;
            $model->save(false);
            return ['success' => "ok", 'sts' => $model->status];
        }
    }

    public function actionGetTenantList() {
        $org = CoOrganization::findOne(['org_domain' => DOMAIN_PATH]);
        
        if(empty($org))
            return ['success' => false, 'message' => 'There is no organization assigned for this domain.'];
        
        $list = ArrayHelper::map($org->coActiveTenants, 'tenant_id', 'tenant_name');
        
        return ['tenantList' => $list, 'org_sts' => $org->status, 'success' => true];
    }

    public function actionError() {
        $exception = Yii::$app->errorHandler->exception;
        if ($exception !== null) {
            return ['success' => false, 'message' => "Error {$exception->statusCode} : {$exception->getMessage()} !!!"];
        }
    }

    public function actionGetnavigation() {
        $get = Yii::$app->request->get();
        $user_id = Yii::$app->user->identity->user->user_id;
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        $role_ids = ArrayHelper::map(CoUsersRoles::find()->where(['user_id' => $user_id])->all(), 'role_id', 'role_id');
        $resource_ids = ArrayHelper::map(CoRolesResources::find()->where(['IN', 'role_id', $role_ids])->andWhere(['tenant_id' => $tenant_id])->all(), 'resource_id', 'resource_id');

        $menus = CoRolesResources::getModuleTreeByResourcename($get['resourceName']);

        foreach ($menus as $key => $menu) {
            if (in_array($menu['value'], $resource_ids)) {
                foreach ($menu['children'] as $ckey => $child) {
                    if (in_array($child['value'], $resource_ids)) {
                        foreach ($child['children'] as $ckey2 => $child2) {
                            if (!in_array($child2['value'], $resource_ids)) {
                                unset($menus[$key]['children'][$ckey]['children'][$ckey2]);
                            }
                        }
                    } else {
                        unset($menus[$key]['children'][$ckey]);
                    }
                }
            } else {
                unset($menus[$key]);
            }
        }

        return ['navigation' => $menus[0]['children']];
    }

    public function actionGetconsultantcharges() {
        $get = Yii::$app->request->get();
        if (!empty($get)) {
            $charge_code_id = $get['consultant_id'];
            return ['success' => true, 'chargesList' => CoChargePerCategory::getConsultantCharges($charge_code_id)];
        }
    }

    public function actionDailycron() {
        $organizations = CoOrganization::find()->andWhere(['status' => '1'])->all();
        
        foreach ($organizations as $key => $organization) {
            foreach ($organization->coTenants as $key => $tenant) {

                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, "{$organization->org_domain}/api/IRISORG/web/v1/default/updatebilling");
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, ['tenant_id' => $tenant->tenant_id]);  //Post Fields
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

                $headers = array();
                $headers[] = "x-domain-path: {$organization->org_domain}";

                curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
                $server_output = curl_exec($ch);
                curl_close($ch);

//                print $server_output;
            }
        }
    }

    public function actionUpdatebilling() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $active_encounters = PatEncounter::find()->tenant($post['tenant_id'])->status()->active()->all();
            
            foreach ($active_encounters as $key => $active_encounter) {
                Yii::$app->hepler->updateRecurring($active_encounter->patCurrentAdmissionExecptClinicalDischarge);
            }
            
            //Cancel Old Active Appointments
            $today = date("Y-m-d");
            $op_encounters = PatEncounter::find()
                    ->tenant($post['tenant_id'])
                    ->status()
                    ->active()
                    ->encounterType("OP")
                    ->andWhere(["<", "DATE(encounter_date)", $today])
                    ->all();

            foreach ($op_encounters as $op_encounter) {
                $user = CoLogin::findOne(['user_id' => $op_encounter->created_by]);
                Yii::$app->user->login($user);
                $data = array();
                $data['appt_status'] = "C";
                $data['encounter_id'] = $op_encounter->encounter_id;
                $data['status_time'] = date("H:i:s");
                $data['status_date'] = date("Y-m-d");
                $data['patient_id'] = $op_encounter->patient_id;
                $data['tenant_id'] = $post['tenant_id'];

                $model = new PatAppointment;
                $model->attributes = $data;
                $model->save(false);
                Yii::$app->user->logout();
            }
        }
    }
    
    public function actionGetDiagnosisList() {
        $list = array();
        $data = PatDiagnosis::find()->all();
        foreach ($data as $key => $value) {
            $list[] = array('label' => $value->diag_name . '-' . $value->diag_description);
        }
        return ['diagnosisList' => $list];
    }
}
