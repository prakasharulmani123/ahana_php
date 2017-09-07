CREATE VIEW `v_billing_recurring` AS (
SELECT
  `pat_billing_recurring`.`tenant_id`      AS `tenant_id`,
  `pat_billing_recurring`.`encounter_id`   AS `encounter_id`,
  `pat_billing_recurring`.`room_type_id`   AS `room_type_id`,
  `pat_billing_recurring`.`room_type`      AS `room_type`,
  `pat_billing_recurring`.`charge_item_id` AS `charge_item_id`,
  `pat_billing_recurring`.`charge_item`    AS `charge_item`,
  MIN(`pat_billing_recurring`.`recurr_date`) AS `from_date`,
  MAX(`pat_billing_recurring`.`recurr_date`) AS `to_date`,
  ((TO_DAYS(MAX(`pat_billing_recurring`.`recurr_date`)) - TO_DAYS(MIN(`pat_billing_recurring`.`recurr_date`))) + 1) AS `duration`,
  TRUNCATE((SUM(`pat_billing_recurring`.`charge_amount`) / ((TO_DAYS(MAX(`pat_billing_recurring`.`recurr_date`)) - TO_DAYS(MIN(`pat_billing_recurring`.`recurr_date`))) + 1)),2) AS `charge_amount`,
  SUM(`pat_billing_recurring`.`charge_amount`) AS `total_charge`
FROM `pat_billing_recurring`
GROUP BY `pat_billing_recurring`.`encounter_id`,`pat_billing_recurring`.`room_type_id`,`pat_billing_recurring`.`recurr_group`,`pat_billing_recurring`.`charge_item_id`,`pat_billing_recurring`.`charge_amount`)