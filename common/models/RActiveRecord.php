<?php

namespace common\models;

use common\models\behaviors\SoftDelete;
use Yii;
use yii\behaviors\BlameableBehavior;
use yii\behaviors\TimestampBehavior;
use yii\db\ActiveRecord;
use yii\db\Expression;

class RActiveRecord extends ActiveRecord {

    public function behaviors() {
        return [
            [
                'class' => TimestampBehavior::className(),
                'attributes' => [
                    ActiveRecord::EVENT_BEFORE_INSERT => ['created_at', 'modified_at'],
                    ActiveRecord::EVENT_BEFORE_UPDATE => ['modified_at'],
                ],
                'value' => new Expression('NOW()')
            ],
            [
                'class' => BlameableBehavior::className(),
                'updatedByAttribute' => 'modified_by',
                'value' => function ($event) {
                    if (isset(Yii::$app->user->identity->user_id))
                        return Yii::$app->user->identity->user_id;
                }
            ],
            'softDelete' => [
                'class' => SoftDelete::className(),
                // these are the default values, which you can omit
                'attribute' => 'deleted_at',
                'value' => null, // this is the same format as in TimestampBehavior
                'safeMode' => false, // this processes '$model->delete()' calls as soft-deletes
            ],
        ];
    }

    public function beforeSave($insert) {
        if (isset(Yii::$app->user->identity) && Yii::$app->user->identity->user_id > 0) {
            $this->tenant_id = Yii::$app->user->identity->user->tenant_id;
        }
        return parent::beforeSave($insert);
    }
}
