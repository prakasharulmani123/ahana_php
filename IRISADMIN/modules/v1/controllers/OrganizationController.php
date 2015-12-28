<?php

namespace IRISADMIN\modules\v1\controllers;

use Yii;
use yii\filters\ContentNegotiator;
use yii\web\Response;
use yii\rest\ActiveController;
use yii\filters\auth\HttpBearerAuth;
use yii\data\ActiveDataProvider;
use yii\web\HttpException;

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

    //Organization save with multiple records.
    public function actionCreate() {
        $model = new $this->modelClass;
        if ($model->load(Yii::$app->request->post())) {
            if ($model->save()) {
                $tenant_id = $model->tenant_id;
                if ($tenant_id) {
                    
                    /* save records to another table with tenant id */
//                    $employee->attributes = $model->attributes;
//                    $employee->save();
                }
                return ['success' => true, 'access_token' => Yii::$app->user->identity->getAuthKey()];
            } else {
                
            }
        }
    }

}
