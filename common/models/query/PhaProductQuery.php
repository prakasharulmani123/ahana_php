<?php

namespace common\models\query;

use Yii;

class PhaProductQuery extends CommonQuery {

    public function nameLike($name = NULL) {
        $explode = array_map('trim', explode('|', $name));
        
        $query = $this->andWhere("product_name LIKE '%{$explode[0]}%'");
        if(isset($explode[1]))
            $query->orWhere("product_unit_count LIKE '%{$explode[1]}%'");
        if(isset($explode[2]))
            $query->orWhere("product_unit LIKE '%{$explode[2]}%'");

        return $query;
    }

}
