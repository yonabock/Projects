INSERT INTO billing_cycle_dates
  (billing_cycle_date_id,
   utl_id,
   utl_zone,
   commodity,
   billing_cycle,
   billing_cycle_date,
   entered_by,
   entered_date)

  (SELECT seq_billing_cycle_dates_id.nextval,
          '51409605',
          NULL,
          NULL,
          billing_cycle,
          billing_cycle_date,
          '??',
          SYSDATE
   FROM   jos24oct.billing_cycle_dates
   WHERE  billing_cycle_date_id >= 5915
          AND billing_cycle_date_id <= 6032);
