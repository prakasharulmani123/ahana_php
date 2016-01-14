<?php

namespace common\models\query;

class CoUserQuery extends CommonQuery {
    
    public function careprovider($care_provider = '1') {
        return $this->andWhere(['care_provider' => $care_provider]);
    }
    
}
