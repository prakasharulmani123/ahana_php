<?php

namespace common\models\query;

use Yii;

class CoStateQuery extends CommonQuery {

    public function tenantWithNull($tenant_id = NULL) {
        if ($tenant_id == null && empty($tenant_id))
            $tenant_id = Yii::$app->user->identity->user->tenant_id;
        return $this->andWhere(['tenant_id' => $tenant_id])->orWhere(['tenant_id' => null]);
    }

}
