<?php

namespace common\models\query;

use Yii;

class PatEncounterQuery extends CommonQuery {
    
    public function encounterType($type = 'IP') {
        return $this->andWhere(['encounter_type' => $type]);
    }


}
