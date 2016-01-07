<?php

namespace IRISORG\modules\v1\controllers;

use common\models\CoTenant;
use Yii;
use yii\filters\auth\HttpBearerAuth;
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

    public function actionGetorg() {
        $tenant_id = Yii::$app->user->identity->user->tenant_id;
        if (!empty($tenant_id)) {
            $return = array();

            $organization = CoTenant::find()->where(['tenant_id' => $tenant_id])->one();
            $return = $organization->attributes;
            $return['city'] = $organization->coMasterCity->city_name;
            $return['state'] = $organization->coMasterState->state_name;
            $return['country'] = $organization->coMasterCountry->country_name;

            return ['success' => true, 'return' => $return];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

}
