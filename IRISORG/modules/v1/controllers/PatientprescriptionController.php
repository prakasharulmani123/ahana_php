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

            $all_patient_id = PatPatient::find()
                    ->select('GROUP_CONCAT(patient_id) AS allpatient')
                    ->where(['patient_global_guid' => $patient->patient_global_guid])
                    ->one();

            if (isset($get['encounter_id'])) {
                $encounter_id = $get['encounter_id'];
                $data = PatPrescription::find()->tenant()
                        ->active()
                        ->where("patient_id IN ($all_patient_id->allpatient)")
                        ->andWhere(['encounter_id' => $encounter_id])
                        ->orderBy(['created_at' => SORT_DESC])->limit($get['pageSize'])
                        ->offset($offset)
                        ->all();
                $totalCount = PatPrescription::find()->tenant()
                        ->active()
                        ->where("patient_id IN ($all_patient_id->allpatient)")
                        ->andWhere(['encounter_id' => $encounter_id])
                        ->orderBy(['created_at' => SORT_DESC])
                        ->limit($get['pageSize'])
                        ->offset($offset)
                        ->count();
            } else {
                if (isset($get['date']) && $get['date'] != "") {
                    $pres_date = $get['date'];
                    $data = PatPrescription::find()->tenant()
                            ->active()
                            ->where("patient_id IN ($all_patient_id->allpatient)")
                            ->andWhere(['DATE(pres_date)' => $pres_date])
                            ->orderBy(['created_at' => SORT_DESC])
                            ->limit($get['pageSize'])
                            ->offset($offset)
                            ->all();
                    $totalCount = PatPrescription::find()->tenant()
                            ->active()
                            ->where("patient_id IN ($all_patient_id->allpatient)")
                            ->andWhere(['DATE(pres_date)' => $pres_date])
                            ->orderBy(['created_at' => SORT_DESC])
                            ->limit($get['pageSize'])
                            ->offset($offset)
                            ->count();
                } else {
                    $data = PatPrescription::find()->tenant()
                            ->active()
                            ->where("patient_id IN ($all_patient_id->allpatient)")
                            ->orderBy(['created_at' => SORT_DESC])
                            ->limit($get['pageSize'])
                            ->offset($offset)
                            ->all();
                    $totalCount = PatPrescription::find()->tenant()
                            ->active()
                            ->where("patient_id IN ($all_patient_id->allpatient)")
                            ->orderBy(['created_at' => SORT_DESC])
                            ->limit($get['pageSize'])
                            ->offset($offset)
                            ->count();
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
        $post = [];
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
        if (!empty($post['doc_id'])) {
            $doc_exists = PatDocuments::find()->tenant()->andWhere([
                        'patient_id' => $patient->patient_id,
                        'doc_type_id' => $case_history_xml->doc_type_id,
                        'encounter_id' => $post['encounter_id'],
                        'doc_id' => $post['doc_id'],
                    ])->one();
        }

        if (!empty($doc_exists)) {
            $patient_document = $doc_exists;
            $xml = $doc_exists->document_xml;
        } else {
            $patient_document = new PatDocuments;
            $xml = $case_history_xml->document_xml;
        }
        if(isset($post['scenario']) && $post['scenario']) {
            $patient_document->scenario = $type;
        }
 
        $attr = [
            'patient_id' => $patient->patient_id,
            'encounter_id' => $post['encounter_id'],
            'doc_type_id' => $case_history_xml->doc_type_id
        ];

        $attr = array_merge($post, $attr);
        $patient_document->attributes = $attr;

        $patient_document->patient_id = $patient->patient_id;
        $patient_document->encounter_id = $post['encounter_id'];
        $patient_document->doc_type_id = $case_history_xml->doc_type_id;

        if ($patient_document->validate() || $post['novalidate'] == 'true' || $post['novalidate'] == '1') {
            $result = $this->prepareXml($xml, $post);
            if (empty($doc_exists)) {
                $result = $this->preparePreviousPrescriptionXml($result, 'RGprevprescription', $post['encounter_id']);
            }
            if (isset($post['button_id'])) {
                if ($post['table_id'] == 'TBicdcode') {
                    $result = $this->prepareIcdCodeXml($result, $post['table_id'], $post['rowCount']);
                }
            }
            $patient_document->document_xml = $result;
            $patient_document->save(false);
            return ['success' => true, 'xml' => $result, 'doc_id' => $patient_document->doc_id];
        } else {
            return ['success' => false, 'message' => Html::errorSummary([$patient_document])];
        }
    }

    protected function preparePreviousPrescriptionXml($xml, $table_id, $encounterid) {
        $xmlLoad = simplexml_load_string($xml);
        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $x) {
                if ($x->attributes()->type == 'RadGrid' && $x->attributes()->AddButtonTableId == $table_id) {
                    if (!empty($encounterid)) {
                        $prescriptions = PatPrescription::find()->joinWith(['patPrescriptionItems', 'patPrescriptionItems.freq', 'patPrescriptionItems.presRoute'])->tenant()->active()
                                ->andWhere(['encounter_id' => $encounterid])
                                ->orderBy(['created_at' => SORT_DESC])
                                ->one();
                        if (!empty($prescriptions)) {
                            foreach ($prescriptions->patPrescriptionItems as $key => $value) {

                                $product_box = 'txtproductname' . $key;
                                $generic_box = 'txtgenericname' . $key;
                                $drug_box = 'txtdrugname' . $key;
                                $route_box = 'txtroute' . $key;
                                $frequency_box = 'txtfrequency' . $key;
                                $noofdays_box = 'txtnoofdays' . $key;
                                $txtaf_bf_box = 'txtaf/bf' . $key;

                                $value['product_name'] = str_replace(["&nbsp;", "&"], ["&#160;", "&amp;"], $value['product_name']);
                                $value['generic_name'] = str_replace(["&nbsp;", "&"], ["&#160;", "&amp;"], $value['generic_name']);
                                $value['drug_name'] = str_replace(["&nbsp;", "&"], ["&#160;", "&amp;"], $value['drug_name']);

                                $columns = $x->addChild('COLUMNS');

                                $field1 = $columns->addChild('FIELD');
                                $field1->addAttribute('id', $product_box);
                                $field1->addAttribute('type', 'TextBox');

                                $properties1 = $field1->addChild('PROPERTIES');

                                $property1 = $properties1->addChild('PROPERTY', $product_box);
                                $property1->addAttribute('name', 'id');

                                $property2 = $properties1->addChild('PROPERTY', $product_box);
                                $property2->addAttribute('name', 'name');

                                $property3 = $properties1->addChild('PROPERTY', 'form-control');
                                $property3->addAttribute('name', 'class');

                                $property4 = $properties1->addChild('PROPERTY', $value['product_name']);
                                $property4->addAttribute('name', 'value');

                                //Generic Text Box
                                $field12 = $columns->addChild('FIELD');
                                $field12->addAttribute('id', $generic_box);
                                $field12->addAttribute('type', 'TextBox');

                                $properties12 = $field12->addChild('PROPERTIES');

                                $property12 = $properties12->addChild('PROPERTY', $generic_box);
                                $property12->addAttribute('name', 'id');

                                $property22 = $properties12->addChild('PROPERTY', $generic_box);
                                $property22->addAttribute('name', 'name');

                                $property32 = $properties12->addChild('PROPERTY', 'form-control');
                                $property32->addAttribute('name', 'class');

                                $property42 = $properties12->addChild('PROPERTY', $value['generic_name']);
                                $property42->addAttribute('name', 'value');

                                //Drug Text Box
                                $field13 = $columns->addChild('FIELD');
                                $field13->addAttribute('id', $drug_box);
                                $field13->addAttribute('type', 'TextBox');

                                $properties13 = $field13->addChild('PROPERTIES');

                                $property13 = $properties13->addChild('PROPERTY', $drug_box);
                                $property13->addAttribute('name', 'id');

                                $property23 = $properties13->addChild('PROPERTY', $drug_box);
                                $property23->addAttribute('name', 'name');

                                $property33 = $properties13->addChild('PROPERTY', 'form-control');
                                $property33->addAttribute('name', 'class');

                                $property43 = $properties13->addChild('PROPERTY', $value['drug_name']);
                                $property43->addAttribute('name', 'value');

                                //Route Text Box
                                $field14 = $columns->addChild('FIELD');
                                $field14->addAttribute('id', $route_box);
                                $field14->addAttribute('type', 'TextBox');

                                $properties14 = $field14->addChild('PROPERTIES');

                                $property14 = $properties14->addChild('PROPERTY', $route_box);
                                $property14->addAttribute('name', 'id');

                                $property24 = $properties14->addChild('PROPERTY', $route_box);
                                $property24->addAttribute('name', 'name');

                                $property34 = $properties14->addChild('PROPERTY', 'form-control');
                                $property34->addAttribute('name', 'class');

                                $property44 = $properties14->addChild('PROPERTY', $value->presRoute->route_name);
                                $property44->addAttribute('name', 'value');

                                //Frequency Text Box
                                $field15 = $columns->addChild('FIELD');
                                $field15->addAttribute('id', $frequency_box);
                                $field15->addAttribute('type', 'TextBox');

                                $properties15 = $field15->addChild('PROPERTIES');

                                $property15 = $properties15->addChild('PROPERTY', $frequency_box);
                                $property15->addAttribute('name', 'id');

                                $property25 = $properties15->addChild('PROPERTY', $frequency_box);
                                $property25->addAttribute('name', 'name');

                                $property35 = $properties15->addChild('PROPERTY', 'form-control');
                                $property35->addAttribute('name', 'class');

                                $property45 = $properties15->addChild('PROPERTY', $value->freq->freq_name);
                                $property45->addAttribute('name', 'value');

                                //Drug Text Box
                                $field16 = $columns->addChild('FIELD');
                                $field16->addAttribute('id', $noofdays_box);
                                $field16->addAttribute('type', 'TextBox');

                                $properties16 = $field16->addChild('PROPERTIES');

                                $property16 = $properties16->addChild('PROPERTY', $noofdays_box);
                                $property16->addAttribute('name', 'id');

                                $property26 = $properties16->addChild('PROPERTY', $noofdays_box);
                                $property26->addAttribute('name', 'name');

                                $property36 = $properties16->addChild('PROPERTY', 'form-control');
                                $property36->addAttribute('name', 'class');

                                $property46 = $properties16->addChild('PROPERTY', $value['number_of_days']);
                                $property46->addAttribute('name', 'value');

                                //Drug Text Box
                                $field17 = $columns->addChild('FIELD');
                                $field17->addAttribute('id', $txtaf_bf_box);
                                $field17->addAttribute('type', 'TextBox');

                                $properties17 = $field17->addChild('PROPERTIES');

                                $property17 = $properties17->addChild('PROPERTY', $txtaf_bf_box);
                                $property17->addAttribute('name', 'id');

                                $property27 = $properties17->addChild('PROPERTY', $txtaf_bf_box);
                                $property27->addAttribute('name', 'name');

                                $property37 = $properties17->addChild('PROPERTY', 'form-control');
                                $property37->addAttribute('name', 'class');

                                $property47 = $properties17->addChild('PROPERTY', $value['food_type']);
                                $property47->addAttribute('name', 'value');
                            }
                        }
                    }
                }
            }
        }
        $xml = $xmlLoad->asXML();
        return $xml;
    }

    protected function prepareIcdCodeXml($xml, $table_id, $rowCount) {
        $xmlLoad = simplexml_load_string($xml);
        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $x) {
                if ($x->attributes()->type == 'RadGrid' && $x->attributes()->AddButtonTableId == $table_id) {

                    $text_box = 'icd_code' . $rowCount;
                    $columns = $x->addChild('COLUMNS');

                    $field1 = $columns->addChild('FIELD');
                    $field1->addAttribute('id', $text_box);
                    $field1->addAttribute('type', 'TextBox');
                    $field1->addAttribute('label', '');

                    $properties1 = $field1->addChild('PROPERTIES');

                    $property1 = $properties1->addChild('PROPERTY', $text_box);
                    $property1->addAttribute('name', 'id');

                    $property2 = $properties1->addChild('PROPERTY', $text_box);
                    $property2->addAttribute('name', 'name');

                    $property3 = $properties1->addChild('PROPERTY', 'form-control icd_code_autocomplete');
                    $property3->addAttribute('name', 'class');
                }
            }
        }
        $xml = $xmlLoad->asXML();
        return $xml;
    }

    protected function prepareXml($xml, $post) {
        $xmlLoad = simplexml_load_string($xml);
        $postKeys = array_keys($post);

        foreach ($xmlLoad->children() as $group) {
            foreach ($group->PANELBODY->FIELD as $x) {

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
                                    if ($list_value == 'Diabetes' || $list_value == 'Hypertension' || $list_value == 'CVA' || $list_value == 'Asthma/Allergy/TB' || $list_value == 'Cancer' || $list_value == 'Seizure' || $list_value == 'CAD' || $list_value == 'Mental Illness' || $list_value == 'Others') {
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
            $all_patient_id = PatPatient::find()
                    ->select('GROUP_CONCAT(patient_id) AS allpatient')
                    ->where(['patient_global_guid' => $patient->patient_global_guid])
                    ->one();

            $condition = [
                'deleted_at' => '0000-00-00 00:00:00',
                'doc_type' => 'MCH'
            ];

            $data = VDocuments::find()
                    ->where($condition)
                    ->andWhere("patient_id IN ($all_patient_id->allpatient)")
                    ->groupBy('encounter_id')
                    ->orderBy(['encounter_id' => SORT_DESC])
                    ->asArray()
                    ->all();

            foreach ($data as $key => $value) {
                $details = VDocuments::find()
                        ->where(['encounter_id' => $value['encounter_id'],
                            'tenant_id' => $value['tenant_id']])
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
