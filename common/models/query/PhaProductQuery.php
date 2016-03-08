<?php

namespace common\models\query;

use Yii;

class PhaProductQuery extends CommonQuery {

    public function nameLike($name = NULL) {
        return $this->andWhere("product_name LIKE '%$name%'");
    }

}
