<?php

namespace common\models;

use common\models\query\PatProcedureQuery;
use Yii;
use yii\db\ActiveQuery;
use yii\helpers\Json;

/**
 * This is the model class for table "pat_procedure".
 *
 * @property integer $proc_id
 * @property integer $tenant_id
 * @property integer $encounter_id
 * @property integer $patient_id
 * @property integer $charge_subcat_id
 * @property string $proc_date
 * @property string $proc_consultant_ids
 * @property string $proc_description
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 *
 * @property PatEncounter $encounter
 * @property CoRoomChargeCategory $chargeCat
 * @property CoTenant $tenant
 */
class PatProcedure extends RActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'pat_procedure';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['charge_subcat_id', 'proc_date'], 'required'],
            [['tenant_id', 'encounter_id', 'charge_subcat_id', 'created_by', 'modified_by', 'patient_id'], 'integer'],
            [['proc_date', 'created_at', 'modified_at', 'deleted_at', 'patient_id'], 'safe'],
            [['proc_consultant_ids', 'proc_description', 'status'], 'string']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'proc_id' => 'Proc',
            'tenant_id' => 'Tenant',
            'encounter_id' => 'Encounter',
            'charge_subcat_id' => 'Procedure',
            'proc_date' => 'Date',
            'proc_consultant_ids' => 'Consultant',
            'proc_description' => 'Description',
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
    public function getEncounter() {
        return $this->hasOne(PatEncounter::className(), ['encounter_id' => 'encounter_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getChargeCat() {
        return $this->hasOne(CoRoomChargeSubcategory::className(), ['charge_subcat_id' => 'charge_subcat_id']);
    }

    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }

    public function getPatient() {
        return $this->hasOne(PatPatient::className(), ['patient_id' => 'patient_id']);
    }

    public static function find() {
        return new PatProcedureQuery(get_called_class());
    }

    public function beforeValidate() {
        $this->setConsultId();
        return parent::beforeValidate();
    }

    public function beforeSave($insert) {
        $this->setConsultId();
        return parent::beforeSave($insert);
    }

    public function setConsultId() {
        if (is_array($this->proc_consultant_ids))
            $this->proc_consultant_ids = Json::encode($this->proc_consultant_ids);
    }

    public function fields() {
        $extend = [
            'encounter' => function ($model) {
                return isset($model->encounter) ? $model->encounter : '-';
            },
            'procedure_name' => function ($model) {
                return isset($model->chargeCat) ? $model->chargeCat->charge_subcat_name : '-';
            },
            'doctors' => function ($model) {
                if (isset($this->proc_consultant_ids) && is_array($this->proc_consultant_ids)) {
                    $ids = implode(',', $this->proc_consultant_ids);

                    $query = "SELECT GROUP_CONCAT(concat(title_code,name) SEPARATOR ', ') as doctors ";
                    $query .= "From co_user ";
                    $query .= "Where find_in_set(user_id, '$ids') > 0 ";

                    $command = Yii::$app->db->createCommand($query);
                    $data = $command->queryAll();
                    return $data[0]['doctors'];
                }
            },
        ];
        $fields = array_merge(parent::fields(), $extend);
        return $fields;
    }

    public function afterFind() {
        if (is_string($this->proc_consultant_ids))
            $this->proc_consultant_ids = Json::decode($this->proc_consultant_ids);

        return parent::afterFind();
    }

}
