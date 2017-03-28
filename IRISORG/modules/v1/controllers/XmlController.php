<?php

namespace IRISORG\modules\v1\controllers;

use Yii;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\FileHelper;
use yii\web\Controller;
use yii\web\Response;

class XmlController extends Controller {

    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => QueryParamAuth::className(),
            'only' => ['getnavigation', 'getconsultantcharges', 'switchbranch', 'getlog'],
        ];
        $behaviors['contentNegotiator'] = [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
            ],
        ];

        return $behaviors;
    }

    public function actionIndex() {
        echo "AAAAAAA";
        exit;
        return $this->render('index');
    }

    private function getAllFiles($foler_name = 'uploads') {
        $webroot = Yii::getAlias('@webroot');
        $files = FileHelper::findFiles($webroot . '/' . $foler_name, [
                    'only' => ['*.xml'],
                    'recursive' => true,
        ]);
        return $files;
    }

    private function createDDLItem($field, $new_val) {
        $item = $field->addChild('LISTITEM', $new_val);
        $item->addAttribute('value', $new_val);
        $item->addAttribute('Selected', 'False');
    }

    //2. Section of past medical history Can we add RTA & Surgery (earlier suggested by Gopi Sir)  - COMPLETED
//    public function actionInsertnewnode() {
//        $field_type = 'DropDownList';
//        if ($field_type == 'DropDownList') {
//            $find_val = 'Thyroid dysfunction';
//            $new_val = 'RTA &amp; Surgery';
//            $xpath = "/FIELDS/GROUP/PANELBODY//LISTITEM[@value='{$find_val}']/parent::LISTITEMS";
//        }
//
//        $all_files = $this->getAllFiles();
//        $error_files = [];
//        if (!empty($all_files)) {
//            foreach ($all_files as $key => $files) {
//                if (filesize($files) > 0) {
//                    libxml_use_internal_errors(true);
//                    $xml = simplexml_load_file($files, null, LIBXML_NOERROR);
//                    if ($xml === false) {
//                        $error_files[$key]['name'] = $files;
//                        $error_files[$key]['error'] = libxml_get_errors();
//                        continue;
//                    }
//                    $targets = $xml->xpath($xpath);
//                    if (!empty($targets)) {
//                        foreach ($targets as $target) {
//                            $this->createDDLItem($target, $new_val);
//                        }
//                    }
//                    $xml->asXML($files);
//                }
//            }
//        }
//        echo "<pre>";
//        print_r($error_files);
//        exit;
//    }

}
