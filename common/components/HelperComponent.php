<?php

namespace common\components;

use yii\base\Component;
use yii\helpers\Html;

class HelperComponent extends Component {

    public $content;

    public function init() {
        parent::init();
        $this->content = 'Hello Yii 2.0';
    }

    public function display($content = null) {
        if ($content != null) {
            $this->content = $content;
        }
        echo Html::encode($this->content);
    }

}

?>
