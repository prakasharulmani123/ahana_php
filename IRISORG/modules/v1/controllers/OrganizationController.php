<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoResources;
use common\models\CoRole;
use common\models\CoRolesResources;
use common\models\CoTenant;
use common\models\CoUsersRoles;
use Yii;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * OrganizationController implements the CRUD actions for CoTenant model.
 */
class OrganizationController extends ActiveController {

    public $modelClass = 'common\models\CoTenant';

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

    //org_module.js
    public function actionGetorgmodules() {
        $user_id = Yii::$app->user->identity->user->user_id;
        $user_role = CoUsersRoles::find()->tenant()->where(['user_id' => $user_id])->one();
        $role_resources = CoRolesResources::find()->tenant()->andWhere(['role_id' => $user_role->role_id])->all();
        return ['success' => true, 'modules' => $role_resources];
    }

    //role_rights.js
    public function actionGetorg() {
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
        $access_tenant_id = Yii::$app->user->identity->access_tenant_id;
        $tenant_super_role = CoRole::getTenantSuperRole($tenant_id);
        $tenant_super_role_id = $tenant_super_role->role_id;

        if (!empty($tenant_id)) {
            $return = array();
            $organization = CoTenant::find()->where(['tenant_id' => $tenant_id])->one();
            return ['success' => true, 'return' => $organization, 'modules' => CoRolesResources::getOrgModuleTree($access_tenant_id, $tenant_super_role_id)];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    //role_rights.js
    public function actionGetorgmodulesbyrole() {
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
        $tenant_super_role = CoRole::getTenantSuperRole($tenant_id);
        $tenant_super_role_id = $tenant_super_role->role_id;

        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $role_id = Yii::$app->request->post('role_id');
            return ['success' => true, 'modules' => CoRolesResources::getOrgModuletreeByRole($tenant_id, $tenant_super_role_id, $role_id)];
        }
    }

    //role_rights.js
    public function actionUpdaterolerights() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            if (Yii::$app->request->post('Module')) {
                if (!empty(Yii::$app->request->post('Module')['role_id'])) {
                    $resource_id = Yii::$app->request->post('Module')['resource_ids'];
                    $model = CoRole::findOne(['role_id' => Yii::$app->request->post('Module')['role_id']]);

                    $resources = CoResources::find()->where(['in', 'resource_id', $resource_id])->all();

                    // extra columns to be saved to the many to many table
                    $extraColumns = ['tenant_id' => Yii::$app->user->identity->logged_tenant_id, 'created_by' => Yii::$app->user->identity->user_id, 'status' => '1', 'role_id' => Yii::$app->request->post('Module')['role_id']];

                    $unlink = true; // unlink tags not in the list
                    $delete = true; // delete unlinked tags
                    $model->linkAll('resources', $resources, $extraColumns, $unlink, $delete);

                    return ['success' => true];
                } else {
                    return ['success' => false, 'message' => "Please select role"];
                }
            }
        } else {
            return ['success' => false, 'message' => 'Please Fill the Form'];
        }
    }

    public function actionUpdatesharing() {
        $post = Yii::$app->request->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;

        $unset_configs = \common\models\AppConfiguration::updateAll(['value' => '0'], "tenant_id = {$tenant_id} AND `key` like '%SHARE_%'");

        if (isset($post['share'])) {
            $share_resources = array_keys($post['share']);
            $set_configs = \common\models\AppConfiguration::updateAll(['value' => '1'], ['tenant_id' => $tenant_id, 'code' => $share_resources]);
        }
        return ['success' => true];
    }

}
