CREATE OR REPLACE PACKAGE usage IS
  --
  -- To modify this template, edit file PKGSPEC.TXT in TEMPLATE
  -- directory of SQL Navigator
  --
  -- Purpose: Briefly explain the functionality of the package
  --
  -- MODIFICATION HISTORY
  -- Person      Date    Comments
  -- ---------   ------  ------------------------------------------
  -- Enter package declarations as shown below

  --------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_YB_NEW;
  ----------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE;
  ---------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_HU_FF_OLD;

  /*   FUNCTION function_name
       ( param1 IN datatype DEFAULT default_value,
         param2 IN OUT datatype)
       RETURN  datatype;
  */
  -----------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_HU_OLD;
  ------------------------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_jos18dec;
  ---------------------------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_YB_12_17;
  -------------------------------------------------------------------------------------------------------------------------------------
  FUNCTION GET_SERVICE_YEARLY_USAGE(ipnServiceId IN service.service_id%TYPE)
    RETURN VARCHAR2;
  ----------------------------------------------------------------------------------------
  FUNCTION GET_YEARLY_USAGE_AMOUNT(ipnServiceId IN service.service_id%TYPE)
    RETURN NUMBER;
  --------------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_MU_OLD;
  --------------------------------------------------------------------------------------
END; -- Package spec
/
CREATE OR REPLACE PACKAGE BODY usage

 IS
  --
  -- To modify this template, edit file PKGBODY.TXT in TEMPLATE
  -- directory of SQL Navigator
  --
  -- Purpose: Briefly explain the functionality of the package body
  --
  -- MODIFICATION HISTORY
  -- Person      Date    Comments
  -- ---------   ------  ------------------------------------------
  -- Enter procedure, function bodies as shown below
  ---------------------------------------------------------------------------------


  /*
    Purpose:
    To calculate total monthly usage for each service, for those months not yet recorded in service_monthly_usage table,
    and insert into said table.
    
    Tables used in this procedure:
    inb_867_hu hu; inb_867_mu mu; service s; service_monthly_usage smu; utl_usage_percentage u
    
  */
  PROCEDURE CREATE_MONTHLY_USAGE_YB_NEW IS
    sDefaultServiceType settings.service_class_default%TYPE;
  
  
  
    /*variables of values to insert into service_monthly_usage*/
    nServiceID           service_monthly_usage.service_id%TYPE;
    dMonthYear           service_monthly_usage.month_year%TYPE;
    nAccumulatedAmount   service_monthly_usage.amount%TYPE;
    sUnitOfMeasure       service_monthly_usage.uom%TYPE;
    sHuOrMu              service_monthly_usage.hu_or_mu%TYPE;
    sEnteredBy           service_monthly_usage.entered_by%TYPE;
    sSourceOfCalculation service_monthly_usage.source_of_calculation%TYPE;
  
  
    /*
    selects all records from inb_867_mu/hu
    */
    CURSOR curHUMU IS
      SELECT humu.SOURCE_TABLE,
             humu.service_id,
             humu.utl_id,
             humu.commodity,
             humu.start_date,
             humu.end_date,
             humu.total_usage_amount,
             humu.uom,
             s.service_type
      FROM   (SELECT 'HU' SOURCE_TABLE,
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
              WHERE  mu.transaction_purpose = '00') humu
      JOIN   service s
      ON     humu.service_id = s.service_id
      WHERE  (UPPER(humu.commodity) <> 'E' OR UPPER(humu.uom) = 'KH') --FOR ELECTRIC ACCEPT ONLY KH
             AND humu.uom IS NOT NULL
             AND humu.start_date IS NOT NULL
             AND humu.end_date IS NOT NULL
      --AND rownum < 3
      ORDER  BY service_id, start_date;
  
    recHUMU    curHUMU%ROWTYPE;
    dStartDate recHUMU.Start_Date%TYPE;
  
    dEndDate                recHUMU.End_Date%TYPE;
    nTotalDays              NUMBER;
    nTotalUsage             recHUMU.total_usage_amount%TYPE; -- total usage for current billing period in HU/MU
    nAvgDailyUsage          NUMBER;
    dLastOfMonth            DATE;
    nDaysWithinCurMonthYear NUMBER;
    nRemainderDays          NUMBER;
    nDaysInMonth            NUMBER;
    nAccumulatedDays        NUMBER;
    dFetchedMonthYear       service_monthly_usage.month_year%TYPE;
    sServiceType            service.service_type%TYPE;
    nAvgBillUsage           inb_867_hu.total_usage_amount%TYPE;
    nReferencePercentOfYear NUMBER;
    nAvgUsage               inb_867_hu.total_usage_amount%TYPE;
    TYPE utlIdList IS TABLE OF VARCHAR2(30);
    overlappingUtlsLst utlIdList;
    nAdjustment        NUMBER;
  
  BEGIN
  
    sEnteredBy := 'CREATE_MONTHLY_USAGE_YB_NEW';
  
  
    /*gets a list of all utls that have overlapping start/end dates for billing cycle*/
    SELECT mu.utl_id
    BULK   COLLECT
    INTO   overlappingUtlsLst
    FROM   inb_867_mu mu
    JOIN   utl_rpm urpm
    ON     mu.utl_id = urpm.utl_id
    JOIN   inb_867_mu mu2
    ON     mu.start_date = mu2.end_date
           AND mu.service_id = mu2.service_id
           AND mu.inb_867_mu_id <> mu2.inb_867_mu_id
    GROUP  BY urpm.utl_short_name, mu.utl_id
    HAVING COUNT(mu.utl_id) > 50
    ORDER  BY urpm.utl_short_name, mu.utl_id;
  
  
    --sets value of :sDefaultServiceType to residential or commercial
    SELECT st.service_class_default
    INTO   sDefaultServiceType
    FROM   settings st;
  
  
    OPEN curHUMU;
    FETCH curHUMU
      INTO recHUMU; --this is done here once to fetch the first record. Subsequently it is done near the end of loop 3
    dFetchedMonthYear := trunc(recHUMU.Start_Date, 'MON'); --this is set here once for the first record. Subsequently it is set near the end of loop 3 "K
  
  
    LOOP
      --(loop 1) loops through each relevant serviceId
      EXIT WHEN curHUMU%NOTFOUND;
    
      /*Reset these variables to 0 for each new serviceId */
      nRemainderDays     := 0;
      nAccumulatedAmount := 0;
      nAccumulatedDays   := 0;
    
      nServiceId     := recHUMU.service_Id;
      sUnitOfMeasure := recHUMU.uom;
      dMonthYear     := dFetchedMonthYear; --this is done here once for each serviceId.
      dLastOfMonth   := last_day(dMonthYear); -- subsequently it is done near the end of loop 2.   
      nDaysInMonth   := dLastOfMonth - (dMonthYear - 1);
    
      /* set nAdjustments to one for utls that overlapp last and first day of billing cycle
      reset nAdjustment to zero for all other utls*/
      IF recHUMU.Utl_Id MEMBER OF overlappingUtlsLst THEN
        nAdjustment := 1;
      ELSE
        nAdjustment := 0;
      END IF;
      BEGIN
        LOOP
          --(loop 2) loops through each monthYear, starting at the earliest month in HUMU for this serviceId
          --and then incrementing by 1 to the next month
          --INCREMENT IS DONE right before the END OF THE LOOP
        
          IF dFetchedMonthYear = dMonthYear THEN
            --the most recent fetch is equal to the monthYear that we are up to, that means we have data for this dMonthYear,
            --so we will go into loop 3 and start processing it.
            --OTHERWISE we have no data for this dMonthYear so we have to calculate based on average.
          
            --NOTE: The average-calculation was NOT put into an ELSE clause, as one may have expected. The reason is because it might be possible
            --to have data but only minimal data which might return 0 usage. We DO want such a case to move on and calculate average.
            --therefor we did not put it in an else clause. Rather it is in a new if statement: IF nAccumulatedDays = 0.
            LOOP
              --(loop 3) loops through all billing cycles that overlap current monthYear for current sServiceId
              IF nRemainderDays = 0 THEN
                --1.EITHER this is the first time inside this loop for this serviceId (for '00')
                --2.OR the current billing cycle (i.e. current recHUMU ('00')) starts on the 1st of the month
                --3.OR the current billing cycle ('00') starts in middle of the month AND
                --   3a.EITHER there was no bill ('00') for the earlier part of the month 
                --   3b.OR it has already been calculated 
              
                /* values directly from or directly based on current record of HU/MU */
                dStartDate := recHUMU.Start_Date;
                dEndDate   := recHUMU.End_Date;
              
                /* 
                *set dEndDate one day earlier for those utilities that overlapp end date with nest start date
                *BUT ONLY for billing cycles that do not have the same end date as start date 
                */
                IF dEndDate > dStartDate THEN
                  dEndDate := dEndDate - nAdjustment;
                END IF;
              
              
                nTotalDays     := dEndDate - (dStartDate - 1);
                nTotalUsage    := recHUMU.total_usage_amount; -- total usage for current billing period in HU/MU
                nAvgDailyUsage := nTotalUsage / nTotalDays;
              
              
                nDaysWITHINCurMonthYear := dLastOfMonth - (dStartDate - 1); --number of days from CURRENT BILLING CYCLE that are in current month_year
                nRemainderDays          := nTotalDays -
                                           nDaysWithinCurMonthYear;
              
              
                nAccumulatedAmount := nAccumulatedAmount + (nDaysWithinCurMonthYear *
                                      nAvgDailyUsage); -- usage amount calculated, (so far,) for current month_year
                nAccumulatedDays   := nAccumulatedDays +
                                      nDaysWITHINCurMonthYear;
              
              ELSE
                --i.e. nRemainderDays > 0
                --we already got some or all days for this month, and maybe evn days from future month(s)
                IF nRemainderDays >= nDaysInMonth THEN
                  --we already got ALL days for this month
                  nAccumulatedAmount := nDaysInMonth * nAvgDailyUsage;
                  nRemainderDays     := nRemainderDays - nDaysInMonth;
                ELSE
                  --we only got some some days for this month
                  nAccumulatedAmount := nRemainderDays * nAvgDailyUsage;
                  nAccumulatedDays   := nRemainderDays;
                  nRemainderDays     := 0;
                END IF;
              
              END IF; --nRemainderDays = 0
            
              IF nRemainderDays = 0 THEN
                -- we calculated all days and usage from previous fetch so...
                FETCH curHUMU
                  INTO recHUMU;
                dFetchedMonthYear := trunc(recHUMU.Start_Date, 'MON');
                /* 
                WHEN recHUMU.Humuservice_Id <> nServiceId then we are up to a new serviceId so exit this loop (3),
                then insert calculated info,
                then exit loop 2 as well to begin loop 1 again for the new serviceId
                OR dNewMonthYear (of new record) > dMonthYear then we are up to a new month so exit this loop (3),
                then insert calculated info, and then begin loop 2 for the new month.
                */
                EXIT WHEN recHUMU.service_Id <> nServiceId OR dFetchedMonthYear > dMonthYear;
              END IF;
            END LOOP; --(loop 3) end of loop that loops through all billing cycles that overlap current monthYear
          
          
            IF nAccumulatedDays = nDaysInMonth THEN
              sSourceOfCalculation := 'COMPLETE_MONTH';
            
            ELSE
              IF nAccumulatedAmount > 0 THEN
                sSourceOfCalculation := 'PARTIAL_MONTH';
                nAccumulatedAmount   := nDaysInMonth * nAvgDailyUsage;
              ELSE
                sSourceOfCalculation := 'ERROR:TOO_MANY_DAYS';
              END IF;
            END IF;
          
          END IF; --dNewMonthYear = dMonthYear
        
          IF nAccumulatedDays = 0 THEN
            sSourceOfCalculation := 'FROM_AVERAGE';
            sServiceType         := nvl(recHUMU.service_type,
                                        sDefaultServiceType);
          
            SELECT AVG(usg)
            INTO   nAvgBillUsage
            FROM   (SELECT hu.total_usage_amount usg
                    FROM   inb_867_hu hu
                    WHERE  (UPPER(commodity) <> 'E' OR UPPER(uom) = 'KH') --FOR ELECTRIC ACCEPT ONLY KH                         
                           AND service_id = nServiceID
                    UNION ALL
                    SELECT mu.total_usage_amount usg
                    FROM   inb_867_mu mu
                    WHERE  (UPPER(commodity) <> 'E' OR UPPER(uom) = 'KH') --FOR ELECTRIC ACCEPT ONLY KH                         
                           AND service_id = nServiceID
                           AND mu.transaction_purpose = '00');
          
            BEGIN
              -- FF May 6 2016 make sure it doesn;t just error out of we don't have the data in utl_usage_percentage 
              SELECT CASE
                       WHEN UPPER(sServiceType) = 'RESIDENTIAL' THEN
                        u.res_pct_of_yr
                       ELSE
                        u.com_pct_of_yr
                     END
              INTO   nReferencePercentOfYear
              FROM   utl_usage_percentage u
              WHERE  utl_id = recHUMU.utl_id ---
                     AND commodity = recHUMU.commodity ---
                     AND to_char(month_year, 'MON') =
                     to_char(dMonthYear, 'MON')
                     AND rownum < 2
              ORDER  BY u.month_year DESC;
            EXCEPTION
              WHEN OTHERS THEN
                NULL;
            END;
            nAccumulatedAmount := nAvgBillUsage * 12 *
                                  nReferencePercentOfYear / 100;
          
          END IF;
        
        
          INSERT INTO service_monthly_usage
            (service_monthly_usage_id,
             service_id,
             month_year,
             amount,
             uom,
             hu_or_mu,
             entered_date,
             entered_by,
             source_of_calculation)
          VALUES
            (SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
             nServiceID,
             dMonthYear,
             ROUND(nAccumulatedAmount, 5),
             sUnitOfMeasure,
             sHuOrMu,
             SYSTIMESTAMP,
             sEnteredBy,
             sSourceOfCalculation);
        
        
        
          /* when recHUMU.Humuservice_Id <> nServiceId then we are dealing with a new serviceId so exit this loop 
          OR */
          EXIT WHEN recHUMU.service_Id <> nServiceId OR dMonthYear >= SYSDATE;
        
          /* if we didn't exit and we are still in this loop then we are still in the same serviceId
          so we add_months() to move on to next month */
          dMonthYear   := add_months(dMonthYear, 1);
          dLastOfMonth := last_day(dMonthYear); -- subsequently it is done near the end of loop 2.   
          nDaysInMonth := dLastOfMonth - (dMonthYear - 1);
        END LOOP; --(loop 2) end of loop that loops through each yearMonth that overlapps at least a partial billing cycle (of current serviceId)
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                               ipsErrMessage            => SQLERRM,
                               ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE',
                               ipnErrCode               => SQLCODE,
                               ipnServiceId             => nServiceId,
                               ipsEnteredBy             => sys_context('USERENV',
                                                                       'SESSION_USER'),
                               ipsUtlAcctId             => '',
                               ipsUtlId                 => '',
                               ipsCommodity             => '');
        
          /*bring curHUMU to next service_id */
          WHILE recHUMU.service_Id = nServiceId LOOP
            EXIT WHEN curHUMU%NOTFOUND;
            FETCH curHUMU
              INTO recHUMU;
            dFetchedMonthYear := trunc(recHUMU.Start_Date, 'MON');
          END LOOP;
      END;
    
    END LOOP; --(loop 1) end of loop that loops through each relevant serviceId
    CLOSE curHUMU;
  
  
  
  END;





  --------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_jos18dec IS
    dNearestMonthToNow         DATE := '01-Jan-1990';
    dNumberOfMonthsToProcess   NUMBER;
    dLastMonth                 DATE := '01-Jan-1990';
    dFirstMonth                DATE := '01-Jan-1990';
    nDaysInMonth               NUMBER;
    nCurrentServiceID          SERVICE.SERVICE_ID%TYPE;
    dStartOfPeriod             DATE;
    dEndOfPeriod               DATE;
    dLastOfMonth               DATE;
    nTotalNumberOfDaysInPeriod NUMBER;
    nNumberOfRelevantDaysInSet NUMBER;
    nAverageDailyUseInSet      NUMBER;
    nAccumulatedNumberOfDays   NUMBER := 0;
    nTotalAccumulatedDays      NUMBER := 0;
    nAccumulatedUsage          NUMBER := 0;
    sUnitOfMeasure             VARCHAR2(25);
    sServiceType               SERVICE.Service_Type%TYPE;
    sDefaultServiceType        SERVICE.Service_Type%TYPE;
    sHuOrMu                    VARCHAR2(2);
    nReferenceOnePercentUsage  NUMBER := 0;
    nReferencePercentOfYear    NUMBER := 0;
    bEntered                   BOOLEAN;
    dFirstDate                 DATE;
    dLastDate                  DATE;
    nAvgUsage                  NUMBER; -- FF May/9/2016
  
  
  
    CURSOR curService IS
    
      SELECT s.service_id,
             s.commodity,
             s.utl_id,
             s.hst_req_date,
             s.service_type
      FROM   service s
      WHERE  service_id IN (SELECT DISTINCT service_id
                            FROM   inb_867_mu mu
                            UNION
                            SELECT DISTINCT service_id
                            FROM   inb_867_hu hu)
      ORDER  BY s.service_id;
  
  
    CURSOR curRelevantRecs IS
      SELECT 'HU' SOURCE_TABLE,
             hu.service_id,
             hu.start_date,
             hu.end_date,
             hu.total_usage_amount,
             hu.uom
      FROM   inb_867_hu hu
      WHERE  ((UPPER(hu.commodity) = 'E' AND UPPER(hu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
             OR UPPER(hu.commodity) <> 'E')
             AND hu.start_date <> hu.end_date
             AND hu.start_date <= dLastOfMonth
             AND hu. end_date > dStartOfPeriod
             AND service_id = nCurrentServiceID
             AND hu.uom IS NOT NULL
             AND hu.start_date IS NOT NULL
             AND hu.end_date IS NOT NULL
      UNION
      SELECT 'MU' SOURCE_TABLE,
             mu.service_id,
             mu.start_date,
             mu.end_date,
             mu.total_usage_amount,
             mu.uom
      FROM   inb_867_mu mu
      WHERE  ((UPPER(mu.commodity) = 'E' AND UPPER(mu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
             OR UPPER(mu.commodity) <> 'E')
             AND mu.start_date <= dLastOfMonth
             AND mu. end_date > dStartOfPeriod
             AND mu.service_id = nCurrentServiceID
             AND mu.uom IS NOT NULL
             AND mu.start_date IS NOT NULL
             AND mu.end_date IS NOT NULL;
  
  BEGIN
    FOR recService IN curService LOOP
      BEGIN
        -- MR 11/6/17 Sometimes the sUnitOfMeasure doesn't get reset for the new service_id so we set it now and
        SELECT *
        INTO   sUnitOfMeasure --            if the procedure needs to change it at a later time, it changes it.
        FROM   (SELECT mu.uom
                FROM   inb_867_mu mu
                WHERE  ((UPPER(mu.commodity) = 'E' AND UPPER(mu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
                       OR UPPER(mu.commodity) <> 'E')
                       AND mu.service_id = recService.Service_Id
                       AND mu.uom IS NOT NULL
                       AND mu.start_date IS NOT NULL
                       AND mu.end_date IS NOT NULL
                UNION ALL --Need to do union all (and not union) because we want that if uom of mu and hu are different then mu wins, and by reg union for some reason the hu was row 1 (maybe because there were more hu records then mu) and we have a where clause "WHERE  rownum < 2"
                SELECT hu.uom
                FROM   Inb_867_Hu hu
                WHERE  ((UPPER(hu.commodity) = 'E' AND UPPER(hu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
                       OR UPPER(hu.commodity) <> 'E')
                       AND hu.start_date <> hu.end_date
                       AND service_id = recService.Service_Id
                       AND hu.uom IS NOT NULL
                       AND hu.start_date IS NOT NULL
                       AND hu.end_date IS NOT NULL)
        WHERE  rownum < 2;
      EXCEPTION
        WHEN no_data_found THEN
          -- If we don't have any 867MU or 867HU we base it off of the commodity
          SELECT DECODE(s.commodity, 'E', 'KH', 'TD')
          INTO   sUnitOfMeasure
          FROM   service s
          WHERE  s.service_id = recService.Service_Id;
      END;
      BEGIN
        SELECT st.service_class_default
        INTO   sDefaultServiceType
        FROM   settings st;
        BEGIN
          --USED TO CATCH ANY AND ALL EXCEPTIONS BELOW
          nCurrentServiceID := recService.Service_Id;
          --    DBMS_OUTPUT.Put_Line('nxtSrvcId '||systimestamp);
          --Get the last month that exists in service monthly usage table
          SELECT MAX(month_year) --Select the most recent record already entered into service monthly usage with this service id
          INTO   dLastMonth
          FROM   SERVICE_MONTHLY_USAGE
          WHERE  service_id = nCurrentServiceID;
          ------------ FF trying to fix issue when MU comes before HU this thing is not working... but not resolved)
          /*SELECT LEAST(hu.myr,mu.myr) INTO dLastMonth from  
          (SELECT nvl(MAX(month_year),TRUNC(SYSDATE) - (25*12) ) myr --Select the most recent record already entered into service monthly usage with this service id
             --  INTO dLastMonth
          FROM SERVICE_MONTHLY_USAGE
               WHERE service_id = nCurrentServiceID
               AND   HU_OR_MU = 'HU'
          ) HU,
          
                 
          (SELECT MAX(month_year) myr --Select the most recent record already entered into service monthly usage with this service id
             --  INTO dLastMonth
          FROM SERVICE_MONTHLY_USAGE
               WHERE service_id = nCurrentServiceID
               AND   HU_OR_MU = 'MU'
          ) MU;  */
        
          ----------
          BEGIN
            SELECT *
            INTO   dFirstDate
            FROM   (SELECT MIN(start_date) fDate
                    -- get the first (oldest) record with this service id from inb_867
                    FROM   inb_867_mu mu
                    WHERE  service_id = nCurrentServiceID
                           AND mu.start_date IS NOT NULL
                    UNION
                    SELECT MIN(start_date) fDate -- get the first (oldest) record with this service id from inb_867
                    FROM   inb_867_hu hu
                    WHERE  service_id = nCurrentServiceID
                           AND hu.start_date IS NOT NULL
                    ORDER  BY 1)
            WHERE  fDate IS NOT NULL
                   AND rownum < 2;
          EXCEPTION
            --MR 10/30/17 Sometimes there are no records (besides for null start date records) and error 
            WHEN no_data_found THEN
              --            because there are no results at all
              dFirstDate := NULL;
          END;
          BEGIN
            SELECT *
            INTO   dLastDate
            FROM   (SELECT MAX(start_date) msDate
                    --get the most recent month in mu and normalize to first of that month
                    FROM   inb_867_mu
                    WHERE  service_id = nCurrentServiceID
                    UNION
                    SELECT MAX(start_date) msDate --get the most recent month in mu and normalize to first of that month
                    FROM   inb_867_hu
                    WHERE  service_id = nCurrentServiceID
                    ORDER  BY 1 DESC)
            WHERE  msDate IS NOT NULL
                   AND rownum < 2;
          EXCEPTION
            --MR 10/30/17 Sometimes there are no records (besides for null start date records) and error because there are no
            WHEN no_data_found THEN
              --            results at all
              dLastDate := NULL;
          END;
          IF dFirstDate IS NOT NULL AND dLastDate IS NOT NULL THEN
            SELECT to_date('1-' || to_char(MIN(dFirstDate), 'MON-YYYY'))
            INTO   dFirstMonth
            FROM   dual;
            SELECT to_date('1-' || to_char(MAX(dLastDate), 'MON-YYYY'))
            INTO   dNearestMonthToNow
            FROM   dual;
          END IF;
          IF dLastMonth IS NOT NULL THEN
            --there already exists at least one record with this service id in service monthly usage
            SELECT months_between((add_months(dNearestMonthToNow, 1)),
                                  dLastMonth)
            INTO   dNumberOfMonthsToProcess
            FROM   dual;
          ELSE
            --this service id is not yet found in service monthly usage table
            SELECT months_between((add_months(dNearestMonthToNow, 1)),
                                  dFirstMonth)
            INTO   dNumberOfMonthsToProcess
            FROM   dual;
          END IF;
          FOR i IN 1 .. dNumberOfMonthsToProcess LOOP
            BEGIN
              bEntered := NULL;
              --Get the start and end of the period we are concerned with. (We want to move backward from most recent to older)
              dStartOfPeriod := Add_Months(dNearestMonthToNow, (i - 1) * -1);
              dEndOfPeriod   := LAST_DAY(dStartOfPeriod);
              dLastOfMonth   := LAST_DAY(dStartOfPeriod);
              --Run the cursor on the mu to get any rows that has data which overlaps this period (getting 2 is common)
              nAccumulatedNumberOfDays := 0;
              nAccumulatedUsage        := 0;
              IF dLastMonth IS NULL OR dStartOfPeriod <> dLastMonth THEN
                IF dFirstMonth <= dStartOfPeriod THEN
                  FOR recRelevantRecs IN curRelevantRecs LOOP
                    --  DBMS_OUTPUT.Put_Line('relevant recs loop '||systimestamp); 
                    BEGIN
                      IF nTotalAccumulatedDays = 0 THEN
                        -- first record of this service id
                        dEndOfPeriod := LAST_DAY(recRelevantRecs.End_Date);
                      ELSE
                        dEndOfPeriod := LAST_DAY(ADD_MONTHS(recRelevantRecs.End_Date,
                                                            -1));
                      END IF;
                      SELECT CAST(recRelevantRecs.Source_Table AS
                                  VARCHAR2(2))
                      INTO   sHuOrMu
                      FROM   dual;
                      nTotalNumberOfDaysInPeriod := dEndOfPeriod -
                                                    dStartOfPeriod + 1;
                      dLastOfMonth               := LAST_DAY(dStartOfPeriod);
                      --How many days in the period --last day is inclusive so +1
                      SELECT (dLastOfMonth - dStartOfPeriod) + 1
                      INTO   nDaysInMonth
                      FROM   dual;
                      IF (recRelevantRecs.Start_Date = dStartOfPeriod) AND
                         ((recRelevantRecs.End_Date - 1) = dLastOfMonth) THEN
                        nAccumulatedUsage := recRelevantRecs.Total_Usage_Amount;
                        IF recRelevantRecs.Uom IS NULL THEN
                          BEGIN
                            SELECT uom
                            INTO   sUnitOfMeasure
                            FROM   inb_867_hu
                            WHERE  uom IS NOT NULL
                                   AND service_id = nCurrentServiceID
                                   AND ROWNUM < 2;
                          EXCEPTION
                            WHEN no_data_found THEN
                              BEGIN
                                SELECT uom
                                INTO   sUnitOfMeasure
                                FROM   inb_867_mu
                                WHERE  uom IS NOT NULL
                                       AND service_id = nCurrentServiceID
                                       AND ROWNUM < 2;
                              EXCEPTION
                                WHEN no_data_found THEN
                                  ROLLBACK; --Dont insert partial service monthly records...
                                  GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                                       ipsErrMessage            => SQLERRM,
                                                       ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE',
                                                       ipnErrCode               => SQLCODE,
                                                       ipnServiceId             => nCurrentServiceID,
                                                       ipsEnteredBy             => sys_context('USERENV',
                                                                                               'SESSION_USER'),
                                                       ipsUtlAcctId             => '',
                                                       ipsUtlId                 => '',
                                                       ipsCommodity             => '');
                              END;
                          END;
                        ELSE
                          sUnitOfMeasure := recRelevantRecs.Uom;
                        END IF;
                        nAccumulatedNumberOfDays := nDaysInMonth;
                      ELSE
                        --Whats the average daily use?   --mu End_Dates are NOT inclusive so no +1 (they repeat on the following months record...)
                        IF (recRelevantRecs.End_Date -
                           recRelevantRecs.Start_Date) > 0 THEN
                          -- if month is swallowed within record can't calculate avg daily use in set with this equation.
                          nAverageDailyUseInSet := recRelevantRecs.Total_Usage_Amount /
                                                   (recRelevantRecs.End_Date -
                                                   recRelevantRecs.Start_Date);
                        END IF;
                        --How many days in the set actually intersect with the period and therefore are relevant?
                        IF to_char(dStartOfPeriod, 'MON') <>
                           to_char(recRelevantRecs.Start_Date, 'MON') AND
                           to_char(dLastOfMonth, 'MON') <>
                           to_char(recRelevantRecs.End_Date, 'MON') THEN
                          nNumberOfRelevantDaysInSet := nDaysInMonth;
                        ELSIF (dLastOfMonth) = (recRelevantRecs.Start_Date) THEN
                          nNumberOfRelevantDaysInSet := 1;
                        ELSE
                          nNumberOfRelevantDaysInSet := LEAST(dLastOfMonth,
                                                              recRelevantRecs.End_Date + 1) -
                                                        GREATEST(dStartOfPeriod,
                                                                 recRelevantRecs.Start_Date);
                        END IF;
                        nTotalAccumulatedDays := nTotalAccumulatedDays +
                                                 nNumberOfRelevantDaysInSet;
                        --Accumulate what we can from this record and move on
                        nAccumulatedNumberOfDays := nAccumulatedNumberOfDays +
                                                    nNumberOfRelevantDaysInSet;
                        nAccumulatedUsage        := nAccumulatedUsage +
                                                    (nAverageDailyUseInSet *
                                                    nNumberOfRelevantDaysInSet);
                        IF recRelevantRecs.Uom IS NULL THEN
                          BEGIN
                            SELECT uom
                            INTO   sUnitOfMeasure
                            FROM   inb_867_hu
                            WHERE  uom IS NOT NULL
                                   AND service_id = nCurrentServiceID
                                   AND ROWNUM < 2;
                          EXCEPTION
                            WHEN no_data_found THEN
                              BEGIN
                                SELECT uom
                                INTO   sUnitOfMeasure
                                FROM   inb_867_mu m
                                WHERE  uom IS NOT NULL
                                       AND service_id = nCurrentServiceID
                                       AND ROWNUM < 2;
                              EXCEPTION
                                WHEN no_data_found THEN
                                  ROLLBACK; --Dont insert partial service monthly records...
                                  GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                                       ipsErrMessage            => SQLERRM,
                                                       ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE',
                                                       ipnErrCode               => SQLCODE,
                                                       ipnServiceId             => nCurrentServiceID,
                                                       ipsEnteredBy             => sys_context('USERENV',
                                                                                               'SESSION_USER'),
                                                       ipsUtlAcctId             => '',
                                                       ipsUtlId                 => '',
                                                       ipsCommodity             => '');
                              END;
                          END;
                        ELSE
                          sUnitOfMeasure := recRelevantRecs.Uom;
                        END IF;
                        IF nAccumulatedNumberOfDays > nDaysInMonth THEN
                          nAccumulatedUsage := nAverageDailyUseInSet *
                                               nDaysInMonth;
                        END IF;
                      END IF;
                      IF (nAccumulatedNumberOfDays >= nDaysInMonth) THEN
                        -- we have full month with real data                             
                        --now insert data
                        IF bEntered IS NULL THEN
                          --              DBMS_OUTPUT.Put_Line('insert complete '||systimestamp);
                          INSERT INTO SERVICE_MONTHLY_USAGE
                            (SERVICE_MONTHLY_USAGE_ID,
                             SERVICE_ID,
                             MONTH_YEAR,
                             AMOUNT,
                             UOM,
                             HU_OR_MU,
                             ENTERED_DATE,
                             ENTERED_BY,
                             SOURCE_OF_CALCULATION)
                            SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
                                   nCurrentServiceID,
                                   dStartOfPeriod,
                                   ROUND(nAccumulatedUsage, 5),
                                   sUnitOfMeasure,
                                   sHuOrMu,
                                   SYSTIMESTAMP,
                                   'CREATE_MONTHLY_USAGE',
                                   'COMPLETE_MONTH'
                            FROM   DUAL;
                          bEntered                 := TRUE;
                          nAccumulatedNumberOfDays := 0;
                          --adjust start date to next month and reset # of days and accumulated usage to 0
                          dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -1);
                        END IF;
                      END IF;
                    END; --FOR recRelevantRecs IN curRelevantRecs LOOP
                  END LOOP;
                
                  --Did we cover the whole month or so we need to manufacturer more days of usage based on averages?
                  IF (nAccumulatedNumberOfDays < nDaysInMonth) AND
                     sUnitOfMeasure IS NOT NULL THEN
                    --If we have "enough data" in this month we can jus prorate based on that otherwise we need to go back to the utility average use
                    --define what "enough data" means in the predicate to the following if clause. However FF says that even one day is  better than the alternative.
                    IF nAccumulatedNumberOfDays > 0 THEN
                      --we have some data for this month
                      nAverageDailyUseInSet      := nAverageDailyUseInSet /
                                                    nAccumulatedNumberOfDays; --Manufactured daily use based on averages so far
                      nNumberOfRelevantDaysInSet := nDaysInMonth -
                                                    nAccumulatedNumberOfDays; --This is the amount of days we are missing
                      nAccumulatedUsage          := nAccumulatedUsage +
                                                    (nAverageDailyUseInSet *
                                                    nNumberOfRelevantDaysInSet);
                      IF bEntered IS NULL THEN
                        --   DBMS_OUTPUT.Put_Line('insert partial '||systimestamp); 
                        INSERT INTO SERVICE_MONTHLY_USAGE
                          (SERVICE_MONTHLY_USAGE_ID,
                           SERVICE_ID,
                           MONTH_YEAR,
                           AMOUNT,
                           UOM,
                           HU_OR_MU,
                           ENTERED_DATE,
                           ENTERED_BY,
                           SOURCE_OF_CALCULATION)
                          SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
                                 nCurrentServiceID,
                                 dStartOfPeriod,
                                 ROUND(nAccumulatedUsage, 5),
                                 sUnitOfMeasure,
                                 sHuOrMu,
                                 SYSTIMESTAMP,
                                 'CREATE_MONTHLY_USAGE',
                                 'PARTIAL_MONTH'
                          FROM   DUAL;
                        bEntered := TRUE;
                        --adjust start date to next month and reset # of days and accumulated usage to 0
                        dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -1);
                      END IF;
                    ELSE
                      --we have no data for this month
                      --Then use the ratio of this guys usage in a different month to determine what this months usage should be.
                      --PLEASE NOTE THAT THIS SHOULD NOT BE POSSIBLE TO OCCUR ON THE FIRST MONTH IN, SINCE IF WE ARE IN THIS PROC WE ARE GUARANTEED AT LEAST SOME REAL DATA
                      -- IF nIsReferenceProportion = 0 THEN
                      --what percentage of the year does this month reflect in the average customer?
                      --residential/commercial?
                      IF recService.Service_Type IS NULL THEN
                        SELECT st.service_class_default
                        INTO   sServiceType
                        FROM   settings st;
                      ELSE
                        sServiceType := recService.Service_Type;
                      END IF;
                      BEGIN
                        -- FF May 6 2016 make sure it doesn;t just error out of we don't have the data in utl_usage_percentage 
                        SELECT CASE
                                 WHEN UPPER(sServiceType) = 'RESIDENTIAL' THEN
                                  u.res_pct_of_yr
                                 ELSE
                                  u.com_pct_of_yr
                               END
                        INTO   nReferencePercentOfYear
                        FROM   utl_usage_percentage u
                        WHERE  1 = 1
                               AND utl_id = recService.utl_id
                               AND commodity = recService.commodity
                               AND to_char(month_year, 'MON') =
                               to_char(dStartOfPeriod, 'MON')
                               AND rownum < 2
                        ORDER  BY u.month_year DESC;
                      EXCEPTION
                        WHEN OTHERS THEN
                          -- if we don;t have the data in utl_usage_percentage
                          -- at least, not to error out we will approximate and set the percentage 
                          -- the avergae of all the date we have.
                          SELECT AVG(usg)
                          INTO   nAvgUsage
                          FROM   (SELECT hu.total_usage_amount usg
                                  FROM   inb_867_hu hu
                                  WHERE  ((UPPER(hu.commodity) = 'E' AND
                                         UPPER(hu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
                                         OR UPPER(hu.commodity) <> 'E')
                                         AND service_id = nCurrentServiceID
                                  UNION ALL
                                  SELECT mu.total_usage_amount usg
                                  FROM   inb_867_mu mu
                                  WHERE  ((UPPER(mu.commodity) = 'E' AND
                                         UPPER(mu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
                                         OR UPPER(mu.commodity) <> 'E')
                                         AND service_id = nCurrentServiceID);
                        
                      END;
                      /*                            SELECT amount INTO nAccumulatedUsage FROM
                          (
                              SELECT month_year, amount 
                              FROM SERVICE_MONTHLY_USAGE
                              WHERE service_id = nCurrentServiceID
                              AND month_year = add_months(dStartOfPeriod, 1)                      
                          );
                      IF nAccumulatedUsage <= 0 THEN -- FF May/6/2016 make sure that we get an amount no mather what.
                         nAccumulatedUsage := nAnyUsageAmount;                         
                      END IF;
                      IF nReferenceOnePercentUsage > 0 THEN
                          nAccumulatedUsage := nAccumulatedUsage / nReferenceOnePercentUsage;
                      ELSE 
                          nAccumulatedUsage := nAccumulatedUsage / nReferencePercentOfYear;
                      END IF;*/
                      --what was this customers usage this month? Divide that by the percentage and your result is the reference one percent.
                      nReferenceOnePercentUsage :=  /*nAccumulatedUsage /*/
                       nReferencePercentOfYear;
                      --once we set proportion, change value to 1 so will never recalculate for this service id
                      /* 
                              nIsReferenceProportion := 1;
                          END IF;
                      END IF;*/
                      --and multiply it by our established 1% Reference (see calc just below)
                      IF nAvgUsage = 0 THEN
                        -- FF May/9/2016 -- added this so if needed to resort to avergae, that is what we should insert in table;
                        nAccumulatedUsage := nReferencePercentOfYear *
                                             nAccumulatedUsage /*nReferenceOnePercentUsage*/
                         ;
                      ELSE
                        nAccumulatedUsage := nAvgUsage;
                      END IF;
                      IF bEntered IS NULL THEN
                        --    DBMS_OUTPUT.Put_Line('insert avg '||systimestamp); 
                        --insert this calculated data into database if it does not already exist
                        INSERT INTO SERVICE_MONTHLY_USAGE
                          (SERVICE_MONTHLY_USAGE_ID,
                           SERVICE_ID,
                           MONTH_YEAR,
                           AMOUNT,
                           UOM,
                           HU_OR_MU,
                           ENTERED_DATE,
                           ENTERED_BY,
                           SOURCE_OF_CALCULATION)
                          SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
                                 nCurrentServiceID,
                                 dStartOfPeriod,
                                 ROUND(nAccumulatedUsage, 5),
                                 sUnitOfMeasure,
                                 sHuOrMu,
                                 SYSTIMESTAMP,
                                 'CREATE_MONTHLY_USAGE',
                                 'FROM_AVERAGE'
                          FROM   DUAL;
                        bEntered := TRUE;
                        --adjust start date to next month and reset # of days and accumulated usage to 0
                        dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -1);
                      END IF;
                    END IF;
                    --On First Month setup a reference proportion to total usage to be used in months where there is no data
                  
                  
                  
                  END IF;
                  --one last adjustment, per ff we should make the date of month_year in to the past since some retarded utilities send future projections
                  --in place of mu's (like keyspanLI for example)
                  WHILE dStartOfPeriod > SYSDATE LOOP
                    dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -12); --roll year back by one until in the past.
                  END LOOP;
                  --we'll insert one month at a time, but the commit is for a whole service at a shot (see end of loop below)
                END IF;
              END IF;
            END;
          END LOOP; --dNumberOfMonthsToProcess
        
          COMMIT; --This includes the records to the service_monthly_usage as well
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK; --Dont insert partial service monthly records...
            IF sUnitOfMeasure IS NOT NULL THEN
              GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                   ipsErrMessage            => SQLERRM,
                                   ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE',
                                   ipnErrCode               => SQLCODE,
                                   ipnServiceId             => nCurrentServiceID,
                                   ipsEnteredBy             => sys_context('USERENV',
                                                                           'SESSION_USER'),
                                   ipsUtlAcctId             => '',
                                   ipsUtlId                 => '',
                                   ipsCommodity             => '');
            END IF;
        END;
        nTotalAccumulatedDays := 0; --resets for each service id
      END;
    END LOOP;
  END;

  --------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_HU_FF_OLD IS
  
    ---***************OBSOLETED BY select * from MAY 5, 2014
  
    -- This procedure needs to run on  a scheduler
    -- Enter the procedure variables here. As shown below
    -- variable_name        datatype  NOT NULL DEFAULT default_value;
    nMaxInb867HuId     INB_867_HU.inb_867_hu_id%TYPE;
    nMaxId             INB_867_HU.inb_867_hu_id%TYPE;
    nServiceId         INB_867_HU.service_id%TYPE;
    dMonth             DATE;
    dYear              DATE;
    sMonthYearStart    VARCHAR2(8);
    sMonthYearEnd      VARCHAR2(8);
    sMonthYearEndPrior VARCHAR2(8);
    nDaysInMonth       NUMBER;
    nDailyAmount       NUMBER;
    nDailyAmountPrior  NUMBER;
    nDaysInMonthPrior  NUMBER;
    dEndDatePrior      DATE;
    nMonthAmount       NUMBER;
    i                  NUMBER;
    bSameMonth         BOOLEAN;
    nTotalDays         NUMBER;
    nMaxHUId           NUMBER;
  
    TYPE huTyp IS TABLE OF inb_867_hu%ROWTYPE;
    huTbl huTyp;
  
    CURSOR curHuServiceId IS
      SELECT DISTINCT service_id
      FROM   inb_867_hu
      WHERE  inb_867_hu_id >
             (SELECT max_id
              FROM   MISC_PROCESS_LOG
              WHERE  process_name = 'CREATE_MONTHLY_USAGE_HU');
    CURSOR curHU IS
      SELECT hu.service_id,
             hu.start_date,
             hu.end_date,
             hu.total_usage_amount,
             hu.uom,
             rownum
      FROM   inb_867_hu hu
      WHERE  hu.service_id = nServiceId
      ORDER  BY hu.start_date;
    /* Figure out the contribution of the 1st half of record 2, and second half of record one; calculate their daily amount and then add them up
        For record # 1 where we have no information about the prior month we sinmply prorate his daily amount by the days in the month
    */
  BEGIN
  
    SELECT MAX(hu.inb_867_hu_id)
    INTO   nMaxHUId
    FROM   inb_867_hu hu;
  
    FOR recHuServiceId IN curHuServiceId LOOP
      nServiceId := recHuServiceId.service_id;
      SELECT *
      BULK   COLLECT
      INTO   huTbl
      FROM   inb_867_hu
      WHERE  service_id = nServiceId
      ORDER  BY start_date;
      --            DBMS_OUTPUT.Put_Line( 'nServiceId: ' || nServiceId );
      nTotalDays := 0;
      FOR i IN 1 .. huTbl.count LOOP
        BEGIN
          IF i > 1 THEN
            --                        DBMS_OUTPUT.Put_Line( '>1' );
            -- **nDailyAmountPrior :=  huTbl(i-1).total_usage_amount / ( huTbl(i-1).end_date -  huTbl(i-1).start_date + 1) ; -- daily amount for each day in this period
            nDailyAmountPrior := huTbl(i - 1).total_usage_amount /
                                  (huTbl(i - 1).end_date - huTbl(i - 1)
                                               .start_date);
            -- ** nDaysInMonthPrior := huTbl(i-1).end_date - ( to_date('1-' || to_char(huTbl(i-1).end_date,'MON-YYYY'))) + 1;
            nDaysInMonthPrior := huTbl(i - 1).end_date -
                                  (to_date('1-' ||
                                           to_char(huTbl(i - 1).end_date,
                                                   'MON-YYYY'))); -- + 1;
            nDailyAmount      := huTbl(i)
                                 .total_usage_amount /
                                  (huTbl(i)
                                   .end_date - huTbl(i).start_date + 1); -- daily amount for each day in this period
            nDaysInMonth      := LAST_DAY(huTbl(i).start_date) - huTbl(i)
                                .start_date + 1;
            sMonthYearStart   := to_char(huTbl(i).start_date, 'MON-YYYY'); -- this is the month we are calculating and unserting
            nMonthAmount      := (nDailyAmount * nDaysInMonth) +
                                 (nDailyAmountPrior * (nDaysInMonthPrior)); -- (nDaysInMonthPrior -1) we need to take one day off otherwise we adding one extra day to the days of the month
            --                        DBMS_OUTPUT.Put_Line( sMonthYearStart || ' nDaysInMonth + nDaysInMonthPrior: ' || to_char(nDaysInMonth + nDaysInMonthPrior));
          ELSE
            nDailyAmount    := huTbl(i)
                               .total_usage_amount /
                                (huTbl(i).end_date - huTbl(i).start_date + 1); -- daily amount for each day in this period
            nDaysInMonth    := LAST_DAY(huTbl(i).start_date) - huTbl(i)
                              .start_date + 1;
            sMonthYearStart := to_char(huTbl(i).start_date, 'MON-YYYY'); -- this is the month we are calculating and unserting
            nMonthAmount    := nDailyAmount *
                               (LAST_DAY(huTbl(i).start_date) -
                               (to_date('1-' ||
                                         to_char(huTbl(i).start_date,
                                                 'MON-YYYY'))) + 1);
            nTotalDays      := (LAST_DAY(huTbl(i).start_date) -
                               (to_date('1-' ||
                                         to_char(huTbl(i).start_date,
                                                 'MON-YYYY'))) + 1);
            --                        DBMS_OUTPUT.Put_Line( sMonthYearStart || ' When 1, total days in month: ' || nTotalDays ) ;
          END IF;
          /*  DBMS_OUTPUT.Put_Line( 'nDailyAmountPrior: ' || nDailyAmountPrior );
          DBMS_OUTPUT.Put_Line( 'nDaysInMonthPrior: ' || nDaysInMonthPrior );
          DBMS_OUTPUT.Put_Line( 'nDailyAmount: ' || nDailyAmount );
          DBMS_OUTPUT.Put_Line( 'nDaysInMonth: ' || nDaysInMonth );
          DBMS_OUTPUT.Put_Line( 'sMonthYearStart: ' || sMonthYearStart );
          DBMS_OUTPUT.Put_Line( 'nMonthAmount: ' || nMonthAmount );
          DBMS_OUTPUT.Put_Line( 'huTbl(i).total_usage_amount: ' || huTbl(i).total_usage_amount );
          DBMS_OUTPUT.Put_Line( 'huTbl(i).end_date: ' || huTbl(i).end_date );
          DBMS_OUTPUT.Put_Line( 'huTbl(i).start_date: ' || huTbl(i).start_date ); */
          --                    DBMS_OUTPUT.Put_Line( i );
        
          INSERT INTO service_monthly_usage
            (SERVICE_MONTHLY_USAGE_ID,
             SERVICE_ID,
             MONTH_YEAR,
             AMOUNT,
             UOM,
             HU_OR_MU,
             ENTERED_DATE,
             ENTERED_BY)
          VALUES
            (SEQ_SERVICE_MONTHLY_USAGE_ID.NEXTVAL,
             nServiceId,
             TO_DATE(sMonthYearStart, 'MON-YYYY'),
             ROUND(nMonthAmount, 5),
             huTbl(i).uom,
             'HU',
             SYSTIMESTAMP,
             sys_context('USERENV', 'SESSION_USER'));
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.Put_Line(SQLERRM);
        END;
      END LOOP;
    END LOOP;
  
    UPDATE MISC_PROCESS_LOG
    SET    max_id = nMaxHUId
    WHERE  process_name = 'CREATE_MONTHLY_USAGE_HU';
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
  END;
  /* -- prorate last month
   i := huTbl.count;
   nDailyAmount :=  huTbl(i).total_usage_amount / ( huTbl(i).end_date -  huTbl(i).start_date + 1) ; -- daily amount for each day in this period
   --nDaysInMonth := LAST_DAY(huTbl(i).start_date) - huTbl(i).start_date + 1;
   sMonthYearStart := to_char(huTbl(i).end_date,'MON-YYYY'); -- this is the month we are calculating and unserting
   nMonthAmount :=  nDailyAmount * ( LAST_DAY(huTbl(i).end_date) - ( to_date('1-' || to_char(huTbl(i).end_date,'MON-YYYY'))) + 1 );
   --nTotalDays := ( LAST_DAY(huTbl(i).start_date) - ( to_date('1-' || to_char(huTbl(i).start_date,'MON-YYYY'))) + 1 );
   --DBMS_OUTPUT.Put_Line( sMonthYearStart || ' When 1, total days in month: ' || nTotalDays ) ;
   insert into service_monthly_usage(
           SERVICE_MONTHLY_USAGE_ID,
           SERVICE_ID,
           MONTH_YEAR,
           AMOUNT,
           UOM,
           HU_OR_MU,
           ENTERED_DATE,
           ENTERED_BY)
  values ( SEQ_SERVICE_MONTHLY_USAGE_ID.NEXTVAL,
           nServiceId,
           TO_DATE(sMonthYearStart,'MON-YYYY'),
           ROUND(nMonthAmount,5),
           huTbl(i).uom,
           'HU',
           SYSTIMESTAMP,
           sys_context('USERENV', 'SESSION_USER')
                   );
   commit;*/

  /*
  if to_char(huTbl(i).start_date,'MON-YYYY') = to_char(huTbl(i).end_date,'MON-YYYY') then
      bSameMonth := true;
  else
      bSameMonth := false;
  end if; */

  -- Enter further code below as specified in the Package spec.
  ---------------------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_HU_OLD IS
    dNearestMonthToNowInHU   DATE;
    dNumberOfMonthsToProcess NUMBER;
  
    nCurrentServiceID SERVICE.SERVICE_ID%TYPE;
  
    dStartOfPeriod             DATE;
    dEndOfPeriod               DATE;
    nTotalNumberOfDaysInPeriod NUMBER;
    nTotalUsageInPeriod        NUMBER;
    nNumberOfRelevantDaysInSet NUMBER;
    nAverageDailyUseInSet      NUMBER;
    nAccumulatedNumberOfDays   NUMBER := 0;
    nAccumulatedUsage          NUMBER := 0;
    sUnitOfMeasure             VARCHAR2(25);
    sServiceType               SERVICE.Service_Type%TYPE;
  
    nIsReferenceProportion    VARCHAR2(1) := 0;
    nReferenceOnePercentUsage NUMBER := 0;
    nReferencePercentOfYear   NUMBER := 0;
    --    nDidWeManufacture varchar2(1);  --**Testing code
  
    CURSOR curHuService IS
      SELECT s.service_id,
             s.commodity,
             s.utl_id,
             s.hst_req_date,
             s.service_type
      FROM   service s
      WHERE  service_id IN
             (SELECT DISTINCT service_id
              FROM   inb_867_hu hu
              WHERE  hu.create_usage_processed_date = TO_DATE('1-JAN-1900'));
  
    CURSOR curHuRelevantRecs IS
      SELECT *
      FROM   inb_867_hu hu
      WHERE  ((UPPER(hu.commodity) = 'E' AND UPPER(hu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
             OR UPPER(hu.commodity) <> 'E')
             AND hu.start_date <= dEndOfPeriod
             AND hu.end_date > dStartOfPeriod
             AND service_id = nCurrentServiceID;
  
  BEGIN
    dNumberOfMonthsToProcess := 12; --change this if you ever want to guarantee more or less months of data
  
    FOR recHuService IN curHuService LOOP
      BEGIN
        BEGIN
          --USED TO CATCH ANY AND ALL EXCEPTIONS BELOW
          nCurrentServiceID := recHuService.Service_Id;
          --        nCurrentServiceID := 33964;   --**Testing code
        
          SELECT to_date('1-' || to_char(MAX(start_date), 'MON-YYYY')) --get the most recent month in hu and normalize to first of that month
          INTO   dNearestMonthToNowInHU
          FROM   inb_867_hu
          WHERE  service_id = nCurrentServiceID;
        
          FOR i IN 1 .. dNumberOfMonthsToProcess LOOP
            BEGIN
              --Get the start and end of the period we are concerned with. (We want to move backward from most recent to older)
              dStartOfPeriod := Add_Months(dNearestMonthToNowInHU,
                                           (i - 1) * -1);
              dEndOfPeriod   := LAST_DAY(dStartOfPeriod);
            
              --How many days in the period --last day is inclusive so +1  
              nTotalNumberOfDaysInPeriod := dEndOfPeriod - dStartOfPeriod + 1;
            
              --Run the cursor on the HU to get any rows that has data which overlaps this period (getting 2 is common)
              nAccumulatedNumberOfDays := 0;
              nAccumulatedUsage        := 0;
              --            nDidWeManufacture := 0;   --**Testing code
            
              FOR recHuRelevantRecs IN curHuRelevantRecs LOOP
                BEGIN
                  --Whats the average daily use?   --HU End_Dates are NOT inclusive so no +1 (they repeat on the following months record...)
                  nAverageDailyUseInSet := recHuRelevantRecs.Total_Usage_Amount /
                                           (recHuRelevantRecs.End_Date -
                                           recHuRelevantRecs.Start_Date);
                
                  --How many days in the set actually intersect with the period and therefore are relevant? 
                  nNumberOfRelevantDaysInSet := LEAST(dEndOfPeriod,
                                                      recHuRelevantRecs.End_Date - 1) -
                                                GREATEST(dStartOfPeriod,
                                                         recHuRelevantRecs.Start_Date) + 1;
                
                  --Accumulate what we can from this record and move on
                  nAccumulatedNumberOfDays := nAccumulatedNumberOfDays +
                                              nNumberOfRelevantDaysInSet;
                  nAccumulatedUsage        := nAccumulatedUsage +
                                              (nAverageDailyUseInSet *
                                              nNumberOfRelevantDaysInSet);
                
                  sUnitOfMeasure := recHuRelevantRecs.Uom;
                EXCEPTION
                  WHEN OTHERS THEN
                    GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                         ipsErrMessage            => SQLERRM,
                                         ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE_HU Inside recHuRelevantRecs LOOP',
                                         ipnErrCode               => SQLCODE,
                                         ipnServiceId             => nCurrentServiceID,
                                         ipsEnteredBy             => sys_context('USERENV',
                                                                                 'SESSION_USER'),
                                         ipsUtlAcctId             => recHuRelevantRecs.Utl_Acct_Id,
                                         ipsUtlId                 => recHuRelevantRecs.Utl_Id,
                                         ipsCommodity             => recHuRelevantRecs.Commodity);
                END;
              END LOOP;
            
              --Did we cover the whole month or so we need to manufacturer more days of usage based on averages?
              IF nAccumulatedNumberOfDays < nTotalNumberOfDaysInPeriod THEN
                --If we have "enough data" in this month we can jus prorate based on that otherwise we need to go back to the utility average use
                --define what "enough data" means in the predicate to the following if clause. However FF says that even one day is  better than the alternative.
                --               nDidWeManufacture := 1; --**Testing code
                IF nAccumulatedNumberOfDays > 0 THEN
                  nAverageDailyUseInSet      := nAverageDailyUseInSet /
                                                nAccumulatedNumberOfDays; --Manufactured daily use based on averages so far
                  nNumberOfRelevantDaysInSet := nTotalNumberOfDaysInPeriod -
                                                nAccumulatedNumberOfDays; --This is the amount of days we are missing
                  nAccumulatedUsage          := nAccumulatedUsage +
                                                (nAverageDailyUseInSet *
                                                nNumberOfRelevantDaysInSet);
                  --                  nAccumulatedNumberOfDays := nAccumulatedNumberOfDays + nNumberOfRelevantDaysInSet; --**Testing code
                ELSE
                  --Then use the ratio of this guys usage in a different month to determine what this months usage should be.
                  --PLEASE NOTE THAT THIS SHOULD NOT BE POSSIBLE TO OCCUR ON THE FIRST MONTH IN, SINCE IF WE ARE IN THIS PROC WE ARE GUARANTEED AT LEAST SOME REAL DATA
                
                  --get the average percentage this month represents 
                  SELECT CASE
                           WHEN UPPER(sServiceType) = 'RESIDENTIAL' THEN
                            u.res_pct_of_yr
                           ELSE
                            u.com_pct_of_yr
                         END
                  INTO   nReferencePercentOfYear
                  FROM   utl_usage_percentage u
                  WHERE  1 = 1
                         AND utl_id = recHuService.utl_id
                         AND commodity = recHuService.commodity
                         AND to_char(month_year, 'MON') =
                         to_char(trunc(dStartOfPeriod), 'MON')
                         AND rownum < 2
                  ORDER  BY u.month_year DESC;
                
                  --and multiply it by our established 1% Reference (see calc just below)
                  nAccumulatedUsage := nReferencePercentOfYear *
                                       nReferenceOnePercentUsage;
                  --                    nAccumulatedNumberOfDays := 0;    --**Testing code 
                END IF;
              END IF;
            
              --On First Month setup a reference proportion to total usage to be used in months where there is no data
              IF nIsReferenceProportion = 0 THEN
              
                --what percentage of the year does this month reflect in the average customer? 
              
                --residential/commercial?
                IF recHuService.Service_Type IS NULL THEN
                  SELECT st.service_class_default
                  INTO   sServiceType
                  FROM   settings st;
                ELSE
                  sServiceType := recHuService.Service_Type;
                END IF;
              
                SELECT CASE
                         WHEN UPPER(sServiceType) = 'RESIDENTIAL' THEN
                          u.res_pct_of_yr
                         ELSE
                          u.com_pct_of_yr
                       END
                INTO   nReferencePercentOfYear
                FROM   utl_usage_percentage u
                WHERE  1 = 1
                       AND utl_id = recHuService.utl_id
                       AND commodity = recHuService.commodity
                       AND to_char(month_year, 'MON') =
                       to_char(trunc(dStartOfPeriod), 'MON')
                       AND rownum < 2
                ORDER  BY u.month_year DESC;
              
                --what was this customers usage this month? Divide that by the percentage and your result is the reference one percent.
                nReferenceOnePercentUsage := nAccumulatedUsage /
                                             nReferencePercentOfYear;
              
                nIsReferenceProportion := 1;
              END IF;
            
              --one last adjustment, per ff we should make the date of month_year in to the past since some retarded utilities send future projections 
              --in place of hu's (like keyspanLI for example)
              WHILE dStartOfPeriod >
                    nvl(recHuService.Hst_Req_Date, SYSDATE) OR
                    LAST_DAY(dStartOfPeriod) >
                    nvl(recHuService.Hst_Req_Date, SYSDATE) --(Really last_day... would be enough but would not be obvious what the purpose was so...)
               LOOP
                dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -12); --roll year back by one until in the past.
              END LOOP;
            
              --we'll insert one month at a time, but the commit is for a whole service at a shot (see end of loop below)
              INSERT INTO SERVICE_MONTHLY_USAGE
                (SERVICE_MONTHLY_USAGE_ID,
                 SERVICE_ID,
                 MONTH_YEAR,
                 AMOUNT,
                 UOM,
                 HU_OR_MU,
                 ENTERED_DATE,
                 ENTERED_BY)
                SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
                       nCurrentServiceID,
                       dStartOfPeriod,
                       ROUND(nAccumulatedUsage, 5),
                       sUnitOfMeasure,
                       'HU',
                       SYSTIMESTAMP,
                       'CREATE_MONTHLY_USAGE_HU'
                FROM   DUAL;
              --            SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval, 33964, dStartOfPeriod, ROUND(nAccumulatedUsage,2) , nAccumulatedNumberOfDays, DECODE(nDidWeManufacture, 0, 'NO', 1, 'MN'), SYSDATE, 'CREATE_MONTHLY_USAGE_HU_SS' FROM DUAL;   --**Testing code
            END;
          END LOOP; --dNumberOfMonthsToProcess
        
          UPDATE inb_867_hu hu
          SET    hu.create_usage_processed_date = SYSDATE
          WHERE  hu.service_id = nCurrentServiceID;
        
          COMMIT; --This includes the records to the service_monthly_usage as well
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK; --Dont insert partial service monthly records...
            IF SQLCODE = -1 THEN
              -- FF/NM NOv/19/2014 since the record doen;t get updated we keep on getting the error again and again since th erecord
              -- comes up again and again so let's just get it out of the way for now... 
              UPDATE inb_867_hu h
              SET    h.create_usage_processed_date = '1-jan-1909'
              WHERE  service_id = nCurrentServiceID;
              COMMIT;
            END IF;
            GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                 ipsErrMessage            => SQLERRM,
                                 ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE_HU',
                                 ipnErrCode               => SQLCODE,
                                 ipnServiceId             => nCurrentServiceID,
                                 ipsEnteredBy             => sys_context('USERENV',
                                                                         'SESSION_USER'),
                                 ipsUtlAcctId             => '',
                                 ipsUtlId                 => '',
                                 ipsCommodity             => '');
        END;
      END;
    END LOOP;
  END;
  -------------------------------------------------------------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE IS
    dNearestMonthToNow         DATE := '01-Jan-1990';
    dNumberOfMonthsToProcess   NUMBER;
    dLastMonth                 DATE := '01-Jan-1990';
    dFirstMonth                DATE := '01-Jan-1990';
    nDaysInMonth               NUMBER;
    nCurrentServiceID          SERVICE.SERVICE_ID%TYPE;
    dStartOfPeriod             DATE;
    dEndOfPeriod               DATE;
    dLastOfMonth               DATE;
    nTotalNumberOfDaysInPeriod NUMBER;
    nNumberOfRelevantDaysInSet NUMBER;
    nAverageDailyUseInSet      NUMBER;
    nAccumulatedNumberOfDays   NUMBER := 0;
    nTotalAccumulatedDays      NUMBER := 0;
    nAccumulatedUsage          NUMBER := 0;
    sUnitOfMeasure             VARCHAR2(25);
    sServiceType               SERVICE.Service_Type%TYPE;
    sDefaultServiceType        SERVICE.Service_Type%TYPE;
    sHuOrMu                    VARCHAR2(2);
    nReferenceOnePercentUsage  NUMBER := 0;
    nReferencePercentOfYear    NUMBER := 0;
    bEntered                   BOOLEAN;
    dFirstDate                 DATE;
    dLastDate                  DATE;
    nAvgUsage                  NUMBER; -- FF May/9/2016
  
    CURSOR curService IS
    --selects info from service table where id has inb_867_mu/hu
      SELECT s.service_id,
             s.commodity,
             s.utl_id,
             s.hst_req_date,
             s.service_type
      FROM   service s
      WHERE  service_id IN (SELECT DISTINCT service_id
                            FROM   inb_867_mu mu
                            UNION
                            SELECT DISTINCT service_id
                            FROM   inb_867_hu hu)
      ORDER  BY s.service_id;
  
    CURSOR curRelevantRecs IS
    -- selects info from inb_867_mu/hu for a specific serviceID  AND   hu.start_date <= dLastOfMonth AND   hu.end_date> dStartOfPeriod
      SELECT 'HU' SOURCE_TABLE,
             hu.service_id,
             hu.start_date,
             hu.end_date,
             hu.total_usage_amount,
             hu.uom
      FROM   inb_867_hu hu
      WHERE  ((UPPER(hu.commodity) = 'E' AND UPPER(hu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
             OR UPPER(hu.commodity) <> 'E')
             AND hu.start_date <> hu.end_date
             AND hu.start_date <= dLastOfMonth
             AND hu.end_date > dStartOfPeriod
             AND service_id = nCurrentServiceID
             AND hu.uom IS NOT NULL
             AND hu.start_date IS NOT NULL
             AND hu.end_date IS NOT NULL
      UNION
      SELECT 'MU' SOURCE_TABLE,
             mu.service_id,
             mu.start_date,
             mu.end_date,
             mu.total_usage_amount,
             mu.uom
      FROM   inb_867_mu mu
      WHERE  ((UPPER(mu.commodity) = 'E' AND UPPER(mu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
             OR UPPER(mu.commodity) <> 'E')
             AND mu.start_date <= dLastOfMonth
             AND mu. end_date > dStartOfPeriod
             AND mu.service_id = nCurrentServiceID
             AND mu.uom IS NOT NULL
             AND mu.start_date IS NOT NULL
             AND mu.end_date IS NOT NULL;
  
  BEGIN
    --goes through each serviceID
    FOR recService IN curService LOOP
      BEGIN
        --sets value of :sDefaultServiceType to residential or commercial
        SELECT st.service_class_default
        INTO   sDefaultServiceType
        FROM   settings st;
        BEGIN
          --USED TO CATCH ANY AND ALL EXCEPTIONS BELOW
          nCurrentServiceID := recService.Service_Id;
          --    DBMS_OUTPUT.Put_Line('nxtSrvcId '||systimestamp);
          --Get the last month that exists in service_monthly_usage table
          SELECT MAX(month_year) --Select the most recent record already entered into service_monthly_usage with this service id
          INTO   dLastMonth
          FROM   SERVICE_MONTHLY_USAGE
          WHERE  service_id = nCurrentServiceID;
          ------------ FF trying to fix issue when MU comes before HU this thing is not working... but not resolved)
          /*SELECT LEAST(hu.myr,mu.myr) INTO dLastMonth from  
          (SELECT nvl(MAX(month_year),TRUNC(SYSDATE) - (25*12) ) myr --Select the most recent record already entered into service monthly usage with this service id
             --  INTO dLastMonth
          FROM SERVICE_MONTHLY_USAGE
               WHERE service_id = nCurrentServiceID
               AND   HU_OR_MU = 'HU'
          ) HU,
          
                 
          (SELECT MAX(month_year) myr --Select the most recent record already entered into service monthly usage with this service id
             --  INTO dLastMonth
          FROM SERVICE_MONTHLY_USAGE
               WHERE service_id = nCurrentServiceID
               AND   HU_OR_MU = 'MU'
          ) MU;  */
        
          ----------
          SELECT *
          INTO   dFirstDate
          FROM   (SELECT MIN(start_date) fDate
                  -- get the first (oldest) record with this service id from inb_867
                  FROM   inb_867_mu
                  WHERE  service_id = nCurrentServiceID
                  UNION
                  SELECT MIN(start_date) fDate -- get the first (oldest) record with this service id from inb_867
                  FROM   inb_867_hu
                  WHERE  service_id = nCurrentServiceID
                  ORDER  BY 1)
          WHERE  fDate IS NOT NULL
                 AND rownum < 2;
          SELECT *
          INTO   dLastDate
          FROM   (SELECT MAX(start_date) msDate
                  --get the most recent month in mu and normalize to first of that month
                  FROM   inb_867_mu
                  WHERE  service_id = nCurrentServiceID
                  UNION
                  SELECT MAX(start_date) msDate --get the most recent month in mu and normalize to first of that month
                  FROM   inb_867_hu
                  WHERE  service_id = nCurrentServiceID
                  ORDER  BY 1 DESC)
          WHERE  msDate IS NOT NULL
                 AND rownum < 2;
          IF dFirstDate IS NOT NULL THEN
            SELECT to_date('1-' || to_char(MIN(dFirstDate), 'MON-YYYY'))
            INTO   dFirstMonth
            FROM   dual;
            SELECT to_date('1-' || to_char(MAX(dLastDate), 'MON-YYYY'))
            INTO   dNearestMonthToNow
            FROM   dual;
          END IF;
          IF dLastMonth IS NOT NULL THEN
            --there already exists at least one record with this service id in service monthly usage
            SELECT months_between((add_months(dNearestMonthToNow, 1)),
                                  dLastMonth)
            INTO   dNumberOfMonthsToProcess
            FROM   dual;
          ELSE
            --this service id is not yet found in service monthly usage table
            SELECT months_between((add_months(dNearestMonthToNow, 1)),
                                  dFirstMonth)
            INTO   dNumberOfMonthsToProcess
            FROM   dual;
          END IF;
          FOR i IN 1 .. dNumberOfMonthsToProcess LOOP
            BEGIN
              bEntered := NULL;
              --Get the start and end of the period we are concerned with. (We want to move backward from most recent to older)
              dStartOfPeriod := Add_Months(dNearestMonthToNow, (i - 1) * -1);
              dEndOfPeriod   := LAST_DAY(dStartOfPeriod);
              dLastOfMonth   := LAST_DAY(dStartOfPeriod);
              --Run the cursor on the mu to get any rows that has data which overlaps this period (getting 2 is common)
              nAccumulatedNumberOfDays := 0;
              nAccumulatedUsage        := 0;
              IF dLastMonth IS NULL OR dStartOfPeriod <> dLastMonth THEN
                IF dFirstMonth <= dStartOfPeriod THEN
                  FOR recRelevantRecs IN curRelevantRecs LOOP
                    --  DBMS_OUTPUT.Put_Line('relevant recs loop '||systimestamp); 
                    BEGIN
                      IF nTotalAccumulatedDays = 0 THEN
                        -- first record of this service id
                        dEndOfPeriod := LAST_DAY(recRelevantRecs.End_Date);
                      ELSE
                        dEndOfPeriod := LAST_DAY(ADD_MONTHS(recRelevantRecs.End_Date,
                                                            -1));
                      END IF;
                      SELECT CAST(recRelevantRecs.Source_Table AS
                                  VARCHAR2(2))
                      INTO   sHuOrMu
                      FROM   dual;
                      nTotalNumberOfDaysInPeriod := dEndOfPeriod -
                                                    dStartOfPeriod + 1;
                      dLastOfMonth               := LAST_DAY(dStartOfPeriod);
                      --How many days in the period --last day is inclusive so +1
                      SELECT (dLastOfMonth - dStartOfPeriod) + 1
                      INTO   nDaysInMonth
                      FROM   dual;
                      IF (recRelevantRecs.Start_Date = dStartOfPeriod) AND
                         ((recRelevantRecs.End_Date - 1) = dLastOfMonth) THEN
                        nAccumulatedUsage := recRelevantRecs.Total_Usage_Amount;
                        IF recRelevantRecs.Uom IS NULL THEN
                          BEGIN
                            SELECT uom
                            INTO   sUnitOfMeasure
                            FROM   inb_867_hu
                            WHERE  uom IS NOT NULL
                                   AND service_id = nCurrentServiceID
                                   AND ROWNUM < 2;
                          EXCEPTION
                            WHEN no_data_found THEN
                              BEGIN
                                SELECT uom
                                INTO   sUnitOfMeasure
                                FROM   inb_867_mu
                                WHERE  uom IS NOT NULL
                                       AND service_id = nCurrentServiceID
                                       AND ROWNUM < 2;
                              EXCEPTION
                                WHEN no_data_found THEN
                                  ROLLBACK; --Dont insert partial service monthly records...
                                  GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                                       ipsErrMessage            => SQLERRM,
                                                       ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE',
                                                       ipnErrCode               => SQLCODE,
                                                       ipnServiceId             => nCurrentServiceID,
                                                       ipsEnteredBy             => sys_context('USERENV',
                                                                                               'SESSION_USER'),
                                                       ipsUtlAcctId             => '',
                                                       ipsUtlId                 => '',
                                                       ipsCommodity             => '');
                              END;
                          END;
                        ELSE
                          sUnitOfMeasure := recRelevantRecs.Uom;
                        END IF;
                        nAccumulatedNumberOfDays := nDaysInMonth;
                      ELSE
                        --Whats the average daily use?   --mu End_Dates are NOT inclusive so no +1 (they repeat on the following months record...)
                        IF (recRelevantRecs.End_Date -
                           recRelevantRecs.Start_Date) > 0 THEN
                          -- if month is swallowed within record can't calculate avg daily use in set with this equation.
                          nAverageDailyUseInSet := recRelevantRecs.Total_Usage_Amount /
                                                   (recRelevantRecs.End_Date -
                                                   recRelevantRecs.Start_Date);
                        END IF;
                        --How many days in the set actually intersect with the period and therefore are relevant?
                        IF to_char(dStartOfPeriod, 'MON') <>
                           to_char(recRelevantRecs.Start_Date, 'MON') AND
                           to_char(dLastOfMonth, 'MON') <>
                           to_char(recRelevantRecs.End_Date, 'MON') THEN
                          nNumberOfRelevantDaysInSet := nDaysInMonth;
                        ELSIF (dLastOfMonth) = (recRelevantRecs.Start_Date) THEN
                          nNumberOfRelevantDaysInSet := 1;
                        ELSE
                          nNumberOfRelevantDaysInSet := LEAST(dLastOfMonth,
                                                              recRelevantRecs.End_Date + 1) -
                                                        GREATEST(dStartOfPeriod,
                                                                 recRelevantRecs.Start_Date);
                        END IF;
                        nTotalAccumulatedDays := nTotalAccumulatedDays +
                                                 nNumberOfRelevantDaysInSet;
                        --Accumulate what we can from this record and move on
                        nAccumulatedNumberOfDays := nAccumulatedNumberOfDays +
                                                    nNumberOfRelevantDaysInSet;
                        nAccumulatedUsage        := nAccumulatedUsage +
                                                    (nAverageDailyUseInSet *
                                                    nNumberOfRelevantDaysInSet);
                        IF recRelevantRecs.Uom IS NULL THEN
                          BEGIN
                            SELECT uom
                            INTO   sUnitOfMeasure
                            FROM   inb_867_hu
                            WHERE  uom IS NOT NULL
                                   AND service_id = nCurrentServiceID
                                   AND ROWNUM < 2;
                          EXCEPTION
                            WHEN no_data_found THEN
                              BEGIN
                                SELECT uom
                                INTO   sUnitOfMeasure
                                FROM   inb_867_mu m
                                WHERE  uom IS NOT NULL
                                       AND service_id = nCurrentServiceID
                                       AND ROWNUM < 2;
                              EXCEPTION
                                WHEN no_data_found THEN
                                  ROLLBACK; --Dont insert partial service monthly records...
                                  GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                                       ipsErrMessage            => SQLERRM,
                                                       ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE',
                                                       ipnErrCode               => SQLCODE,
                                                       ipnServiceId             => nCurrentServiceID,
                                                       ipsEnteredBy             => sys_context('USERENV',
                                                                                               'SESSION_USER'),
                                                       ipsUtlAcctId             => '',
                                                       ipsUtlId                 => '',
                                                       ipsCommodity             => '');
                              END;
                          END;
                        ELSE
                          sUnitOfMeasure := recRelevantRecs.Uom;
                        END IF;
                        IF nAccumulatedNumberOfDays > nDaysInMonth THEN
                          nAccumulatedUsage := nAverageDailyUseInSet *
                                               nDaysInMonth;
                        END IF;
                      END IF;
                      IF (nAccumulatedNumberOfDays >= nDaysInMonth) THEN
                        -- we have full month with real data                             
                        --now insert data
                        IF bEntered IS NULL THEN
                          --              DBMS_OUTPUT.Put_Line('insert complete '||systimestamp);
                          INSERT INTO SERVICE_MONTHLY_USAGE
                            (SERVICE_MONTHLY_USAGE_ID,
                             SERVICE_ID,
                             MONTH_YEAR,
                             AMOUNT,
                             UOM,
                             HU_OR_MU,
                             ENTERED_DATE,
                             ENTERED_BY,
                             SOURCE_OF_CALCULATION)
                            SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
                                   nCurrentServiceID,
                                   dStartOfPeriod,
                                   ROUND(nAccumulatedUsage, 5),
                                   sUnitOfMeasure,
                                   sHuOrMu,
                                   SYSTIMESTAMP,
                                   'CREATE_MONTHLY_USAGE',
                                   'COMPLETE_MONTH'
                            FROM   DUAL;
                          bEntered                 := TRUE;
                          nAccumulatedNumberOfDays := 0;
                          --adjust start date to next month and reset # of days and accumulated usage to 0
                          dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -1);
                        END IF;
                      END IF;
                    END; --FOR recRelevantRecs IN curRelevantRecs LOOP
                  END LOOP;
                
                  --Did we cover the whole month or so we need to manufacturer more days of usage based on averages?
                  IF (nAccumulatedNumberOfDays < nDaysInMonth) AND
                     sUnitOfMeasure IS NOT NULL THEN
                    --If we have "enough data" in this month we can jus prorate based on that otherwise we need to go back to the utility average use
                    --define what "enough data" means in the predicate to the following if clause. However FF says that even one day is  better than the alternative.
                    IF nAccumulatedNumberOfDays > 0 THEN
                      --we have some data for this month
                      nAverageDailyUseInSet      := nAverageDailyUseInSet /
                                                    nAccumulatedNumberOfDays; --Manufactured daily use based on averages so far
                      nNumberOfRelevantDaysInSet := nDaysInMonth -
                                                    nAccumulatedNumberOfDays; --This is the amount of days we are missing
                      nAccumulatedUsage          := nAccumulatedUsage +
                                                    (nAverageDailyUseInSet *
                                                    nNumberOfRelevantDaysInSet);
                      IF bEntered IS NULL THEN
                        --   DBMS_OUTPUT.Put_Line('insert partial '||systimestamp); 
                        INSERT INTO SERVICE_MONTHLY_USAGE
                          (SERVICE_MONTHLY_USAGE_ID,
                           SERVICE_ID,
                           MONTH_YEAR,
                           AMOUNT,
                           UOM,
                           HU_OR_MU,
                           ENTERED_DATE,
                           ENTERED_BY,
                           SOURCE_OF_CALCULATION)
                          SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
                                 nCurrentServiceID,
                                 dStartOfPeriod,
                                 ROUND(nAccumulatedUsage, 5),
                                 sUnitOfMeasure,
                                 sHuOrMu,
                                 SYSTIMESTAMP,
                                 'CREATE_MONTHLY_USAGE',
                                 'PARTIAL_MONTH'
                          FROM   DUAL;
                        bEntered := TRUE;
                        --adjust start date to next month and reset # of days and accumulated usage to 0
                        dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -1);
                      END IF;
                    ELSE
                      --we have no data for this month
                      --Then use the ratio of this guys usage in a different month to determine what this months usage should be.
                      --PLEASE NOTE THAT THIS SHOULD NOT BE POSSIBLE TO OCCUR ON THE FIRST MONTH IN, SINCE IF WE ARE IN THIS PROC WE ARE GUARANTEED AT LEAST SOME REAL DATA
                      -- IF nIsReferenceProportion = 0 THEN
                      --what percentage of the year does this month reflect in the average customer?
                      --residential/commercial?
                      IF recService.Service_Type IS NULL THEN
                        SELECT st.service_class_default
                        INTO   sServiceType
                        FROM   settings st;
                      ELSE
                        sServiceType := recService.Service_Type;
                      END IF;
                      BEGIN
                        -- FF May 6 2016 make sure it doesn;t just error out of we don't have the data in utl_usage_percentage 
                        SELECT CASE
                                 WHEN UPPER(sServiceType) = 'RESIDENTIAL' THEN
                                  u.res_pct_of_yr
                                 ELSE
                                  u.com_pct_of_yr
                               END
                        INTO   nReferencePercentOfYear
                        FROM   utl_usage_percentage u
                        WHERE  1 = 1
                               AND utl_id = recService.utl_id
                               AND commodity = recService.commodity
                               AND to_char(month_year, 'MON') =
                               to_char(dStartOfPeriod, 'MON')
                               AND rownum < 2
                        ORDER  BY u.month_year DESC;
                      EXCEPTION
                        WHEN OTHERS THEN
                          -- if we don;t have the data in utl_usage_percentage
                          -- at least, not to error out we will approximate and set the percentage 
                          -- the avergae of all the date we have.
                          SELECT AVG(usg)
                          INTO   nAvgUsage
                          FROM   (SELECT hu.total_usage_amount usg
                                  FROM   inb_867_hu hu
                                  WHERE  ((UPPER(hu.commodity) = 'E' AND
                                         UPPER(hu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
                                         OR UPPER(hu.commodity) <> 'E')
                                         AND service_id = nCurrentServiceID
                                  UNION ALL
                                  SELECT mu.total_usage_amount usg
                                  FROM   inb_867_mu mu
                                  WHERE  ((UPPER(mu.commodity) = 'E' AND
                                         UPPER(mu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
                                         OR UPPER(mu.commodity) <> 'E')
                                         AND service_id = nCurrentServiceID);
                        
                      END;
                      /*                            SELECT amount INTO nAccumulatedUsage FROM
                          (
                              SELECT month_year, amount 
                              FROM SERVICE_MONTHLY_USAGE
                              WHERE service_id = nCurrentServiceID
                              AND month_year = add_months(dStartOfPeriod, 1)                      
                          );
                      IF nAccumulatedUsage <= 0 THEN -- FF May/6/2016 make sure that we get an amount no mather what.
                         nAccumulatedUsage := nAnyUsageAmount;                         
                      END IF;
                      IF nReferenceOnePercentUsage > 0 THEN
                          nAccumulatedUsage := nAccumulatedUsage / nReferenceOnePercentUsage;
                      ELSE 
                          nAccumulatedUsage := nAccumulatedUsage / nReferencePercentOfYear;
                      END IF;*/
                      --what was this customers usage this month? Divide that by the percentage and your result is the reference one percent.
                      nReferenceOnePercentUsage :=  /*nAccumulatedUsage /*/
                       nReferencePercentOfYear;
                      --once we set proportion, change value to 1 so will never recalculate for this service id
                      /* 
                              nIsReferenceProportion := 1;
                          END IF;
                      END IF;*/
                      --and multiply it by our established 1% Reference (see calc just below)
                      IF nAvgUsage = 0 THEN
                        -- FF May/9/2016 -- added this so if needed to resort to avergae, that is what we should insert in table;
                        nAccumulatedUsage := nReferencePercentOfYear *
                                             nAccumulatedUsage /*nReferenceOnePercentUsage*/
                         ;
                      ELSE
                        nAccumulatedUsage := nAvgUsage;
                      END IF;
                      IF bEntered IS NULL THEN
                        --    DBMS_OUTPUT.Put_Line('insert avg '||systimestamp); 
                        --insert this calculated data into database if it does not already exist
                        INSERT INTO SERVICE_MONTHLY_USAGE
                          (SERVICE_MONTHLY_USAGE_ID,
                           SERVICE_ID,
                           MONTH_YEAR,
                           AMOUNT,
                           UOM,
                           HU_OR_MU,
                           ENTERED_DATE,
                           ENTERED_BY,
                           SOURCE_OF_CALCULATION)
                          SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
                                 nCurrentServiceID,
                                 dStartOfPeriod,
                                 ROUND(nAccumulatedUsage, 5),
                                 sUnitOfMeasure,
                                 sHuOrMu,
                                 SYSTIMESTAMP,
                                 'CREATE_MONTHLY_USAGE',
                                 'FROM_AVERAGE'
                          FROM   DUAL;
                        bEntered := TRUE;
                        --adjust start date to next month and reset # of days and accumulated usage to 0
                        dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -1);
                      END IF;
                    END IF;
                    --On First Month setup a reference proportion to total usage to be used in months where there is no data
                  
                  END IF;
                  --one last adjustment, per ff we should make the date of month_year in to the past since some retarded utilities send future projections
                  --in place of mu's (like keyspanLI for example)
                  WHILE dStartOfPeriod > SYSDATE LOOP
                    dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -12); --roll year back by one until in the past.
                  END LOOP;
                  --we'll insert one month at a time, but the commit is for a whole service at a shot (see end of loop below)
                END IF;
              END IF;
            END;
          END LOOP; --dNumberOfMonthsToProcess
        
          COMMIT; --This includes the records to the service_monthly_usage as well
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK; --Dont insert partial service monthly records...
            IF sUnitOfMeasure IS NOT NULL THEN
              GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                   ipsErrMessage            => SQLERRM,
                                   ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE',
                                   ipnErrCode               => SQLCODE,
                                   ipnServiceId             => nCurrentServiceID,
                                   ipsEnteredBy             => sys_context('USERENV',
                                                                           'SESSION_USER'),
                                   ipsUtlAcctId             => '',
                                   ipsUtlId                 => '',
                                   ipsCommodity             => '');
            END IF;
        END;
        nTotalAccumulatedDays := 0; --resets for each service id
      END;
    END LOOP;
  END;

  ----------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_YB_12_17 IS
    dNearestMonthToNow         DATE := '01-Jan-1990';
    dNumberOfMonthsToProcess   NUMBER;
    dLastMonth                 DATE := '01-Jan-1990';
    dFirstMonth                DATE := '01-Jan-1990';
    nDaysInMonth               NUMBER;
    nCurrentServiceID          SERVICE.SERVICE_ID%TYPE;
    dStartOfPeriod             DATE;
    dEndOfPeriod               DATE;
    dLastOfMonth               DATE;
    nTotalNumberOfDaysInPeriod NUMBER;
    nNumberOfRelevantDaysInSet NUMBER;
    nAverageDailyUseInSet      NUMBER;
    nAccumulatedNumberOfDays   NUMBER := 0;
    nTotalAccumulatedDays      NUMBER := 0;
    nAccumulatedUsage          NUMBER := 0;
    sUnitOfMeasure             VARCHAR2(25);
    sServiceType               SERVICE.Service_Type%TYPE;
    sDefaultServiceType        SERVICE.Service_Type%TYPE;
    sHuOrMu                    VARCHAR2(2);
    nReferenceOnePercentUsage  NUMBER := 0;
    nReferencePercentOfYear    NUMBER := 0;
    bEntered                   BOOLEAN;
    dFirstDate                 DATE;
    dLastDate                  DATE;
    nAvgUsage                  NUMBER; -- FF May/9/2016
  
    CURSOR curService IS
    --selects info from service table where id has inb_867_mu/hu
      SELECT s.service_id,
             s.commodity,
             s.utl_id,
             s.hst_req_date,
             s.service_type
      FROM   service s
      WHERE  service_id IN (SELECT DISTINCT service_id
                            FROM   inb_867_mu mu
                            UNION
                            SELECT DISTINCT service_id
                            FROM   inb_867_hu hu)
      ORDER  BY s.service_id;
  
    CURSOR curRelevantRecs IS
    -- used to select info from inb_867_mu/hu for a specific serviceID
    -- for one specific month period  
    --AND   hu.start_date <= dLastOfMonth AND   hu.end_date> dStartOfPeriod...
    --... i.e. at least part of usage period overlapps "PERIOD"
      SELECT 'HU' SOURCE_TABLE,
             hu.service_id,
             hu.start_date,
             hu.end_date,
             hu.total_usage_amount,
             hu.uom
      FROM   inb_867_hu hu
      WHERE  ((UPPER(hu.commodity) = 'E' AND UPPER(hu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
             OR UPPER(hu.commodity) <> 'E')
             AND hu.start_date <> hu.end_date
             AND hu.start_date <= dLastOfMonth
             AND hu.end_date > dStartOfPeriod
             AND service_id = nCurrentServiceID
             AND hu.uom IS NOT NULL
             AND hu.start_date IS NOT NULL
             AND hu.end_date IS NOT NULL
      UNION
      SELECT 'MU' SOURCE_TABLE,
             mu.service_id,
             mu.start_date,
             mu.end_date,
             mu.total_usage_amount,
             mu.uom
      FROM   inb_867_mu mu
      WHERE  ((UPPER(mu.commodity) = 'E' AND UPPER(mu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
             OR UPPER(mu.commodity) <> 'E')
             AND mu.start_date <= dLastOfMonth
             AND mu. end_date > dStartOfPeriod
             AND mu.service_id = nCurrentServiceID
             AND mu.uom IS NOT NULL
             AND mu.start_date IS NOT NULL
             AND mu.end_date IS NOT NULL;
  
  BEGIN
    --goes through each serviceID
    FOR recService IN curService LOOP
      BEGIN
        --sets value of :sDefaultServiceType to residential or commercial
        SELECT st.service_class_default
        INTO   sDefaultServiceType
        FROM   settings st; --?? YB ? why is this inside the loop?
        BEGIN
          --USED TO CATCH ANY AND ALL EXCEPTIONS BELOW
          nCurrentServiceID := recService.Service_Id;
          --    DBMS_OUTPUT.Put_Line('nxtSrvcId '||systimestamp);
          --Get the last month that exists in service_monthly_usage table
          SELECT MAX(month_year) --Select the most recent record already entered into service_monthly_usage with this service id
          INTO   dLastMonth
          FROM   SERVICE_MONTHLY_USAGE
          WHERE  service_id = nCurrentServiceID;
          ------------ FF trying to fix issue when MU comes before HU this thing is not working... but not resolved)
          /*SELECT LEAST(hu.myr,mu.myr) INTO dLastMonth from  
          (SELECT nvl(MAX(month_year),TRUNC(SYSDATE) - (25*12) ) myr --Select the most recent record already entered into service monthly usage with this service id
             --  INTO dLastMonth
          FROM SERVICE_MONTHLY_USAGE
               WHERE service_id = nCurrentServiceID
               AND   HU_OR_MU = 'HU'
          ) HU,
          
                 
          (SELECT MAX(month_year) myr --Select the most recent record already entered into service monthly usage with this service id
             --  INTO dLastMonth
          FROM SERVICE_MONTHLY_USAGE
               WHERE service_id = nCurrentServiceID
               AND   HU_OR_MU = 'MU'
          ) MU;  */
        
          ----------
          SELECT *
          INTO   dFirstDate
          FROM   (SELECT MIN(start_date) fDate
                  -- get the first (oldest) record with this service id from inb_867
                  FROM   inb_867_mu
                  WHERE  service_id = nCurrentServiceID
                  UNION
                  SELECT MIN(start_date) fDate -- get the first (oldest) record with this service id from inb_867
                  FROM   inb_867_hu
                  WHERE  service_id = nCurrentServiceID
                  ORDER  BY 1)
          WHERE  fDate IS NOT NULL
                 AND rownum < 2;
          SELECT *
          INTO   dLastDate
          FROM   (SELECT MAX(start_date) msDate
                  --get the most recent month in mu ?? and normalize to first of that month?? YB
                  FROM   inb_867_mu
                  WHERE  service_id = nCurrentServiceID
                  UNION
                  SELECT MAX(start_date) msDate --get the most recent month in mu and normalize to first of that month
                  FROM   inb_867_hu
                  WHERE  service_id = nCurrentServiceID
                  ORDER  BY 1 DESC)
          WHERE  msDate IS NOT NULL
                 AND rownum < 2;
          IF dFirstDate IS NOT NULL THEN
            SELECT to_date('1-' || to_char(MIN(dFirstDate), 'MON-YYYY'))
            INTO   dFirstMonth
            FROM   dual; --??MIN?? YB
            SELECT to_date('1-' || to_char(MAX(dLastDate), 'MON-YYYY'))
            INTO   dNearestMonthToNow
            FROM   dual; --??MAX?? YB
          END IF;
          IF dLastMonth IS NOT NULL THEN
            --there already exists at least one record with this service id in service_monthly_usage
            --dLastMonth: = month of last record in service_monthly_usage table
            --dNearestMonthToNow:   source=inb_867_MU/HU
            SELECT months_between((add_months(dNearestMonthToNow, 1)),
                                  dLastMonth)
            INTO   dNumberOfMonthsToProcess
            FROM   dual;
          ELSE
            --this service id is not yet found in service monthly usage table
            -- dFirstMonth             source=inb_867_MU/HU
            --dNearestMonthToNow:     source=inb_867_MU/HU
            SELECT months_between((add_months(dNearestMonthToNow, 1)),
                                  dFirstMonth)
            INTO   dNumberOfMonthsToProcess
            FROM   dual;
          END IF;
          --looping through dNumberOfMonthsToProcess      
          FOR i IN 1 .. dNumberOfMonthsToProcess LOOP
            BEGIN
              bEntered := NULL;
              --Get the start and end of the period we are concerned with. (We want to move backward from most recent to older)
              --dNearestMonthToNow  =   last start month in inb_867_MU/HU (for current serviceID)         
              dStartOfPeriod := Add_Months(dNearestMonthToNow, (i - 1) * -1);
              dEndOfPeriod   := LAST_DAY(dStartOfPeriod); --?? YB
              dLastOfMonth   := LAST_DAY(dStartOfPeriod); --?? YB
            
              nAccumulatedNumberOfDays := 0;
              nAccumulatedUsage        := 0;
            
              --dLastMonth = month of last record in service_monthly_usage table
              --dStartOfPeriod = first day of month we are currently concerned with
              --dFirstMonth = month of first record in service_monthly_usage table
            
              IF dLastMonth IS NULL OR dStartOfPeriod <> dLastMonth THEN
                --if last record in s_m_u IS the current month...
                -- ... END -> FOR i IN 1..dNumberOfMonthsToProcess LOOP & END -> FOR recService IN curService LOOP, move on to... 
                -- ...in other words move on to next service id...
                --... otherwise ...
              
                --dFirstMonth = date of first record in inb_867_MU/HU    
                IF dFirstMonth <= dStartOfPeriod THEN
                  -- if first record in s_m_u is earlier or = to current month
                
                  --Run a cursor on the hu/mu to get any rows that has data which overlaps this period (getting 2 is common)
                  FOR recRelevantRecs IN curRelevantRecs LOOP
                    --  DBMS_OUTPUT.Put_Line('relevant recs loop '||systimestamp); 
                    BEGIN
                      IF nTotalAccumulatedDays = 0 THEN
                        -- first record of this service id for "current period"
                        dEndOfPeriod := LAST_DAY(recRelevantRecs.End_Date);
                      ELSE
                        dEndOfPeriod := LAST_DAY(ADD_MONTHS(recRelevantRecs.End_Date,
                                                            -1));
                      END IF;
                      SELECT CAST(recRelevantRecs.Source_Table AS
                                  VARCHAR2(2))
                      INTO   sHuOrMu
                      FROM   dual;
                      nTotalNumberOfDaysInPeriod := dEndOfPeriod -
                                                    dStartOfPeriod + 1;
                      dLastOfMonth               := LAST_DAY(dStartOfPeriod);
                      --How many days in the period --last day is inclusive so +1
                      SELECT (dLastOfMonth - dStartOfPeriod) + 1
                      INTO   nDaysInMonth
                      FROM   dual;
                      IF (recRelevantRecs.Start_Date = dStartOfPeriod) AND
                         ((recRelevantRecs.End_Date - 1) = dLastOfMonth) THEN
                        nAccumulatedUsage := recRelevantRecs.Total_Usage_Amount;
                        IF recRelevantRecs.Uom IS NULL THEN
                          BEGIN
                            SELECT uom
                            INTO   sUnitOfMeasure
                            FROM   inb_867_hu
                            WHERE  uom IS NOT NULL
                                   AND service_id = nCurrentServiceID
                                   AND ROWNUM < 2;
                          EXCEPTION
                            WHEN no_data_found THEN
                              BEGIN
                                SELECT uom
                                INTO   sUnitOfMeasure
                                FROM   inb_867_mu
                                WHERE  uom IS NOT NULL
                                       AND service_id = nCurrentServiceID
                                       AND ROWNUM < 2;
                              EXCEPTION
                                WHEN no_data_found THEN
                                  ROLLBACK; --Dont insert partial service monthly records...
                                  GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                                       ipsErrMessage            => SQLERRM,
                                                       ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE',
                                                       ipnErrCode               => SQLCODE,
                                                       ipnServiceId             => nCurrentServiceID,
                                                       ipsEnteredBy             => sys_context('USERENV',
                                                                                               'SESSION_USER'),
                                                       ipsUtlAcctId             => '',
                                                       ipsUtlId                 => '',
                                                       ipsCommodity             => '');
                              END;
                          END;
                        ELSE
                          sUnitOfMeasure := recRelevantRecs.Uom;
                        END IF;
                        nAccumulatedNumberOfDays := nDaysInMonth;
                      ELSE
                        --Whats the average daily use?   --mu End_Dates are NOT inclusive so no +1 (they repeat on the following months record...)
                        IF (recRelevantRecs.End_Date -
                           recRelevantRecs.Start_Date) > 0 THEN
                          -- if month is swallowed within record can't calculate avg daily use in set with this equation.
                          nAverageDailyUseInSet := recRelevantRecs.Total_Usage_Amount /
                                                   (recRelevantRecs.End_Date -
                                                   recRelevantRecs.Start_Date);
                        END IF;
                        --How many days in the set actually intersect with the period and therefore are relevant?
                        IF to_char(dStartOfPeriod, 'MON') <>
                           to_char(recRelevantRecs.Start_Date, 'MON') AND
                           to_char(dLastOfMonth, 'MON') <>
                           to_char(recRelevantRecs.End_Date, 'MON') THEN
                          nNumberOfRelevantDaysInSet := nDaysInMonth;
                        ELSIF (dLastOfMonth) = (recRelevantRecs.Start_Date) THEN
                          nNumberOfRelevantDaysInSet := 1;
                        ELSE
                          nNumberOfRelevantDaysInSet := LEAST(dLastOfMonth,
                                                              recRelevantRecs.End_Date + 1) -
                                                        GREATEST(dStartOfPeriod,
                                                                 recRelevantRecs.Start_Date);
                        END IF;
                        nTotalAccumulatedDays := nTotalAccumulatedDays +
                                                 nNumberOfRelevantDaysInSet;
                        --Accumulate what we can from this record and move on
                        nAccumulatedNumberOfDays := nAccumulatedNumberOfDays +
                                                    nNumberOfRelevantDaysInSet;
                        nAccumulatedUsage        := nAccumulatedUsage +
                                                    (nAverageDailyUseInSet *
                                                    nNumberOfRelevantDaysInSet);
                        IF recRelevantRecs.Uom IS NULL THEN
                          BEGIN
                            SELECT uom
                            INTO   sUnitOfMeasure
                            FROM   inb_867_hu
                            WHERE  uom IS NOT NULL
                                   AND service_id = nCurrentServiceID
                                   AND ROWNUM < 2;
                          EXCEPTION
                            WHEN no_data_found THEN
                              BEGIN
                                SELECT uom
                                INTO   sUnitOfMeasure
                                FROM   inb_867_mu m
                                WHERE  uom IS NOT NULL
                                       AND service_id = nCurrentServiceID
                                       AND ROWNUM < 2;
                              EXCEPTION
                                WHEN no_data_found THEN
                                  ROLLBACK; --Dont insert partial service monthly records...
                                  GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                                       ipsErrMessage            => SQLERRM,
                                                       ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE',
                                                       ipnErrCode               => SQLCODE,
                                                       ipnServiceId             => nCurrentServiceID,
                                                       ipsEnteredBy             => sys_context('USERENV',
                                                                                               'SESSION_USER'),
                                                       ipsUtlAcctId             => '',
                                                       ipsUtlId                 => '',
                                                       ipsCommodity             => '');
                              END;
                          END;
                        ELSE
                          sUnitOfMeasure := recRelevantRecs.Uom;
                        END IF;
                        IF nAccumulatedNumberOfDays > nDaysInMonth THEN
                          nAccumulatedUsage := nAverageDailyUseInSet *
                                               nDaysInMonth;
                        END IF;
                      END IF;
                      IF (nAccumulatedNumberOfDays >= nDaysInMonth) THEN
                        -- we have full month with real data                             
                        --now insert data
                        IF bEntered IS NULL THEN
                          --              DBMS_OUTPUT.Put_Line('insert complete '||systimestamp);
                          INSERT INTO SERVICE_MONTHLY_USAGE
                            (SERVICE_MONTHLY_USAGE_ID,
                             SERVICE_ID,
                             MONTH_YEAR,
                             AMOUNT,
                             UOM,
                             HU_OR_MU,
                             ENTERED_DATE,
                             ENTERED_BY,
                             SOURCE_OF_CALCULATION)
                            SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
                                   nCurrentServiceID,
                                   dStartOfPeriod,
                                   ROUND(nAccumulatedUsage, 5),
                                   sUnitOfMeasure,
                                   sHuOrMu,
                                   SYSTIMESTAMP,
                                   'CREATE_MONTHLY_USAGE_YB_12_17',
                                   'COMPLETE_MONTH'
                            FROM   DUAL;
                          bEntered                 := TRUE;
                          nAccumulatedNumberOfDays := 0;
                          --adjust start date to next month and reset # of days and accumulated usage to 0
                          dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -1);
                        END IF;
                      END IF;
                    END; --FOR recRelevantRecs IN curRelevantRecs LOOP
                  END LOOP;
                
                  --Did we cover the whole month or not so we need to manufacturer more days of usage based on averages?
                  IF (nAccumulatedNumberOfDays < nDaysInMonth) AND
                     sUnitOfMeasure IS NOT NULL THEN
                    --If we have "enough data" in this month we can jus prorate based on that otherwise we need to go back to the utility average use
                    --define what "enough data" means in the predicate to the following if clause. However FF says that even one day is  better than the alternative.
                    IF nAccumulatedNumberOfDays > 0 THEN
                      --we have some data for this month
                      nAverageDailyUseInSet      := nAverageDailyUseInSet /
                                                    nAccumulatedNumberOfDays; --Manufactured daily use based on averages so far
                      nNumberOfRelevantDaysInSet := nDaysInMonth -
                                                    nAccumulatedNumberOfDays; --This is the amount of days we are missing
                      nAccumulatedUsage          := nAccumulatedUsage +
                                                    (nAverageDailyUseInSet *
                                                    nNumberOfRelevantDaysInSet);
                      IF bEntered IS NULL THEN
                        --   DBMS_OUTPUT.Put_Line('insert partial '||systimestamp); 
                        INSERT INTO SERVICE_MONTHLY_USAGE
                          (SERVICE_MONTHLY_USAGE_ID,
                           SERVICE_ID,
                           MONTH_YEAR,
                           AMOUNT,
                           UOM,
                           HU_OR_MU,
                           ENTERED_DATE,
                           ENTERED_BY,
                           SOURCE_OF_CALCULATION)
                          SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
                                 nCurrentServiceID,
                                 dStartOfPeriod,
                                 ROUND(nAccumulatedUsage, 5),
                                 sUnitOfMeasure,
                                 sHuOrMu,
                                 SYSTIMESTAMP,
                                 'CREATE_MONTHLY_USAGE_YB_12_17',
                                 'PARTIAL_MONTH'
                          FROM   DUAL;
                        bEntered := TRUE;
                        --adjust start date to next month and reset # of days and accumulated usage to 0
                        dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -1);
                      END IF;
                    ELSE
                      --we have no data for this month
                      --Then use the ratio of this guys usage in a different month to determine what this months usage should be.
                      --PLEASE NOTE THAT THIS SHOULD NOT BE POSSIBLE TO OCCUR ON THE FIRST MONTH IN, SINCE IF WE ARE IN THIS PROC WE ARE GUARANTEED AT LEAST SOME REAL DATA
                      -- IF nIsReferenceProportion = 0 THEN
                      --what percentage of the year does this month reflect in the average customer?
                      --residential/commercial?
                      IF recService.Service_Type IS NULL THEN
                        SELECT st.service_class_default
                        INTO   sServiceType
                        FROM   settings st;
                      ELSE
                        sServiceType := recService.Service_Type;
                      END IF;
                      BEGIN
                        -- FF May 6 2016 make sure it doesn;t just error out of we don't have the data in utl_usage_percentage 
                        SELECT CASE
                                 WHEN UPPER(sServiceType) = 'RESIDENTIAL' THEN
                                  u.res_pct_of_yr
                                 ELSE
                                  u.com_pct_of_yr
                               END
                        INTO   nReferencePercentOfYear
                        FROM   utl_usage_percentage u
                        WHERE  1 = 1
                               AND utl_id = recService.utl_id
                               AND commodity = recService.commodity
                               AND to_char(month_year, 'MON') =
                               to_char(dStartOfPeriod, 'MON')
                               AND rownum < 2
                        ORDER  BY u.month_year DESC;
                      EXCEPTION
                        WHEN OTHERS THEN
                          -- if we don;t have the data in utl_usage_percentage
                          -- at least, not to error out we will approximate and set the percentage 
                          -- the avergae of all the date we have.
                          SELECT AVG(usg)
                          INTO   nAvgUsage
                          FROM   (SELECT hu.total_usage_amount usg
                                  FROM   inb_867_hu hu
                                  WHERE  ((UPPER(hu.commodity) = 'E' AND
                                         UPPER(hu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
                                         OR UPPER(hu.commodity) <> 'E')
                                         AND service_id = nCurrentServiceID
                                  UNION ALL
                                  SELECT mu.total_usage_amount usg
                                  FROM   inb_867_mu mu
                                  WHERE  ((UPPER(mu.commodity) = 'E' AND
                                         UPPER(mu.uom) = 'KH') --FOR ELECTRIC ONLY ACCEPT KH
                                         OR UPPER(mu.commodity) <> 'E')
                                         AND service_id = nCurrentServiceID);
                        
                      END;
                      /*                            SELECT amount INTO nAccumulatedUsage FROM
                          (
                              SELECT month_year, amount 
                              FROM SERVICE_MONTHLY_USAGE
                              WHERE service_id = nCurrentServiceID
                              AND month_year = add_months(dStartOfPeriod, 1)                      
                          );
                      IF nAccumulatedUsage <= 0 THEN -- FF May/6/2016 make sure that we get an amount no mather what.
                         nAccumulatedUsage := nAnyUsageAmount;                         
                      END IF;
                      IF nReferenceOnePercentUsage > 0 THEN
                          nAccumulatedUsage := nAccumulatedUsage / nReferenceOnePercentUsage;
                      ELSE 
                          nAccumulatedUsage := nAccumulatedUsage / nReferencePercentOfYear;
                      END IF;*/
                      --what was this customers usage this month? Divide that by the percentage and your result is the reference one percent.
                      nReferenceOnePercentUsage :=  /*nAccumulatedUsage /*/
                       nReferencePercentOfYear;
                      --once we set proportion, change value to 1 so will never recalculate for this service id
                      /* 
                              nIsReferenceProportion := 1;
                          END IF;
                      END IF;*/
                      --and multiply it by our established 1% Reference (see calc just below)
                      IF nAvgUsage = 0 THEN
                        -- FF May/9/2016 -- added this so if needed to resort to avergae, that is what we should insert in table;
                        nAccumulatedUsage := nReferencePercentOfYear *
                                             nAccumulatedUsage /*nReferenceOnePercentUsage*/
                         ;
                      ELSE
                        nAccumulatedUsage := nAvgUsage;
                      END IF;
                      IF bEntered IS NULL THEN
                        --    DBMS_OUTPUT.Put_Line('insert avg '||systimestamp); 
                        --insert this calculated data into database if it does not already exist
                        INSERT INTO SERVICE_MONTHLY_USAGE
                          (SERVICE_MONTHLY_USAGE_ID,
                           SERVICE_ID,
                           MONTH_YEAR,
                           AMOUNT,
                           UOM,
                           HU_OR_MU,
                           ENTERED_DATE,
                           ENTERED_BY,
                           SOURCE_OF_CALCULATION)
                          SELECT SEQ_SERVICE_MONTHLY_USAGE_ID.Nextval,
                                 nCurrentServiceID,
                                 dStartOfPeriod,
                                 ROUND(nAccumulatedUsage, 5),
                                 sUnitOfMeasure,
                                 sHuOrMu,
                                 SYSTIMESTAMP,
                                 'CREATE_MONTHLY_USAGE',
                                 'FROM_AVERAGE'
                          FROM   DUAL;
                        bEntered := TRUE;
                        --adjust start date to next month and reset # of days and accumulated usage to 0
                        dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -1);
                      END IF;
                    END IF;
                    --On First Month setup a reference proportion to total usage to be used in months where there is no data
                  
                  END IF;
                  --one last adjustment, per ff we should make the date of month_year in to the past since some retarded utilities send future projections
                  --in place of mu's (like keyspanLI for example)
                  WHILE dStartOfPeriod > SYSDATE LOOP
                    dStartOfPeriod := ADD_MONTHS(dStartOfPeriod, -12); --roll year back by one until in the past.
                  END LOOP;
                  --we'll insert one month at a time, but the commit is for a whole service at a shot (see end of loop below)
                END IF;
              END IF;
            END;
          END LOOP; --dNumberOfMonthsToProcess
        
          COMMIT; --This includes the records to the service_monthly_usage as well
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK; --Dont insert partial service monthly records...
            IF sUnitOfMeasure IS NOT NULL THEN
              GLOBAL.LOG_EXCEPTION(ipsExcText               => '',
                                   ipsErrMessage            => SQLERRM,
                                   ipsProcessCalledFromName => 'USAGE.CREATE_MONTHLY_USAGE',
                                   ipnErrCode               => SQLCODE,
                                   ipnServiceId             => nCurrentServiceID,
                                   ipsEnteredBy             => sys_context('USERENV',
                                                                           'SESSION_USER'),
                                   ipsUtlAcctId             => '',
                                   ipsUtlId                 => '',
                                   ipsCommodity             => '');
            END IF;
        END;
        nTotalAccumulatedDays := 0; --resets for each service id
      END;
    END LOOP;
  END;
  ---------------------------------------------------------------------------------------------
  FUNCTION GET_SERVICE_YEARLY_USAGE(ipnServiceId IN service.service_id%TYPE)
    RETURN VARCHAR2 IS
    -- RP. Created Apr/2013 . This functions returns the most recent 12 months of usage
    --     It selects the max of the month_year fro the service and based on that collects the sum
    --     of the 12 prior months
  
    dLatestDate   DATE;
    nAmountAndUOM VARCHAR2(50);
    sCommodity    VARCHAR2(1);
    sUOM          VARCHAR2(10);
  
  BEGIN
    SELECT MAX(smu.month_year)
    INTO   dLatestDate
    FROM   service_monthly_usage smu
    WHERE  smu.service_id = ipnServiceId;
  
    BEGIN
      SELECT SUM(smu.Amount) || '-' || smu.uom
      INTO   nAmountAndUOM
      FROM   service_monthly_usage smu
      WHERE  smu.service_id = ipnServiceId
             AND smu.month_year -- ff Removed Nov 3 2014 dLatestDate doesn't make any sense
             BETWEEN add_months(dLatestDate, -11) AND dLatestDate
             AND smu.uom IS NOT NULL -- ff added Feb/17/2015
      GROUP  BY smu.uom;
    
      --MR 10/18/2017 There are some people that have a mix of gas and electric uom (by mistake) in such a case we were getting an error that we are 
      --              getting back more that one row and putting it into a variable. The exception catches it and checks the commodity and sums up
      --              the usage without grouping
    EXCEPTION
      WHEN OTHERS THEN
        SELECT commodity
        INTO   sCommodity
        FROM   service
        WHERE  service_id = ipnserviceid;
      
        IF sCommodity = 'E' THEN
          sUOM := 'KH';
        ELSIF sCommodity = 'G' THEN
          sUOM := 'TD';
        END IF;
      
        SELECT SUM(smu.amount) || '-' || sUOM
        INTO   nAmountAndUOM
        FROM   service_monthly_usage smu
        WHERE  smu.service_id = ipnserviceid
               AND smu.month_year BETWEEN add_months(dlatestdate, -11) AND
               dlatestdate
               AND smu.uom IS NOT NULL;
    END;
    RETURN nAmountAndUOM;
  END;
  ---------------------------------------------------------------------------------------------------
  FUNCTION GET_YEARLY_USAGE_AMOUNT(ipnServiceId IN service.service_id%TYPE)
    RETURN NUMBER IS
    -- RP. Created Apr/2013 . This functions returns the most recent 12 months of usage
    --     It selects the max of the month_year fro the service and based on that collects the sum
    --     of the 12 prior months
  
    dLatestDate DATE;
    nAmount     NUMBER;
  
  BEGIN
    SELECT MAX(smu.month_year)
    INTO   dLatestDate
    FROM   service_monthly_usage smu
    WHERE  smu.service_id = ipnServiceId;
  
    SELECT SUM(smu.Amount)
    INTO   nAmount
    FROM   service_monthly_usage smu
    WHERE  smu.service_id = ipnServiceId
           AND smu.month_year -- ff Removed Nov 3 2014 dLatestDate doesn't make any sense
           BETWEEN add_months(dLatestDate, -11) AND dLatestDate;
    --group by smu.uom; removed FF nov/13/2014
  
    RETURN nAmount;
  END;

  --------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_MU_OLD IS
    -- This procedure needs to run on  a scheduler
    -- Enter the procedure variables here. As shown below
    -- variable_name        datatype  NOT NULL DEFAULT default_value;
    nMaxInb867MuId           INB_867_MU.inb_867_mu_id%TYPE;
    nNextInb867MuIdToProcess INB_867_MU.inb_867_mu_id%TYPE;
    nMaxId                   INB_867_MU.inb_867_mu_id%TYPE;
    nServiceId               INB_867_MU.service_id%TYPE;
    dMonth                   DATE;
    dYear                    DATE;
    sMonthYearStart          VARCHAR2(8);
    sMonthYearEnd            VARCHAR2(8);
    sMonthYearEndPrior       VARCHAR2(8);
    nDaysInMonth             NUMBER;
    nDailyAmount             NUMBER;
    nDailyAmountPrior        NUMBER;
    nDaysInMonthPrior        NUMBER;
    dEndDatePrior            DATE;
    nMonthAmount             NUMBER;
    i                        NUMBER;
    bSameMonth               BOOLEAN;
    nTotalDays               NUMBER;
    nMaxMUId                 NUMBER;
    ninb_867_mu_id           NUMBER;
  
    dPreviousStartDate    DATE;
    dPreviousEndDate      DATE;
    nPreviousMonthlyUsage NUMBER;
    nId                   NUMBER;
    sUOM                  VARCHAR2(5);
    nContinousAmount      NUMBER;
    nInsertRecord         NUMBER;
    dSMUMonthYear         DATE;
    sSMUHuOrMu            VARCHAR2(2);
    nCalculatedAmount     NUMBER;
    dLoopDate             DATE;
    nProratedAmount       NUMBER;
    nAmountToUse          NUMBER;
  
    TYPE muTyp IS TABLE OF inb_867_mu%ROWTYPE;
    muTbl muTyp;
  
    TYPE LastRecordedMURecordType IS TABLE OF inb_867_mu%ROWTYPE;
    LastRecordedMURecordTBL LastRecordedMURecordType;
  
    TYPE LastRecordedHURecordType IS TABLE OF inb_867_hu%ROWTYPE;
    LastRecordedHURecordTBL LastRecordedHURecordType;
  
    CURSOR curMuServiceId IS
      SELECT DISTINCT service_id
      FROM   inb_867_mu
      WHERE  inb_867_mu_id >
             (SELECT max_id
              FROM   MISC_PROCESS_LOG
              WHERE  process_name = 'CREATE_MONTHLY_USAGE_MU');
  
    /* Figure out the contribution of the 1st half of record 2, and second half of record one; calculate their daily amount and then add them up
        For record # 1 where we have no information about the prior month we sinmply prorate his daily amount by the days in the month
    */
  BEGIN
  
    SELECT MAX(mu.inb_867_mu_id)
    INTO   nMaxMUId
    FROM   inb_867_mu mu;
  
    SELECT max_id + 1
    INTO   nNextInb867MuIdToProcess
    FROM   MISC_PROCESS_LOG
    WHERE  process_name = 'CREATE_MONTHLY_USAGE_MU';
  
    FOR recMuServiceId IN curMuServiceId LOOP
    
      nServiceId        := recMuServiceId.service_id;
      nCalculatedAmount := 0;
      nContinousAmount  := 0;
      nProratedAmount   := 0;
    
      SELECT *
      BULK   COLLECT
      INTO   muTbl
      FROM   inb_867_mu m
      WHERE  m.service_id = nServiceId
             AND m.inb_867_mu_id >= nNextInb867MuIdToProcess
      ORDER  BY m.start_date;
    
      FOR i IN 1 .. muTbl.count LOOP
        BEGIN
        
          --DBMS_OUTPUT.Put_Line( 'nServiceId: ' || nServiceId || '   muTbl(i).start_date' || muTbl(i).start_date );
          IF i = 1 THEN
            --if its the first record for a specific Service Id
            -- we have to look at the service monthly tble to see
            -- if the last record is a HU or MU
          
            --getting the last record from the service_monthly_usage table for a specific service
            SELECT MAX(u.month_year), MAX(u.hu_or_mu)
            INTO   dSMUMonthYear, sSMUHuOrMu
            FROM   service_monthly_usage u
            WHERE  u.service_id = nServiceId;
            DBMS_OUTPUT.Put_Line(dSMUMonthYear || ' ||  ' || sSMUHuOrMu);
          
            IF sSMUHuOrMu = 'HU' THEN
              /* select * bulk collect into LastRecordedHURecordTBL from inb_867_hu h
              where service_id = nServiceId
               AND h.uom  = 'KH'
               AND  to_char(h.start_date,'MON-YYYY') =  to_char(sSMUMonthYear,'MON-YYYY')
               GROUP BY   h.start_date ,
                          h.total_usage_amount,
                          h.end_date ;
              
                IF LastRecordedHURecordTBL.count = 0 THEN
                   dbms_output.put_line('No Hu Data');
                                     */
            
              SELECT Start_date, End_date, total_usage_amount
              INTO   dPreviousStartDate,
                     dPreviousEndDate,
                     nPreviousMonthlyUsage
              FROM   (SELECT h.start_date, h.total_usage_amount, h.end_date
                      FROM   inb_867_hu h
                      WHERE  service_id = nServiceId
                             AND h.uom = 'KH'
                             AND to_char(h.start_date, 'MON-YYYY') =
                             to_char(dSMUMonthYear, 'MON-YYYY')
                      
                      GROUP  BY h.start_date,
                                h.total_usage_amount,
                                h.end_date
                      ORDER  BY start_date DESC)
              WHERE  rownum = 1;
            
            ELSE
              /*select * bulk collect into LastRecordedMURecordTBL from inb_867_mu m
                     where service_id = nServiceId
                     AND  to_char(m.start_date,'MON-YYYY') =  to_char(TO_DATE(sSMUMonthYear),'MON-YYYY');
              */
            
              SELECT Start_date, End_date, total_usage_amount
              INTO   dPreviousStartDate,
                     dPreviousEndDate,
                     nPreviousMonthlyUsage
              FROM   (SELECT *
                      FROM   inb_867_mu m
                      WHERE  service_id = nServiceId
                             AND to_char(m.start_date, 'MON-YYYY') =
                             to_char(dSMUMonthYear, 'MON-YYYY')
                      ORDER  BY start_date DESC)
              WHERE  ROWnum = 1;
            END IF;
          
          ELSE
            -- if it not the first record put the previous record in to the variables
            dPreviousStartDate    := muTbl(i - 1).start_date;
            dPreviousEndDate      := muTbl(i - 1).End_Date;
            nPreviousMonthlyUsage := muTbl(i - 1).Total_usage_amount;
          END IF;
        
          IF to_char(muTbl(i).start_date, 'MM') >
             to_char(TO_DATE(dPreviousEndDate, 'DD-MON-YYYY'), 'MM') THEN
            --dLoopDate := dPreviousEndDate;
            IF nProratedAmount = 0 THEN
              SELECT s.amount, s.month_year
              INTO   nProratedAmount, dLoopDate
              FROM   service_monthly_usage s
              WHERE  s.month_year =
                     (SELECT MAX(month_year)
                      FROM   service_monthly_usage s
                      WHERE  s.service_id = nServiceId)
                     AND s.service_id = nServiceId;
            END IF;
            dloopdate := to_date('01' || to_char(add_months(dLoopDate, 1),
                                                 'MON-YYYY'));
            WHILE to_char(dLoopDate, 'MM') <
                  to_char(muTbl(i).start_date, 'MM') AND
                  to_char(dLoopDate, 'YYYY') <=
                  to_char(muTbl(i).start_date, 'YYYY') LOOP
            
              INSERT INTO service_monthly_usage
                (SERVICE_MONTHLY_USAGE_ID,
                 SERVICE_ID,
                 MONTH_YEAR,
                 AMOUNT,
                 UOM,
                 HU_OR_MU,
                 ENTERED_DATE,
                 ENTERED_BY)
              VALUES
                (SEQ_SERVICE_MONTHLY_USAGE_ID.NEXTVAL,
                 nServiceId,
                 dLoopDate,
                 ROUND(nProratedAmount, 5),
                 muTbl(i).uom,
                 'MU',
                 SYSTIMESTAMP,
                 sys_context('USERENV', 'SESSION_USER'));
            
              COMMIT;
              dloopdate := to_date('01' || to_char(add_months(dLoopDate, 1),
                                                   'MON-YYYY'));
            END LOOP;
            nProratedAmount := 0;
          END IF;
        
          --if the current start date 1/15/13 equals the previoius end  dates month 1/15/13
          IF to_char(muTbl(i).start_date, 'MM') =
             to_char(TO_DATE(dPreviousEndDate), 'MM') THEN
            --if the current start date 1/15/13 not equeal the current end date 2/5/13
            IF to_char(muTbl(i).start_date, 'MM') <>
               to_char(muTbl(i).end_date, 'MM') THEN
              --this nContinousAmount is for when  month continues over a few records and splits
              IF nContinousAmount <> 0 THEN
                --DBMS_OUTPUT.Put_Line( 'IF nContinousAmount <> 0 ');
                --DBMS_OUTPUT.Put_Line( 'nContinousAmount = ' || nContinousAmount);
                nCalculatedAmount := nContinousAmount;
                nContinousAmount  := 0;
              ELSE
                --testing if the DAY of the Prevoius End Date is the same as the Current Start Date
                -- if is don't count it from the previous record only from the current record otherwise count it from the previous record
                IF to_char(muTbl(i).start_date, 'DD') =
                   to_char(dPreviousEndDate, 'DD') THEN
                  nDailyAmountPrior := nPreviousMonthlyUsage /
                                       (dPreviousEndDate -
                                       dPreviousStartDate);
                  nDaysInMonthPrior := dPreviousEndDate -
                                       (to_date('1-' ||
                                                to_char(dPreviousEndDate,
                                                        'MON-YYYY')));
                ELSE
                  nDailyAmountPrior := nPreviousMonthlyUsage /
                                       ((dPreviousEndDate -
                                       dPreviousStartDate) + 1);
                  nDaysInMonthPrior := to_char(dPreviousEndDate, 'MM');
                END IF;
                nCalculatedAmount := (nDailyAmountPrior *
                                     (nDaysInMonthPrior));
              END IF;
              IF to_char(muTbl(i).start_date, 'DD') =
                 to_char(dPreviousEndDate, 'DD') THEN
                nDailyAmount := muTbl(i)
                                .total_usage_amount /
                                 (muTbl(i).end_date - muTbl(i).start_date + 1); -- daily amount for each day in this period
                nDaysInMonth := LAST_DAY(muTbl(i).start_date) - muTbl(i)
                               .start_date + 1;
              ELSE
                nDailyAmount := muTbl(i)
                                .total_usage_amount /
                                 ((muTbl(i).end_date) - muTbl(i).start_date); -- daily amount for each day in this period
                nDaysInMonth := (LAST_DAY(muTbl(i).start_date) - muTbl(i)
                                .start_date) +
                                (muTbl(i).start_date - dPreviousEndDate);
              END IF;
              sMonthYearStart := to_char(muTbl(i).start_date, 'MON-YYYY'); -- this is the month we are calculating and unserting
              nMonthAmount    := (nDailyAmount * nDaysInMonth) +
                                 nCalculatedAmount; -- we need to take one day off otherwise we adding one extra day to the days of the month
              nInsertRecord   := 1;
            
            ELSIF to_char(muTbl(i).start_date, 'MM') =
                  to_char(muTbl(i).end_date, 'MM') THEN
            
              nDaysInMonthPrior := dPreviousEndDate -
                                   (to_date('1-' ||
                                            to_char(dpreviousEndDate,
                                                    'MON-YYYY'),
                                            'DD-MON-YYYY'));
              nDailyAmountPrior := nPreviousMonthlyUsage /
                                   (dPreviousEndDate - dPreviousStartDate);
              nCalculatedAmount := nDailyAmountPrior * nDaysInMonthPrior;
              IF to_char(last_Day(muTbl(i).end_date), 'DD') =
                 to_Char(muTbl(i).end_date, 'DD') THEN
                sMonthYearStart  := to_char(muTbl(i).start_date, 'MON-YYYY'); -- this is the month we are calculating and unserting
                nMonthAmount     := muTbl(i)
                                    .total_usage_amount + nCalculatedAmount;
                nContinousAmount := 0;
                nInsertRecord    := 1;
              ELSE
                -- made this if statemet for records like thie
                --16-jul-2012 - 6-aug-2012
                --6-aug-2012 - 26-aug-2012
                --26-aug-2012   - 6-sep-2012
                -- for the second record we don't need to add again the previous record we have it we just need the current total amount
                IF nContinousAmount = 0 THEN
                  nContinousAmount := nContinousAmount +
                                      (muTbl(i).total_usage_amount +
                                       nCalculatedAmount);
                ELSE
                  nContinousAmount := nContinousAmount + muTbl(i)
                                     .total_usage_amount;
                END IF;
                nInsertRecord := 0;
              END IF;
            END IF;
          ELSE
            nDailyAmount := muTbl(i)
                            .total_usage_amount /
                             ((muTbl(i).end_date) - muTbl(i).start_date); -- daily amount for each day in this period
            nDaysInMonth := (LAST_DAY(muTbl(i).start_date) - muTbl(i)
                            .start_date) +
                            (to_char(muTbl(i).start_date, 'DD'));
          
            sMonthYearStart := to_char(muTbl(i).start_date, 'MON-YYYY'); -- this is the month we are calculating and unserting
            nMonthAmount    := nDaysInMonth * nDailyAmount;
            nInsertRecord   := 1;
          END IF;
        
          --the current start date get all its days if its a full month if its not  then
          --put the number of days in a varible with the usage amount per day and save it for the
          --next records
          --
          /*  iF muTbl(i).end_date - muTbl(i).start_date >= to_char(last_day(muTbl(i).start_date),'DD') THEN
          
                    nDailyAmountPrior :=  muTbl(i).total_usage_amount / ( muTbl(i).end_date - muTbl(i).start_date ) ;
                    --sMonthYearStart := to_char(to_date(muTbl(i).Start_date,'MON-DD-YYYY'),'MON-YYYY');
          
                    sMonthYearStart := to_char(muTbl(i).Start_date,'MON-YYYY');
                    nMonthAmount := (nDailyAmountPrior * to_char(last_day(muTbl(i).start_date),'DD'));
          
                    insert into service_monthly_usage(
                            SERVICE_MONTHLY_USAGE_ID,
                            SERVICE_ID,
                            MONTH_YEAR,
                            AMOUNT,
                            UOM,
                            HU_OR_MU,
                            ENTERED_DATE,
                            ENTERED_BY)
                   values ( SEQ_SERVICE_MONTHLY_USAGE_ID.NEXTVAL,
                            nServiceId,
                            TO_DATE(sMonthYearStart,'MON-YYYY'),
                            ROUND(nMonthAmount,5),
                            muTbl(i).uom,
                            'MU',
                            SYSTIMESTAMP,
                            sys_context('USERENV', 'SESSION_USER')
                                    );
                commit;
          
          
          
          END IF ;
          */
          IF nInsertRecord = 1 THEN
            INSERT INTO service_monthly_usage
              (SERVICE_MONTHLY_USAGE_ID,
               SERVICE_ID,
               MONTH_YEAR,
               AMOUNT,
               UOM,
               HU_OR_MU,
               ENTERED_DATE,
               ENTERED_BY)
            VALUES
              (SEQ_SERVICE_MONTHLY_USAGE_ID.NEXTVAL,
               nServiceId,
               TO_DATE(sMonthYearStart, 'MON-YYYY'),
               ROUND(nMonthAmount, 5),
               muTbl(i).uom,
               'MU',
               SYSTIMESTAMP,
               sys_context('USERENV', 'SESSION_USER'));
            COMMIT;
            nInsertRecord := 0;
          END IF;
          --if there is a record that is missing months between the start and end date
          IF to_char(add_Months(mutbl(i).start_date, 1), 'MON-YYYY') <>
             to_char(mutbl(i).end_date, 'MON-YYYY') THEN
            dLoopDate := add_Months(mutbl(i).start_date, 1);
            WHILE to_char(dLoopDate, 'MM') <
                  to_char(mutbl(i).end_date, 'MM') LOOP
            
              INSERT INTO service_monthly_usage
                (SERVICE_MONTHLY_USAGE_ID,
                 SERVICE_ID,
                 MONTH_YEAR,
                 AMOUNT,
                 UOM,
                 HU_OR_MU,
                 ENTERED_DATE,
                 ENTERED_BY)
              VALUES
                (SEQ_SERVICE_MONTHLY_USAGE_ID.NEXTVAL,
                 nServiceId,
                 to_date('01-' || to_char(dLoopDate, 'MON-YYYY'),
                         'DD-MON-YYYY'),
                 ROUND(nMonthAmount, 5),
                 muTbl(i).uom,
                 'MU',
                 SYSTIMESTAMP,
                 sys_context('USERENV', 'SESSION_USER'));
              COMMIT;
              dLoopDate := add_months(dLoopDate, 1);
            END LOOP;
          END IF;
        
        END;
      
      END LOOP;
    
    END LOOP;
    --DBMS_OUTPUT.Put_Line(nMaxMUId);
  
    UPDATE MISC_PROCESS_LOG
    SET    max_id = nMaxMUId
    WHERE  process_name = 'CREATE_MONTHLY_USAGE_MU';
  
    COMMIT;
  
    /* EXCEPTION
    WHEN others THEN
       raise ;*/
  END;
  ----------------------------------------------------------------------------------------------
  PROCEDURE CREATE_MONTHLY_USAGE_FF_NEW IS
    -- This procedure needs to run on  a scheduler
    -- Enter the procedure variables here. As shown below
    -- variable_name        datatype  NOT NULL DEFAULT default_value;
    nMaxInb867MuId           INB_867_MU.inb_867_mu_id%TYPE;
    nNextInb867MuIdToProcess INB_867_MU.inb_867_mu_id%TYPE;
    nMaxId                   INB_867_MU.inb_867_mu_id%TYPE;
    nServiceId               INB_867_MU.service_id%TYPE;
    dMonth                   DATE;
    dYear                    DATE;
    sMonthYearStart          VARCHAR2(8);
    sMonthYearEnd            VARCHAR2(8);
    sMonthYearEndPrior       VARCHAR2(8);
    nDaysInMonth             NUMBER;
    nDailyAmount             NUMBER;
    nDailyAmountPrior        NUMBER;
    nDaysInMonthPrior        NUMBER;
    dEndDatePrior            DATE;
    nMonthAmount             NUMBER;
    i                        NUMBER;
    bSameMonth               BOOLEAN;
    nTotalDays               NUMBER;
    nMaxMUId                 NUMBER;
    ninb_867_mu_id           NUMBER;
  
    dPreviousStartDate    DATE;
    dPreviousEndDate      DATE;
    nPreviousMonthlyUsage NUMBER;
    nId                   NUMBER;
    sUOM                  VARCHAR2(5);
    nContinousAmount      NUMBER;
    nInsertRecord         NUMBER;
    dSMUMonthYear         DATE;
    sSMUHuOrMu            VARCHAR2(2);
    nCalculatedAmount     NUMBER;
    dLoopDate             DATE;
    nProratedAmount       NUMBER;
    nAmountToUse          NUMBER;
    nStartToLastAmount    NUMBER;
    nLastToFirstAmount    NUMBER;
  
    TYPE muTyp IS TABLE OF inb_867_mu%ROWTYPE;
    muTbl muTyp;
  
    TYPE LastRecordedMURecordType IS TABLE OF inb_867_mu%ROWTYPE;
    LastRecordedMURecordTBL LastRecordedMURecordType;
  
    TYPE LastRecordedHURecordType IS TABLE OF inb_867_hu%ROWTYPE;
    LastRecordedHURecordTBL LastRecordedHURecordType;
  
    CURSOR curSvcHUMU IS
      SELECT *
      FROM   (SELECT DISTINCT to_date('1-' ||
                                      to_char(hu.start_date, 'MON-YYYY')) dtyr,
                              service_id svid,
                              hu.start_date,
                              hu.total_usage_amount,
                              hu.end_date
              FROM   inb_867_hu hu
              WHERE  hu.start_date IS NOT NULL
                     AND hu.start_date > TRUNC(SYSDATE) - (25 * 12)
              UNION
              SELECT DISTINCT to_date('1-' ||
                                      to_char(mu.start_date, 'MON-YYYY')) dtyr,
                              service_id svid,
                              mu.start_date,
                              mu.total_usage_amount,
                              mu.end_date
              FROM   inb_867_mu mu
              WHERE  mu.start_date IS NOT NULL
                     AND mu.start_date > TRUNC(SYSDATE) - (25 * 12))
      WHERE  NOT EXISTS (SELECT 1
              FROM   service_monthly_usage smu
              WHERE  smu.month_year = dtyr
                     AND service_id = svid)
             AND svid BETWEEN 3744170 AND 3744247 -- ********** take out 
      ORDER  BY svid, dtyr;
  
    /* Figure out the contribution of the 1st half of record 2, and second half of record one; calculate their daily amount and then add them up
        For record # 1 where we have no information about the prior month we sinmply prorate his daily amount by the days in the month
    */
  BEGIN
    /*        FOR recSvcHUMU IN curSvcHUMU LOOP
    nStartToLastAmount := reports.GetProratedMonthlyAmount(
                             ipdPeriodEndDate        => last_day(recSvcHUMU.dtyr),
                             ipdInvoiceStartDate     => recSvcHUMU.start_date,
                             ipdInvoiceEndDate       => recSvcHUMU.end_date,
                             ipnTotalToProrateAmount => recSvcHUMU.total_usage_amount);*/
    NULL;
  
  END;

----------------------------------------------------------------------------------------------    
END;
/
