<?php

namespace common\components;

//use Faker\Provider\zh_TW\DateTime;


use common\models\CoRoomCharge;
use common\models\PatAdmission;
use common\models\PatBillingRecurring;
use common\models\PatEncounter;
use DateTime;
use yii\base\Component;

class HelperComponent extends Component {

    public function convert_number_to_words($number) {

        $hyphen = '-';
        $conjunction = ' and ';
        $separator = ', ';
        $negative = 'negative ';
        $decimal = ' point ';
        $dictionary = array(
            0 => 'zero',
            1 => 'one',
            2 => 'two',
            3 => 'three',
            4 => 'four',
            5 => 'five',
            6 => 'six',
            7 => 'seven',
            8 => 'eight',
            9 => 'nine',
            10 => 'ten',
            11 => 'eleven',
            12 => 'twelve',
            13 => 'thirteen',
            14 => 'fourteen',
            15 => 'fifteen',
            16 => 'sixteen',
            17 => 'seventeen',
            18 => 'eighteen',
            19 => 'nineteen',
            20 => 'twenty',
            30 => 'thirty',
            40 => 'fourty',
            50 => 'fifty',
            60 => 'sixty',
            70 => 'seventy',
            80 => 'eighty',
            90 => 'ninety',
            100 => 'hundred',
            1000 => 'thousand',
            1000000 => 'million',
            1000000000 => 'billion',
            1000000000000 => 'trillion',
            1000000000000000 => 'quadrillion',
            1000000000000000000 => 'quintillion'
        );

        if (!is_numeric($number)) {
            return false;
        }

        if (($number >= 0 && (int) $number < 0) || (int) $number < 0 - PHP_INT_MAX) {
            // overflow
            trigger_error(
                    'convert_number_to_words only accepts numbers between -' . PHP_INT_MAX . ' and ' . PHP_INT_MAX, E_USER_WARNING
            );
            return false;
        }

        if ($number < 0) {
            return $negative . $this->convert_number_to_words(abs($number));
        }

        $string = $fraction = null;

        if (strpos($number, '.') !== false) {
            list($number, $fraction) = explode('.', $number);
        }

        switch (true) {
            case $number < 21:
                $string = $dictionary[$number];
                break;
            case $number < 100:
                $tens = ((int) ($number / 10)) * 10;
                $units = $number % 10;
                $string = $dictionary[$tens];
                if ($units) {
                    $string .= $hyphen . $dictionary[$units];
                }
                break;
            case $number < 1000:
                $hundreds = $number / 100;
                $remainder = $number % 100;
                $string = $dictionary[$hundreds] . ' ' . $dictionary[100];
                if ($remainder) {
                    $string .= $conjunction . $this->convert_number_to_words($remainder);
                }
                break;
            default:
                $baseUnit = pow(1000, floor(log($number, 1000)));
                $numBaseUnits = (int) ($number / $baseUnit);
                $remainder = $number % $baseUnit;
                $string = $this->convert_number_to_words($numBaseUnits) . ' ' . $dictionary[$baseUnit];
                if ($remainder) {
                    $string .= $remainder < 100 ? $conjunction : $separator;
                    $string .= $this->convert_number_to_words($remainder);
                }
                break;
        }

        if (null !== $fraction && is_numeric($fraction)) {
            $string .= $decimal;
            $words = array();
            foreach (str_split((string) $fraction) as $number) {
                $words[] = $dictionary[$number];
            }
            $string .= implode(' ', $words);
        }

        return ucwords($string);
    }

    public function updateRecurring($admission) {
        if (empty($admission))
            return;

        //Check Recurring Exists on that date
        $recurr_date = date('Y-m-d');
        $current_recurring = PatBillingRecurring::find()->select(['SUM(charge_amount) as charge_amount', 'room_type_id'])->tenant($admission->tenant_id)->andWhere(['encounter_id' => $admission->encounter_id, 'recurr_date' => $recurr_date])->groupBy(['recurr_date', 'room_type_id'])->one();

        if (empty($current_recurring)) {
            $room_charges = $this->getRoomChargeItems($admission->tenant_id, $admission->room_type_id);

            if (empty($room_charges))
                return;

            foreach ($room_charges as $key => $charge) {
                $data = [
                    'tenant_id' => $admission->tenant_id,
                    'encounter_id' => $admission->encounter_id,
                    'patient_id' => $admission->patient_id,
                    'room_type_id' => $admission->room_type_id,
                    'room_type' => $admission->roomType->room_type_name,
                    'charge_item_id' => $charge->charge_item_id,
                    'charge_item' => $charge->roomChargeItem->charge_item_name,
                    'recurr_date' => $recurr_date,
                    'charge_amount' => $this->_getChargeAmount($admission, $charge),
                    'recurr_group' => $admission->admn_id,
                ];
                $this->_insertRecurringModel($data);
            }
        }
    }

    public function addRecurring($admission) {
        $room_charges = $this->getRoomChargeItems($admission->tenant_id, $admission->room_type_id);

        if (empty($room_charges))
            return;

        foreach ($room_charges as $key => $charge) {
            $data = [
                'encounter_id' => $admission->encounter_id,
                'patient_id' => $admission->patient_id,
                'room_type_id' => $admission->room_type_id,
                'room_type' => $admission->roomType->room_type_name,
                'charge_item_id' => $charge->charge_item_id,
                'charge_item' => $charge->roomChargeItem->charge_item_name,
                'recurr_date' => $admission->status_date,
                'charge_amount' => $this->_getChargeAmount($admission, $charge),
                'recurr_group' => $admission->admn_id,
            ];
            $this->_insertRecurringModel($data);
        }
    }

    public function transferRecurring($admission) {
        $recurr_date = date('Y-m-d', strtotime($admission->status_date));
        //Check Recurring Exists on that date
        $current_recurring = PatBillingRecurring::find()->select(['SUM(charge_amount) as charge_amount', 'room_type_id'])->tenant()->andWhere(['encounter_id' => $admission->encounter_id, 'recurr_date' => $recurr_date])->groupBy(['recurr_date', 'room_type_id'])->one();

        if (empty($current_recurring)) {
            $this->addRecurring($admission);
        } else {
            //If Room Type changed (Ex: AC != Non-AC)
            if ($admission->room_type_id != $current_recurring->room_type_id) {
                $room_charge = CoRoomCharge::find()->select(['SUM(charge) as charge'])->tenant()->status()->active()->andWhere(['room_type_id' => $admission->room_type_id])->groupBy(['room_type_id'])->one();

                //Current Charge (Room Rent: 500, DMO: 400) is lesser than Calculated Charge (Room Rent: 400, DMO: 100)
                if ($current_recurring->charge_amount < $room_charge->charge) {
                    //Delete Current Recurring Billings
                    PatBillingRecurring::deleteAll("tenant_id = :tenant_id AND encounter_id = :encounter_id AND room_type_id = :room_type_id AND recurr_date = :recurr_date", [
                        ':tenant_id' => $admission->tenant_id,
                        ':encounter_id' => $admission->encounter_id,
                        ':room_type_id' => $current_recurring->room_type_id,
                        ':recurr_date' => $recurr_date,
                    ]);
                    //Add New Recurring Billings.
                    $this->addRecurring($admission);
                }
            }
        }
    }

    public function cancelRecurring($admission) {
        //Delete Current Recurring Billings
        PatBillingRecurring::deleteAll("tenant_id = :tenant_id AND encounter_id = :encounter_id AND recurr_group = :recurr_group", [
            ':tenant_id' => $admission->tenant_id,
            ':encounter_id' => $admission->encounter_id,
            ':recurr_group' => $admission->admn_id,
        ]);

        //Get Last Admission
        $current_encounter = PatEncounter::find()->tenant()->andWhere(['encounter_id' => $admission->encounter_id])->one();
        $current_admission = $current_encounter->patCurrentAdmission;

        $from_date = date('Y-m-d', strtotime($current_admission->status_date));
        $to_date = date('Y-m-d');
        $diff_days = $this->_getDayDiff($from_date, $to_date);

        //Insert Recurring upto current date
        for ($i = 0; $i <= $diff_days; $i++) {
            $room_charges = $this->getRoomChargeItems($current_admission->tenant_id, $current_admission->room_type_id);

            if (!empty($room_charges)) {
                foreach ($room_charges as $key => $charge) {
                    $data = [
                        'encounter_id' => $current_admission->encounter_id,
                        'patient_id' => $current_admission->patient_id,
                        'room_type_id' => $current_admission->room_type_id,
                        'room_type' => $current_admission->roomType->room_type_name,
                        'charge_item_id' => $charge->charge_item_id,
                        'charge_item' => $charge->roomChargeItem->charge_item_name,
                        'recurr_date' => date('Y-m-d', strtotime($current_admission->status_date . "+$i days")),
                        'charge_amount' => $charge->charge,
                        'recurr_group' => $current_admission->admn_id,
                    ];
                    $this->_insertRecurringModel($data);
                }
            }
        }
    }

    public function getRoomChargeItems($tenant_id, $room_type_id) {
        return CoRoomCharge::find()->tenant($tenant_id)->status()->active()->andWhere(['room_type_id' => $room_type_id])->all();
    }

    private function _getDayDiff($from_date, $to_date) {
        $date1 = new DateTime($from_date);
        $date2 = new DateTime($to_date);

        return $date2->diff($date1)->format("%a");
    }

    private function _insertRecurringModel($data) {
        $recurring_model = new PatBillingRecurring;
        $recurring_model->attributes = $data;
        $recurring_model->save();
    }

    private function _getChargeAmount($admission, $charge) {
        //Get Patient Past Room charge when he was admitted.
        $bill_recurring = PatBillingRecurring::find()
                ->tenant($admission->tenant_id)
                ->status()
                ->active()
                ->andWhere([
                    'encounter_id' => $admission->encounter_id,
                    'patient_id' => $admission->patient_id,
                    'room_type_id' => $admission->room_type_id,
                    'charge_item_id' => $charge->charge_item_id
                ])
                ->orderBy(['recurr_date' => SORT_DESC])
                ->one();

        return !empty($bill_recurring) ? $bill_recurring->charge_amount : $charge->charge;
    }

}

?>
