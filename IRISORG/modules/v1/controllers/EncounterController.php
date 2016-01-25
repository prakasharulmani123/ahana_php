<?php
namespace IRISORG\modules\v1\controllers;

use common\models\PatAdmission;
use common\models\PatAppoinment;
use common\models\PatEncounter;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;


/**
 * EncounterController implements the CRUD actions for CoTenant model.
 */
class EncounterController extends ActiveController {

    public $modelClass = 'common\models\PatEncounter';

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
            $model = CoEncounter::find()->where(['patient_id' => $id])->one();
            $model->remove();

            //Remove all related records
            foreach ($model->room as $room) {
                $room->remove();
            }
            //
            return ['success' => true];
        }
    }

    public function actionCreateappointment() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            $model = new PatEncounter();
            $appt_model = new PatAppoinment();
            
            $model_attr = array(
                'patient_id' => (isset($post['patient_id']) ? $post['patient_id'] : ''),
                'encounter_type' => 'OP',
            );
            $model->attributes = $model_attr;

            $appt_model->attributes = $post;

            $valid = $model->validate();
            $valid = $appt_model->validate() && $valid;

            if ($valid) {
                $model->save(false);

                $appt_model->encounter_id = $model->encounter_id;
                $appt_model->save(false);

                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $appt_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionCreateadmission() {
        $post = Yii::$app->getRequest()->post();
        if (!empty($post)) {
            $model = new PatEncounter();
            $admission_model = new PatAdmission();
            
            $model->encounter_type = "IP";
            $model->attributes = $post['PatEncounter'];
            $admission_model->attributes = $post['PatAdmission'];

            $valid = $model->validate();
            $valid = $admission_model->validate() && $valid;

            if ($valid) {
                $model->save(false);

                $admission_model->encounter_id = $model->encounter_id;
                $admission_model->save(false);

                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $admission_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

}
