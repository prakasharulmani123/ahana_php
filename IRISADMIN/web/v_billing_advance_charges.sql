CREATE VIEW `v_billing_advance_charges` AS (
SELECT
  `a`.`tenant_id`      AS `tenant_id`,
  `a`.`encounter_id`   AS `encounter_id`,
  `a`.`patient_id`     AS `patient_id`,
  `a`.`payment_id`     AS `payment_id`,
  `a`.`payment_date`   AS `payment_date`,
  `a`.`card_type`      AS `card_type`,
  `a`.`card_number`    AS `card_number`,
  `a`.`bank_name`      AS `bank_name`,
  `a`.`bank_number`    AS `bank_number`,
  `a`.`bank_date`      AS `bank_date`,
  'Advance Charge'     AS `category`,
  CONCAT('Payment (',`a`.`payment_id`,')') AS `headers`,
  0                    AS `charge`,
  0                    AS `visit_count`,
  (CASE `a`.`payment_mode` WHEN 'CA' THEN 'Cash' WHEN 'CD' THEN 'Card' WHEN 'ON' THEN 'Online' WHEN 'CH' THEN 'Cheque' ELSE NULL END) AS `trans_mode`,
  `a`.`payment_amount` AS `total_charge`,
  0                    AS `extra_amount`,
  0                    AS `concession_amount`
FROM `pat_billing_payment` `a`
WHERE ((`a`.`status` = '1')
       AND (`a`.`deleted_at` = '0000-00-00 00:00:00')))