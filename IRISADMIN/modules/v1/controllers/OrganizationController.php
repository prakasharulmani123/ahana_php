<?php

namespace IRISADMIN\modules\v1\controllers;

use common\models\CoLogin;
use common\models\CoResources;
use common\models\CoRole;
use common\models\CoRolesResources;
use common\models\CoTenant;
use common\models\CoUser;
use common\models\CoUsersRoles;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\HttpException;
use yii\web\Response;

/**
 * OrganizationController implements the CRUD actions for CoTenant model.
 */
class OrganizationController extends ActiveController {

    public $modelClass = 'common\models\CoTenant';

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
            'query' => $modelClass::find()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }

    public function actionSearch() {
        if (!empty($_GET)) {
            $model = new $this->modelClass;
            foreach ($_GET as $key => $value) {
                if (!$model->hasAttribute($key)) {
                    throw new HttpException(404, 'Invalid attribute:' . $key);
                }
            }
            try {
                $provider = new ActiveDataProvider([
                    'query' => $model->find()->where($_GET),
                    'pagination' => false
                ]);
            } catch (Exception $ex) {
                throw new HttpException(500, 'Internal server error');
            }

            if ($provider->getCount() <= 0) {
                throw new HttpException(404, 'No entries found with this query string');
            } else {
                return $provider;
            }
        } else {
            throw new HttpException(400, 'There are no query string');
        }
    }

    public function actionCreateorg() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $model = new CoTenant();
            $model->attributes = Yii::$app->request->post('Tenant');

            $role_model = new CoRole();
            $role_model->attributes = Yii::$app->request->post('Role');

            $user_model = new CoUser();
            $user_model->scenario = 'saveorg';
            $user_model->attributes = Yii::$app->request->post('User');

            $login_model = new CoLogin();
            $login_model->attributes = Yii::$app->request->post('Login');

            $valid = $model->validate();
            $valid = $role_model->validate() && $valid;
            $valid = $user_model->validate() && $valid;
            $valid = $login_model->validate() && $valid;

            if ($valid) {
                $model->save(false);

                $role_model->tenant_id = $model->tenant_id;
                $role_model->save(false);

                $user_model->tenant_id = $model->tenant_id;
                $user_model->save(false);

                $login_model->user_id = $user_model->user_id;
                $login_model->setPassword($login_model->password);
                $login_model->save(false);

                $user = $user_model;
                $roles = [$role_model];
                $extraColumns = ['tenant_id' => $model->tenant_id, 'created_by' => Yii::$app->user->identity->user_id]; // extra columns to be saved to the many to many table
                $unlink = true; // unlink tags not in the list
                $delete = true; // delete unlinked tags
                $user->linkAll('roles', $roles, $extraColumns, $unlink, $delete);

                if (Yii::$app->request->post('Module')) {
                    $resource_id = Yii::$app->request->post('Module')['resource_ids'];
                    $role = $role_model;
                    $resources = CoResources::find()->where(['in', 'resource_id', $resource_id])->all();
                    $extraColumns = ['tenant_id' => $model->tenant_id, 'created_by' => Yii::$app->user->identity->user_id]; // extra columns to be saved to the many to many table
                    $unlink = true; // unlink tags not in the list
                    $delete = true; // delete unlinked tags
                    $role->linkAll('resources', $resources, $extraColumns, $unlink, $delete);
                }

                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $role_model, $user_model, $login_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionUpdateorg() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {

            if (Yii::$app->request->post('Tenant')) {
                $model = CoTenant::findOne(['tenant_id' => Yii::$app->request->post('Tenant')['tenant_id']]);
                $model->attributes = Yii::$app->request->post('Tenant');
                $valid = $model->validate();
            }

            if (Yii::$app->request->post('Role')) {
                $model = CoRole::findOne(['role_id' => Yii::$app->request->post('Role')['role_id']]);
                $model->attributes = Yii::$app->request->post('Role');
                $valid = $model->validate();
            }

            if (Yii::$app->request->post('Login')) {
                $model = CoLogin::findOne(['login_id' => Yii::$app->request->post('Login')['login_id']]);
                $model->attributes = Yii::$app->request->post('Login');
                if(!empty($model->password))
                    $model->setPassword($model->password);
                
                $valid = $model->validate();
            }

            if (Yii::$app->request->post('User')) {
                $model = CoUser::findOne(['user_id' => Yii::$app->request->post('User')['user_id']]);
                $model->scenario = 'saveorg';
                $model->attributes = Yii::$app->request->post('User');
                $valid = $model->validate();
            }

            if (Yii::$app->request->post('Module')) {
                $resource_id = Yii::$app->request->post('Module')['resource_ids'];
                $model = CoRole::findOne(['role_id' => Yii::$app->request->post('Module')['role_id']]);

                $resources = CoResources::find()->where(['in', 'resource_id', $resource_id])->all();
                $extraColumns = ['tenant_id' => Yii::$app->request->post('Module')['tenant_id'], 'created_by' => Yii::$app->user->identity->user_id, 'status' => '1']; // extra columns to be saved to the many to many table
                $unlink = true; // unlink tags not in the list
                $delete = true; // delete unlinked tags
                $model->linkAll('resources', $resources, $extraColumns, $unlink, $delete);

                //For Update Status
                $role_resources = CoRolesResources::find()->tenant(Yii::$app->request->post('Module')['tenant_id'])->where(['role_id' => Yii::$app->request->post('Module')['role_id']])->all();
                foreach ($role_resources as $role_resource) {
                    if ($role_resource->status != '1') {
                        $role_resource->updateAttributes(['status' => '1']);
                    }
                }

                return ['success' => true];
            }

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

    public function actionGetorg() {
        $tenant_id = Yii::$app->request->get('id');

        if (!empty($tenant_id)) {
            $return = array();

            $organization = CoTenant::find()->tenant($tenant_id)->one();
            $userProf = CoUser::find()->where(['tenant_id' => $tenant_id, 'created_by' => Yii::$app->user->identity->user_id])->one();
            $user_role = CoUsersRoles::find()->where(['tenant_id' => $tenant_id, 'user_id' => $userProf->user_id])->one();
            $login = CoLogin::find()->where(['user_id' => $userProf->user_id])->one();
            $login->password = '';

            $return['Tenant'] = $this->excludeColumns($organization->attributes);
            $return['User'] = $this->excludeColumns($userProf->attributes);
            $return['Role'] = $this->excludeColumns($user_role->role->attributes);
            $return['Login'] = $this->excludeColumns($login->attributes);

            return ['success' => true, 'return' => $return, 'modules' => CoRolesResources::getModuletreeByRole($tenant_id, $user_role->role_id)];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function excludeColumns($attrs) {
        $exclude_cols = ['created_by', 'created_at', 'modified_by', 'modified_at', 'password_reset_token', 'auth_token', 'care_provider', 'speciality_id', 'Inactivation_date', 'activation_date'];
        foreach ($attrs as $col => $val) {
            if (in_array($col, $exclude_cols))
                unset($attrs[$col]);
        }
        return $attrs;
    }

    public function actionValidateorg() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $valid = true;
            if (isset($post['Tenant'])) {
                $model = new CoTenant();
                $model->attributes = Yii::$app->request->post('Tenant');
            }

            if (isset($post['Role'])) {
                $model = new CoRole();
                $model->attributes = Yii::$app->request->post('Role');
            }

            if (isset($post['Login'])) {
                $model = new CoLogin();
                $model->attributes = Yii::$app->request->post('Login');
            }

            if (isset($post['User'])) {
                $model = new CoUser();
                $model->attributes = Yii::$app->request->post('CoUser');
            }

            $role = new CoRole();
            if (isset($post['RoleLogin'])) {
                $role->attributes = Yii::$app->request->post('Role');
                $valid = $role->validate();

                $model = new CoLogin();
                $model->attributes = Yii::$app->request->post('Login');
            }

            $valid = $model->validate() && $valid;

            if ($valid) {
                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $role])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

}
