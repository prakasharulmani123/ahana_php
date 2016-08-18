<?php

namespace IRISORG\modules\v1\controllers;

use common\models\PatDocuments;
use common\models\PatDocumentTypes;
use common\models\PatPatient;
use common\models\VDocuments;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
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

    //Delete Function
    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('doc_id');
        if ($id) {
            $model = PatDocuments::find()->where(['doc_id' => $id])->one();
            $model->delete();
            return ['success' => true];
        }
    }

    //Index Function
    public function actionGetpatientdocuments() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['patient_id'])) {
            $patient = PatPatient::getPatientByGuid($get['patient_id']);
            $condition = [
                'patient_id' => $patient->patient_id,
                'deleted_at' => '0000-00-00 00:00:00',
            ];
            $data = VDocuments::find()
                    ->where($condition)
                    ->groupBy('encounter_id')
                    ->orderBy(['encounter_id' => SORT_DESC])
                    ->asArray()
                    ->all();

            foreach ($data as $key => $value) {
                $details = VDocuments::find()
                        ->where(['encounter_id' => $value['encounter_id']])
                        ->andWhere($condition)
                        ->orderBy(['date_time' => SORT_DESC])
                        ->asArray()
                        ->all();

                $data[$key]['all'] = $details;
            }
            return ['success' => true, 'result' => $data];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    //Save Create / Update
    public function actionSavedocument() {
        $post = Yii::$app->getRequest()->post();
        $patient = PatPatient::getPatientByGuid($post['patient_id']);
        $type = 'CH';
        $case_history_xml = PatDocumentTypes::getDocumentType($type);

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
        $patient_document->scenario = $type;

        $attr = [
            'patient_id' => $patient->patient_id,
            'encounter_id' => $post['encounter_id'],
            'doc_type_id' => $case_history_xml->doc_type_id
        ];
        $attr = array_merge($post, $attr);
        $patient_document->attributes = $attr;

        if ($patient_document->validate() || $post['novalidate'] == 'true') {
            $result = $this->prepareXml($xml, $post);

            if (isset($post['button_id'])) {
                if ($post['table_id'] == 'RGCompliant') {
                    $result = $this->preparePresentingComplaintsXml($result, $post['table_id'], $post['rowCount']);
                } elseif ($post['table_id'] == 'RGMedicalHistory') {
                    $result = $this->preparePastMedicalHistoryXml($result, $post['table_id'], $post['rowCount']);
                } elseif ($post['table_id'] == 'RGPhamaco') {
                    $result = $this->preparePhamacotherapyXml($result, $post['table_id'], $post['rowCount']);
                } elseif ($post['table_id'] == 'RGfamily') {
                    $result = $this->prepareFamilyHistoryXml($result, $post['table_id'], $post['rowCount']);
                } elseif ($post['table_id'] == 'RGalt') {
                    $result = $this->prepareAlternativeTherapiesXml($result, $post['table_id'], $post['rowCount']);
                } elseif ($post['table_id'] == 'RGSubs') {
                    $result = $this->prepareSubstanceHistoryXml($result, $post['table_id'], $post['rowCount']);
                }
            }
            if (isset($post['status']))
                $patient_document->status = $post['status'];

            $patient_document->document_xml = $result;
            $patient_document->save(false);
            return ['success' => true, 'xml' => $result];
        } else {
            return ['success' => false, 'message' => Html::errorSummary([$patient_document])];
        }
    }

    protected function prepareXml($xml, $post) {
        $xmlLoad = simplexml_load_string($xml);
        $postKeys = array_keys($post);

        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $x) {

                //Main Field - PanelBar
                if ($x->attributes()->type == 'PanelBar') {
                    foreach ($x->FIELD as $pb) {
                        if ($pb->attributes()->type == 'RadGrid') {
                            foreach ($pb->COLUMNS as $columns) {
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
                                                            } else {
                                                                $list_value->attributes()['Selected'] = 'false';
                                                            }
                                                        }
                                                    } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                                        $post_referral_details = $value; // String
                                                        $list_referral_details = $y->LISTITEMS->LISTITEM;
                                                        foreach ($list_referral_details as $list_value) {
                                                            if ($list_value == $post_referral_details) {
                                                                $list_value->attributes()['Selected'] = 'true';
                                                            } else {
                                                                $list_value->attributes()['Selected'] = 'false';
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
                                                    } else {
                                                        $list_value->attributes()['Selected'] = 'false';
                                                    }
                                                }
                                            } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                                $field->attributes()['Backcontrols'] = 'hide';
//                                                $radio_field_id = ['radio_pb_illnesstype'];
                                                $list_values_array = ['Other Illness'];

                                                $post_referral_details = $value;
                                                $list_referral_details = $field->LISTITEMS->LISTITEM;

                                                foreach ($list_referral_details as $list_value) {
                                                    if ($list_value == $post_referral_details) {
//                                                        if (in_array($key, $radio_field_id)) {
                                                        if (in_array($list_value, $list_values_array)) {
                                                            $field->attributes()['Backcontrols'] = 'show';
                                                        }
//                                                        }
                                                        $list_value->attributes()['Selected'] = 'true';
                                                    } else {
                                                        $list_value->attributes()['Selected'] = 'false';
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

                        //Main FIELD Inside Panel Bar- Normal Checkbox, Radio, Input, etc...
                        foreach ($post as $key => $value) {
                            if ($key == $pb->attributes()) {
                                $type = $pb->attributes()->type;
                                //Checkbox
                                if ($type == 'CheckBoxList') {
                                    $post_referral_details = $value;
                                    $list_referral_details = $pb->LISTITEMS->LISTITEM;
                                    $pb->attributes()['Backcontrols'] = 'hide';
                                    foreach ($list_referral_details as $list_value) {
                                        if (in_array($list_value, $post_referral_details)) {
                                            $list_value->attributes()['Selected'] = 'true';
                                            if ($list_value == 'Others' || $key == 'CBDelusions') {
                                                $pb->attributes()['Backcontrols'] = 'show';
                                            }
                                        } else {
                                            $list_value->attributes()['Selected'] = 'false';
                                        }
                                    }
                                } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                    $pb->attributes()['Backcontrols'] = 'hide';
                                    $radio_field_id = ['previous_ects', 'rb_pb_Response1', 'RBtypeofmarriage', 'RBpbprenatal', 'RBpbperinatal2', 'RBpbmajorillness', 'RBpbdevelopmentmilestone', 'RBpbmajorillnessduringchild', 'RBpbhomeatmosphere', 'RBpbhomeatmosphereadole', 'RBpbbreakstudy', 'RBpbfrechangeschool', 'RBpbmedium', 'RBpbteacherrelation', 'RBpbstudentrelation', 'RBpbworkrecord', 'RBRegularity', 'RBObsession', 'RBOrientation'];
                                    $list_values_array = ['Yes', 'Discontinued', 'Consanguineous', 'Eventful', 'Delayed', 'Unsatisfactory', 'Others', 'Irregular', 'Present', 'Oriented'];

                                    $post_referral_details = $value;
                                    $list_referral_details = $pb->LISTITEMS->LISTITEM;

                                    foreach ($list_referral_details as $list_value) {
                                        if ($list_value == $post_referral_details) {
                                            if (in_array($key, $radio_field_id)) {
                                                if (in_array($list_value, $list_values_array)) {
                                                    $pb->attributes()['Backcontrols'] = 'show';
                                                }
                                            } else {
                                                $pb->attributes()['Backcontrols'] = 'show';
                                            }
                                            $list_value->attributes()['Selected'] = 'true';
                                        } else {
                                            $list_value->attributes()['Selected'] = 'false';
                                        }
                                    }
                                } elseif ($type == 'textareaFull') {
                                    if (isset($pb->VALUE)) {
                                        unset($pb->VALUE);
                                    }
                                    $pb->addChild('VALUE', $value);
                                } else {
                                    foreach ($pb->PROPERTIES->PROPERTY as $text_pro) {
                                        if ($text_pro['name'] == 'value') {
                                            $dom = dom_import_simplexml($text_pro);
                                            $dom->parentNode->removeChild($dom);
                                        }
                                    }
                                    $text_box_value = $pb->PROPERTIES->addChild('PROPERTY', $value);
                                    $text_box_value->addAttribute('name', 'value');
                                }
                            }
                        }

                        //Child FIELD Inside Panel Bar- Normal Checkbox, Radio, Input, etc...
                        if (isset($pb->FIELD)) {
                            foreach ($pb->FIELD as $pbchild) {
                                foreach ($post as $key => $value) {
                                    if ($key == $pbchild->attributes()) {
                                        $type = $pbchild->attributes()->type;

                                        if ($type == 'CheckBoxList') {
                                            $post_referral_details = $value; // Array
                                            $list_referral_details = $pbchild->LISTITEMS->LISTITEM;
                                            foreach ($list_referral_details as $list_value) {
                                                if (in_array($list_value, $post_referral_details)) {
                                                    $list_value->attributes()['Selected'] = 'true';
                                                } else {
                                                    $list_value->attributes()['Selected'] = 'false';
                                                }
                                            }
                                        } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                            $post_referral_details = $value; // String
                                            $list_referral_details = $pbchild->LISTITEMS->LISTITEM;
                                            foreach ($list_referral_details as $list_value) {
                                                if ($list_value == $post_referral_details) {
                                                    $list_value->attributes()['Selected'] = 'true';
                                                } else {
                                                    $list_value->attributes()['Selected'] = 'false';
                                                }
                                            }
                                        } elseif ($type == 'textareaFull') {
                                            if (isset($pbchild->VALUE)) {
                                                unset($pbchild->VALUE);
                                            }
                                            $pbchild->addChild('VALUE', $value);
                                        } else {
                                            foreach ($pbchild->PROPERTIES->PROPERTY as $text_pro) {
                                                if ($text_pro['name'] == 'value') {
                                                    $dom = dom_import_simplexml($text_pro);
                                                    $dom->parentNode->removeChild($dom);
                                                }
                                            }
                                            $text_box_value = $pbchild->PROPERTIES->addChild('PROPERTY', $value);
                                            $text_box_value->addAttribute('name', 'value');
                                        }
                                    }
                                }
                            }
                        }

                        //Sub Panel Bar
                        if ($pb->attributes()->type == 'PanelBar') {
                            foreach ($pb->FIELD as $pbsub) {
                                if ($pbsub->attributes()->type == 'RadGrid') {
                                    foreach ($pbsub->COLUMNS as $columns) {
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
                                                                    } else {
                                                                        $list_value->attributes()['Selected'] = 'false';
                                                                    }
                                                                }
                                                            } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                                                $post_referral_details = $value; // String
                                                                $list_referral_details = $y->LISTITEMS->LISTITEM;
                                                                foreach ($list_referral_details as $list_value) {
                                                                    if ($list_value == $post_referral_details) {
                                                                        $list_value->attributes()['Selected'] = 'true';
                                                                    } else {
                                                                        $list_value->attributes()['Selected'] = 'false';
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
                                                            } else {
                                                                $list_value->attributes()['Selected'] = 'false';
                                                            }
                                                        }
                                                    } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                                        $field->attributes()['Backcontrols'] = 'hide';
//                                                $radio_field_id = ['radio_pb_illnesstype'];
                                                        $list_values_array = ['Other Illness'];

                                                        $post_referral_details = $value;
                                                        $list_referral_details = $field->LISTITEMS->LISTITEM;

                                                        foreach ($list_referral_details as $list_value) {
                                                            if ($list_value == $post_referral_details) {
//                                                        if (in_array($key, $radio_field_id)) {
                                                                if (in_array($list_value, $list_values_array)) {
                                                                    $field->attributes()['Backcontrols'] = 'show';
                                                                }
//                                                        }
                                                                $list_value->attributes()['Selected'] = 'true';
                                                            } else {
                                                                $list_value->attributes()['Selected'] = 'false';
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

                                //Main FIELD Inside Panel Bar- Normal Checkbox, Radio, Input, etc...
                                foreach ($post as $key => $value) {
                                    if ($key == $pbsub->attributes()) {
                                        $type = $pbsub->attributes()->type;
                                        //Checkbox
                                        if ($type == 'CheckBoxList') {
                                            $post_referral_details = $value;
                                            $list_referral_details = $pbsub->LISTITEMS->LISTITEM;
                                            $pbsub->attributes()['Backcontrols'] = 'hide';
                                            foreach ($list_referral_details as $list_value) {
                                                if (in_array($list_value, $post_referral_details)) {
                                                    $list_value->attributes()['Selected'] = 'true';
                                                    if ($list_value == 'Others' || $key == 'CBDelusions') {
                                                        $pbsub->attributes()['Backcontrols'] = 'show';
                                                    }
                                                } else {
                                                    $list_value->attributes()['Selected'] = 'false';
                                                }
                                            }
                                        } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                            $pbsub->attributes()['Backcontrols'] = 'hide';
                                            $radio_field_id = ['previous_ects', 'rb_pb_Response1', 'RBtypeofmarriage', 'RBpbprenatal', 'RBpbperinatal2', 'RBpbmajorillness', 'RBpbdevelopmentmilestone', 'RBpbmajorillnessduringchild', 'RBpbhomeatmosphere', 'RBpbhomeatmosphereadole', 'RBpbbreakstudy', 'RBpbfrechangeschool', 'RBpbmedium', 'RBpbteacherrelation', 'RBpbstudentrelation', 'RBpbworkrecord', 'RBRegularity', 'RBObsession', 'RBOrientation'];
                                            $list_values_array = ['Yes', 'Discontinued', 'Consanguineous', 'Eventful', 'Delayed', 'Unsatisfactory', 'Others', 'Irregular', 'Present', 'Oriented'];

                                            $post_referral_details = $value;
                                            $list_referral_details = $pbsub->LISTITEMS->LISTITEM;

                                            foreach ($list_referral_details as $list_value) {
                                                if ($list_value == $post_referral_details) {
                                                    if (in_array($key, $radio_field_id)) {
                                                        if (in_array($list_value, $list_values_array)) {
                                                            $pbsub->attributes()['Backcontrols'] = 'show';
                                                        }
                                                    } else {
                                                        $pbsub->attributes()['Backcontrols'] = 'show';
                                                    }
                                                    $list_value->attributes()['Selected'] = 'true';
                                                } else {
                                                    $list_value->attributes()['Selected'] = 'false';
                                                }
                                            }
                                        } elseif ($type == 'textareaFull') {
                                            if (isset($pbsub->VALUE)) {
                                                unset($pbsub->VALUE);
                                            }
                                            $pbsub->addChild('VALUE', $value);
                                        } else {
                                            foreach ($pbsub->PROPERTIES->PROPERTY as $text_pro) {
                                                if ($text_pro['name'] == 'value') {
                                                    $dom = dom_import_simplexml($text_pro);
                                                    $dom->parentNode->removeChild($dom);
                                                }
                                            }
                                            $text_box_value = $pbsub->PROPERTIES->addChild('PROPERTY', $value);
                                            $text_box_value->addAttribute('name', 'value');
                                        }
                                    }
                                }

                                //Child FIELD Inside Panel Bar- Normal Checkbox, Radio, Input, etc...
                                if (isset($pbsub->FIELD)) {
                                    foreach ($pbsub->FIELD as $pbsubchild) {
                                        foreach ($post as $key => $value) {
                                            if ($key == $pbsubchild->attributes()) {
                                                $type = $pbsubchild->attributes()->type;

                                                if ($type == 'CheckBoxList') {
                                                    $post_referral_details = $value; // Array
                                                    $list_referral_details = $pbsubchild->LISTITEMS->LISTITEM;
                                                    foreach ($list_referral_details as $list_value) {
                                                        if (in_array($list_value, $post_referral_details)) {
                                                            $list_value->attributes()['Selected'] = 'true';
                                                        } else {
                                                            $list_value->attributes()['Selected'] = 'false';
                                                        }
                                                    }
                                                } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                                    $post_referral_details = $value; // String
                                                    $list_referral_details = $pbsubchild->LISTITEMS->LISTITEM;
                                                    foreach ($list_referral_details as $list_value) {
                                                        if ($list_value == $post_referral_details) {
                                                            $list_value->attributes()['Selected'] = 'true';
                                                        } else {
                                                            $list_value->attributes()['Selected'] = 'false';
                                                        }
                                                    }
                                                } elseif ($type == 'textareaFull') {
                                                    if (isset($pbsubchild->VALUE)) {
                                                        unset($pbsubchild->VALUE);
                                                    }
                                                    $pbsubchild->addChild('VALUE', $value);
                                                } else {
                                                    foreach ($pbsubchild->PROPERTIES->PROPERTY as $text_pro) {
                                                        if ($text_pro['name'] == 'value') {
                                                            $dom = dom_import_simplexml($text_pro);
                                                            $dom->parentNode->removeChild($dom);
                                                        }
                                                    }
                                                    $text_box_value = $pbsubchild->PROPERTIES->addChild('PROPERTY', $value);
                                                    $text_box_value->addAttribute('name', 'value');
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        //End Sub Panel Bar
                    }
                }

                //Main Field - GRID
                if ($x->attributes()->type == 'RadGrid') {
                    foreach ($x->COLUMNS as $columns) {
                        foreach ($columns->FIELD as $field) {
                            //Child FIELD
                            if (isset($field->FIELD)) {
                                foreach ($field->FIELD as $y) {
                                    foreach ($post as $key => $value) {
                                        if ($key == $y->attributes()->id) {
                                            $type = $y->attributes()->type;

                                            if ($type == 'CheckBoxList') {
                                                $post_referral_details = $value; // Array
                                                $list_referral_details = $y->LISTITEMS->LISTITEM;
                                                foreach ($list_referral_details as $list_value) {
                                                    if (in_array($list_value, $post_referral_details)) {
                                                        $list_value->attributes()['Selected'] = 'true';
                                                    } else {
                                                        $list_value->attributes()['Selected'] = 'false';
                                                    }
                                                }
                                            } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                                $post_referral_details = $value; // String
                                                $list_referral_details = $y->LISTITEMS->LISTITEM;
                                                foreach ($list_referral_details as $list_value) {
                                                    if ($list_value == $post_referral_details) {
                                                        $list_value->attributes()['Selected'] = 'true';
                                                    } else {
                                                        $list_value->attributes()['Selected'] = 'false';
                                                    }
                                                }
                                            } elseif ($type == 'textareaFull' || $type == 'TextArea') {
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
                                if ($key == $field->attributes()->id) {
                                    $type = $field->attributes()->type;
                                    //Checkbox
                                    if ($type == 'CheckBoxList') {
                                        $post_referral_details = $value;
                                        $list_referral_details = $field->LISTITEMS->LISTITEM;
                                        foreach ($list_referral_details as $list_value) {
                                            if (in_array($list_value, $post_referral_details)) {
                                                $list_value->attributes()['Selected'] = 'true';
                                            } else {
                                                $list_value->attributes()['Selected'] = 'false';
                                            }
                                        }
                                    } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                        $field->attributes()['Backcontrols'] = 'hide';
//                                        $radio_field_id = ['radio_med_his_currently_under_treatment'];
                                        $list_values_array = ['No'];

                                        $post_referral_details = $value;
                                        $list_referral_details = $field->LISTITEMS->LISTITEM;
                                        foreach ($list_referral_details as $list_value) {
                                            if ($list_value == $post_referral_details) {
//                                                if (in_array($key, $radio_field_id)) {
                                                if (in_array($list_value, $list_values_array)) {
                                                    $field->attributes()['Backcontrols'] = 'show';
                                                }
//                                                }
                                                $list_value->attributes()['Selected'] = 'true';
                                            } else {
                                                $list_value->attributes()['Selected'] = 'false';
                                            }
                                        }
                                    } elseif ($type == 'textareaFull' || $type == 'TextArea') {
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

                //Main FIELD - Normal Checkbox, Radio, Input, etc...
                foreach ($post as $key => $value) {
                    if ($key == $x->attributes()->id) {
                        $type = $x->attributes()->type;
                        //Checkbox
                        if ($type == 'CheckBoxList') {
                            $post_referral_details = $value;
                            $list_referral_details = $x->LISTITEMS->LISTITEM;
                            $x->attributes()['Backcontrols'] = 'hide';
                            foreach ($list_referral_details as $list_value) {
                                if (in_array($list_value, $post_referral_details)) {
                                    $list_value->attributes()['Selected'] = 'true';
                                    if ($list_value == 'Others') {
                                        $x->attributes()['Backcontrols'] = 'show';
                                    }
                                } else {
                                    $list_value->attributes()['Selected'] = 'false';
                                }
                            }
                        } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                            $x->attributes()['Backcontrols'] = 'hide';
                            $radio_field_id = ['religion', 'relationship', 'social_functioning', 'occupational_functioning', 'similar_episodes'];
                            $list_values_array = ['Others', 'Impaired', 'Yes'];

                            $post_referral_details = $value;
                            $list_referral_details = $x->LISTITEMS->LISTITEM;

                            foreach ($list_referral_details as $list_value) {
                                if ($list_value == $post_referral_details) {
                                    if (in_array($key, $radio_field_id)) {
                                        if (in_array($list_value, $list_values_array)) {
                                            $x->attributes()['Backcontrols'] = 'show';
                                        }
                                    } else {
                                        $x->attributes()['Backcontrols'] = 'show';
                                    }
                                    $list_value->attributes()['Selected'] = 'true';
                                } else {
                                    $list_value->attributes()['Selected'] = 'false';
                                }
                            }
                        } elseif ($type == 'textareaFull' || $type == 'TextArea') {
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

                //Child FIELD
                if (isset($x->FIELD)) {
                    foreach ($x->FIELD as $y) {
                        foreach ($post as $key => $value) {
                            if ($key == $y->attributes()->id) {
                                $type = $y->attributes()->type;

                                if ($type == 'CheckBoxList') {
                                    $post_referral_details = $value; // Array
                                    $list_referral_details = $y->LISTITEMS->LISTITEM;
                                    foreach ($list_referral_details as $list_value) {
                                        if (in_array($list_value, $post_referral_details)) {
                                            $list_value->attributes()['Selected'] = 'true';
                                        } else {
                                            $list_value->attributes()['Selected'] = 'false';
                                        }
                                    }
                                } elseif ($type == 'DropDownList' || $type == 'RadioButtonList') {
                                    $post_referral_details = $value;
                                    $list_referral_details = $y->LISTITEMS->LISTITEM;
                                    foreach ($list_referral_details as $list_value) {
                                        if ($list_value == $post_referral_details) {
                                            $list_value->attributes()['Selected'] = 'true';
                                        } else {
                                            $list_value->attributes()['Selected'] = 'false';
                                        }
                                    }
                                } elseif ($type == 'textareaFull' || $type == 'TextArea') {
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
            }
        }

        $xml = $xmlLoad->asXML();

        return $xml;
    }

    protected function preparePresentingComplaintsXml($xml, $table_id, $rowCount) {
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

                    $property3 = $properties1->addChild('PROPERTY', 'form-control');
                    $property3->addAttribute('name', 'class');

                    $field2 = $columns->addChild('FIELD');
                    $field2->addAttribute('id', $text_box2);
                    $field2->addAttribute('type', 'TextBoxDDL');

                    $properties2 = $field2->addChild('PROPERTIES');

                    $property4 = $properties2->addChild('PROPERTY', $text_box2);
                    $property4->addAttribute('name', 'id');

                    $property5 = $properties2->addChild('PROPERTY', 'return isNumericKeyStroke(event)');
                    $property5->addAttribute('name', 'onkeydown');

                    $property6 = $properties2->addChild('PROPERTY', $text_box2);
                    $property6->addAttribute('name', 'name');

                    $property7 = $properties2->addChild('PROPERTY', 'form-control');
                    $property7->addAttribute('name', 'class');

                    $subfield1 = $field2->addChild('FIELD');
                    $subfield1->addAttribute('id', $dropdown);
                    $subfield1->addAttribute('type', 'DropDownList');

                    $properties3 = $subfield1->addChild('PROPERTIES');

                    $property8 = $properties3->addChild('PROPERTY', $dropdown);
                    $property8->addAttribute('name', 'id');

                    $property9 = $properties3->addChild('PROPERTY', $dropdown);
                    $property9->addAttribute('name', 'name');

                    $property10 = $properties3->addChild('PROPERTY', 'form-control');
                    $property10->addAttribute('name', 'class');

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

    protected function preparePastMedicalHistoryXml($xml, $table_id, $rowCount) {
        $xmlLoad = simplexml_load_string($xml);
        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $x) {
                if ($x->attributes()->type == 'RadGrid' && $x->attributes()->AddButtonTableId == $table_id) {
                    $dropdown = 'DDLMedHis' . $rowCount;
                    $text_box = 'TxtMedHisDuration' . $rowCount;
                    $radio = 'radio_med_his_currently_under_treatment' . $rowCount;
                    $radio_back_div = 'med_his_currently_under_treatment_reason_div' . $rowCount;
                    $dropdown_2 = 'DDLMedHisDuration' . $rowCount;

                    $columns = $x->addChild('COLUMNS');

                    //FIELD 1
                    $field1 = $columns->addChild('FIELD');
                    $field1->addAttribute('id', $dropdown);
                    $field1->addAttribute('type', 'DropDownList');

                    $properties1 = $field1->addChild('PROPERTIES');

                    $property1 = $properties1->addChild('PROPERTY', $dropdown);
                    $property1->addAttribute('name', 'id');

                    $property2 = $properties1->addChild('PROPERTY', $dropdown);
                    $property2->addAttribute('name', 'name');

                    $property22 = $properties1->addChild('PROPERTY', 'form-control');
                    $property22->addAttribute('name', 'class');

                    $listitems = $field1->addChild('LISTITEMS');

                    $listitem1 = $listitems->addChild('LISTITEM', '--Select--');
                    $listitem1->addAttribute('value', '');
                    $listitem1->addAttribute('Selected', 'False');

                    $listitem2 = $listitems->addChild('LISTITEM', 'Diabetes');
                    $listitem2->addAttribute('value', 'Diabetes');
                    $listitem2->addAttribute('Selected', 'False');

                    $listitem3 = $listitems->addChild('LISTITEM', 'Hypertension');
                    $listitem3->addAttribute('value', 'Hypertension');
                    $listitem3->addAttribute('Selected', 'False');

                    $listitem4 = $listitems->addChild('LISTITEM', 'Tuberculosis');
                    $listitem4->addAttribute('value', 'Tuberculosis');
                    $listitem4->addAttribute('Selected', 'False');

                    $listitem5 = $listitems->addChild('LISTITEM', 'Hepatitis');
                    $listitem5->addAttribute('value', 'Hepatitis');
                    $listitem5->addAttribute('Selected', 'False');

                    $listitem6 = $listitems->addChild('LISTITEM', 'Asthma');
                    $listitem6->addAttribute('value', 'Asthma');
                    $listitem6->addAttribute('Selected', 'False');

                    $listitem7 = $listitems->addChild('LISTITEM', 'Bronchitis');
                    $listitem7->addAttribute('value', 'Bronchitis');
                    $listitem7->addAttribute('Selected', 'False');

                    $listitem8 = $listitems->addChild('LISTITEM', 'Head injury/LOC');
                    $listitem8->addAttribute('value', 'Head injury/LOC');
                    $listitem8->addAttribute('Selected', 'False');

                    $listitem9 = $listitems->addChild('LISTITEM', 'Seizures');
                    $listitem9->addAttribute('value', 'Seizures');
                    $listitem9->addAttribute('Selected', 'False');

                    $listitem10 = $listitems->addChild('LISTITEM', 'Cerebrovascular Accidents');
                    $listitem10->addAttribute('value', 'Cerebrovascular Accidents');
                    $listitem10->addAttribute('Selected', 'False');

                    $listitem11 = $listitems->addChild('LISTITEM', 'Immuno compromised state');
                    $listitem11->addAttribute('value', 'Immuno compromised state');
                    $listitem11->addAttribute('Selected', 'False');

                    $listitem12 = $listitems->addChild('LISTITEM', 'Mycocardial Infarction');
                    $listitem12->addAttribute('value', 'Mycocardial Infarction');
                    $listitem12->addAttribute('Selected', 'False');

                    $listitem13 = $listitems->addChild('LISTITEM', 'Allergies');
                    $listitem13->addAttribute('value', 'Allergies');
                    $listitem13->addAttribute('Selected', 'False');

                    $listitem14 = $listitems->addChild('LISTITEM', 'IHD');
                    $listitem14->addAttribute('value', 'IHD');
                    $listitem14->addAttribute('Selected', 'False');

                    //FIELD 2
                    $field2 = $columns->addChild('FIELD');
                    $field2->addAttribute('id', $text_box);
                    $field2->addAttribute('type', 'TextBoxDDL');

                    $properties2 = $field2->addChild('PROPERTIES');

                    $property3 = $properties2->addChild('PROPERTY', $text_box);
                    $property3->addAttribute('name', 'id');

                    $property4 = $properties2->addChild('PROPERTY', 'return isNumericKeyStroke(event)');
                    $property4->addAttribute('name', 'onkeydown');

                    $property5 = $properties2->addChild('PROPERTY', $text_box);
                    $property5->addAttribute('name', 'name');

                    $property55 = $properties2->addChild('PROPERTY', 'form-control');
                    $property55->addAttribute('name', 'class');

                    //SUB FIELD 1
                    $subfield1 = $field2->addChild('FIELD');
                    $subfield1->addAttribute('id', $dropdown_2);
                    $subfield1->addAttribute('type', 'DropDownList');

                    $properties3 = $subfield1->addChild('PROPERTIES');

                    $property6 = $properties3->addChild('PROPERTY', $dropdown_2);
                    $property6->addAttribute('name', 'id');

                    $property7 = $properties3->addChild('PROPERTY', $dropdown_2);
                    $property7->addAttribute('name', 'name');

                    $property77 = $properties3->addChild('PROPERTY', 'form-control');
                    $property77->addAttribute('name', 'class');

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

                    //FIELD 3
                    $field3 = $columns->addChild('FIELD');
                    $field3->addAttribute('id', $radio);
                    $field3->addAttribute('type', 'RadioButtonList');
                    $field3->addAttribute('Backcontrols', 'hide');
                    $field3->addAttribute('Backdivid', $radio_back_div);

                    $properties1 = $field3->addChild('PROPERTIES');

                    $property2 = $properties1->addChild('PROPERTY', $radio);
                    $property2->addAttribute('name', 'name');

                    $listitems = $field3->addChild('LISTITEMS');

                    $listitem1 = $listitems->addChild('LISTITEM', 'Yes');
                    $listitem1->addAttribute('value', 'Yes');
                    $listitem1->addAttribute('id', 'radio_med_his_currently_under_treatment1' . $rowCount);
                    $listitem1->addAttribute('Selected', 'False');
                    $listitem1->addAttribute('onclick', "OThersvisible(this.id, '$radio_back_div', 'none');");

                    $listitem2 = $listitems->addChild('LISTITEM', 'No');
                    $listitem2->addAttribute('value', 'No');
                    $listitem2->addAttribute('id', 'radio_med_his_currently_under_treatment2' . $rowCount);
                    $listitem2->addAttribute('Selected', 'False');
                    $listitem2->addAttribute('onclick', "OThersvisible(this.id, '$radio_back_div', 'block');");

                    //SUB FIELD 1
                    $field3_sub = $field3->addChild('FIELD');
                    $field3_sub->addAttribute('id', 'med_his_currently_under_treatment_reason' . $rowCount);
                    $field3_sub->addAttribute('type', 'TextBox');
                    $field3_sub->addAttribute('label', 'Reason: ');

                    $field3_properties = $field3_sub->addChild('PROPERTIES');

                    $property8 = $field3_properties->addChild('PROPERTY', 'med_his_currently_under_treatment_reason' . $rowCount);
                    $property8->addAttribute('name', 'id');

                    $property9 = $field3_properties->addChild('PROPERTY', 'med_his_currently_under_treatment_reason' . $rowCount);
                    $property9->addAttribute('name', 'name');

                    $property10 = $field3_properties->addChild('PROPERTY', 'form-control');
                    $property10->addAttribute('name', 'class');

                    $property11 = $field3_properties->addChild('PROPERTY', 'Reason');
                    $property11->addAttribute('name', 'placeholder');
                }
            }
        }

        $xml = $xmlLoad->asXML();
        return $xml;
    }

    protected function preparePhamacotherapyXml($xml, $table_id, $rowCount) {
        $xmlLoad = simplexml_load_string($xml);
        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $y) {
                if ($y->attributes()->type == 'PanelBar') {
                    foreach ($y->FIELD as $x) {
                        if ($x->attributes()->type == 'RadGrid' && $x->attributes()->AddButtonTableId == $table_id) {

                            $text_box = 'txtPhamacoDrugName' . $rowCount; //Textbox1 Name
                            $text_box2 = 'txtPhamacoDuration' . $rowCount; //Textbox2 Name
                            $text_box3 = 'txtPhamacoSideEffects' . $rowCount; //Textbox2 Name
                            $radio = 'radioPhamacoCurrentlyUnderTreatment' . $rowCount; //DDL Name
                            $dropdown = 'DDLPhamacoDuration' . $rowCount; //DDL Name

                            $columns = $x->addChild('COLUMNS');

                            //FIELD 1
                            $field1 = $columns->addChild('FIELD');
                            $field1->addAttribute('id', $text_box);
                            $field1->addAttribute('type', 'TextBox');

                            $properties1 = $field1->addChild('PROPERTIES');

                            $property1 = $properties1->addChild('PROPERTY', $text_box);
                            $property1->addAttribute('name', 'id');

                            $property2 = $properties1->addChild('PROPERTY', $text_box);
                            $property2->addAttribute('name', 'name');

                            $property22 = $properties1->addChild('PROPERTY', 'form-control');
                            $property22->addAttribute('name', 'class');

                            //FIELD 2
                            $field2 = $columns->addChild('FIELD');
                            $field2->addAttribute('id', $text_box2);
                            $field2->addAttribute('type', 'TextBoxDDL');

                            $properties2 = $field2->addChild('PROPERTIES');

                            $property3 = $properties2->addChild('PROPERTY', $text_box2);
                            $property3->addAttribute('name', 'id');

                            $property4 = $properties2->addChild('PROPERTY', 'return isNumericKeyStroke(event)');
                            $property4->addAttribute('name', 'onkeydown');

                            $property5 = $properties2->addChild('PROPERTY', $text_box2);
                            $property5->addAttribute('name', 'name');

                            $property55 = $properties2->addChild('PROPERTY', 'form-control');
                            $property55->addAttribute('name', 'class');

                            $subfield1 = $field2->addChild('FIELD');
                            $subfield1->addAttribute('id', $dropdown);
                            $subfield1->addAttribute('type', 'DropDownList');

                            $properties3 = $subfield1->addChild('PROPERTIES');

                            $property6 = $properties3->addChild('PROPERTY', $dropdown);
                            $property6->addAttribute('name', 'id');

                            $property7 = $properties3->addChild('PROPERTY', $dropdown);
                            $property7->addAttribute('name', 'name');

                            $property77 = $properties3->addChild('PROPERTY', 'form-control');
                            $property77->addAttribute('name', 'class');

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

                            //FIELD 3
                            $field3 = $columns->addChild('FIELD');
                            $field3->addAttribute('id', $radio);
                            $field3->addAttribute('type', 'RadioButtonList');

                            $properties1 = $field3->addChild('PROPERTIES');

                            $property2 = $properties1->addChild('PROPERTY', $radio);
                            $property2->addAttribute('name', 'name');

                            $listitems = $field3->addChild('LISTITEMS');

                            $listitem1 = $listitems->addChild('LISTITEM', 'Adequate');
                            $listitem1->addAttribute('value', 'Adequate');
                            $listitem1->addAttribute('id', 'radioPhamacoCurrentlyUnderTreatment1' . $rowCount);
                            $listitem1->addAttribute('Selected', 'False');

                            $listitem2 = $listitems->addChild('LISTITEM', 'Inadequate');
                            $listitem2->addAttribute('value', 'Inadequate');
                            $listitem2->addAttribute('id', 'radioPhamacoCurrentlyUnderTreatment2' . $rowCount);
                            $listitem2->addAttribute('Selected', 'False');

                            $listitem3 = $listitems->addChild('LISTITEM', 'Partial');
                            $listitem3->addAttribute('value', 'Partial');
                            $listitem3->addAttribute('id', 'radioPhamacoCurrentlyUnderTreatment3' . $rowCount);
                            $listitem3->addAttribute('Selected', 'False');

                            //FIELD 4
                            $field4 = $columns->addChild('FIELD');
                            $field4->addAttribute('id', $text_box3);
                            $field4->addAttribute('type', 'TextBox');

                            $properties1 = $field4->addChild('PROPERTIES');

                            $property1 = $properties1->addChild('PROPERTY', $text_box3);
                            $property1->addAttribute('name', 'id');

                            $property2 = $properties1->addChild('PROPERTY', $text_box3);
                            $property2->addAttribute('name', 'name');

                            $property222 = $properties1->addChild('PROPERTY', 'form-control');
                            $property222->addAttribute('name', 'class');
                        }
                    }
                }
            }
        }

        $xml = $xmlLoad->asXML();
        return $xml;
    }

    protected function prepareAlternativeTherapiesXml($xml, $table_id, $rowCount) {
        $xmlLoad = simplexml_load_string($xml);
        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $y) {
                if ($y->attributes()->type == 'PanelBar') {
                    foreach ($y->FIELD as $x) {
                        if ($x->attributes()->type == 'RadGrid' && $x->attributes()->AddButtonTableId == $table_id) {

                            $dropdown = 'ddl_pb_therapy' . $rowCount; //DDL Name
                            $radio = 'radio_pb_taken' . $rowCount; //DDL Name
                            $radio2 = 'radio_pb_currently_under_taken' . $rowCount; //DDL Name

                            $columns = $x->addChild('COLUMNS');

                            //FIELD 1
                            $field1 = $columns->addChild('FIELD');
                            $field1->addAttribute('id', $dropdown);
                            $field1->addAttribute('type', 'DropDownList');

                            $properties1 = $field1->addChild('PROPERTIES');

                            $property1 = $properties1->addChild('PROPERTY', $dropdown);
                            $property1->addAttribute('name', 'id');

                            $property2 = $properties1->addChild('PROPERTY', $dropdown);
                            $property2->addAttribute('name', 'name');

                            $property22 = $properties1->addChild('PROPERTY', 'form-control');
                            $property22->addAttribute('name', 'class');

                            $listitems = $field1->addChild('LISTITEMS');

                            $listitem1 = $listitems->addChild('LISTITEM', '--Select--');
                            $listitem1->addAttribute('value', '');
                            $listitem1->addAttribute('Selected', 'False');

                            $listitem2 = $listitems->addChild('LISTITEM', 'Magico Religious');
                            $listitem2->addAttribute('value', 'Magico Religious');
                            $listitem2->addAttribute('Selected', 'False');

                            $listitem3 = $listitems->addChild('LISTITEM', 'Homeopathy');
                            $listitem3->addAttribute('value', 'Homeopathy');
                            $listitem3->addAttribute('Selected', 'False');

                            $listitem4 = $listitems->addChild('LISTITEM', 'Ayurveda');
                            $listitem4->addAttribute('value', 'Ayurveda');
                            $listitem4->addAttribute('Selected', 'False');

                            //FIELD 2
                            $field2 = $columns->addChild('FIELD');
                            $field2->addAttribute('id', $radio);
                            $field2->addAttribute('type', 'RadioButtonList');

                            $properties2 = $field2->addChild('PROPERTIES');

                            $property5 = $properties2->addChild('PROPERTY', $radio);
                            $property5->addAttribute('name', 'name');

                            $listitems = $field2->addChild('LISTITEMS');

                            $listitem1 = $listitems->addChild('LISTITEM', 'Yes');
                            $listitem1->addAttribute('value', 'Yes');
                            $listitem1->addAttribute('id', 'radio_pb_taken1' . $rowCount);
                            $listitem1->addAttribute('Selected', 'False');

                            $listitem2 = $listitems->addChild('LISTITEM', 'No');
                            $listitem2->addAttribute('value', 'No');
                            $listitem2->addAttribute('id', 'radio_pb_taken2' . $rowCount);
                            $listitem2->addAttribute('Selected', 'False');

                            //FIELD 3
                            $field2 = $columns->addChild('FIELD');
                            $field2->addAttribute('id', $radio2);
                            $field2->addAttribute('type', 'RadioButtonList');

                            $properties2 = $field2->addChild('PROPERTIES');

                            $property5 = $properties2->addChild('PROPERTY', $radio2);
                            $property5->addAttribute('name', 'name');

                            $listitems = $field2->addChild('LISTITEMS');

                            $listitem1 = $listitems->addChild('LISTITEM', 'Adequate');
                            $listitem1->addAttribute('value', 'Adequate');
                            $listitem1->addAttribute('id', 'radio_pb_currently_under_taken1' . $rowCount);
                            $listitem1->addAttribute('Selected', 'False');

                            $listitem2 = $listitems->addChild('LISTITEM', 'Inadequate');
                            $listitem2->addAttribute('value', 'Inadequate');
                            $listitem2->addAttribute('id', 'radio_pb_currently_under_taken2' . $rowCount);
                            $listitem2->addAttribute('Selected', 'False');

                            $listitem3 = $listitems->addChild('LISTITEM', 'Partial');
                            $listitem3->addAttribute('value', 'Partial');
                            $listitem3->addAttribute('id', 'radio_pb_currently_under_taken3' . $rowCount);
                            $listitem3->addAttribute('Selected', 'False');
                        }
                    }
                }
            }
        }

        $xml = $xmlLoad->asXML();
        return $xml;
    }

    protected function prepareFamilyHistoryXml($xml, $table_id, $rowCount) {
        $xmlLoad = simplexml_load_string($xml);
        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $y) {
                if ($y->attributes()->type == 'PanelBar') {
                    foreach ($y->FIELD as $x) {
                        if ($x->attributes()->type == 'RadGrid' && $x->attributes()->AddButtonTableId == $table_id) {

                            $radio = 'radio_pb_illnesstype' . $rowCount; //DDL Name
                            $radio2 = 'radio_pb_treatment' . $rowCount; //DDL Name
                            $dropdown = 'ddl_pb_relation' . $rowCount; //DDL Name
                            $text_box = 'radio_pb_illnesstype_note' . $rowCount; //Textbox1 Name
                            $back_div_id = 'radio_pb_illnesstype_note_div' . $rowCount; //Textbox1 Name

                            $columns = $x->addChild('COLUMNS');

                            //FIELD 1
                            $field1 = $columns->addChild('FIELD');
                            $field1->addAttribute('id', $dropdown);
                            $field1->addAttribute('type', 'DropDownList');

                            $properties1 = $field1->addChild('PROPERTIES');

                            $property1 = $properties1->addChild('PROPERTY', $dropdown);
                            $property1->addAttribute('name', 'id');

                            $property2 = $properties1->addChild('PROPERTY', $dropdown);
                            $property2->addAttribute('name', 'name');

                            $property22 = $properties1->addChild('PROPERTY', 'form-control');
                            $property22->addAttribute('name', 'class');

                            $listitems = $field1->addChild('LISTITEMS');

                            $listitem1 = $listitems->addChild('LISTITEM', '--Select--');
                            $listitem1->addAttribute('value', '');
                            $listitem1->addAttribute('Selected', 'False');

                            $listitem2 = $listitems->addChild('LISTITEM', 'GrandParents');
                            $listitem2->addAttribute('value', 'GrandParents');
                            $listitem2->addAttribute('Selected', 'False');

                            $listitem3 = $listitems->addChild('LISTITEM', 'Parents');
                            $listitem3->addAttribute('value', 'Parents');
                            $listitem3->addAttribute('Selected', 'False');

                            $listitem4 = $listitems->addChild('LISTITEM', 'Siblings');
                            $listitem4->addAttribute('value', 'Siblings');
                            $listitem4->addAttribute('Selected', 'False');

                            $listitem5 = $listitems->addChild('LISTITEM', 'Spouse');
                            $listitem5->addAttribute('value', 'Spouse');
                            $listitem5->addAttribute('Selected', 'False');

                            $listitem6 = $listitems->addChild('LISTITEM', 'Children');
                            $listitem6->addAttribute('value', 'Children');
                            $listitem6->addAttribute('Selected', 'False');

                            $listitem7 = $listitems->addChild('LISTITEM', 'Uncle/Aunt');
                            $listitem7->addAttribute('value', 'Uncle/Aunt');
                            $listitem7->addAttribute('Selected', 'False');

                            //FIELD 2
                            $field2 = $columns->addChild('FIELD');
                            $field2->addAttribute('id', $radio);
                            $field2->addAttribute('type', 'RadioButtonList');
                            $field2->addAttribute('Backcontrols', 'hide');
                            $field2->addAttribute('Backdivid', $back_div_id);

                            $properties2 = $field2->addChild('PROPERTIES');

                            $property5 = $properties2->addChild('PROPERTY', $radio);
                            $property5->addAttribute('name', 'name');

                            $listitems = $field2->addChild('LISTITEMS');

                            $listitem1 = $listitems->addChild('LISTITEM', 'Similar Illness');
                            $listitem1->addAttribute('id', 'radio_pb_illnesstype1' . $rowCount);
                            $listitem1->addAttribute('value', 'Similar Illness');
                            $listitem1->addAttribute('Selected', 'False');
                            $listitem1->addAttribute('onclick', "OThersvisible(this.id,'$back_div_id','none');");

                            $listitem2 = $listitems->addChild('LISTITEM', 'Other Illness');
                            $listitem2->addAttribute('id', 'radio_pb_illnesstype2' . $rowCount);
                            $listitem2->addAttribute('value', 'Other Illness');
                            $listitem2->addAttribute('Selected', 'False');
                            $listitem2->addAttribute('onclick', "OThersvisible(this.id,'$back_div_id','block');");

                            $subfield1 = $field2->addChild('FIELD');
                            $subfield1->addAttribute('id', $text_box);
                            $subfield1->addAttribute('type', 'TextBox');
                            $subfield1->addAttribute('label', 'Other: ');

                            $properties3 = $subfield1->addChild('PROPERTIES');

                            $property6 = $properties3->addChild('PROPERTY', $text_box);
                            $property6->addAttribute('name', 'id');

                            $property7 = $properties3->addChild('PROPERTY', $text_box);
                            $property7->addAttribute('name', 'name');

                            $property8 = $properties3->addChild('PROPERTY', 'form-control');
                            $property8->addAttribute('name', 'class');

                            $property9 = $properties3->addChild('PROPERTY', 'Other');
                            $property9->addAttribute('name', 'placeholder');

                            //FIELD 3
                            $field3 = $columns->addChild('FIELD');
                            $field3->addAttribute('id', $radio2);
                            $field3->addAttribute('type', 'RadioButtonList');

                            $properties1 = $field3->addChild('PROPERTIES');

                            $property2 = $properties1->addChild('PROPERTY', $radio2);
                            $property2->addAttribute('name', 'name');

                            $listitems = $field3->addChild('LISTITEMS');

                            $listitem1 = $listitems->addChild('LISTITEM', 'Treated');
                            $listitem1->addAttribute('value', 'Treated');
                            $listitem1->addAttribute('id', 'radio_pb_treatment1' . $rowCount);
                            $listitem1->addAttribute('Selected', 'False');

                            $listitem2 = $listitems->addChild('LISTITEM', 'Untreated');
                            $listitem2->addAttribute('value', 'Untreated');
                            $listitem2->addAttribute('id', 'radio_pb_treatment2' . $rowCount);
                            $listitem2->addAttribute('Selected', 'False');
                        }
                    }
                }
            }
        }

        $xml = $xmlLoad->asXML();
        return $xml;
    }

    protected function prepareSubstanceHistoryXml($xml, $table_id, $rowCount) {
        $xmlLoad = simplexml_load_string($xml);
        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $y) {
                if ($y->attributes()->type == 'PanelBar') {
                    foreach ($y->FIELD as $xx) {
                        if ($xx->attributes()->type == 'PanelBar') {
                            foreach ($xx->FIELD as $x) {
                                if ($x->attributes()->type == 'RadGrid' && $x->attributes()->AddButtonTableId == $table_id) {

                                    $text_box = 'txtPBDuration' . $rowCount; //Textbox1 Name
                                    $dropdown = 'ddl_pb_substance' . $rowCount; //DDL Name
                                    $dropdown2 = 'DDLPBDuration' . $rowCount; //DDL Name
                                    $checkbox = 'CBPBpattern' . $rowCount; //DDL Name

                                    $columns = $x->addChild('COLUMNS');

                                    //FIELD 1
                                    $field1 = $columns->addChild('FIELD');
                                    $field1->addAttribute('id', $dropdown);
                                    $field1->addAttribute('type', 'DropDownList');

                                    $properties1 = $field1->addChild('PROPERTIES');

                                    $property1 = $properties1->addChild('PROPERTY', $dropdown);
                                    $property1->addAttribute('name', 'id');

                                    $property2 = $properties1->addChild('PROPERTY', $dropdown);
                                    $property2->addAttribute('name', 'name');

                                    $property22 = $properties1->addChild('PROPERTY', 'form-control');
                                    $property22->addAttribute('name', 'class');

                                    $listitems = $field1->addChild('LISTITEMS');

                                    $listitem1 = $listitems->addChild('LISTITEM', '--Select--');
                                    $listitem1->addAttribute('value', '');
                                    $listitem1->addAttribute('Selected', 'False');

                                    $listitem2 = $listitems->addChild('LISTITEM', 'Smoking');
                                    $listitem2->addAttribute('value', 'Smoking');
                                    $listitem2->addAttribute('Selected', 'False');

                                    $listitem3 = $listitems->addChild('LISTITEM', 'Alcohol');
                                    $listitem3->addAttribute('value', 'Alcohol');
                                    $listitem3->addAttribute('Selected', 'False');

                                    $listitem4 = $listitems->addChild('LISTITEM', 'Cannabis');
                                    $listitem4->addAttribute('value', 'Cannabis');
                                    $listitem4->addAttribute('Selected', 'False');

                                    $listitem5 = $listitems->addChild('LISTITEM', 'Solvents/Inhalants');
                                    $listitem5->addAttribute('value', 'Solvents/Inhalants');
                                    $listitem5->addAttribute('Selected', 'False');

                                    $listitem6 = $listitems->addChild('LISTITEM', 'Others');
                                    $listitem6->addAttribute('value', 'Others');
                                    $listitem6->addAttribute('Selected', 'False');

                                    //FIELD 2
                                    $field2 = $columns->addChild('FIELD');
                                    $field2->addAttribute('id', $text_box);
                                    $field2->addAttribute('type', 'TextBoxDDL');

                                    $properties2 = $field2->addChild('PROPERTIES');

                                    $property3 = $properties2->addChild('PROPERTY', $text_box);
                                    $property3->addAttribute('name', 'id');

                                    $property4 = $properties2->addChild('PROPERTY', 'return isNumericKeyStroke(event)');
                                    $property4->addAttribute('name', 'onkeydown');

                                    $property5 = $properties2->addChild('PROPERTY', $text_box);
                                    $property5->addAttribute('name', 'name');

                                    $property55 = $properties2->addChild('PROPERTY', 'form-control');
                                    $property55->addAttribute('name', 'class');

                                    $subfield1 = $field2->addChild('FIELD');
                                    $subfield1->addAttribute('id', $dropdown2);
                                    $subfield1->addAttribute('type', 'DropDownList');

                                    $properties3 = $subfield1->addChild('PROPERTIES');

                                    $property6 = $properties3->addChild('PROPERTY', $dropdown2);
                                    $property6->addAttribute('name', 'id');

                                    $property7 = $properties3->addChild('PROPERTY', $dropdown2);
                                    $property7->addAttribute('name', 'name');

                                    $property77 = $properties3->addChild('PROPERTY', 'form-control');
                                    $property77->addAttribute('name', 'class');

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

                                    //FIELD 3
                                    $field3 = $columns->addChild('FIELD');
                                    $field3->addAttribute('id', $checkbox);
                                    $field3->addAttribute('type', 'CheckBoxList');

                                    $properties1 = $field3->addChild('PROPERTIES');

                                    $property2 = $properties1->addChild('PROPERTY', "CBPBpattern{$rowCount}[]");
                                    $property2->addAttribute('name', 'name');

                                    $listitems = $field3->addChild('LISTITEMS');

                                    $listitem1 = $listitems->addChild('LISTITEM', 'Use');
                                    $listitem1->addAttribute('value', 'Use');
                                    $listitem1->addAttribute('id', 'CBPBpattern1' . $rowCount);
                                    $listitem1->addAttribute('Selected', 'False');

                                    $listitem2 = $listitems->addChild('LISTITEM', 'Abuse');
                                    $listitem2->addAttribute('value', 'Abuse');
                                    $listitem2->addAttribute('id', 'CBPBpattern2' . $rowCount);
                                    $listitem2->addAttribute('Selected', 'False');

                                    $listitem3 = $listitems->addChild('LISTITEM', 'Dependence');
                                    $listitem3->addAttribute('value', 'Dependence');
                                    $listitem3->addAttribute('id', 'CBPBpattern3' . $rowCount);
                                    $listitem3->addAttribute('Selected', 'False');
                                }
                            }
                        }
                    }
                }
            }
        }

        $xml = $xmlLoad->asXML();
        return $xml;
    }

}
