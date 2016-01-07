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
        if($tenant_id == null)
            $tenant_id = Yii::$app->user->identity->user->tenant_id;
        return $this->andWhere(['tenant_id' => $tenant_id]);
    }

    public function status($status = 1) {
        return $this->andWhere(['status' => $status]);
    }

}
