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
                    'charge_amount' => $charge->charge,
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
                'charge_amount' => $charge->charge,
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
        for ($i = 1; $i <= $diff_days; $i++) {
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

}

?>
