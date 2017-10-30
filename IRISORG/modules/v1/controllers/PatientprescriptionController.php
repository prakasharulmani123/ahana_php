<?php

namespace IRISORG\modules\v1\controllers;

use common\models\AppConfiguration;
use common\models\PatPatient;
use common\models\PatPrescription;
use common\models\PatPrescriptionFrequency;
use common\models\PatPrescriptionItems;
use common\models\PatPrescriptionRoute;
use common\models\PhaDescriptionsRoutes;
use common\models\PatDiagnosis;
use common\models\VDocuments;
use common\models\PatDocumentTypes;
use common\models\PatDocuments;
use Yii;
use yii\data\ActiveDataProvider;
use yii\db\BaseActiveRecord;
use yii\db\Query;
use yii\filters\auth\QueryParamAuth;
use yii\filters\ContentNegotiator;
use yii\helpers\Html;
use yii\rest\ActiveController;
use yii\web\Response;

/**
 * WardController implements the CRUD actions for CoTenant model.
 */
class PatientprescriptionController extends ActiveController {

    public $modelClass = 'common\models\PatPrescription';

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

    public function actionRemove() {
        $id = Yii::$app->getRequest()->post('id');
        if ($id) {
            $model = PatPrescription::find()->where(['pres_id' => $id])->one();
            $model->remove();

//            //Remove all related records
//            foreach ($model->room as $room) {
//                $room->remove();
//            }
//            //

            return ['success' => true];
        }
    }

    public function actionSaveprescription() {
        $post = Yii::$app->getRequest()->post();

        if (!empty($post) && !empty($post['prescriptionItems'])) {
            $model = new PatPrescription;
            $model->attributes = $post;
            if (!empty($post['diag_text']) && empty($model->diag_id)) {
                $diag_model = new PatDiagnosis();
                $diag_model->diag_description = $post['diag_text'];
                $diag_model->save(false);
                $model->diag_id = $diag_model->diag_id;
            }
            $valid = $model->validate();

            foreach ($post['prescriptionItems'] as $key => $item) {
                $item_model = new PatPrescriptionItems();
                $item_model->scenario = 'saveform';
                $item_model->attributes = $item;
                $valid = $item_model->validate() && $valid;
                if (!$valid)
                    break;
            }

            if ($valid) {
                $model->save(false);

                foreach ($post['prescriptionItems'] as $key => $item) {
                    $item_model = new PatPrescriptionItems();
                    $item_model->pres_id = $model->pres_id;
                    $item_model->consultant_id = $model->consultant_id;
                    $item_model->attributes = $item;
                    $item_model->setFrequencyId($item);
                    $item_model->setRouteId();
                    $item_model->save(false);
                }

                $consult_name = '';
                if (isset($model->consultant)) {
                    $consult_name = $model->consultant->title_code . $model->consultant->name;
                }
                return ['success' => true, 'pres_id' => $model->pres_id, 'date' => date('d-M-Y H:i'), 'model' => ['consultant_name' => $consult_name, 'consultant_id' => $model->consultant_id]];
            } else {
                return ['success' => false, 'message' => Html::errorSummary([$model, $item_model])];
            }
        } else {
            return ['success' => false, 'message' => 'Prescriptions cannot be blank'];
        }
    }

    public function actionGetpreviousprescription() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['patient_id'])) {
            $offset = abs($get['pageIndex'] - 1) * $get['pageSize'];
            $patient = PatPatient::getPatientByGuid($get['patient_id']);

            if (isset($get['encounter_id'])) {
                $encounter_id = $get['encounter_id'];
                $data = PatPrescription::find()->tenant()->active()->andWhere(['patient_id' => $patient->patient_id, 'encounter_id' => $encounter_id])->orderBy(['created_at' => SORT_DESC])->limit($get['pageSize'])->offset($offset)->all();
                $totalCount = PatPrescription::find()->tenant()->active()->andWhere(['patient_id' => $patient->patient_id, 'encounter_id' => $encounter_id])->orderBy(['created_at' => SORT_DESC])->limit($get['pageSize'])->offset($offset)->count();
            } else {
                if (isset($get['date']) && $get['date'] != "") {
                    $pres_date = $get['date'];
                    $data = PatPrescription::find()->tenant()->active()->andWhere(['patient_id' => $patient->patient_id, 'DATE(pres_date)' => $pres_date])->orderBy(['created_at' => SORT_DESC])->limit($get['pageSize'])->offset($offset)->all();
                    $totalCount = PatPrescription::find()->tenant()->active()->andWhere(['patient_id' => $patient->patient_id, 'DATE(pres_date)' => $pres_date])->orderBy(['created_at' => SORT_DESC])->limit($get['pageSize'])->offset($offset)->count();
                } else {
                    $data = PatPrescription::find()->tenant()->active()->andWhere(['patient_id' => $patient->patient_id])->orderBy(['created_at' => SORT_DESC])->limit($get['pageSize'])->offset($offset)->all();
                    $totalCount = PatPrescription::find()->tenant()->active()->andWhere(['patient_id' => $patient->patient_id])->orderBy(['created_at' => SORT_DESC])->limit($get['pageSize'])->offset($offset)->count();
                }
            }
            return ['success' => true, 'prescriptions' => $data, 'totalCount' => $totalCount];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionGetsaleprescription() {
        $get = Yii::$app->getRequest()->get();

        if (isset($get['patient_id'])) {
            $patient = PatPatient::getPatientByGuid($get['patient_id']);
            if (isset($get['encounter_id'])) {
                $encounter_id = $get['encounter_id'];
                $data = PatPrescription::find()
                        ->tenant()
                        ->active()
                        ->andWhere([
                            'patient_id' => $patient->patient_id,
                            'encounter_id' => $encounter_id
                        ])
                        ->orderBy(['created_at' => SORT_DESC])
                        ->one();
            }
            return ['success' => true, 'prescription' => $data];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    /* pharmacy_prodesc.js */

    public function actionGetactiveroutes() {
        $routes = PatPrescriptionRoute::find()->tenant()->active()->status()->all();
        return ['success' => true, 'routes' => $routes];
    }

    public function actionGetdescriptionroutes() {
        $id = Yii::$app->request->get('id');
        if (!empty($id)) {
            $routes = PhaDescriptionsRoutes::find()->tenant()->andWhere(['description_id' => $id])->all();
            return ['success' => true, 'routes' => $routes];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionGetconsultantfreq() {
        $get = Yii::$app->request->get();
        if (!empty($get)) {
            $freq = PatPrescriptionFrequency::find()
                    ->tenant()
                    ->status()
                    ->active()
                    ->andWhere(['consultant_id' => $get['consultant_id']])
                    ->orderBy(['created_at' => SORT_DESC])
                    ->all();
            return ['success' => true, 'freq' => $freq];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionGetconsultantnoofdays() {
        $get = Yii::$app->request->get();
        if (!empty($get)) {
            $tenant_id = Yii::$app->user->identity->logged_tenant_id;
            $connection = Yii::$app->client;
            $command = $connection->createCommand("SELECT pat_prescription_items.number_of_days FROM pat_prescription LEFT JOIN pat_prescription_items ON pat_prescription_items.pres_id = pat_prescription.pres_id WHERE (pat_prescription.tenant_id=:tenant_id) AND (pat_prescription.deleted_at=:deleted_at) AND (pat_prescription.status=:status) AND (pat_prescription.consultant_id=:consultant_id) ORDER BY pat_prescription.created_at DESC ", [':tenant_id' => $tenant_id, ':deleted_at' => '0000-00-00 00:00:00', ':status' => '1', ':consultant_id' => $get['consultant_id']]);
            $result = $command->queryAll();
            $connection->close();
            return ['success' => true, 'noofdays' => $result];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionFrequencyremove() {
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $frequency = PatPrescriptionFrequency::find()->tenant()->andWhere(['freq_id' => $post['id'], 'consultant_id' => $post['consultant_id']])->one();
            $frequency->status = 0;
            $frequency->save(false);
            return ['success' => true];
        } else {
            return ['success' => false, 'message' => 'Invalid Access'];
        }
    }

    public function actionGetdiagnosis() {
        $get = Yii::$app->getRequest()->get();
        $text = $get['diag_description'];
        $Diag = PatDiagnosis::find()
                ->andFilterWhere([
                    'or',
                        ['like', 'diag_name', $text],
                        ['like', 'diag_description', $text],
                ])
                ->limit(25)
                ->all();
        return $Diag;
    }

    public function actionUpdatetabsetting() {
        $post = Yii::$app->getRequest()->post();
        $tenant_id = Yii::$app->user->identity->logged_tenant_id;
        $unset_configs = AppConfiguration::updateAll(['value' => '0'], "tenant_id = {$tenant_id} AND `code` IN ('PTV','PTR','PTN')");
        if (!empty($post)) {
            foreach ($post as $value) {
                $tab_name = $value['name'];
                $tab_array[] = "'$tab_name'";
            }
            $tab = implode(',', $tab_array);
            $config = AppConfiguration::updateAll(['value' => '1'], "tenant_id = {$tenant_id} AND `key` IN ($tab)");
        }
        return ['success' => true];
    }

    public function actionSavemedicaldocument() {
        $form = Yii::$app->getRequest()->post();
        foreach ($form as $key => $value) {
            if (isset($value['value'])) {
                if (strpos($value['name'], '[]') !== false) {
                    $field_name = str_replace("[]", "", $value['name']);
                    $post[$field_name][] = str_replace("&nbsp;", "&#160;", $value['value']);
                } else {
                    if ($value['name'] != 'history_presenting_illness') {
                        $post[$value['name']] = str_replace(["&nbsp;", "&"], ["&#160;", "&amp;"], $value['value']);
                    } else {
                        $post[$value['name']] = $value['value'];
                    }
                }
            } else {
                $post[$value['name']] = '';
            }
        }

        $patient = PatPatient::getPatientByGuid($post['patient_id']);
        $type = 'MCH';
        $case_history_xml = PatDocumentTypes::getDocumentType($type);

        $doc_exists = '';
//        if (!empty($post['doc_id'])) {
//            $doc_exists = PatDocuments::find()->tenant()->andWhere([
//                        'patient_id' => $patient->patient_id,
//                        'doc_type_id' => $case_history_xml->doc_type_id,
//                        'encounter_id' => $post['encounter_id'],
//                        'doc_id' => $post['doc_id'],
//                    ])->one();
//        }

        if (!empty($doc_exists)) {
            $patient_document = $doc_exists;
            $xml = $doc_exists->document_xml;
        } else {
            $patient_document = new PatDocuments;
            $xml = $case_history_xml->document_xml;
        }
        $patient_document->scenario = $type;
        $patient_document->patient_id = $patient->patient_id;
        $patient_document->encounter_id = $post['encounter_id'];
        $patient_document->doc_type_id = $case_history_xml->doc_type_id;
        $result = $this->prepareXml($xml, $post);
        $patient_document->document_xml = $result;
        $patient_document->save(false);
        return ['success' => true];
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
                            foreach ($pb->COLUMNS as $key => $columns) {
                                foreach ($columns->FIELD as $field) {
                                    //Child FIELD
                                    if (isset($field->FIELD)) {
                                        foreach ($field->FIELD as $y) {
                                            foreach ($post as $key => $value) {
                                                if ($key == $y->attributes()) {
                                                    $type = $y->attributes()->type;
                                                    //print_r($y->attributes());
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
                                                    } elseif ($type == 'MultiDropDownList') {
                                                        //echo $type; print_r($list_referral_details); //die;
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
                                                        //echo $type; print_r($list_value); //die;
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
                                                        $y->addChild('VALUE');
                                                        if ($value != '')
                                                            $this->addCData($value, $y->VALUE);
                                                    } else {
                                                        //echo $y->attributes()->texttypeid[0];
                                                        if (!empty($y->attributes()->texttypeid[0]) && ($y->attributes()->texttypeid[0] == 'selectdropdown')) {
                                                            //echo $y->attributes()->texttypeid[0];
                                                            if (!empty($value)) {
                                                                $list = $field->FIELD[1]->LISTITEMS->LISTITEM;
                                                                foreach ($list as $listvalue) {
                                                                    $lis[] = $listvalue['value'][0];
                                                                }
                                                                if (in_array($value, $lis)) {
                                                                    
                                                                } else {
                                                                    $item = $field->FIELD[1]->LISTITEMS->addChild('LISTITEM', $value);
                                                                    $item->addAttribute('value', $value);
                                                                    $item->addAttribute('Selected', "true");
                                                                }
                                                            }
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
                                                $list_values_array = ['Other Illness', 'Yes'];

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
                                                $field->addChild('VALUE');
                                                if ($value != '')
                                                    $this->addCData($value, $field->VALUE);
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
                                } //die;
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
                                            if ($list_value == 'Others' || $key == 'CBDelusions' || $list_value == 'Personal' || $list_value == 'Social' || $list_value == 'Test' || $list_value == 'Immediate' || $list_value == 'Recent' || $list_value == 'Remote' || $list_value == 'Catatonic') {
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
                                } elseif ($type == 'textareaFull' || $type == 'TextArea') {
                                    if (isset($pb->VALUE)) {
                                        unset($pb->VALUE);
                                    }
                                    $pb->addChild('VALUE');
                                    if ($value != '')
                                        $this->addCData($value, $pb->VALUE);
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
                                        } elseif ($type == 'textareaFull' || $type == 'TextArea') {
                                            if (isset($pbchild->VALUE)) {
                                                unset($pbchild->VALUE);
                                            }
                                            $pbchild->addChild('VALUE');
                                            if ($value != '')
                                                $this->addCData($value, $pbchild->VALUE);
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
                                                            } elseif ($type == 'textareaFull' || $type == 'TextArea') {
                                                                if (isset($y->VALUE)) {
                                                                    unset($y->VALUE);
                                                                }
                                                                $y->addChild('VALUE');
                                                                if ($value != '')
                                                                    $this->addCData($value, $y->VALUE);
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
                                                    } elseif ($type == 'DropDownList' || $type == 'RadioButtonList' || $type == 'DropDowntextbox') {
                                                        $field->attributes()['Backcontrols'] = 'hide';
//                                                $radio_field_id = ['radio_pb_illnesstype'];
                                                        $list_values_array = ['Other Illness', 'Others'];

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
                                                        $field->addChild('VALUE');
                                                        if ($value != '')
                                                            $this->addCData($value, $field->VALUE);
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
                                                    if ($list_value == 'Others' || $key == 'CBDelusions' || $list_value == 'Personal' || $list_value == 'Social' || $list_value == 'Test' || $list_value == 'Immediate' || $list_value == 'Recent' || $list_value == 'Remote' || $list_value == 'Catatonic') {
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
                                            $pbsub->addChild('VALUE');
                                            if ($value != '')
                                                $this->addCData($value, $pbsub->VALUE);
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
                                                    $pbsubchild->addChild('VALUE');
                                                    if ($value != '')
                                                        $this->addCData($value, $pbsubchild->VALUE);
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
                                                $y->addChild('VALUE');
                                                if ($value != '')
                                                    $this->addCData($value, $y->VALUE);
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
                                        $field->addChild('VALUE');
                                        if ($value != '')
                                            $this->addCData($value, $field->VALUE);
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
                        if ($type == 'CheckBoxList' || $type == 'MultiDropDownList') {
                            $post_referral_details = $value;
                            $list_referral_details = $x->LISTITEMS->LISTITEM;
                            $x->attributes()['Backcontrols'] = 'hide';
                            foreach ($list_referral_details as $list_value) {
                                if (in_array($list_value, $post_referral_details)) {
                                    $list_value->attributes()['Selected'] = 'true';
                                    if ($list_value == 'Others' || $list_value == 'Personal' || $list_value == 'Social' || $list_value == 'Test' || $list_value == 'Immediate' || $list_value == 'Recent' || $list_value == 'Remote' || $list_value == 'Catatonic') {
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
                            $x->addChild('VALUE');
                            if ($value != '')
                                $this->addCData($value, $x->VALUE);
                        } else {
                            if (isset($x->PROPERTIES->PROPERTY)) {
                                foreach ($x->PROPERTIES->PROPERTY as $text_pro) {
                                    if ($text_pro['name'] == 'value') {
                                        $dom = dom_import_simplexml($text_pro);
                                        $dom->parentNode->removeChild($dom);
                                    }
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
                                    $y->addChild('VALUE');
                                    if ($value != '')
                                        $this->addCData($value, $y->VALUE);
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

    protected function addCData($cdata_text, \SimpleXMLElement $node) {
        $node = dom_import_simplexml($node);
        $no = $node->ownerDocument;
        $node->appendChild($no->createCDATASection($cdata_text));
    }

    public function actionGetpatientdocuments() {
        $get = Yii::$app->getRequest()->get();
        //print_r($get); die;
        if (isset($get['patient_id'])) {
            $patient = PatPatient::getPatientByGuid($get['patient_id']);
            $condition = [
                'patient_id' => $patient->patient_id,
                'deleted_at' => '0000-00-00 00:00:00',
                'doc_type' => 'MCH'
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

}
