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

    private function createDDLItem($field, $item, $value) {
        $item = $field->addChild('LISTITEM', $item);
        $item->addAttribute('value', $value);
        $item->addAttribute('Selected', 'False');
    }
    
    public function actionSetattrvalue() {
        $node = 'LISTITEM';
        $attr = 'value';
        $find = 'RTA &amp; Surgery';
        $replace = 'RTA & Surgery';
        $xpath = "/FIELDS/GROUP/PANELBODY//{$node}[@{$attr}='{$find}']";

        $all_files = $this->getAllFiles();
        $error_files = [];
        if (!empty($all_files)) {
            foreach ($all_files as $key => $files) {
                if (filesize($files) > 0) {
                    libxml_use_internal_errors(true);
                    $xml = simplexml_load_file($files, null, LIBXML_NOERROR);
                    if ($xml === false) {
                        $error_files[$key]['name'] = $files;
                        $error_files[$key]['error'] = libxml_get_errors();
                        continue;
                    }
                    $targets = $xml->xpath($xpath);
                    if (!empty($targets)) {
                        foreach ($targets as $target) {
                            $target[$attr] = $replace;
                        }
                    }
                    $xml->asXML($files);
                }
            }
        }
        echo "<pre>";
        print_r($error_files);
        exit;
    }

    //2. Section of past medical history Can we add RTA & Surgery (earlier suggested by Gopi Sir)  - COMPLETED
    public function actionInsertnewnode() {
        $field_type = 'DropDownList';
        if ($field_type == 'DropDownList') {
            $find_val = 'Thyroid dysfunction';
            $item = 'RTA &amp; Surgery';
            $value = 'RTA & Surgery';
            $xpath = "/FIELDS/GROUP/PANELBODY//LISTITEM[@value='{$find_val}']/parent::LISTITEMS";
        }

        $all_files = $this->getAllFiles();
        $error_files = [];
        if (!empty($all_files)) {
            foreach ($all_files as $key => $files) {
                if (filesize($files) > 0) {
                    libxml_use_internal_errors(true);
                    $xml = simplexml_load_file($files, null, LIBXML_NOERROR);
                    if ($xml === false) {
                        $error_files[$key]['name'] = $files;
                        $error_files[$key]['error'] = libxml_get_errors();
                        continue;
                    }
                    $targets = $xml->xpath($xpath);
                    if (!empty($targets)) {
                        foreach ($targets as $target) {
                            $target_array = (array) $target;
                            if (!in_array($value, $target_array['LISTITEM'])) {
                                $this->createDDLItem($target, $item, $value);
                            }
                        }
                    }
                    $xml->asXML($files);
                }
            }
        }
        echo "<pre>";
        print_r($error_files);
        exit;
    }

    //3. Section of treatment history's table - it's showing currently under treatment in 3rd column Pls consider it as Treatment Response
    public function actionChangetext() {
        $find = 'Currently under treatment';
        $replace = 'Treatment Response';
        $xpath = "/FIELDS/GROUP/PANELBODY//FIELD[@type='RadGrid' and @ADDButtonID='RGPhamacoadd']/HEADER/TH[3]";

        $all_files = $this->getAllFiles();
        $error_files = [];
        if (!empty($all_files)) {
            foreach ($all_files as $key => $files) {
                if (filesize($files) > 0) {
                    libxml_use_internal_errors(true);
                    $xml = simplexml_load_file($files, null, LIBXML_NOERROR);
                    if ($xml === false) {
                        $error_files[$key]['name'] = $files;
                        $error_files[$key]['error'] = libxml_get_errors();
                        continue;
                    }
                    $targets = $xml->xpath($xpath);
                    if (!empty($targets)) {
                        if ($targets[0][0] == $find) {
                            $targets[0][0] = $replace;
                        }
                    }
                    $xml->asXML($files);
                }
            }
        }
        echo "<pre>";
        print_r($error_files);
        exit;
    }

    //3. Side effects - Changes
    public function actionSideeffects() {
        $xpath = "/FIELDS/GROUP/PANELBODY//FIELD[@type='RadGrid' and @ADDButtonID='RGPhamacoadd']//FIELD[@type='TextBox' and @label='Reason: ']";
        
        $all_files = $this->getAllFiles();
        $error_files = [];
        if (!empty($all_files)) {
            foreach ($all_files as $key => $files) {
                if (filesize($files) > 0) {
                    libxml_use_internal_errors(true);
                    $xml = simplexml_load_file($files, null, LIBXML_NOERROR);
                    if ($xml === false) {
                        $error_files[$key]['name'] = $files;
                        $error_files[$key]['error'] = libxml_get_errors();
                        continue;
                    }
                    $targets = $xml->xpath($xpath);
                    if (!empty($targets)) {
                        foreach($targets as $target){
                            if($target['label'] != '') {
                                $target['label'] = '';
                            }
                            if($target->PROPERTIES->PROPERTY[3] == 'Reason'){
                                $target->PROPERTIES->PROPERTY[3] = 'Mention that side effect';
                            }
                        }
                    }
                    $xml->asXML($files);
                }
            }
        }
        echo "<pre>";
        print_r($error_files);
        exit;
    }

}
