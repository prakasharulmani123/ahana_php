<?php

namespace common\models\query;

use Yii;
use yii\db\ActiveQuery;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of CoRoleQuery
 *
 * @author ark-05
 */
class CommonQuery extends ActiveQuery {

    public function tenant($tenant_id = NULL) {
        if ($tenant_id == null && empty($tenant_id))
            $tenant_id = Yii::$app->user->identity->user->tenant_id;
        return $this->andWhere(['tenant_id' => $tenant_id]);
    }

    public function status($status = '1') {
        if (strpos($status, ',') !== false) {
            $status = explode(',', $status);
        }
        return $this->andWhere(['status' => $status]);
    }

    public function active() {
        return $this->andWhere('deleted_at = "0000-00-00 00:00:00"');
    }

    public function deleted() {
        return $this->andWhere('deleted_at != "0000-00-00 00:00:00"');
    }

}
