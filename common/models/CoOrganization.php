<?php

namespace common\models;

use yii\db\ActiveQuery;
use yii\db\Connection;

/**
 * This is the model class for table "co_organization".
 *
 * @property integer $org_id
 * @property string $org_name
 * @property string $org_description
 * @property string $org_db_host
 * @property string $org_db_username
 * @property string $org_db_password
 * @property string $org_database
 * @property string $org_domain
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property CoLogin[] $coLogins
 * @property CoTenant[] $coTenants
 */
class CoOrganization extends GActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'co_organization';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['org_name', 'org_description', 'org_db_host', 'org_db_username', 'org_database', 'org_domain'], 'required'],
            [['org_description', 'status'], 'string'],
            [['created_by', 'modified_by'], 'integer'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
            [['org_name'], 'string', 'max' => 100],
            [['org_db_host', 'org_db_username', 'org_db_password', 'org_database', 'org_domain'], 'string', 'max' => 255],
            [['org_name', 'org_database', 'org_domain'], 'unique'],
            ['org_database', 'checkDB'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'org_id' => 'Org ID',
            'org_name' => 'Organization Name',
            'org_description' => 'Organization Description',
            'org_db_host' => 'Organization Database Host',
            'org_db_username' => 'Organization Database Username',
            'org_db_password' => 'Organization Database Password',
            'org_database' => 'Organization Database Name',
            'org_domain' => 'Organization Domain Name',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
        ];
    }

    /**
     * @return ActiveQuery
     */
    public function getCoLogins() {
        return $this->hasMany(CoLogin::className(), ['org_id' => 'org_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getCoTenants() {
        return $this->hasMany(CoTenant::className(), ['org_id' => 'org_id']);
    }

    public function fields() {
        $extend = [
            'tenants' => function ($model) {
                return $model->coTenants;
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    public function checkDB($attribute, $params) {
        try {
            $connection = new Connection([
                'dsn' => "mysql:host={$this->org_db_host};dbname={$this->org_database}",
                'username' => $this->org_db_username,
                'password' => $this->org_db_password,
            ]);
            $connection->open();
            $connection->close();
        } catch (\Exception $ex) {
            $this->addError($attribute, $ex->getMessage());
        }
    }

    public function afterSave($insert, $changedAttributes) {
        if ($insert) {
            $connection = new Connection([
                'dsn' => "mysql:host={$this->org_db_host};dbname={$this->org_database}",
                'username' => $this->org_db_username,
                'password' => $this->org_db_password,
            ]);
            $connection->open();

            $command = $connection->createCommand("INSERT INTO co_organization VALUES({$this->org_id},'{$this->org_name}','{$this->org_description}','{$this->org_db_host}','{$this->org_db_username}','{$this->org_db_password}','{$this->org_database}','{$this->org_domain}','{$this->status}',{$this->created_by},'{$this->created_at}',{$this->modified_by},'{$this->modified_at}','{$this->deleted_at}')");
            $command->execute();
            $connection->close();
        }
        return parent::afterSave($insert, $changedAttributes);
    }

}
