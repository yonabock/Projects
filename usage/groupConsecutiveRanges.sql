WITH grp_starts AS
 (SELECT service_id,
         total_usage_amount,
         start_date,
         end_date,
         CASE
            WHEN start_date = lag(end_date)
             over(PARTITION BY service_id ORDER BY start_date, end_date) THEN
             0
            ELSE
             1
          END grp_start
  FROM   inb_867_hu),
grp AS
 (SELECT service_id,
         total_usage_amount,
         start_date,
         end_date,
         SUM(grp_start) OVER(ORDER BY service_id, start_date, end_date) grp
  FROM   grp_starts)
SELECT MAX(ROWNUM) OVER(PARTITION BY service_id),
       ROWNUM,
       end_date - start_date days,
       CASE
          WHEN ROWNUM = MIN(ROWNUM) OVER(PARTITION BY grp) THEN
           GREATEST(start_date, TRUNC(end_date, 'mon'))
          ELSE
           start_date
        END adjusted_start_date,
       CASE
          WHEN ROWNUM = MAX(ROWNUM) OVER(PARTITION BY grp) THEN
           (LEAST(last_day(start_date), end_date))
          ELSE
           end_date
        END adjusted_end_date,
       CASE
          WHEN ROWNUM = MIN(ROWNUM) OVER(PARTITION BY grp) THEN
           (end_date - GREATEST(start_date, TRUNC(end_date, 'mon')))
          WHEN ROWNUM = MAX(ROWNUM) OVER(PARTITION BY grp) THEN
           (LEAST(last_day(start_date + 1), end_date) - start_date)
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
               (LEAST(last_day(start_date + 1), end_date) - start_date) > 0 THEN
           total_usage_amount / (end_date - start_date) *
           (LEAST(last_day(start_date + 1), end_date) - start_date)
          ELSE
           total_usage_amount
        END adjusted_usage_amount,
       grp.*
FROM   grp
ORDER  BY grp;
-----------------------------------------------------------------------------
WITH grp_starts AS
 (SELECT service_id,
         total_usage_amount,
         start_date,
         end_date,
         CASE
            WHEN start_date = lag(end_date)
             over(PARTITION BY service_id ORDER BY start_date, end_date) THEN
             0
            ELSE
             1
          END grp_start
  FROM   inb_867_hu),
grp AS
 (SELECT service_id,
         total_usage_amount,
         start_date,
         end_date,
         SUM(grp_start) OVER(ORDER BY service_id, start_date, end_date) grp
  FROM   grp_starts),
grp_adjusted AS
 (SELECT MAX(ROWNUM) OVER(PARTITION BY service_id),
         ROWNUM,
         end_date - start_date days,
         CASE
            WHEN ROWNUM = MIN(ROWNUM) OVER(PARTITION BY grp) THEN
             GREATEST(start_date, TRUNC(end_date, 'mon'))
            ELSE
             start_date
          END adjusted_start_date,
         CASE
            WHEN ROWNUM = MAX(ROWNUM) OVER(PARTITION BY grp) THEN
             (LEAST(last_day(start_date), end_date))
            ELSE
             end_date
          END adjusted_end_date,
         CASE
            WHEN ROWNUM = MIN(ROWNUM) OVER(PARTITION BY grp) THEN
             (end_date - GREATEST(start_date, TRUNC(end_date, 'mon')))
            WHEN ROWNUM = MAX(ROWNUM) OVER(PARTITION BY grp) THEN
             (LEAST(last_day(start_date + 1), end_date) - start_date)
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
                 (LEAST(last_day(start_date + 1), end_date) - start_date) > 0 THEN
             total_usage_amount / (end_date - start_date) *
             (LEAST(last_day(start_date + 1), end_date) - start_date)
            ELSE
             total_usage_amount
          END adjusted_usage_amount,
         grp.*
  FROM   grp)


SELECT SUM(tsmu.amount),
       MIN(tsmu.month_year),
       MAX(tsmu.month_year),
       SUM(tsmu.amount) / DECODE(max(g.aua), 0, 1, max(g.aua)) dif,
       max(g.aua),
       MAX(minService_id),
       MAX(minService_id),
       MAX(start_date),
       MAX(end_date),
       MAX(grp)
FROM   (SELECT SUM(adjusted_usage_amount) aua,
               MIN(service_id) minService_id,
               MIN(adjusted_start_date) start_date,
               MAX(adjusted_end_date) end_date,
               
               grp
        FROM   grp_adjusted
        GROUP  BY grp
        HAVING COUNT(*)>12) g
JOIN   Test_Service_Monthly_Usage tsmu
ON     tsmu.service_id = g.minService_id
       AND tsmu.month_year BETWEEN g.start_date AND g.end_date
        GROUP  BY grp
ORDER  BY dif DESC
