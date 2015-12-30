<?php

namespace IRISADMIN\modules\v1\controllers;

use common\models\CoRolesResources;
use common\models\CoLogin;
use common\models\CoRole;
use common\models\CoTenant;
use common\models\CoUser;
use common\models\CoUsersRoles;
use Yii;
use yii\data\ActiveDataProvider;
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

    public function actionSaveorg() {
        if (!empty(Yii::$app->request->post())) {
            $model = new CoTenant();
            $model->scenario = 'create';
            $model->attributes = Yii::$app->request->post('Tenant');

            $role_model = new CoRole();
            $role_model->attributes = Yii::$app->request->post('Role');

            $user_model = new CoUser();
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
                $role_model->created_by = -1;
                $role_model->save(false);

                $user_model->tenant_id = $model->tenant_id;
                $user_model->created_by = -1;
                $user_model->save(false);

                $login_model->user_id = $user_model->user_id;
                $login_model->created_by = -1;
                $login_model->save(false);

                $user_role_model = new CoUsersRoles();
                $user_role_model->attributes = array(
                    'tenant_id' => $model->tenant_id,
                    'user_id' => $user_model->user_id,
                    'role_id' => $role_model->role_id,
                    'created_by' => -1
                );
                $user_role_model->save(false);
            
                if (Yii::$app->request->post('Module')) {
                    $resources = Yii::$app->request->post('Module')['resource_ids'];
                    if (!empty($resources)) {
                        foreach ($resources as $resource_id) {
                            $resource_model = new CoRolesResources();
                            $resource_model->attributes = array(
                                'tenant_id' => $model->tenant_id,
                                'role_id' => $role_model->role_id,
                                'resource_id' => $resource_id,
                                'created_by' => -1
                            );
                            $resource_model->save(false);
                        }
                    }
                }
                
                return ['success' => true];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $role_model, $user_model, $login_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }
    
    public function actionGetorg() {
        if (!empty(Yii::$app->request->get('id'))) {
            $return = array();
            $tenant_id = Yii::$app->request->get('id');
            
            $organization = CoTenant::find()->where(['tenant_id' => $tenant_id])->one();
            $userProf = CoUser::find()->where(['tenant_id' => $tenant_id, 'created_by' => -1])->one();
            $user_role = CoUsersRoles::find()->where(['tenant_id' => $tenant_id, 'user_id' => $userProf->user_id])->one();
            $login = CoLogin::find()->where(['user_id' => $userProf->user_id])->one();
            $login->password = '';
            
            $return['Tenant'] = $organization->attributes;
            $return['User'] = $userProf->attributes;
            $return['Role'] = $user_role->role->attributes;
            $return['Login'] = $login->attributes;
            
            return ['success' => true, 'return' => $return, 'modules' => CoRolesResources::getModuletreeByRole($tenant_id, $user_role->role_id)];
        }else{
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

}
