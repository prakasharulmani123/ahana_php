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
        $base_xml = [realpath(dirname(__FILE__) . '/../../../../IRISADMIN/web/case_history.xml')];
        $all_files = \yii\helpers\ArrayHelper::merge($base_xml, $files);
        return $all_files;
    }

    private function createDDLItem($field, $item, $value) {
        $item = $field->addChild('LISTITEM', $item);
        $item->addAttribute('value', $value);
        $item->addAttribute('Selected', 'False');
    }

    private function createRadioButton($field, $item, $value, $id) {
        $item = $field->addChild('LISTITEM', $item);
        $item->addAttribute('value', $value);
        $item->addAttribute('id', $id);
        $item->addAttribute('Selected', 'False');
    }

    private function simplexml_insert_after($insert, $target) {
        $target_dom = dom_import_simplexml($target);
        $insert_dom = $target_dom->ownerDocument->importNode(dom_import_simplexml($insert), true);
        if ($target_dom->nextSibling) {
            return $target_dom->parentNode->insertBefore($insert_dom, $target_dom->nextSibling);
        } else {
            return $target_dom->parentNode->appendChild($insert_dom);
        }
    }

    public function actionInsertnewfield() {
        $xpath = "/FIELDS/GROUP/PANELBODY//FIELD[@id='CBleisuretimespent']";
        $insert = '<FIELD id="CBfantasies" header2Class="Premorbid_Personality" type="CheckBoxList" label="Fantasies and Dreams">
                        <PROPERTIES>
                            <PROPERTY name="name">CBfantasies[]</PROPERTY>
                        </PROPERTIES>
                        <LISTITEMS>
                            <LISTITEM value="Day Dreaming" id="CBfantasies1" Selected="False">Day Dreaming</LISTITEM>
                            <LISTITEM value="Recurrent Dreams" id="CBfantasies2" Selected="False">Recurrent Dreams</LISTITEM>
                            <LISTITEM value="Sexual Fantasies" id="CBfantasies3" Selected="False">Sexual Fantasies</LISTITEM>
                            <LISTITEM value="Non sexual fantasies" id="CBfantasies4" Selected="False">Non sexual fantasies</LISTITEM>
                            <LISTITEM value="Unrealistic" id="CBfantasies5" Selected="False">Unrealistic</LISTITEM>
                            <LISTITEM value="Goal oriented" id="CBfantasies6" Selected="False">Goal oriented</LISTITEM>
                        </LISTITEMS>
                    </FIELD>';

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
                            $this->simplexml_insert_after(simplexml_load_string($insert), $target);
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

    public function actionSetattrvalue() {
        $node = 'FIELD';
        $attr = 'label';
        $find = 'Attension';
        $replace = 'Attention';
//        $node = 'LISTITEM';
//        $attr = 'value';
//        $find = 'RTA &amp; Surgery';
//        $replace = 'RTA & Surgery';
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
        $field_type = 'RadioButtonList';
        if ($field_type == 'DropDownList') {
            $find_val = 'Thyroid dysfunction';
            $item = 'RTA &amp; Surgery';
            $value = 'RTA & Surgery';
            $xpath = "/FIELDS/GROUP/PANELBODY//LISTITEM[@value='{$find_val}']/parent::LISTITEMS";
        } else if ($field_type == 'RadioButtonList') {
            $find_val = 'RBknowledgeofspouse2';
            $item = 'NA';
            $value = 'NA';
            $id = 'RBknowledgeofspouse3';
            $xpath = "/FIELDS/GROUP/PANELBODY//LISTITEM[@id='{$find_val}']/parent::LISTITEMS";
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
                                if ($field_type == 'DropDownList') {
                                    $this->createDDLItem($target, $item, $value);
                                } else if ($field_type == 'RadioButtonList') {
                                    $this->createRadioButton($target, $item, $value, $id);
                                }
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
        $xpath = "/FIELDS/GROUP/PANELBODY//FIELD[@type='RadGrid' and @ADDButtonID='RGPhamacoadd']//FIELD[@type='RadioButtonList']/FIELD[@type='TextBox']";
        $list_items = ['slurred speech', 'blurred vision', 'drowsiness', 'extra pyramidal symptoms', 'increased salivation', 'dysphagia', 'obesity', 'milk secretion', 'constipation', 'hand tremors', 'sexual dysfunction', 'menstrual problems', 'motor restlessness'];

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
                            unset($target['label']);
                            $target['type'] = 'DropDownList';
                            if ($target->PROPERTIES->PROPERTY[3]['name'] == 'placeholder') {
                                unset($target->PROPERTIES->PROPERTY[3]);
                            }

                            $listItems = $target->addChild('LISTITEMS');
                            foreach ($list_items as $itemkey => $value) {
                                $item_{$itemkey} = $listItems->addChild('LISTITEM', $value);
                                $item_{$itemkey}->addAttribute('value', $value);
                                $item_{$itemkey}->addAttribute('Selected', "False");
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

    public function actionRbtocb() {
        $xpath = "/FIELDS/GROUP/PANELBODY//FIELD[@type='RadioButtonList' and @id='relationship']";

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
                            $target['type'] = 'CheckBoxList';
                            $target->PROPERTIES->PROPERTY = $target->PROPERTIES->PROPERTY . '[]';
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

    public function actionLiaddsetattr() {
        $xpath = "/FIELDS/GROUP/PANELBODY//FIELD[@id='precipitating_factor' and @type='CheckBoxList']";

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
                            foreach ($target->LISTITEMS->LISTITEM as $list_item) {
                                if (isset($list_item['onclick'])) {
                                    unset($list_item['onclick']);
                                }
                                $list_item->addAttribute('onclick', "OThersvisible(this.id, 'precipitating_factor_other_div', 'block');");
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

    public function actionChangetxtattrval() {
        $xpath = "/FIELDS/GROUP/PANELBODY//LISTITEM[@id='RBmaritalsexualsatisfac1']";

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
                            $target['value'] = 'satisfactory';
                            $target[0] = 'satisfactory';
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

    public function actionRbtoddl() {
        $xpath = "/FIELDS/GROUP/PANELBODY//FIELD[@type='RadioButtonList' and @id='primary_care_giver']";
        $field_property = [
            'id' => 'primary_care_giver',
            'name' => 'primary_care_giver',
            'class' => 'form-control'
        ];
        $list_items = ['Self', 'Father', 'Mother', 'Sibling', 'Spouse', 'Children', 'Friend', 'Others'];

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
                            $target['type'] = 'DropDownList';

                            unset($target->PROPERTIES);
                            $properties = $target->addChild('PROPERTIES');
                            foreach ($field_property as $key => $value) {
                                $property_{$key} = $properties->addChild("PROPERTY", $value);
                                $property_{$key}->addAttribute('name', $key);
                            }

                            unset($target->LISTITEMS);
                            $listItems = $target->addChild('LISTITEMS');
                            foreach ($list_items as $key => $value) {
                                $item_{$key} = $listItems->addChild('LISTITEM', $value);
                                $item_{$key}->addAttribute('value', $value);
                                $item_{$key}->addAttribute('Selected', ($key == 0 ? "True" : "False"));
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

    public function actionTextareafulltotextarea() {
        $xpath = "/FIELDS/GROUP/PANELBODY//FIELD[@type='textareaFull']";

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
                            if ($target['id'] == 'history_presenting_illness') {
                                continue;
                            }
                            $target['type'] = 'TextArea';
                            foreach ($target->PROPERTIES->PROPERTY as $property) {
                                if ($property['name'] == 'class') {
                                    $property[0] = 'form-control';
                                }

                                if ($property['name'] == 'rows') {
                                    $property['name'] = 'placeholder';
                                    $property[0] = 'Notes';
                                }
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

    public function actionDeletefield() {
        $xpath = "/FIELDS/GROUP/PANELBODY//FIELD[@type='RadGrid' and @ADDButtonID='RGCompliantadd']//FIELD[@type='TextBoxDDL']";

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
                            $dom = dom_import_simplexml($target);
                            $dom->parentNode->removeChild($dom);
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

    public function actionDeleteth() {
        $xpath = "/FIELDS/GROUP/PANELBODY//FIELD[@type='RadGrid' and @ADDButtonID='RGCompliantadd']/HEADER";

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
                            if (isset($target->TH[1])) {
                                unset($target->TH[1]);
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
