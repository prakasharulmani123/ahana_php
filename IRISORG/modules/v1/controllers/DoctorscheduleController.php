<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoDoctorSchedule;
use Yii;
use yii\bootstrap\Html;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * RoomChargeCategoryController implements the CRUD actions for CoTenant model.
 */
class DoctorscheduleController extends ActiveController {

    public $modelClass = 'common\models\CoDoctorSchedule';

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

    public function actionRemoveall() {
        $id = Yii::$app->getRequest()->post('id');
        if ($id) {
            $model = CoDoctorSchedule::find()->where(['user_id' => $id])->all();
            foreach ($model as $docSch) {
                $docSch->remove();
            }
            return ['success' => true];
        }
    }

    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('id');
        if ($id) {
            $model = CoDoctorSchedule::find()->where(['schedule_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }

    public function actionCreateschedule() {
        $post = Yii::$app->getRequest()->post();

        $model = new CoDoctorSchedule();
        $model->scenario = 'create';

        $model->attributes = array(
            'user_id' => isset($post['user_id']) ? $post['user_id'] : '',
            'custom_day' => isset($post['custom_day']) ? $post['custom_day'] : '',
            'timings' => isset($post['timings']) ? $post['timings'] : '',
        );
        $valid = $model->validate();
        if (!$valid)
            return ['success' => false, 'message' => Html::errorSummary([$model])];

//        if ($post['day_type'] == 'A') {
//            $deleted = CoDoctorSchedule::find()->tenant()->where('user_id = :user_id and schedule_day != :schedule_day', ['user_id' => $post['user_id'], 'schedule_day' => '-1'])->all();
//        } else if ($post['day_type'] == 'C') {
//            $deleted = CoDoctorSchedule::find()->tenant()->where('user_id = :user_id and schedule_day = :schedule_day', ['user_id' => $post['user_id'], 'schedule_day' => '-1'])->all();
//        }
//        if (isset($deleted) && !empty($deleted)){
//            foreach ($deleted as $delete) {
//                $delete->delete();
//            }
//        }
        foreach ($post['custom_day'] as $day) {
            if ($day['checked'] == 1) {
                foreach ($post['timings'] as $timing) {
                    $day_value = $post['day_type'] == 'A' ? '-1' : $day['value'];

                    $attr = [
                        'user_id' => $post['user_id'],
                        'schedule_day' => $day_value,
                        'schedule_time_in' => date('H:i:s', strtotime($timing['schedule_time_in'])),
                        'schedule_time_out' => date('H:i:s', strtotime($timing['schedule_time_out'])),
                    ];

                    $exists = CoDoctorSchedule::find()->tenant()->active()->andwhere($attr)->one();

                    if (empty($exists)) {
                        $new_model = new CoDoctorSchedule();
                        $new_model->attributes = $attr;
                        $new_model->save(false);
                    }
                }
            }
        }
    }

    public function actionGetdoctortimeschedule() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post)) {
            if (isset($post['doctor_id']) && isset($post['schedule_date']) && $post['doctor_id'] != '' && $post['schedule_date'] != '') {
                $doctor_id = $post['doctor_id'];
                $schedule_day = date('N', strtotime($post['schedule_date']));

                $all_schedules = CoDoctorSchedule::find()
                        ->where('schedule_day = :day', [':day' => $schedule_day])
                        ->orWhere('schedule_day = :allday', [':allday' => "-1"])
                        ->andWhere('user_id = :doctor_id', [':doctor_id' => $doctor_id])
                        ->orderBy('schedule_time_in')
                        ->all();

                $timerange = array();
                if (!empty($all_schedules)) {
                    foreach ($all_schedules as $all_schedule) {
                        $timerange = $timerange + self::getTimeScheduleSlots($all_schedule['schedule_time_in'], $all_schedule['schedule_time_out'], '5');
                    }
                }

                return ['success' => true, 'timerange' => $timerange];
            } else {
                return ['success' => false];
            }
        } else {
            return ['success' => false];
        }
    }

    public static function getTimeScheduleSlots($startTime, $endTime, $interval) {
        $array_of_time = array();
        $start_time = strtotime($startTime);
        $end_time = strtotime($endTime);
        $interval_mins = $interval * 60;

        while ($start_time <= $end_time) {
            $array_of_time[] = array("time" => date("H:i:s", $start_time));
            $start_time += $interval_mins;
        }

        return $array_of_time;
    }

}
