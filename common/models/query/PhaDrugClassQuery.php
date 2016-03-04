<?php

namespace common\models\query;

use common\models\PhaDrugGeneric;
use yii\helpers\ArrayHelper;

class PhaDrugClassQuery extends CommonQuery {

    public function notUsed() {
        $ids = ArrayHelper::map(PhaDrugGeneric::find()->all(), 'drug_class_id', 'drug_class_id');
        return $this->andWhere(['NOT IN', 'drug_class_id', $ids]);
    }

}
