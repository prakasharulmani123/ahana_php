<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "co_login".
 *
 * @property integer $login_id
 * @property integer $user_id
 * @property string $username
 * @property string $password
 * @property string $password_reset_token
 * @property string $auth_token
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $activation_date
 * @property string $Inactivation_date
 *
 * @property CoUserProfile $user
 */
class CoLogin extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'co_login';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['user_id', 'username', 'password', 'created_by'], 'required'],
            [['user_id', 'created_by', 'modified_by'], 'integer'],
            [['created_at', 'modified_at', 'activation_date', 'Inactivation_date'], 'safe'],
            [['username', 'password', 'password_reset_token', 'auth_token'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'login_id' => 'Login ID',
            'user_id' => 'User ID',
            'username' => 'Username',
            'password' => 'Password',
            'password_reset_token' => 'Password Reset Token',
            'auth_token' => 'Auth Token',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'activation_date' => 'Activation Date',
            'Inactivation_date' => 'Inactivation Date',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(CoUserProfile::className(), ['user_id' => 'user_id']);
    }
}
