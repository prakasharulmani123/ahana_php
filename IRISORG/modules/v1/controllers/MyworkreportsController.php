<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatConsultant;
use common\models\PatEncounter;
use Yii;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class MyworkreportsController extends ActiveController {

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

    public function actionOpdoctorpaymentreport() {
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        $encounters = PatEncounter::find()
                ->joinWith('patAppointmentSeen')
                ->joinWith("patAppointmentSeen.consultant")
                ->joinWith("patient")
                ->joinWith("patient.patGlobalPatient")
                ->andWhere(['pat_encounter.tenant_id' => $tenant_id])
                ->andWhere('pat_encounter.deleted_at = "0000-00-00 00:00:00"');

        if (isset($post['from']) && isset($post['to']) && isset($post['consultant_id'])) {
            $encounters->andWhere("date(pat_encounter.encounter_date) between '{$post['from']}' AND '{$post['to']}'");
            $encounters->andWhere("pat_appointment.consultant_id = {$post['consultant_id']}");
        }

        $encounters->addSelect(["CONCAT(co_user.title_code, '', co_user.name) as op_doctor_payment_consultant_name"]);
        $encounters->addSelect(["CONCAT(pat_global_patient.patient_title_code, '', pat_global_patient.patient_firstname) as op_doctor_payment_patient_name"]);
        $encounters->addSelect(["pat_appointment.amount as op_doctor_payment_amount"]);
        $encounters->addSelect(["pat_appointment.status_date as op_doctor_payment_seen_date"]);
        $encounters->addSelect(["pat_appointment.status_time as op_doctor_payment_seen_time"]);

        $encounters = $encounters->all();

        $reports = [];
        $total = 0;

        foreach ($encounters as $key => $encounter) {
            $reports[$key]['consultant_name'] = $encounter['op_doctor_payment_consultant_name'];
            $reports[$key]['patient_name'] = $encounter['op_doctor_payment_patient_name'];
            $reports[$key]['payment_amount'] = $encounter['op_doctor_payment_amount'];
            $reports[$key]['op_seen_date_time'] = $encounter['op_doctor_payment_seen_date'] . " " . $encounter['op_doctor_payment_seen_time'];
            $total += $encounter['op_doctor_payment_amount'];
        }

        return ['report' => $reports, 'total' => $total];
    }

    public function actionDocmonthlypayreport() {
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        $consultants = PatConsultant::find()
                ->joinWith("patient")
                ->joinWith("patient.patGlobalPatient")
                ->joinWith("consultant")
                ->joinWith("encounter")
                ->andWhere(['pat_encounter.tenant_id' => $tenant_id])
                ->andWhere('pat_consultant.deleted_at = "0000-00-00 00:00:00"');

        if (isset($post['from']) && isset($post['to']) && isset($post['consultant_id'])) {
            $consultants->andWhere("date(pat_consultant.consult_date) between '{$post['from']}' AND '{$post['to']}'");
            $consultants->andWhere("pat_consultant.consultant_id = {$post['consultant_id']}");
        }

        $consultants->addSelect(["CONCAT(co_user.title_code, '', co_user.name) as report_consultant_name"]);
        $consultants->addSelect(["CONCAT(pat_global_patient.patient_title_code, '', pat_global_patient.patient_firstname) as report_patient_name"]);
        $consultants->addSelect(["COUNT(pat_consultant.charge_amount) as report_total_visit"]);
        $consultants->addSelect(["SUM(pat_consultant.charge_amount) as report_total_charge_amount"]);
        $consultants->groupBy(["pat_consultant.consultant_id", "pat_consultant.patient_id"]);
        $consultants->orderBy(["pat_global_patient.patient_firstname" => SORT_ASC]);

        $consultants = $consultants->all();

        $reports = [];
        $total = 0;

        foreach ($consultants as $key => $encounter) {
            $reports[$key]['consultant_name'] = $encounter['report_consultant_name'];
            $reports[$key]['patient_name'] = $encounter['report_patient_name'];
            $reports[$key]['total_visit'] = $encounter['report_total_visit'];
            $reports[$key]['total_charge_amount'] = $encounter['report_total_charge_amount'];
            $total += $encounter['report_total_charge_amount'];
        }

        return ['report' => $reports, 'total' => $total];
    }

    public function actionAdvancedetails() {
        $model = PatEncounter::find()
                ->tenant()
                ->status()
                ->encounterType("IP")
                ->orderBy([
                    'encounter_date' => SORT_DESC,
                ])
                ->all();

        return $model;
    }

}
