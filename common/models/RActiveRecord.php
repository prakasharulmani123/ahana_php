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

    public function beforeValidate() {
        if (isset(Yii::$app->user->identity) && Yii::$app->user->identity->user_id > 0 && $this->hasAttribute('tenant_id')) {
            $this->tenant_id = Yii::$app->user->identity->user->tenant_id;
        }
        return parent::beforeValidate();
    }

    public function beforeSave($insert) {
        if (isset(Yii::$app->user->identity) && Yii::$app->user->identity->user_id > 0 && $this->hasAttribute('tenant_id')) {
            $this->tenant_id = Yii::$app->user->identity->user->tenant_id;
        }
        return parent::beforeSave($insert);
    }

    public static function timeAgo($time_ago, $cur_time = NULL) {
        if(is_null($cur_time))
            $cur_time = time();
        
        $time_elapsed = $cur_time - $time_ago;
        $seconds = $time_elapsed;
        $minutes = round($time_elapsed / 60);
        $hours = round($time_elapsed / 3600);
        $days = round($time_elapsed / 86400);
        $weeks = round($time_elapsed / 604800);
        $months = round($time_elapsed / 2600640);
        $years = round($time_elapsed / 31207680);
        
        $result = '';
        // Seconds
        if ($seconds <= 60) {
            $result = "$seconds seconds ago";
        }
        //Minutes
        else if ($minutes <= 60) {
            if ($minutes == 1) {
                $result = "one minute ago";
            } else {
                $result = "$minutes minutes ago";
            }
        }
        //Hours
        else if ($hours <= 24) {
            if ($hours == 1) {
                $result = "an hour ago";
            } else {
                $result = "$hours hours ago";
            }
        }
        //Days
        else if ($days <= 7) {
            if ($days == 1) {
                $result = "yesterday";
            } else {
                $result = "$days days ago";
            }
        }
        //Weeks
        else if ($weeks <= 4.3) {
            if ($weeks == 1) {
                $result = "a week ago";
            } else {
                $result = "$weeks weeks ago";
            }
        }
        //Months
        else if ($months <= 12) {
            if ($months == 1) {
                $result = "a month ago";
            } else {
                $result = "$months months ago";
            }
        }
        //Years
        else {
            if ($years == 1) {
                $result = "one year ago";
            } else {
                $result = "$years years ago";
            }
        }
        
        return $result;
    }

}
