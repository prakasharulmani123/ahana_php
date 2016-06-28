<?php

namespace common\models;

use Yii;
use yii\base\Model;

/**
 * Login form
 */
class LoginForm extends Model {

    public $username;
    public $password;
    public $tenant_id;
    //public $rememberMe = true;

    private $_user = false;

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            // username and password are both required
            [['username', 'password', 'tenant_id'], 'required'],
//            [['username', 'password'], 'string', 'min' => 6],
            // rememberMe must be a boolean value
            //['rememberMe', 'boolean'],
            // password is validated by validatePassword()
            ['password', 'validatePassword'],
            ['tenant_id', 'validateTenant'],
        ];
    }

    /**
     * Validates the password.
     * This method serves as the inline validation for password.
     *
     * @param string $attribute the attribute currently being validated
     * @param array $params the additional name-value pairs given in the rule
     */
    public function validatePassword($attribute, $params) {
        if (!$this->hasErrors()) {
            $user = $this->getUser();
            if (!$user || !$user->validatePassword($this->password)) {
                $this->addError($attribute, 'Incorrect username or password.');
            }
        }
    }

    public function validateTenant($attribute, $params) {
        if (!$this->hasErrors()) {
            $tenant = CoLogin::findByUsernameAndTenant($this->username, $this->tenant_id);
            if (empty($tenant)) {
                $this->addError($attribute, 'Organization mismatch.');
            }

            if (!empty($tenant) && $tenant->user->tenant_id != 0) {
                //Account Not Activated
                if (empty($tenant->activation_date) || $tenant->activation_date == '0000-00-00')
                    $this->addError($attribute, 'Your Account is not activated. Contact Admin');
                //Account Will be Activated
                else if (strtotime($tenant->activation_date) > strtotime(date('Y-m-d')))
                    $this->addError($attribute, 'Your Account will be activated on ' . $tenant->activation_date);

                //Account In-activated
                if (!empty($tenant->Inactivation_date) && $tenant->Inactivation_date != '0000-00-00' && strtotime($tenant->Inactivation_date) < strtotime(date('Y-m-d')))
                    $this->addError($attribute, 'Your Account is inactivated on ' . $tenant->Inactivation_date);
            }
        }
    }

    /**
     * Logs in a user using the provided username and password.
     *
     * @return boolean whether the user is logged in successfully
     */
    public function login() {
        if ($this->validate()) {
            $this->setToken();
            return Yii::$app->user->login($this->getUser()/* , $this->rememberMe ? 3600 * 24 * 30 : 0 */);
        } else {
            return false;
        }
    }

    /**
     * Finds user by [[username]]
     *
     * @return User|null
     */
    public function getUser() {
        if ($this->_user === false) {
            $this->_user = CoLogin::findByUsername($this->username);
        }

        return $this->_user;
    }

    public function setToken() {
        if ($this->_user !== false) {
            $token = base64_encode($this->_user->username . time() . rand(1000, 9999));
            $this->_user->authtoken = $token;
            $this->_user->logged_tenant_id = $this->tenant_id;
            $this->_user->access_tenant_id = $this->_user->user->tenant_id == 0 ? $this->_user->user->first_tenant_id : $this->tenant_id;
            $this->_user->save(false);
            $this->_user->authtoken = md5($token);
        }

        return $this->_user;
    }

}
