<?php
namespace IRISORG\modules\v1\controllers;

use common\models\PatAppointment;
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
class AppointmentController extends ActiveController {

    public $modelClass = 'common\models\PatAppointment';

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

    public function actionChangestatus() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            $appt_model = new PatAppointment();
            $appt_model->scenario = 'seen_status';
            $appt_model->attributes = $post;
            $valid = $appt_model->validate();

            if ($valid) {
                $appt_model->save(false);
                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary($appt_model)];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('id');
        if ($id) {
            $model = PatAppointment::find()->where(['city_id' => $id])->one();
            $model->remove();
            return ['success' => true];
        }
    }
    
    public function actionGetfutureappointments(){
        $future_appointments = PatAppointment::getFutureAppointments();
        return $future_appointments;
    }

}
