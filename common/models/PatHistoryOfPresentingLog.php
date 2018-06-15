<?php

namespace common\models;

/**
 * This is the model class for table "pat_history_of_presenting_log".
 *
 * @property integer $history_of_presenting_id
 * @property integer $doc_id
 * @property integer $tenant_id
 * @property string $history_of_presenting
 * @property string $status
 * @property integer $created_by
 * @property string $created_at
 * @property integer $modified_by
 * @property string $modified_at
 * @property string $deleted_at
 */
class PatHistoryOfPresentingLog extends RActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'pat_history_of_presenting_log';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['doc_id', 'tenant_id', 'created_by', 'modified_by'], 'integer'],
            [['history_of_presenting'], 'required'],
            [['history_of_presenting', 'status'], 'string'],
            [['created_at', 'modified_at', 'deleted_at'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'history_of_presenting_id' => 'History Of Presenting ID',
            'doc_id' => 'Doc ID',
            'tenant_id' => 'Tenant ID',
            'history_of_presenting' => 'History Of Presenting',
            'status' => 'Status',
            'created_by' => 'Created By',
            'created_at' => 'Created At',
            'modified_by' => 'Modified By',
            'modified_at' => 'Modified At',
            'deleted_at' => 'Deleted At',
        ];
    }
}
