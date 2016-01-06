<?php

namespace IRISORG\modules\v1\controllers;

use common\models\LoginForm;
use common\models\PasswordResetRequestForm;
use common\models\ResetPasswordForm;
use IRISORG\models\ContactForm;
use Yii;
use yii\base\InvalidParamException;
use yii\filters\AccessControl;
use yii\filters\auth\HttpBearerAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\Controller;
use yii\web\Response;

/**
 * User controller
 */
class UserController extends Controller {

    /**
     * @inheritdoc
     */
    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className(),
            'only' => ['dashboard'],
        ];
        $behaviors['contentNegotiator'] = [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
            ],
        ];
        $behaviors['access'] = [
            'class' => AccessControl::className(),
            'only' => ['dashboard'],
            'rules' => [
                [
                    'actions' => ['dashboard'],
                    'allow' => true,
                    'roles' => ['@'],
                ],
            ],
        ];
        return $behaviors;
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

}
