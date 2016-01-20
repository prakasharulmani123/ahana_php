<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoDoctorSchedule;
use common\models\CoRoomChargeCategory;
use Yii;
use yii\bootstrap\Html;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\HttpBearerAuth;
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
            'class' => HttpBearerAuth::className()
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
            $model = CoRoomChargeCategory::find()->where(['charge_cat_id' => $id])->one();
            $model->remove();

            foreach ($model->roomchargesubcategory as $sub) {
                $sub->remove();
            }
            return ['success' => true];
        }
    }

    public function actionCreateschedule() {
        $post = Yii::$app->getRequest()->post();

        $model = new CoDoctorSchedule();
        $model->attributes = array(
            'user_id' => isset($post['user_id']) ? $post['user_id'] : '',
            'custom_day' => isset($post['custom_day']) ? $post['custom_day'] : '',
            'timings' => isset($post['timings']) ? $post['timings'] : '',
        );
        $valid = $model->validate();
        if (!$valid)
            return ['success' => false, 'message' => Html::errorSummary([$model])];

        foreach ($post['custom_day'] as $day) {
            if ($day['checked'] == 1) {
                foreach ($post['timings'] as $timing) {
                    $model = new CoDoctorSchedule();
                    $model->attributes = array(
                        'user_id' => $post['user_id'],
                        'schedule_day' => $day['value'],
                        'schedule_time_in' => $timing['schedule_time_in'],
                        'schedule_time_out' => $timing['schedule_time_out'],
                    );
                    $model->save(false);
                }
            }
        }
    }

}
