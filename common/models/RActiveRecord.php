<?php

namespace common\models;

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
                    return Yii::$app->user->identity->user_id;
                }
            ],
        ];
    }
    
    //////
}
