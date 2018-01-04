
WITH grp_starts AS
--selects all records from hu and places a 1 in column grp_start if its start date is not consecutive with the previous end date.
--In other words it is starting a new set of consecutive date ranges.
--Otherwise it IS consecutive and gets a 0
 (SELECT service_id,
         total_usage_amount,
         start_date,
         end_date,
         CASE
            WHEN start_date = lag(end_date)
             over(PARTITION BY service_id ORDER BY start_date, end_date)
             OR start_date - 1 = lag(end_date)
             over(PARTITION BY service_id ORDER BY start_date, end_date)  THEN
             0
            ELSE
             1
          END grp_start
  FROM   inb_867_hu
          ORDER BY service_id, start_date
          ),
grp AS
--asigns a unique grp number to each group of consecutive periods. Each member of any individual group is assigned the same number
 (SELECT service_id,
         total_usage_amount,
         start_date,
         end_date,
         SUM(grp_start) OVER(ORDER BY service_id, start_date, end_date) grp
  FROM   grp_starts),
grp_adjusted AS
--chops off the usage of the part of the billing cycle for first and last billing cycle
--so that the group starts on the first of a month an ends on the 30th/31stth
--and adjusts their start and end dates accordingly
 (SELECT MAX(ROWNUM) OVER(PARTITION BY service_id),
         ROWNUM,
         end_date - start_date days,
         CASE
            WHEN ROWNUM = MIN(ROWNUM) OVER(PARTITION BY grp) THEN
             GREATEST(start_date, TRUNC(end_date, 'mon'))
            ELSE
             NULL
          END adjusted_start_date,
         CASE
            WHEN ROWNUM = MAX(ROWNUM) OVER(PARTITION BY grp) THEN
             (LEAST(last_day(start_date), end_date))
            ELSE
             NULL
          END adjusted_end_date,
         CASE
            WHEN ROWNUM = MIN(ROWNUM) OVER(PARTITION BY grp) THEN
             (end_date - GREATEST(start_date, TRUNC(end_date, 'mon')))
            WHEN ROWNUM = MAX(ROWNUM) OVER(PARTITION BY grp) THEN
             (LEAST(last_day(start_date) + 1, end_date) - start_date)
            ELSE
             end_date - start_date
          END adjusted_days,
         CASE
            WHEN ROWNUM = MIN(ROWNUM)
             OVER(PARTITION BY grp) AND
                 (end_date - start_date) *
                 (end_date - GREATEST(start_date, TRUNC(end_date, 'mon'))) > 0 THEN
             total_usage_amount / (end_date - start_date) *
             (end_date - GREATEST(start_date, TRUNC(end_date, 'mon')))
            WHEN ROWNUM = MAX(ROWNUM)
             OVER(PARTITION BY grp) AND
                 (end_date - start_date) *
                 (LEAST(last_day(start_date) + 1, end_date) - start_date) > 0 THEN
             total_usage_amount / (end_date - start_date) *
             (LEAST(last_day(start_date) + 1, end_date) - start_date)
            ELSE
             total_usage_amount
          END adjusted_usage_amount,
         grp.*
  FROM   grp),
grouped_grp AS
--actually groups together each group. Adds up the usage and selects the earliest (adjusted) start date and latest (adjusted) end date
--now we get one record for each consecutive group containing the start date, end date and total usage of the consecutive group
 (SELECT SUM(adjusted_usage_amount) aua,
         MIN(service_id) minService_id,
         MIN(adjusted_start_date) a_start_date,
         MIN(adjusted_end_date) a_end_date,
         
         grp
  FROM   grp_adjusted
  GROUP  BY grp
  HAVING COUNT(*) > 4),
joined AS
--here the grouped_grp results are joined with the Test_Service_Monthly_Usage tsmu on service_id = service_id
--AND month_year BETWEEN a_start_date AND a_end_date
--and then regrouped by grp number
 (SELECT SUM(tsmu.amount) tsmu_amount,
         MIN(tsmu.month_year),
         MAX(tsmu.month_year),
         MAX(grouped_grp.aua) hu_usage,
         MAX(minService_id),
         MIN(a_start_date),
         MIN(a_end_date),
         MAX(grp)
  FROM   grouped_grp
  JOIN   Test_Service_Monthly_Usage tsmu
  ON     tsmu.service_id = grouped_grp.minService_id
        --AND tsmu.service_id= 3887515
         AND tsmu.month_year BETWEEN grouped_grp.a_start_date AND
         grouped_grp.a_end_date
  GROUP  BY grp)
--this select adds a column calulating the percentage dif of the Test_Service_Monthly_Usage vs. hu totals.
--A number 1 means they are 100% the same, 1.05 or .95 means taht one = 95% of the other
SELECT joined.*, tsmu_amount / DECODE(hu_usage, 0, 1, hu_usage) dif
FROM   joined
ORDER  BY dif ASC;

----------------------------------------------------------------
--single account ungrouped
WITH grp_starts AS
--selects all records from hu and places a 1 in column grp_start if its start date is not consecutive with the previous end date.
--In other words it is starting a new set of consecutive date ranges.
--Otherwise it IS consecutive and gets a 0
 (SELECT service_id,
         total_usage_amount,
         start_date,
         end_date,
         CASE
            WHEN start_date = lag(end_date)
             over(PARTITION BY service_id ORDER BY start_date, end_date)
             OR start_date - 1 = lag(end_date)
             over(PARTITION BY service_id ORDER BY start_date, end_date)  THEN
             0
            ELSE
             1
          END grp_start
  FROM   inb_867_hu
          ORDER BY service_id, start_date
          ),
grp AS
--asigns a unique grp number to each group of consecutive periods. Each member of any individual group is assigned the same number
 (SELECT service_id,
         total_usage_amount,
         start_date,
         end_date,
         SUM(grp_start) OVER(ORDER BY service_id, start_date, end_date) grp
  FROM   grp_starts)
--chops off the usage of the part of the billing cycle for first and last billing cycle
--so that the group starts on the first of a month an ends on the 30th/31stth
--and adjusts their start and end dates accordingly
 SELECT MAX(ROWNUM) OVER(PARTITION BY service_id),
         ROWNUM,
         end_date - start_date days,
         CASE
            WHEN ROWNUM = MIN(ROWNUM) OVER(PARTITION BY grp) THEN
             GREATEST(start_date, TRUNC(end_date, 'mon'))
            ELSE
             NULL
          END adjusted_start_date,
         CASE
            WHEN ROWNUM = MAX(ROWNUM) OVER(PARTITION BY grp) THEN
             (LEAST(last_day(start_date), end_date))
            ELSE
             NULL
          END adjusted_end_date,
         CASE
            WHEN ROWNUM = MIN(ROWNUM) OVER(PARTITION BY grp) THEN
             (end_date - GREATEST(start_date, TRUNC(end_date, 'mon')))
            WHEN ROWNUM = MAX(ROWNUM) OVER(PARTITION BY grp) THEN
             (LEAST(last_day(start_date) + 1, end_date) - start_date)
            ELSE
             end_date - start_date
          END adjusted_days,
         CASE
            WHEN ROWNUM = MIN(ROWNUM)
             OVER(PARTITION BY grp) AND
                 (end_date - start_date) *
                 (end_date - GREATEST(start_date, TRUNC(end_date, 'mon'))) > 0 THEN
             total_usage_amount / (end_date - start_date) *
             (end_date - GREATEST(start_date, TRUNC(end_date, 'mon')))
            WHEN ROWNUM = MAX(ROWNUM)
             OVER(PARTITION BY grp) AND
                 (end_date - start_date) *
                 (LEAST(last_day(start_date) + 1, end_date) - start_date) > 0 THEN
             total_usage_amount / (end_date - start_date) *
             (LEAST(last_day(start_date)+ 1, end_date) - start_date)
            ELSE
             total_usage_amount
          END adjusted_usage_amount,
         grp.*
  FROM   grp
  WHERE grp.service_id = 3736808
  ORDER BY grp.start_date;
