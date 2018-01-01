--select from service_monthly_usage where there is no corresponding in service_monthly_usage_test
SELECT * FROM service_monthly_usage_test smut
LEFT JOIN service_monthly_usage smu
ON smut.service_id = smu.service_id
LEFT JOIN (SELECT 'HU' SOURCE_TABLE,
                     hu.service_id,
                     hu.utl_id,
                     hu.commodity,
                     hu.start_date,
                     hu.end_date,
                     hu.total_usage_amount,
                     hu.uom
              FROM   inb_867_hu hu
              
              UNION
              SELECT 'MU' SOURCE_TABLE,
                     mu.service_id,
                     mu.utl_id,
                     mu.commodity,
                     mu.start_date,
                     mu.end_date,
                     mu.total_usage_amount,
                     mu.uom
              FROM   inb_867_mu mu
              WHERE  mu.transaction_purpose = '00'
                     AND
                     mu.utl_tracking_id NOT IN
                     (SELECT mu.cancelled_utl_tracking_id
                      FROM   inb_867_mu mu
                      WHERE  mu.cancelled_utl_tracking_id IS NOT NULL)) humu
ON smu.service_id = humu.service_id AND smu.month_year BETWEEN humu.start_date AND humu.end_date
AND smut.month_year = smu.month_year
WHERE smu.service_id IN (SELECT DISTINCT s.service_id FROM service s)
AND  (UPPER(humu.commodity) <> 'E' OR UPPER(humu.uom) = 'KH') --FOR ELECTRIC ACCEPT ONLY KH
             AND humu.uom IS NOT NULL
             AND humu.start_date IS NOT NULL
             AND humu.end_date IS NOT NULL
             AND (smut.amount > smu.amount *1.5
             OR smut.amount < smu.amount * .5)
ORDER BY smu.service_id, smu.month_year, humu.start_date
;
