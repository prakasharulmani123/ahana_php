<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoInternalCode;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * RoleController implements the CRUD actions for CoTenant model.
 */
class InternalcodeController extends ActiveController {

    public $modelClass = 'common\models\CoInternalCode';

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
            'query' => $modelClass::find()->tenant()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }

    public function actionGetinternalcode() {
        $code_type = Yii::$app->request->get('code_type');
        if (!empty($code_type)) {
            $code = CoInternalCode::find()->tenant()->where(['code_type' => $code_type])->one();
            return ['success' => true, 'code' => $code];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    protected function excludeColumns($attrs) {
        $exclude_cols = ['created_by', 'created_at', 'modified_by', 'modified_at'];
        foreach ($attrs as $col => $val) {
            if (in_array($col, $exclude_cols))
                unset($attrs[$col]);
        }
        return $attrs;
    }

//
//    public function actionCreaterole() {
//        $post = Yii::$app->request->post();
//        if (!empty($post)) {
//            $model = new CoRole();
//            $model->attributes = $post;
//
//            $valid = $model->validate();
//            if ($valid) {
//                $model->save(false);
//
//                return ['success' => true];
//            } else {
//                return ['success' => false, 'message' => Html::errorSummary([$model])];
//            }
//        } else {
//            return ['success' => false, 'message' => 'Please Fill the Form'];
//        }
//    }
//
//    public function actionUpdaterole() {
//        $post = Yii::$app->request->post();
//        if (!empty($post)) {
//            $model = CoRole::findOne($post['role_id']);
//            $model->attributes = $post;
//
//            $valid = $model->validate();
//
//            if ($valid) {
//                $model->save(false);
//                return ['success' => true];
//            } else {
//                return ['success' => false, 'message' => Html::errorSummary([$model])];
//            }
//        } else {
//            return ['success' => false, 'message' => 'Please Fill the Form'];
//        }
//    }
//
//    public function actionGetrole() {
//        $id = Yii::$app->request->get('id');
//        if (!empty($id)) {
//            $data = CoRole::findOne($id);
//            $return = $this->excludeColumns($data->attributes);
//            return ['success' => true, 'return' => $return];
//        } else {
//            return ['success' => false, 'message' => 'Invalid Access'];
//        }
//    }
}
