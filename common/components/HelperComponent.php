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

    //Yet to be confirmed.
    public function syncBilling($tenant_id, $encounter_id) {
        $encounter = PatEncounter::find()->tenant($tenant_id)->status()->andWhere(['encounter_id' => $encounter_id])->one();

        if (!$status)
            $status = $encounter->patCurrentAdmission->admission_status;

//        $recurring_model = PatBillingRecurring::find()->tenant($tenant_id)->status()->andWhere(['encounter_id' => $encounter_id,'charge_item'=>'ROOM'])->one();
//        
//        if(empty($recurring_model))
//            $status = 'new';
//        
//        $data = [
//            'tenant_id' => $tenant_id,
//            'encounter_id' => $encounter_id,
//            'patient_id' => $encounter->patient_id,
//            'room_type_id' => $admission->room_type_id,
//            'room_type' => $admission->roomType->room_type_name,
//            'charge_item_id' => 'Charge Item ID',
//            'charge_item' => 'Charge Item',
//            'from_date' => 'From Date',
//            'to_date' => 'To Date',
//            'duration' => 'Duration',
//            'charge_amount' => 'Charge Amount',
//            'status' => 'Status',
//        ];
//        
//        if(empty($recurring_model))
//            $recurring_model = new PatBillingRecurring;
//        
//        $recurring_model->attributes = $data;
//        $recurring_model->save();
    }

//    public function updateBilling($admn_id) {
//        $admission = PatAdmission::find()->tenant()->andWhere(['admn_id' => $admn_id])->one();
//
//        switch ($admission->admission_status) {
//            case 'A':
//                $this->syncAdmission($admission);
//                break;
//            case 'TR':
//                break;
//            case 'C':
//                $this->syncCancel($admission);
//                break;
//        }
//    }

    public function addRecurring($admission) {
        $room_charges = $this->getRoomChargeItems($admission->tenant_id, $admission->room_type_id);

        $from_date = $to_date = date('Y-m-d');

        $date1 = new DateTime($from_date);
        $date2 = new DateTime($to_date);

        $diff = $date2->diff($date1)->format("%a");

        foreach ($room_charges as $key => $charge) {
            $data = [
                'encounter_id' => $admission->encounter_id,
                'patient_id' => $admission->patient_id,
                'room_type_id' => $admission->room_type_id,
                'room_type' => $admission->roomType->room_type_name,
                'charge_item_id' => $charge->charge_item_id,
                'charge_item' => $charge->roomChargeItem->charge_item_name,
                'from_date' => $from_date,
                'to_date' => $to_date,
                'duration' => $diff,
                'charge_amount' => $charge->charge,
                'status' => '1',
            ];

            $recurring_model = new PatBillingRecurring;
            $recurring_model->attributes = $data;
            $recurring_model->save();
        }
    }

    public function transferRecurring($admission) {
        //Save tranfer room type charges
        
    }

    public function cancelRecurring($admission) {
        PatBillingRecurring::deleteAll("tenant_id = :tenant_id AND status = '1' AND encounter_id = :encounter_id AND room_type_id = :room_type_id", [
            ':tenant_id' => $admission->tenant_id,
            ':encounter_id' => $admission->encounter_id,
            ':room_type_id' => $admission->room_type_id,
        ]);
        
        //Update Recurring Billings
        $current_admission = $admission->encounter->patCurrentAdmission;
        $recurring_bills = PatBillingRecurring::find()->tenant()->status('0')->andWhere(['room_type_id' => $current_admission->room_type_id, 'encounter_id' => $current_admission->encounter_id])->all();
        
        echo '<pre>';
        print_r($current_admission);
        print_r($recurring_bills);
        exit;
    }

    public function getRoomChargeItems($tenant_id, $room_type_id) {
        return CoRoomCharge::find()->tenant($tenant_id)->status()->active()->andWhere(['room_type_id' => $room_type_id])->all();
    }

}

?>
