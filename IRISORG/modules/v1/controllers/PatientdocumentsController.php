<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatDocuments;
use common\models\PatDocumentTypes;
use common\models\PatPatient;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PatientdocumentsController extends ActiveController {

    public $modelClass = 'common\models\PatDocuments';

    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => QueryParamAuth::className()
        ];
        $behaviors['contentNegotiator'] = [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
            ],
        ];

        return $behaviors;
    }

    public function actions() {
        $actions = parent::actions();
        $actions['index']['prepareDataProvider'] = [$this, 'prepareDataProvider'];

        return $actions;
    }

    public function prepareDataProvider() {
        /* @var $modelClass BaseActiveRecord */
        $modelClass = $this->modelClass;

        return new ActiveDataProvider([
            'query' => $modelClass::find()->tenant()->active()->orderBy(['created_at' => SORT_DESC]),
            'pagination' => false,
        ]);
    }

    public function actionGetdocumenttype() {
        $get = Yii::$app->getRequest()->get();
        if (!empty($get)) {
            $result = PatDocumentTypes::getDocumentType($get['doc_type']);
            return ['success' => true, 'result' => $result];
        }
    }

    public function actionGetdocument() {
        $get = Yii::$app->getRequest()->get();
        if (!empty($get)) {
            $result = PatDocuments::find()->tenant()->andWhere(['doc_id' => $get['doc_id']])->one();
            return ['success' => true, 'result' => $result];
        }
    }

    public function actionUpdatedocumenttype() {
        $post = Yii::$app->getRequest()->post();
        $model = PatDocumentTypes::find()->where(['doc_type_id' => 1])->one();
        $model->attributes = array(
            'document_xml' => $post['xml'],
            'document_xslt' => $post['xslt'],
        );
        $model->save(false);
    }

    public function actionSavedocument() {
        $post = Yii::$app->getRequest()->post();
        $patient = PatPatient::getPatientByGuid($post['patient_id']);
        $case_history_xml = PatDocumentTypes::getDocumentType('CH');

        $doc_exists = PatDocuments::find()->tenant()->andWhere([
                    'patient_id' => $patient->patient_id,
                    'doc_type_id' => $case_history_xml->doc_type_id,
                    'encounter_id' => $post['encounter_id'],
                ])->one();

        if (!empty($doc_exists)) {
            $patient_document = $doc_exists;
            $xml = $doc_exists->document_xml;
        } else {
            $patient_document = new PatDocuments;
            $xml = $case_history_xml->document_xml;
        }

        $result = $this->prepareXml($xml, $post);

        if (isset($post['button_id'])) {
            $result = $this->preparePresentingComplaintsXml($result, $post['button_id'], $post['table_id'], $post['rowCount']);
        }

        $patient_document->attributes = [
            'patient_id' => $patient->patient_id,
            'encounter_id' => $post['encounter_id'],
            'doc_type_id' => $case_history_xml->doc_type_id,
            'document_xml' => $result,
        ];
        $patient_document->save(false);
        return ['success' => true, 'xml' => $result];
    }

    protected function prepareXml($xml, $post) {
        $xmlLoad = simplexml_load_string($xml);
        $postKeys = array_keys($post);

        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $x) {

                //GRID
                if ($x->attributes()->type == 'RadGrid') {
                    foreach ($x->COLUMNS as $columns) {
                        foreach ($columns->FIELD as $field) {
                            //Child FIELD
                            if (isset($field->FIELD)) {
                                foreach ($field->FIELD as $y) {
                                    foreach ($post as $key => $value) {
                                        if ($key == $y->attributes()) {
                                            $type = $y->attributes()->type;

                                            if ($type == 'CheckBoxList') {
                                                $post_referral_details = $value; // Array
                                                $list_referral_details = $y->LISTITEMS->LISTITEM;
                                                foreach ($list_referral_details as $list_value) {
                                                    if (in_array($list_value, $post_referral_details)) {
                                                        $list_value->attributes()['Selected'] = 'true';
                                                    }
                                                }
                                            } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                                $post_referral_details = $value; // String
                                                $list_referral_details = $y->LISTITEMS->LISTITEM;
                                                foreach ($list_referral_details as $list_value) {
                                                    if ($list_value == $post_referral_details) {
                                                        $list_value->attributes()['Selected'] = 'true';
                                                    }
                                                }
                                            } elseif ($type == 'textareaFull') {
                                                if (isset($y->VALUE)) {
                                                    unset($y->VALUE);
                                                }
                                                $y->addChild('VALUE', $value);
                                            } else {
                                                foreach ($y->PROPERTIES->PROPERTY as $text_pro) {
                                                    if ($text_pro['name'] == 'value') {
                                                        $dom = dom_import_simplexml($text_pro);
                                                        $dom->parentNode->removeChild($dom);
                                                    }
                                                }
                                                $text_box_value = $y->PROPERTIES->addChild('PROPERTY', $value);
                                                $text_box_value->addAttribute('name', 'value');
                                            }
                                        }
                                    }
                                }
                            }

                            //Main FIELD
                            foreach ($post as $key => $value) {
                                if ($key == $field->attributes()) {
                                    $type = $field->attributes()->type;
                                    //Checkbox
                                    if ($type == 'CheckBoxList') {
                                        $post_referral_details = $value;
                                        $list_referral_details = $field->LISTITEMS->LISTITEM;
                                        foreach ($list_referral_details as $list_value) {
                                            if (in_array($list_value, $post_referral_details)) {
                                                $list_value->attributes()['Selected'] = 'true';
                                            }
                                        }
                                    } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                        $post_referral_details = $value;
                                        $list_referral_details = $field->LISTITEMS->LISTITEM;
                                        foreach ($list_referral_details as $list_value) {
                                            if ($list_value == $post_referral_details) {
                                                $list_value->attributes()['Selected'] = 'true';
                                            }
                                        }
                                    } elseif ($type == 'textareaFull') {
                                        if (isset($field->VALUE)) {
                                            unset($field->VALUE);
                                        }
                                        $field->addChild('VALUE', $value);
                                    } else {
                                        foreach ($field->PROPERTIES->PROPERTY as $text_pro) {
                                            if ($text_pro['name'] == 'value') {
                                                $dom = dom_import_simplexml($text_pro);
                                                $dom->parentNode->removeChild($dom);
                                            }
                                        }
                                        $text_box_value = $field->PROPERTIES->addChild('PROPERTY', $value);
                                        $text_box_value->addAttribute('name', 'value');
                                    }
                                }
                            }
                        }
                    }
                }

                //Child FIELD
                if (isset($x->FIELD)) {
                    foreach ($x->FIELD as $y) {
                        foreach ($post as $key => $value) {
                            if ($key == $y->attributes()) {
                                $type = $y->attributes()->type;

                                if ($type == 'CheckBoxList') {
                                    $post_referral_details = $value; // Array
                                    $list_referral_details = $y->LISTITEMS->LISTITEM;
                                    foreach ($list_referral_details as $list_value) {
                                        if (in_array($list_value, $post_referral_details)) {
                                            $list_value->attributes()['Selected'] = 'true';
                                        }
                                    }
                                } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                    $post_referral_details = $value; // String
                                    $list_referral_details = $y->LISTITEMS->LISTITEM;
                                    foreach ($list_referral_details as $list_value) {
                                        if ($list_value == $post_referral_details) {
                                            $list_value->attributes()['Selected'] = 'true';
                                        }
                                    }
                                } elseif ($type == 'textareaFull') {
                                    if (isset($y->VALUE)) {
                                        unset($y->VALUE);
                                    }
                                    $y->addChild('VALUE', $value);
                                } else {
                                    foreach ($y->PROPERTIES->PROPERTY as $text_pro) {
                                        if ($text_pro['name'] == 'value') {
                                            $dom = dom_import_simplexml($text_pro);
                                            $dom->parentNode->removeChild($dom);
                                        }
                                    }
                                    $text_box_value = $y->PROPERTIES->addChild('PROPERTY', $value);
                                    $text_box_value->addAttribute('name', 'value');
                                }
                            }
                        }
                    }
                }

                //Main FIELD
                foreach ($post as $key => $value) {
                    if ($key == $x->attributes()) {
                        $type = $x->attributes()->type;
                        //Checkbox
                        if ($type == 'CheckBoxList') {
                            $post_referral_details = $value;
                            $list_referral_details = $x->LISTITEMS->LISTITEM;
                            foreach ($list_referral_details as $list_value) {
                                if (in_array($list_value, $post_referral_details)) {
                                    $list_value->attributes()['Selected'] = 'true';
                                }
                            }
                        } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                            $post_referral_details = $value;
                            $list_referral_details = $x->LISTITEMS->LISTITEM;
                            foreach ($list_referral_details as $list_value) {
                                if ($list_value == $post_referral_details) {
                                    $list_value->attributes()['Selected'] = 'true';
                                }
                            }
                        } elseif ($type == 'textareaFull') {
                            if (isset($x->VALUE)) {
                                unset($x->VALUE);
                            }
                            $x->addChild('VALUE', $value);
                        } else {
                            foreach ($x->PROPERTIES->PROPERTY as $text_pro) {
                                if ($text_pro['name'] == 'value') {
                                    $dom = dom_import_simplexml($text_pro);
                                    $dom->parentNode->removeChild($dom);
                                }
                            }
                            $text_box_value = $x->PROPERTIES->addChild('PROPERTY', $value);
                            $text_box_value->addAttribute('name', 'value');
                        }
                    }
                }
            }
        }

        $xml = $xmlLoad->asXML();

        return $xml;
    }

    protected function preparePresentingComplaintsXml($xml, $button_id, $table_id, $rowCount) {
        $xmlLoad = simplexml_load_string($xml);
        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $x) {
                if ($x->attributes()->type == 'RadGrid' && $x->attributes()->AddButtonTableId == $table_id) {
                    $text_box = 'txtComplaints' . $rowCount; //Textbox1 Name
                    $text_box2 = 'txtDuration' . $rowCount; //Textbox2 Name
                    $dropdown = 'DDLDuration' . $rowCount; //DDL Name

                    $columns = $x->addChild('COLUMNS');

                    $field1 = $columns->addChild('FIELD');
                    $field1->addAttribute('id', $text_box);
                    $field1->addAttribute('type', 'TextBox');

                    $properties1 = $field1->addChild('PROPERTIES');

                    $property1 = $properties1->addChild('PROPERTY', $text_box);
                    $property1->addAttribute('name', 'id');

                    $property2 = $properties1->addChild('PROPERTY', $text_box);
                    $property2->addAttribute('name', 'name');

                    $field2 = $columns->addChild('FIELD');
                    $field2->addAttribute('id', $text_box2);
                    $field2->addAttribute('type', 'TextBox');

                    $properties2 = $field2->addChild('PROPERTIES');

                    $property3 = $properties2->addChild('PROPERTY', $text_box2);
                    $property3->addAttribute('name', 'id');

                    $property4 = $properties2->addChild('PROPERTY', 'return isNumericKeyStroke()');
                    $property4->addAttribute('name', 'onkeydown');

                    $property5 = $properties2->addChild('PROPERTY', $text_box2);
                    $property5->addAttribute('name', 'name');

                    $subfield1 = $field2->addChild('FIELD');
                    $subfield1->addAttribute('id', $dropdown);
                    $subfield1->addAttribute('type', 'DropDownList');

                    $properties3 = $subfield1->addChild('PROPERTIES');

                    $property6 = $properties3->addChild('PROPERTY', $dropdown);
                    $property6->addAttribute('name', 'id');

                    $property7 = $properties3->addChild('PROPERTY', $dropdown);
                    $property7->addAttribute('name', 'name');

                    $listitems = $subfield1->addChild('LISTITEMS');

                    $listitem1 = $listitems->addChild('LISTITEM', 'Yrs');
                    $listitem1->addAttribute('value', 'Yrs');
                    $listitem1->addAttribute('Selected', 'False');

                    $listitem2 = $listitems->addChild('LISTITEM', 'Months');
                    $listitem2->addAttribute('value', 'Months');
                    $listitem2->addAttribute('Selected', 'False');

                    $listitem3 = $listitems->addChild('LISTITEM', 'Weeks');
                    $listitem3->addAttribute('value', 'Weeks');
                    $listitem3->addAttribute('Selected', 'False');

                    $listitem4 = $listitems->addChild('LISTITEM', 'Days');
                    $listitem4->addAttribute('value', 'Days');
                    $listitem4->addAttribute('Selected', 'False');
                }
            }
        }

        $xml = $xmlLoad->asXML();
        return $xml;
    }
}
