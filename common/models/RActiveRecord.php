<?php

namespace common\models;

use yii\db\ActiveRecord;

class RActiveRecord extends ActiveRecord {

    public function unsetAttributes($names = null) {
        if ($names === null)
            $names = $this->attributeNames();
        foreach ($names as $name)
            $this->$name = null;
    }

}
