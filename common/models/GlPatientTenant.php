<?php

namespace common\models;

use yii\db\ActiveRecord;

/**
 * This is the model class for table "gl_patient_tenant".
 *
 * @property integer $pat_tenant_id
 * @property integer $org_id
 * @property integer $tenant_id
 * @property string $patient_global_guid
 */
class GlPatientTenant extends ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'gl_patient_tenant';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['org_id', 'tenant_id', 'patient_global_guid'], 'required'],
            [['org_id', 'tenant_id'], 'integer'],
            [['patient_global_guid'], 'string', 'max' => 50]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'pat_tenant_id' => 'Pat Tenant ID',
            'org_id' => 'Org ID',
            'tenant_id' => 'Tenant ID',
            'patient_global_guid' => 'Patient Guid',
        ];
    }
    
    /**
     * @return ActiveQuery
     */
    public function getTenant() {
        return $this->hasOne(CoTenant::className(), ['tenant_id' => 'tenant_id']);
    }
    
    /**
     * @return ActiveQuery
     */
    public function getOrg() {
        return $this->hasOne(CoOrganization::className(), ['org_id' => 'org_id']);
    }
}
