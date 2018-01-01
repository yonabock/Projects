


SELECT a.*, b.*, 

(greatest(a.average,b.humu_average) - LEAST( a.average, b.humu_average))/ replace(greatest(a.average,b.humu_average), 0,1) diff FROM  
  
  
  
  
  (SELECT smut.service_id,
         SUM(smut.amount)/ REPLACE(sum(1+ trunc(last_day(smut.month_year)) - TRUNC(smut.month_year)), 0,1) average
  FROM test_service_monthly_usage smut
  GROUP BY smut.service_id)a
JOIN
(SELECT SUM(humuFiltered.total_usage_amount) / REPLACE(SUM(days) ,0,1)humu_average,
       humuFiltered.service_id,
       humuFiltered.utl_id,
       humuFiltered.commodity
FROM   (SELECT *
        FROM   (SELECT 'HU' SOURCE_TABLE,
                       hu.service_id,
                       hu.utl_id,
                       hu.commodity,
                       hu.start_date,
                       hu.end_date, 
                       hu.end_date - hu.start_date days,
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
                       mu.end_date - mu.start_date,
                       mu.total_usage_amount,
                       mu.uom
                FROM   inb_867_mu mu
                WHERE  mu.transaction_purpose = '00'
                       AND
                       mu.utl_tracking_id NOT IN
                       (SELECT mu.cancelled_utl_tracking_id
                        FROM   inb_867_mu mu
                        WHERE  mu.cancelled_utl_tracking_id IS NOT NULL)) humu
        WHERE  (UPPER(humu.commodity) <> 'E' OR UPPER(humu.uom) = 'KH') --FOR ELECTRIC ACCEPT ONLY KH
               AND humu.uom IS NOT NULL
               AND humu.start_date IS NOT NULL
               AND humu.end_date IS NOT NULL
        ORDER  BY service_id) humuFiltered
GROUP  BY humuFiltered.service_id,
          humuFiltered.utl_id,
          humuFiltered.commodity) b
          ON a.service_id=b.service_id
          ORDER BY diff DESC
