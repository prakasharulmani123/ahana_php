<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoLogin;
use common\models\CoResources;
use common\models\CoRole;
use common\models\CoRolesResources;
use common\models\CoTenant;
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
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\ArrayHelper;
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
//            'class' => QueryParamAuth::className()
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
            'class' => QueryParamAuth::className(),
            'only' => ['dashboard', 'createuser', 'updateuser', 'getuser', 'getlogin', 'updatelogin', 'getuserdata', 'getuserslistbyuser', 'assignroles', 'getdoctorslist', 'checkstateaccess', 'getusercredentialsbytoken', 'logout'],
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
            'query' => $modelClass::find()->tenant()->active()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }

    public function actionGetuserdata() {
        $model = CoUser::find()->tenant()->active()->myUsers()->orderBy(['created_at' => SORT_DESC])->all();
        $data = [];
        foreach ($model as $key => $user) {
            $data[$key] = $user->attributes;
            if (empty($user->login)) {
                $data[$key]['login_link_btn'] = 'btn btn-sm btn-info';
                $data[$key]['login_link_text'] = 'Create';
                $data[$key]['username'] = '-';
                $data[$key]['activation_date'] = '-';
                $data[$key]['Inactivation_date'] = '-';
            } else {
                $data[$key]['login_link_btn'] = 'btn btn-sm btn-primary';
                $data[$key]['login_link_text'] = 'Update';
                $data[$key]['username'] = $user->login->username;
                $data[$key]['activation_date'] = $user->login->activation_date;
                $data[$key]['Inactivation_date'] = $user->login->Inactivation_date;
            }
        }
        return $data;
    }

    public static function Getuserrolesresources() {
        $user_id = Yii::$app->user->identity->user->user_id;
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
        
        //For Super Admin
        if($tenant_id == 0)
            $tenant_id = Yii::$app->user->identity->user->first_tenant_id;

        $role_ids = ArrayHelper::map(CoUsersRoles::find()->where(['user_id' => $user_id])->all(), 'role_id', 'role_id');
        $resource_ids = ArrayHelper::map(CoRolesResources::find()->where(['IN', 'role_id', $role_ids])->andWhere(['tenant_id' => $tenant_id])->all(), 'resource_id', 'resource_id');
        $resources = ArrayHelper::map(CoResources::find()->where(['IN', 'resource_id', $resource_ids])->all(), 'resource_url', 'resource_url');
        
        return $resources;
    }

    public static function GetuserCredentials($tenant_id) {
        $tenant = CoTenant::findOne(['tenant_id' => $tenant_id]);
        $credentials = [
            'org' => $tenant->tenant_name
        ];
        return $credentials;
    }

    public function actionLogin() {
        $model = new LoginForm();
        
        if ($model->load(Yii::$app->getRequest()->getBodyParams(), '') && $model->login()) {
            return ['success' => true, 'access_token' => Yii::$app->user->identity->getAuthKey(), 'resources' => self::Getuserrolesresources(), 'credentials' => self::GetuserCredentials(\Yii::$app->request->post('tenant_id'))];
        } elseif (!$model->validate()) {
            return ['success' => false, 'message' => Html::errorSummary([$model])];
        }
    }

    public function actionLogout() {
        $model = CoLogin::findOne(['login_id' => Yii::$app->user->identity->login_id]);
        if(!empty($model)){
            $model->attributes = ['authtoken' => '','logged_tenant_id' => ''];
            if($model->save(false))
                return ['success' => true];
            else
                return ['success' => false, 'message' => Html::errorSummary([$model])];
        } else{
            return ['success' => false, 'message' => 'Try again later'];
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

            if (empty($model)) {
                $model = new CoLogin;
                $model->scenario = 'create';
            }
            $model->attributes = $post;

            $valid = $model->validate();

            if ($valid) {
                $model->setPassword($model->password);
                $model->save(false);
                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionGetuserslistbyuser() {
        $list = CoUser::find()->tenant()->status()->active()->myUsers()->all();
        return ['userList' => $list];
    }

    public function actionAssignroles() {
        $post = Yii::$app->request->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

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

    public function actionGetdoctorslist() {
        $tenant = null;
        $status = '1';
        $deleted = false;
        $care_provider = '1';

        $get = Yii::$app->getRequest()->get();

        if (isset($get['tenant']))
            $tenant = $get['tenant'];

        if (isset($get['status']))
            $status = strval($get['status']);

        if (isset($get['deleted']))
            $deleted = $get['deleted'] == 'true';

        if (isset($get['care_provider']))
            $care_provider = $get['care_provider'];

        return ['doctorsList' => CoUser::getDoctorsList($tenant, $care_provider, $status, $deleted)];
    }

    protected function excludeColumns($attrs) {
        $exclude_cols = ['created_by', 'created_at', 'modified_by', 'modified_at'];
        foreach ($attrs as $col => $val) {
            if (in_array($col, $exclude_cols))
                unset($attrs[$col]);
        }
        return $attrs;
    }

    public function actionCheckstateaccess() {
        $stateName = Yii::$app->request->post('stateName');
        if ($stateName) {
            return $this->checkstate($stateName);
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    protected function checkstate($stateName) {
        $module = CoResources::find()->where(["resource_url" => $stateName])->one();
        $resource_id = $module->resource_id;

        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
        $user_id = Yii::$app->user->identity->user->user_id;

        $role_ids = CoUsersRoles::find()->select(['GROUP_CONCAT(role_id) AS role_ids'])->where(['tenant_id' => $tenant_id, 'user_id' => $user_id])->one();
        $role_ids = explode(',', $role_ids->role_ids);

        $have_access = CoRolesResources::find()->tenant()->andWhere(['IN', 'role_id', $role_ids])->andWhere(["resource_id" => $resource_id])->one();

        if (!empty($have_access))
            return ['success' => true];
        else
            return ['success' => false, 'message' => 'Invalid access'];
    }

    public function actionGetusercredentialsbytoken() {
        $token = Yii::$app->request->post('token');
        if (!empty($token)) {
            $data = CoLogin::find()->where(['authtoken' => $token])->one();

            $credentials = [
                'org' => $data->user->tenant->tenant_name
            ];
            return ['success' => true, 'credentials' => $credentials];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

}
