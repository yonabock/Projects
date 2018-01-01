PL/SQL Developer Test script 3.0
5
DELETE FROM utl_usage_percentage WHERE ROWID NOT IN(
       SELECT MAX(ROWID)
       FROM UTL_USAGE_PERCENTAGE
       GROUP BY utl_id, commodity, MONTH_YEAR
)
0
0
DELETE FROM service_monthly_usage_test smut WHERE ROWID NOT IN(
       SELECT MAX(ROWID)
       FROM service_monthly_usage_test smut2
       GROUP BY smut2.service_id, MONTH_YEAR
)