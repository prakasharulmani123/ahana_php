<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoLogin;
use common\models\CoRole;
use common\models\CoUser;
use common\models\CoUsersRoles;
use common\models\LoginForm;
use common\models\PasswordResetRequestForm;
use common\models\ResetPasswordForm;
use IRISORG\models\ContactForm;
use Yii;
use yii\base\InvalidParamException;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\db\Expression;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * User controller
 */
class UserController extends ActiveController {

    public $modelClass = 'common\models\CoUser';

    /**
     * @inheritdoc
     */
//    public function behaviors() {
//        $behaviors = parent::behaviors();
//        $behaviors['authenticator'] = [
//            'class' => HttpBearerAuth::className()
//        ];
//        $behaviors['contentNegotiator'] = [
//            'class' => ContentNegotiator::className(),
//            'formats' => [
//                'application/json' => Response::FORMAT_JSON,
//            ],
//        ];
//
//        return $behaviors;
//    }


    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className(),
            'only' => ['dashboard', 'createuser', 'updateuser', 'getuser', 'getlogin', 'updatelogin', 'getuserdata', 'getusernamebytenant', 'assignroles'],
        ];
        $behaviors['contentNegotiator'] = [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
            ],
        ];
//        $behaviors['access'] = [
//            'class' => AccessControl::className(),
//            'only' => ['dashboard'],
//            'rules' => [
//                [
//                    'actions' => ['dashboard'],
//                    'allow' => true,
//                    'roles' => ['@'],
//                ],
//            ],
//        ];
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
            'query' => $modelClass::find()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }

    public function actionGetuserdata() {
        $model = CoUser::find()->orderBy(['created_at' => SORT_DESC])->all();
        $data = [];
        foreach ($model as $key => $user) {
            $data[$key] = $user->attributes;
            if (empty($user->login)) {
                $data[$key]['login_link_btn'] = 'btn btn-sm btn-info';
                $data[$key]['login_link_text'] = 'Create';
            } else {
                $data[$key]['login_link_btn'] = 'btn btn-sm btn-primary';
                $data[$key]['login_link_text'] = 'Update';
            }
        }
        return $data;
    }

    public function actionLogin() {
        $model = new LoginForm();

        if ($model->load(Yii::$app->getRequest()->getBodyParams(), '') && $model->login()) {
            return ['success' => true, 'access_token' => Yii::$app->user->identity->getAuthKey()];
        } elseif (!$model->validate()) {
            return ['success' => false, 'message' => Html::errorSummary([$model])];
        }
    }

    public function actionDashboard() {
        $response = [
            'username' => Yii::$app->user->identity->username,
            'access_token' => Yii::$app->user->identity->getAuthKey(),
        ];

        return $response;
    }

    public function actionContact() {

        $model = new ContactForm();
        if ($model->load(Yii::$app->getRequest()->getBodyParams(), '') && $model->validate()) {
            if ($model->sendEmail(Yii::$app->params['adminEmail'])) {
                $response = [
                    'flash' => [
                        'class' => 'success',
                        'message' => 'Thank you for contacting us. We will respond to you as soon as possible.',
                    ]
                ];
            } else {
                $response = [
                    'flash' => [
                        'class' => 'error',
                        'message' => 'There was an error sending email.',
                    ]
                ];
            }
            return $response;
        } else {
            $model->validate();
            return $model;
        }
    }

    public function actionRequestPasswordReset() {
        $model = new PasswordResetRequestForm();
        $model->attributes = Yii::$app->request->post();

        if ($model->validate()) {
            if ($model->sendEmail()) {
                return ['success' => true, 'message' => 'A reset link sent to your email address. Check your mail.'];
            } else {
                return ['success' => false, 'message' => 'Sorry, we are unable to reset password for email provided.'];
            }
        } else {
            return ['success' => false, 'message' => Html::errorSummary([$model])];
        }
    }

    public function actionCheckResetPassword() {
        $token = Yii::$app->request->post('token');
        if ($token) {
            return $this->checktoken($token);
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionResetPassword() {
        $post = Yii::$app->request->post();
        if ($post) {
            $check_token = $this->checktoken($post['password_reset_token'], true);

            if ($check_token['success']) {
                $model = $check_token['model'];
                $model->attributes = $post;

                if ($model->validate() && $model->resetPassword()) {
                    return ['success' => true, 'message' => 'New password was saved. You will be redirected to Login Page within 10 seconds.'];
                } else {
                    return ['success' => false, 'message' => Html::errorSummary([$model])];
                }
            } else {
                return ['success' => false, 'message' => 'Invalid Access'];
            }
        } else {
            return ['success' => true];
        }
    }

    protected function checktoken($token, $ret_model = false) {
        try {
            $model = new ResetPasswordForm($token);
            if ($ret_model)
                return ['success' => true, 'model' => $model];
            else
                return ['success' => true];
        } catch (InvalidParamException $e) {
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }

    public function actionCreateuser() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $model = new CoUser();
            $model->scenario = 'saveorg';
            $model->attributes = $post;

            $valid = $model->validate();
            if ($valid) {
                $model->save(false);

                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionUpdateuser() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $model = CoUser::find()->where(['user_id' => $post['user_id']])->one();
            $model->scenario = 'saveorg';
            $model->attributes = $post;

            $valid = $model->validate();

            if ($valid) {
                $model->save(false);
                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionGetuser() {
        $id = Yii::$app->request->get('id');
        if (!empty($id)) {
            $data = CoUser::find()->where(['user_id' => $id])->one();
            $return = $this->excludeColumns($data->attributes);
            return ['success' => true, 'return' => $return];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionGetlogin() {
        $id = Yii::$app->request->get('id');
        if (!empty($id)) {
            $user = CoUser::find()->where(['user_id' => $id])->one();

            if (!empty($user)) {
                $data = $user->login;
                $return = empty($data) ? [] : $this->excludeColumns($data->attributes);
                $return['name'] = $user->name;

                return ['success' => true, 'return' => $return];
            } else {
                return ['success' => false, 'message' => 'Invalid Access'];
            }
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionUpdatelogin() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $model = CoLogin::find()->where(['user_id' => $post['user_id']])->one();
            $model = empty($model) ? new CoLogin : $model;
            $model->attributes = $post;

            $valid = $model->validate();

            if ($valid) {
                $model->save(false);
                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionGetusernamebytenant() {
        $list = CoUser::find()->tenant()->status()->all();
        return ['userList' => $list];
    }

    public function actionAssignroles() {
        $post = Yii::$app->request->post();
        $tenant_id = Yii::$app->user->identity->user->tenant_id;
        
        if (!empty($post) && !empty($tenant_id)) {
            $model = new CoUsersRoles;
            $model->tenant_id = $tenant_id;
            $model->scenario = 'roleassign';
            $model->attributes = $post;
            
            if ($model->validate()) {
                $user = CoUser::find()->where(['user_id' => $post['user_id']])->one();
                
                foreach ($post['role_ids'] as $role_id) {
                    $roles[] = CoRole::find()->where(['role_id' => $role_id])->one();
                }
                
                $extraColumns = ['tenant_id' => $tenant_id, 'modified_by' => Yii::$app->user->identity->user_id, 'modified_at' => new Expression('NOW()')]; // extra columns to be saved to the many to many table
                $unlink = true; // unlink tags not in the list
                $delete = true; // delete unlinked tags
                $user->linkAll('roles', $roles, $extraColumns, $unlink, $delete);
                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
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

}
