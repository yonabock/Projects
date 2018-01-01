CREATE OR REPLACE PACKAGE REPORTS AS

  /* TODO enter package declarations (types, exceptions, methods etc) here */

  /*procedure CustomerStatus(rfcCustomerStatus out global.refcur,
                          ipsFromDate in varchar2,
                           ipsToDate in varchar2,
                          ipsStatus in varchar2);
  */

  -------------------------------------------------------------------------------------------------
  PROCEDURE EnrollmentStatus_old(ipsdtBeginDate    IN VARCHAR2,
                                 ipsdtEndDate      IN VARCHAR2,
                                 ipsCommodity      IN VARCHAR2,
                                 ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                 ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                 ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                 ipnServiceid      IN service.service_id%TYPE,
                                 ipsServiceType    IN Service.Service_Type%TYPE,
                                 rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------------
  PROCEDURE EnrollmentSummary_old(ipsdtBeginDate    IN VARCHAR2,
                                  ipsdtEndDate      IN VARCHAR2,
                                  ipsCommodity      IN VARCHAR2,
                                  ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                  ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                  ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                  ipnServiceid      IN service.service_id%TYPE,
                                  ipsServiceType    IN Service.Service_Type%TYPE,
                                  rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------
  -- Compliance report for the Utility FF Jan/14/2016
  PROCEDURE COMP_HistoricalRateData(ipsdtBeginDate    IN VARCHAR2,
                                    ipsdtEndDate      IN VARCHAR2,
                                    ipsCommodity      IN VARCHAR2,
                                    ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                    ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                    ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                    ipnServiceid      IN service.service_id%TYPE,
                                    ipsServiceType    IN Service.Service_Type%TYPE,
                                    ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                                    rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------------
  PROCEDURE get_UTL_Names(rfcUTLName OUT global.refcur);
  -----------------------------------------------------------------------------------------------------
  PROCEDURE ChurnReport(ipsdtBeginDate    IN VARCHAR2,
                        ipsdtEndDate      IN VARCHAR2,
                        ipsCommodity      IN VARCHAR2,
                        ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                        ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                        ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                        ipnServiceid      IN service.service_id%TYPE,
                        ipsServiceType    IN Service.Service_Type%TYPE,
                        ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                        rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------------
  PROCEDURE ChurnReportSummary(ipsdtBeginDate    IN VARCHAR2,
                               ipsdtEndDate      IN VARCHAR2,
                               ipsCommodity      IN VARCHAR2,
                               ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                               ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                               ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                               ipnServiceid      IN service.service_id%TYPE,
                               ipsServiceType    IN Service.Service_Type%TYPE,
                               ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                               rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------------
  PROCEDURE GetListOfReports(rfcReports        OUT global.refCur,
                             ipsReportCategory IN VARCHAR2);
  ----------------------------------------------------------------------------------------------------
  PROCEDURE CommissionFactorOfUsageReport(ipsdtBeginDate    IN VARCHAR2,
                                          ipsdtEndDate      IN VARCHAR2,
                                          ipsCommodity      IN VARCHAR2,
                                          ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                          ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                          ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                          ipnServiceid      IN service.service_id%TYPE,
                                          ipsServiceType    IN Service.Service_Type%TYPE,
                                          rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------------
  PROCEDURE CommissionPercentageOfInvoice(ipsdtBeginDate    IN VARCHAR2,
                                          ipsdtEndDate      IN VARCHAR2,
                                          ipsCommodity      IN VARCHAR2,
                                          ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                          ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                          ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                          ipnServiceid      IN service.service_id%TYPE,
                                          ipsServiceType    IN Service.Service_Type%TYPE,
                                          rfcReport         OUT global.refCur);
  ------------------------------------------------------------------------------------------------------
  PROCEDURE CommissionOneTimeFlatAmount(ipsdtBeginDate    IN VARCHAR2,
                                        ipsdtEndDate      IN VARCHAR2,
                                        ipsCommodity      IN VARCHAR2,
                                        ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                        ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                        ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                        ipnServiceid      IN service.service_id%TYPE,
                                        ipsServiceType    IN Service.Service_Type%TYPE,
                                        rfcReport         OUT global.refCur);
  ------------------------------------------------------------------------------------------------------
  PROCEDURE CommissionsReportDetail(ipsdtBeginDate    IN VARCHAR2,
                                    ipsdtEndDate      IN VARCHAR2,
                                    ipsCommodity      IN VARCHAR2,
                                    ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                    ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                    ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                    ipnServiceid      IN service.service_id%TYPE,
                                    ipsServiceType    IN Service.Service_Type%TYPE,
                                    ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                                    rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------------------

  PROCEDURE CommissionsShortDetail(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                                   rfcReport         OUT global.refCur);
  ------------------------------------------------------------------------------------------------------
  PROCEDURE OpenCommissionsReport(ipsdtBeginDate    IN VARCHAR2,
                                  ipsdtEndDate      IN VARCHAR2,
                                  ipsCommodity      IN VARCHAR2,
                                  ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                  ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                  ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                  ipnServiceid      IN service.service_id%TYPE,
                                  ipsServiceType    IN Service.Service_Type%TYPE,
                                  ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                                  rfcReport         OUT global.refCur);
  ------------------------------------------------------------------------------------------------------
  FUNCTION GetTwoMeterCommission(ipnServiceId IN service.service_id%TYPE)
    RETURN NUMBER;
  ------------------------------------------------------------------------------------------------------
  FUNCTION GetCommissionRate(ipnCommissionPlanId IN commission_plan.commission_plan_id%TYPE,
                             ipnServiceId        IN service.service_id%TYPE)
    RETURN NUMBER;
  ------------------------------------------------------------------------------------------------------
  PROCEDURE ChargeBackReport(ipsdtBeginDate    IN VARCHAR2,
                             ipsdtEndDate      IN VARCHAR2,
                             ipsCommodity      IN VARCHAR2,
                             ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                             ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                             ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                             ipnServiceid      IN service.service_id%TYPE,
                             ipsServiceType    IN Service.Service_Type%TYPE,
                             rfcReports        OUT global.refCur);
  -------------------------------------------------------------------------------------------
  FUNCTION GetChargeBackEventDate(ipsEventName IN charge_back_from_events.event_name%TYPE,
                                  ipnServiceId IN service.service_id%TYPE)
    RETURN VARCHAR2;
  -------------------------------------------------------------------------------------------------------
  PROCEDURE GetReportParam(ipnReportDefId IN report_def.report_def_id%TYPE,
                           rfcReportParam OUT global.refCur);
  -------------------------------------------------------------------------------------------------------
  PROCEDURE GetListOfReportCategory(rfcReportCategory OUT global.refCur);
  ---------------------------------------------------------------------------------------------
  PROCEDURE GetListOfStates(rfcListOfStates OUT global.refCur);
  ------------------------------------------------------------------------------------------------
  PROCEDURE BillingDetail(ipsdtBeginDate    IN VARCHAR2,
                          ipsdtEndDate      IN VARCHAR2,
                          ipsCommodity      IN VARCHAR2,
                          ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                          ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                          ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                          ipnServiceid      IN service.service_id%TYPE,
                          ipsServiceType    IN Service.Service_Type%TYPE,
                          ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                          rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------
  PROCEDURE BillingSummary(ipsdtBeginDate IN VARCHAR2,
                           
                           ipsdtEndDate      IN VARCHAR2,
                           ipsCommodity      IN VARCHAR2,
                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                           ipnServiceid      IN service.service_id%TYPE,
                           ipsServiceType    IN Service.Service_Type%TYPE,
                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                           rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------
  PROCEDURE UnBilledDetail(ipsdtBeginDate    IN VARCHAR2,
                           ipsdtEndDate      IN VARCHAR2, -- this is as_of_date
                           ipsCommodity      IN VARCHAR2,
                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                           ipnServiceid      IN service.service_id%TYPE,
                           ipsServiceType    IN Service.Service_Type%TYPE,
                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                           rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------
  FUNCTION GetUnbilledDays(ipdAsOfDate       IN DATE,
                           ipdEndServiceDate IN service.end_service_date%TYPE,
                           ipdInvoiceEndDate IN invoice.end_date%TYPE)
    RETURN NUMBER;
  --------------------------------------------------------------------------------------------
  FUNCTION GetProratedBillingAmount(ipdAsOfDate            IN DATE,
                                    ipdEndServiceDate      IN service.end_service_date%TYPE,
                                    ipdInvoiceStartDate    IN invoice.start_date%TYPE,
                                    ipdInvoiceEndDate      IN invoice.end_date%TYPE,
                                    ipnUnbilledDays        IN NUMBER,
                                    ipnTotalInvoiceUsage   IN invoice.total_usage_amount%TYPE,
                                    ipnEnergyChargesAmount IN invoice.energy_charges_amount%TYPE,
                                    ipnInvoiceRate         IN invoice.rate_amount%TYPE,
                                    ipsCommodity           IN service.commodity%TYPE,
                                    ipsUtlId               IN service.utl_id%TYPE,
                                    ipnCurrentRatePlanRate IN rate_plan.rate_amount%TYPE,
                                    ipsServiceType         IN service.service_type%TYPE)
    RETURN NUMBER;
  ---------------------------------------------------------------------------------------------------------
  PROCEDURE RateChangeDetailReportAll(ipsdtBeginDate    IN VARCHAR2,
                                      ipsdtEndDate      IN VARCHAR2,
                                      ipsCommodity      IN VARCHAR2,
                                      ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                      ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                      ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                      ipnServiceid      IN service.service_id%TYPE,
                                      ipsServiceType    IN Service.Service_Type%TYPE,
                                      rfcReport         OUT global.refCur);

  ---------------------------------------------------------------------------------------------
  PROCEDURE RateChangeDetailReport(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                                   rfcReport         OUT global.refCur);

  ---------------------------------------------------------------------------------------------------------
  PROCEDURE RateChangeSummaryReport_old(ipsdtBeginDate    IN VARCHAR2,
                                        ipsdtEndDate      IN VARCHAR2,
                                        ipsCommodity      IN VARCHAR2,
                                        ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                        ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                        ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                        ipnServiceid      IN service.service_id%TYPE,
                                        ipsServiceType    IN Service.Service_Type%TYPE,
                                        rfcReport         OUT global.refCur);

  ---------------------------------------------------------------------------------------------------------
  PROCEDURE RateChangeSummaryReport(ipsdtBeginDate    IN VARCHAR2,
                                    ipsdtEndDate      IN VARCHAR2,
                                    ipsCommodity      IN VARCHAR2,
                                    ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                    ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                    ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                    ipnServiceid      IN service.service_id%TYPE,
                                    ipsServiceType    IN Service.Service_Type%TYPE,
                                    ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                    rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------

  PROCEDURE AR_RemittanceSummary(ipsdtBeginDate    IN VARCHAR2,
                                 ipsdtEndDate      IN VARCHAR2,
                                 ipsCommodity      IN VARCHAR2,
                                 ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                 ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                 ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                 ipnServiceid      IN service.service_id%TYPE,
                                 ipsServiceType    IN Service.Service_Type%TYPE,
                                 ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                 rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------

  PROCEDURE AR_RemittanceDetail(ipsdtBeginDate    IN VARCHAR2,
                                ipsdtEndDate      IN VARCHAR2,
                                ipsCommodity      IN VARCHAR2,
                                ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                ipnServiceid      IN service.service_id%TYPE,
                                ipsServiceType    IN Service.Service_Type%TYPE,
                                ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------

  PROCEDURE AR_AgingSummaryByUtility(ipsdtBeginDate    IN VARCHAR2,
                                     ipsdtEndDate      IN VARCHAR2,
                                     ipsCommodity      IN VARCHAR2,
                                     ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                     ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                     ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                     ipnServiceid      IN service.service_id%TYPE,
                                     ipsServiceType    IN Service.Service_Type%TYPE,
                                     ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                     rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------

  PROCEDURE AR_AgingDetailByUtlByAcct(ipsdtBeginDate    IN VARCHAR2,
                                      ipsdtEndDate      IN VARCHAR2,
                                      ipsCommodity      IN VARCHAR2,
                                      ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                      ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                      ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                      ipnServiceid      IN service.service_id%TYPE,
                                      ipsServiceType    IN Service.Service_Type%TYPE,
                                      ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                      rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------

  ---------------------------------------------------------------------------------------------

  PROCEDURE AR_InvcRemitReconcile(ipsdtBeginDate    IN VARCHAR2,
                                  ipsdtEndDate      IN VARCHAR2,
                                  ipsCommodity      IN VARCHAR2,
                                  ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                  ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                  ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                  ipnServiceid      IN service.service_id%TYPE,
                                  ipsServiceType    IN Service.Service_Type%TYPE,
                                  ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                  rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------

  PROCEDURE ENR_ActiveMetersDetail(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                   rfcReport         OUT global.refCur);

  ---------------------------------------------------------------------------------------------
  PROCEDURE ENR_ActiveMetersSummary(ipsdtBeginDate    IN VARCHAR2,
                                    ipsdtEndDate      IN VARCHAR2,
                                    ipsCommodity      IN VARCHAR2,
                                    ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                    ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                    ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                    ipnServiceid      IN service.service_id%TYPE,
                                    ipsServiceType    IN Service.Service_Type%TYPE,
                                    ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                    rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------

  PROCEDURE ENR_EnrollmentRejectionsDetail(ipsdtBeginDate    IN VARCHAR2,
                                           ipsdtEndDate      IN VARCHAR2,
                                           ipsCommodity      IN VARCHAR2,
                                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                           ipnServiceid      IN service.service_id%TYPE,
                                           ipsServiceType    IN Service.Service_Type%TYPE,
                                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                           rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------

  PROCEDURE ENR_EnrollmentExceptionsDetail(ipsdtBeginDate    IN VARCHAR2,
                                           ipsdtEndDate      IN VARCHAR2,
                                           ipsCommodity      IN VARCHAR2,
                                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                           ipnServiceid      IN service.service_id%TYPE,
                                           ipsServiceType    IN Service.Service_Type%TYPE,
                                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                           rfcReport         OUT global.refCur);

  ---------------------------------------------------------------------------------------------
  PROCEDURE ENR_EnrollmentDetail(ipsdtBeginDate    IN VARCHAR2,
                                 ipsdtEndDate      IN VARCHAR2,
                                 ipsCommodity      IN VARCHAR2,
                                 ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                 ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                 ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                 ipnServiceid      IN service.service_id%TYPE,
                                 ipsServiceType    IN Service.Service_Type%TYPE,
                                 ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                 rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------
  PROCEDURE ENR_EnrollmentSummary(ipsdtBeginDate    IN VARCHAR2,
                                  ipsdtEndDate      IN VARCHAR2,
                                  ipsCommodity      IN VARCHAR2,
                                  ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                  ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                  ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                  ipnServiceid      IN service.service_id%TYPE,
                                  ipsServiceType    IN Service.Service_Type%TYPE,
                                  ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                  rfcReport         OUT global.refCur);

  ---------------------------------------------------------------------------------------------
  PROCEDURE EXC_ActiveButNoUsage(ipsdtBeginDate    IN VARCHAR2,
                                 ipsdtEndDate      IN VARCHAR2,
                                 ipsCommodity      IN VARCHAR2,
                                 ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                 ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                 ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                 ipnServiceid      IN service.service_id%TYPE,
                                 ipsServiceType    IN Service.Service_Type%TYPE,
                                 ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                                 rfcReport         OUT global.refCur);

  ---------------------------------------------------------------------------------------------
  PROCEDURE AP_SalesTaxSummary(ipsdtBeginDate    IN VARCHAR2,
                               ipsdtEndDate      IN VARCHAR2,
                               ipsCommodity      IN VARCHAR2,
                               ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                               ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                               ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                               ipnServiceid      IN service.service_id%TYPE,
                               ipsServiceType    IN Service.Service_Type%TYPE,
                               ipsStates         IN utl_rpm.state%TYPE,
                               rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------
  PROCEDURE AP_SalesTaxDetail(ipsdtBeginDate    IN VARCHAR2,
                              ipsdtEndDate      IN VARCHAR2,
                              ipsCommodity      IN VARCHAR2,
                              ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                              ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                              ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                              ipnServiceid      IN service.service_id%TYPE,
                              ipsServiceType    IN Service.Service_Type%TYPE,
                              ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                              rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------                                   
  PROCEDURE ProratedMonthlyUsageAndBilling(ipsdtBeginDate    IN VARCHAR2,
                                           ipsdtEndDate      IN VARCHAR2,
                                           ipsCommodity      IN VARCHAR2,
                                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                           ipnServiceid      IN service.service_id%TYPE,
                                           ipsServiceType    IN Service.Service_Type%TYPE,
                                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                           rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------
  PROCEDURE RP_ServiceClassIncompatible(ipsdtBeginDate    IN VARCHAR2,
                                        ipsdtEndDate      IN VARCHAR2,
                                        ipsCommodity      IN VARCHAR2,
                                        ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                        ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                        ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                        ipnServiceid      IN service.service_id%TYPE,
                                        ipsServiceType    IN Service.Service_Type%TYPE,
                                        ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                        rfcReport         OUT global.refCur);
  -------------------------------------------------------------------------------------------------------
  PROCEDURE RatePlan_InvoiceRateComparison(ipsdtBeginDate    IN VARCHAR2,
                                           ipsdtEndDate      IN VARCHAR2,
                                           ipsCommodity      IN VARCHAR2,
                                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                           ipnServiceid      IN service.service_id%TYPE,
                                           ipsServiceType    IN Service.Service_Type%TYPE,
                                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                           rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------
  PROCEDURE RatePlanNotMinMax(ipsdtBeginDate    IN VARCHAR2,
                              ipsdtEndDate      IN VARCHAR2,
                              ipsCommodity      IN VARCHAR2,
                              ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                              ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                              ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                              ipnServiceid      IN service.service_id%TYPE,
                              ipsServiceType    IN Service.Service_Type%TYPE,
                              ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                              rfcReport         OUT global.refCur);
  -----------------------------------------------------------------------------------------------
  PROCEDURE USG_YearlyUsageSummary(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                   rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------
  PROCEDURE USG_YearlyUsageDetail(ipsdtBeginDate    IN VARCHAR2,
                                  ipsdtEndDate      IN VARCHAR2,
                                  ipsCommodity      IN VARCHAR2,
                                  ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                  ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                  ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                  ipnServiceid      IN service.service_id%TYPE,
                                  ipsServiceType    IN Service.Service_Type%TYPE,
                                  ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                  rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------                                
  PROCEDURE USG_MonthlyUsageDetail(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                   rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------

  PROCEDURE USG_MonthlyUsageSummary(ipsdtBeginDate    IN VARCHAR2,
                                    ipsdtEndDate      IN VARCHAR2,
                                    ipsCommodity      IN VARCHAR2,
                                    ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                    ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                    ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                    ipnServiceid      IN service.service_id%TYPE,
                                    ipsServiceType    IN Service.Service_Type%TYPE,
                                    ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                    rfcReport         OUT global.refCur);
  ---------------------------------------------------------------------------------------------

  PROCEDURE GetSalesCompanyList(rfcSalesCompany OUT global.refCur);
  ---------------------------------------------------------------------------------------------
  PROCEDURE GetReportConstants(rfcSalesCompany OUT global.refCur);
  ----------------------------------------------------------------------------------------------
  FUNCTION GetProratedMonthlyAmount(ipdPeriodEndDate        IN DATE,
                                    ipdInvoiceStartDate     IN invoice.start_date%TYPE,
                                    ipdInvoiceEndDate       IN invoice.end_date%TYPE,
                                    ipnTotalToProrateAmount IN NUMBER)
    RETURN NUMBER;
  ------------------------------------------------------------------------------------------------------
  PROCEDURE rp_ContractExpirations(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                   rfcReport         OUT global.refCur);
  ----------------------------------------------------------------------------------------------   
  PROCEDURE rp_FixedPlanAcctCancelWarning(ipsdtBeginDate    IN VARCHAR2,
                                          ipsdtEndDate      IN VARCHAR2,
                                          ipsCommodity      IN VARCHAR2,
                                          ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                          ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                          ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                          ipnServiceid      IN service.service_id%TYPE,
                                          ipsServiceType    IN Service.Service_Type%TYPE,
                                          ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                          rfcReport         OUT global.refCur);
  ----------------------------------------------------------------------------------------------   
  PROCEDURE xc_InbTransAccountNotFound(ipsdtBeginDate    IN VARCHAR2,
                                       ipsdtEndDate      IN VARCHAR2,
                                       ipsCommodity      IN VARCHAR2,
                                       ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                       ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                       ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                       ipnServiceid      IN service.service_id%TYPE,
                                       ipsServiceType    IN Service.Service_Type%TYPE,
                                       ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                       rfcReport         OUT global.refCur);
  ----------------------------------------------------------------------------------------------   
  PROCEDURE rp_CallLogFollowUp(ipsdtBeginDate    IN VARCHAR2,
                               ipsdtEndDate      IN VARCHAR2,
                               ipsCommodity      IN VARCHAR2,
                               ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                               ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                               ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                               ipnServiceid      IN service.service_id%TYPE,
                               ipsServiceType    IN Service.Service_Type%TYPE,
                               ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                               rfcReport         OUT global.refCur);
  ----------------------------------------------------------------------------------------------   
  PROCEDURE InsertReportDefAndParam(ipsReportCatergory      IN VARCHAR2,
                                    ipsReportName           IN VARCHAR2,
                                    ipsReportDescription    IN VARCHAR2,
                                    ipsPackageName          IN VARCHAR2 DEFAULT 'Reports',
                                    ipsProcedureName        IN VARCHAR2,
                                    ipsRefcursorName        IN VARCHAR2 DEFAULT 'rfcCursor',
                                    ipnEnersoftSystemRoleID NUMBER DEFAULT NULL,
                                    ipsEnteredBy            IN VARCHAR2,
                                    ipdExpiredDate          IN DATE,
                                    ipsExpiredBy            VARCHAR2,
                                    ipsDisplayFlag          VARCHAR2,
                                    ipsControlInitialValue  IN VARCHAR2,
                                    
                                    ipbtxtUTLAccountId IN BOOLEAN,
                                    ipblblUtlAccountId IN BOOLEAN,
                                    
                                    ipbdtpEndDate IN BOOLEAN,
                                    ipblblEndDate IN BOOLEAN,
                                    
                                    ipblstCommodity IN BOOLEAN,
                                    ipblblCommodity IN BOOLEAN,
                                    
                                    ipbtxtServiceId IN BOOLEAN,
                                    ipblblServiceId IN BOOLEAN,
                                    
                                    ipblstUtilityName IN BOOLEAN,
                                    ipblblUtilityName IN BOOLEAN,
                                    
                                    ipbdtpStartDate IN BOOLEAN,
                                    ipblblStartDate IN BOOLEAN,
                                    
                                    ipblstSalesCompany  IN BOOLEAN,
                                    ipblblStatusCompany IN BOOLEAN,
                                    
                                    ipblstCustomerType IN BOOLEAN,
                                    ipblblCustomerType IN BOOLEAN);
  -----------------------------------------------------------------------------------------------                                 

END REPORTS;
/
CREATE OR REPLACE PACKAGE BODY REPORTS AS
  /*
  User   Date               Report            Task
  RP     11/13/2013      EnrollmentStatus     Changed the status_Description to the lookup table rejection_code
  
  RP                        7/21/2013           this report returns  information for the historical request , enrollment request and the service exc
                                         data that does not include ReEnrollment
  RP                        11/13/2013          Changed the status_Description to the lookup table rejection_code
  
  FF/SS;    Jan/27/14     Added extra blank column so we can add totals in the front end
  FF/SS;    Jan/27/14     Added the # to some columns at the end - it will mean that column will be totaled in the front end
  SB 7/20/2015            Added rounding to 4 in the usage summary reports so that the frontend calculates it correctly. 
                          Otherwise the frontend does not work because there are too many decimols.
  */

  PROCEDURE EnrollmentStatus_old(ipsdtBeginDate    IN VARCHAR2,
                                 ipsdtEndDate      IN VARCHAR2,
                                 ipsCommodity      IN VARCHAR2,
                                 ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                 ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                 ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                 ipnServiceid      IN service.service_id%TYPE,
                                 ipsServiceType    IN Service.Service_Type%TYPE,
                                 rfcReport         OUT global.refCur) IS
  BEGIN
  
    OPEN rfcReport FOR
      SELECT c.first_name "First Name",
             c.last_name "Last Name",
             c.street "Address",
             s.utl_acct_id "UTL Account",
             u.utl_short_name "UTL Name",
             s.commodity "Commodity",
             to_char(s.entered_date, 'dd-MON-yyyy') "Service Entered Date",
             to_char(s.hst_req_date, 'dd-MON-yyyy') "Historical Request Date",
             to_char(h.entered_date, 'dd-MON-yyyy') "Historical Request Received",
             h.status_code "Historical Request Response",
             h.description "Historical Request Message",
             to_char(s.enr_req_date, 'dd-MON-yyyy') "Enrollment Request Date",
             to_char(s.start_service_date, 'dd-MON-yyyy') "Start Service Date",
             to_char(e.entered_date, 'dd-MON-yyyy') "Enrollment Received Date",
             e.status_code "Enrollment Request Response",
             e.description "Enrollment Request Message",
             trans.get_status(s.service_id) "Global Status",
             NULL "Service Exc Message"
      FROM   customer c
      JOIN   service s
      ON     s.customer_id = c.customer_id
      LEFT   JOIN (SELECT inb.service_id,
                          inb.utl_name,
                          inb.status_code,
                          r.description,
                          inb.entered_date
                   FROM   inb_814_rsp inb
                   JOIN   service s
                   ON     s.service_id = inb.service_id
                   LEFT   JOIN rejection_codes r
                   ON     inb.status_description = r.code
                   WHERE  inb.transaction_purpose_code = 'HA'
                          AND to_char(nvl(inb.entered_date, SYSDATE),
                                      'dd-MON-yyyy') >=
                          to_char(nvl(s.hst_req_date, SYSDATE),
                                      'dd-MON-yyyy')) h
      ON     h.service_id = s.service_id
      LEFT   JOIN (SELECT inb.service_id,
                          inb.status_code,
                          r.description,
                          inb.entered_date
                   FROM   inb_814_rsp inb
                   JOIN   service s
                   ON     s.service_id = inb.service_id
                   LEFT   JOIN rejection_codes r
                   ON     inb.status_description = r.code
                   WHERE  inb.transaction_purpose_code = 'EA'
                          AND to_char(nvl(inb.entered_date, SYSDATE),
                                      'dd-MON-yyyy') >=
                          to_char(nvl(s.enr_req_date, SYSDATE),
                                      'dd-MON-yyyy')) e
      ON     e.service_id = s.service_id
      JOIN   UTL_OUT_814_EDI u
      ON     s.utl_id = u.utl_id
      JOIN   sales_source sa
      ON     sa.sales_source_id = s.sales_source_id
      JOIN   sales_company sc
      ON     sc.sales_company_id = sa.sales_company_id
      WHERE  TRUNC(s.entered_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
            -- AND (s.service_id = e.service_id OR s.service_id = h.service_id)
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND s.utl_id = nvl(ipsUtlId, s.utl_id)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
                  ipnSalesCompanyId = 0)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND s.service_type = nvl(ipsServiceType, s.service_type)
      
      UNION
      
      SELECT DISTINCT c.first_name,
                      c.last_name,
                      c.street,
                      ss.utl_acct_id "UTL Account",
                      u.utl_short_name "UTL Name",
                      ss.commodity "Commodity",
                      to_char(ss.entered_date, 'dd-MON-yyyy'),
                      NULL,
                      NULL,
                      NULL,
                      
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      trans.get_status(ss.service_id),
                      ss.exc_description "service exc message"
      FROM   customer c
      JOIN   service_exc ss
      ON     ss.customer_id = c.customer_id
      JOIN   utl_out_814_edi u
      ON     ss.utl_id = u.utl_id
      JOIN   sales_source sa
      ON     sa.sales_source_id = ss.sales_source
      JOIN   sales_company sc
      ON     sc.sales_company_id = sa.sales_company_id
      
      WHERE  TRUNC(ss.entered_date_actual) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND ss.exc_description <> 'ReEnrollment'
             AND ss.commodity = nvl(ipscommodity, ss.commodity)
             AND ss.utl_id = nvl(ipsUtlId, ss.utl_id)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
                  ipnSalesCompanyId = 0)
             AND ss.utl_acct_id = nvl(ipsUTLAccountId, ss.utl_acct_id)
             AND (ss.service_id = ipnServiceid OR ipnServiceid = 0)
             AND ss.service_type = nvl(ipsServiceType, ss.service_type);
  
  END;
  ----------------------------------------------------------------------------------------------------------------------------

  PROCEDURE EnrollmentSummary_old(ipsdtBeginDate    IN VARCHAR2,
                                  ipsdtEndDate      IN VARCHAR2,
                                  ipsCommodity      IN VARCHAR2,
                                  ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                  ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                  ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                  ipnServiceid      IN service.service_id%TYPE,
                                  ipsServiceType    IN Service.Service_Type%TYPE,
                                  rfcReport         OUT global.refCur) IS
  BEGIN
    /*
    user                      date                 Comment
    rp                        7/21/2013            groups how many utility,commodity there are.
    */
    OPEN rfcReport FOR
    
      SELECT '' AS " ",
             COUNT(utl_acct_id) "COUNT#", --, GROUPING(b.utl_short_name ),GROUPING(b.commodity),GROUPING(b.status),
             b.utl_short_name "UTL Name",
             b.commodity,
             b.status "Status"
      FROM   (
              
              SELECT s.utl_acct_id,
                      u.utl_short_name,
                      s.commodity,
                      trans.get_status(s.service_id) Status
              
              FROM   customer c
              JOIN   service s
              ON     s.customer_id = c.customer_id
              LEFT   JOIN (SELECT inb.service_id,
                                  inb.utl_name,
                                  inb.status_code,
                                  inb.status_description,
                                  inb.entered_date
                           FROM   inb_814_rsp inb
                           JOIN   service s
                           ON     s.service_id = inb.service_id
                           WHERE  inb.transaction_purpose_code = 'HA'
                                  AND to_char(nvl(inb.entered_date, SYSDATE),
                                              'dd-MON-yyyy') >=
                                  to_char(nvl(s.hst_req_date, SYSDATE),
                                              'dd-MON-yyyy')) h
              ON     h.service_id = s.service_id
              LEFT   JOIN (SELECT inb.service_id,
                                  inb.status_code,
                                  inb.status_description,
                                  inb.entered_date
                           FROM   inb_814_rsp inb
                           JOIN   service s
                           ON     s.service_id = inb.service_id
                           WHERE  inb.transaction_purpose_code = 'EA'
                                  AND to_char(nvl(inb.entered_date, SYSDATE),
                                              'dd-MON-yyyy') >=
                                  to_char(nvl(s.enr_req_date, SYSDATE),
                                              'dd-MON-yyyy')) e
              ON     e.service_id = s.service_id
              JOIN   UTL_OUT_814_EDI u
              ON     s.utl_id = u.utl_id
              JOIN   sales_source sa
              ON     sa.sales_source_id = s.sales_source_id
              JOIN   sales_company sc
              ON     sc.sales_company_id = sa.sales_company_id
              WHERE  TRUNC(s.entered_date) BETWEEN
                     to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
                     to_Date(ipsdtEndDate, 'dd-MON-yyyy')
                    -- AND (s.service_id = e.service_id OR s.service_id = h.service_id)
                     AND s.commodity = nvl(ipscommodity, s.commodity)
                     AND s.utl_id = nvl(ipsUtlId, s.utl_id)
                     AND (sc.sales_company_id = ipnSalesCompanyId OR
                          ipnSalesCompanyId = 0)
                     AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
                     AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
                     AND s.service_type = nvl(ipsServiceType, s.service_type)
              
              UNION
              
              SELECT DISTINCT ss.utl_acct_id "UTL Account",
                               u.utl_short_name "UTL Name",
                               ss.commodity "Commodity",
                               trans.get_status(ss.service_id)
              FROM   customer c
              JOIN   service_exc ss
              ON     ss.customer_id = c.customer_id
              JOIN   utl_out_814_edi u
              ON     ss.utl_id = u.utl_id
              JOIN   sales_source sa
              ON     sa.sales_source_id = ss.sales_source
              JOIN   sales_company sc
              ON     sc.sales_company_id = sa.sales_company_id
              WHERE  TRUNC(ss.entered_date_actual) BETWEEN
                     to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
                     to_Date(ipsdtEndDate, 'dd-MON-yyyy')
                     AND ss.exc_description <> 'ReEnrollment'
                     AND ss.commodity = nvl(ipscommodity, ss.commodity)
                     AND ss.utl_id = nvl(ipsUtlId, ss.utl_id)
                     AND (sc.sales_company_id = ipnSalesCompanyId OR
                          ipnSalesCompanyId = 0)
                     AND
                     ss.utl_acct_id = nvl(ipsUTLAccountId, ss.utl_acct_id)
                     AND (ss.service_id = ipnServiceid OR ipnServiceid = 0)
                     AND
                     ss.service_type = nvl(ipsServiceType, ss.service_type)) b
      GROUP  BY b.utl_short_name, b.commodity, b.status;
    /*
        GROUP BY  rollup(b.utl_short_name ,
                  b.commodity ,
                  b.status)
        HAVING GROUPING(b.utl_short_name ) =1 OR GROUPING(b.status)=0;
    */
  
  END;
  -----------------------------------------------------------------------------------------------
  -- Compliance report for the Utility FF Jan/14/2016
  PROCEDURE COMP_HistoricalRateData(ipsdtBeginDate    IN VARCHAR2,
                                    ipsdtEndDate      IN VARCHAR2,
                                    ipsCommodity      IN VARCHAR2,
                                    ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                    ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                    ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                    ipnServiceid      IN service.service_id%TYPE,
                                    ipsServiceType    IN Service.Service_Type%TYPE,
                                    ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                                    rfcReport         OUT global.refCur) IS
  
  BEGIN
    OPEN rfcReport FOR
    
      SELECT ipsdtBeginDate || '  -  ' || ipsdtEndDate AS "Date Range",
             s.service_class AS "Service Class",
             ur.utl_short_name AS "Utility",
             decode(s.commodity, 'E', 'Electric', 'Gas') AS "Commodity",
             s.utl_zone AS "Zone",
             COUNT(DISTINCT s.service_id) "Number of Accounts",
             decode(rp.rate_plan_type,
                    'Fixed',
                    rp.duration_amount || ' ' || rp.duration_type,
                    '') AS "Term Length",
             round(decode(s.commodity, 'E', AVG(i.rate_amount)), 4) AS "Electric Average Rate",
             round(decode(s.commodity, 'G', AVG(i.rate_amount)), 4) AS "Gas Average Rate",
             mu.uom AS "Unit of Measure"
      FROM   service           s,
             service_rate_plan srp,
             rate_plan         rp,
             utl_rpm           ur,
             invoice           i,
             inb_867_mu        mu
      WHERE  s.service_id = srp.service_id
             AND srp.expired_date IS NULL
             AND srp.rate_plan_id = rp.rate_plan_id
             AND s.utl_id = ur.utl_id
             AND s.service_id = i.service_id
             AND mu.service_id = i.service_id
             AND mu.utl_tracking_id = i.mu_utl_tracking_id
             AND s.start_service_date IS NOT NULL
             AND
             s.start_service_date <= to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND nvl(s.end_service_date, SYSDATE + 1000) >=
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy')
             AND i.transaction_date BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND mu.uom = DECODE(i.commodity, 'E', 'KH', mu.uom)
             AND
             i.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         i.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) -- --YB 12/4/2017  = nvl(ipsUtlId,i.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             ur.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         ur.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) -- --YB 12/4/2017
      GROUP  BY s.service_class,
                ur.utl_short_name,
                s.commodity,
                s.utl_zone,
                decode(rp.rate_plan_type,
                       'Fixed',
                       rp.duration_amount || ' ' || rp.duration_type,
                       ''),
                mu.uom
      ORDER  BY "Utility";
  END;
  ---------------------------------------------------------------------------------------------------------------------------
  PROCEDURE CommissionFactorOfUsageReport(ipsdtBeginDate    IN VARCHAR2,
                                          ipsdtEndDate      IN VARCHAR2,
                                          ipsCommodity      IN VARCHAR2,
                                          ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                          ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                          ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                          ipnServiceid      IN service.service_id%TYPE,
                                          ipsServiceType    IN Service.Service_Type%TYPE,
                                          rfcReport         OUT global.refCur) IS
  BEGIN
    /*
    user                      date          comment
    rp                        7/21/2013     this report figures out the factor of usage commission.
    */
    OPEN rfcReport FOR
    
      SELECT '' AS " ",
             mu.inb_867_mu_id AS "867_MU_ID",
             sc.sales_company_name AS "Sales Company",
             sc.sales_company_id AS "Sales Company ID",
             cp.commission_plan_id AS "Commission Plan ID",
             ct.commission_type AS "Commission Type",
             c.first_name AS "Customer First Name",
             c.last_name AS "Customer Last Name",
             utl.utl_short_name AS "UTL Name",
             s.utl_acct_id AS "UTL Account",
             s.commodity AS "Commodity",
             s.service_id AS "Service Id",
             s.entered_date AS "Enter Date",
             mu.start_date AS "Start Date",
             mu.end_date AS "End Date",
             mu.TOTAL_USAGE_AMOUNT AS "Usage Amount~~d4#",
             cp.per_uom_amount AS "Commission Rate~~d2",
             cp.per_uom_amount * nvl(mu.TOTAL_USAGE_AMOUNT, 0) AS "Commission Amount~~d2#",
             CASE
                WHEN getCommissionRate(cp.commission_plan_id, s.service_id) = 0 THEN
                 0
                ELSE
                 cp.per_uom_amount * nvl(mu.TOTAL_USAGE_AMOUNT, 0)
              END AS "Actual Commission Amount~~c2#",
             cp.charge_back_days_amount AS "Charge back days",
             cb.event_description AS "Charge back event",
             GetChargeBackEventDate(cb.event_name, s.service_id) AS "Event Date",
             s.end_service_date AS "Cancel date",
             cp.min_yearly_usage_amount AS "Min Yearly Usage Required",
             usAGE.GET_YEARLY_USAGE_AMOUNT(s.service_id) AS "Yearly Usage~~d4#",
             PAY.PAID_AMOUNT AS "Amount Paid~~c2#",
             DECODE(PAY.Inb_867_Mu_Id, NULL, 0, 1) AS "Processed"
      FROM   inb_867_Mu mu
      LEFT   JOIN commission_payments PAY
      ON     mu.inb_867_mu_id = PAY.INB_867_MU_ID
      INNER  JOIN service s
      ON     s.service_id = mu.service_id
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      INNER  JOIN sales_source ss
      ON     ss.sales_source_id = s.sales_source_id
      INNER  JOIN commission_plan cp
      ON     ss.commission_plan_id = cp.commission_plan_id
      INNER  JOIN commission_types ct
      ON     ct.commission_types_id = cp.commission_types_id
      INNER  JOIN Charge_Back_From_Events cb
      ON     cb.charge_back_from_events_id = cp.charge_back_from_event
      INNER  JOIN UTL_OUT_814_EDI utl
      ON     utl.utl_id = s.utl_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = ss.sales_company_id
      WHERE  1 = 1
             AND TRUNC(mu.end_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND ct.commission_type = 'FACTOR_OF_USAGE'
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND utl.utl_id = nvl(ipsUtlId, utl.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'));
  END;
  -----------------------------------------------------------------------------------------------
  PROCEDURE CommissionPercentageOfInvoice(ipsdtBeginDate    IN VARCHAR2,
                                          ipsdtEndDate      IN VARCHAR2,
                                          ipsCommodity      IN VARCHAR2,
                                          ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                          ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                          ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                          ipnServiceid      IN service.service_id%TYPE,
                                          ipsServiceType    IN Service.Service_Type%TYPE,
                                          rfcReport         OUT global.refCur) IS
  BEGIN
  
    /*
    user                      date          comment
    rp                        7/21/2013     this report figures out the percentage of invoice commission.
    */
  
    OPEN rfcReport FOR
      SELECT sc.sales_company_name AS "Company Name",
             ct.commission_type AS "Commission Type",
             c.first_name AS "Customer First Name",
             c.last_name AS "Customer Last Name",
             utl.utl_short_name AS "UTL Name",
             i.utl_acct_id AS "UTL Account Id",
             i.commodity AS "Commodity",
             s.service_id AS "Service Id",
             to_char(s.entered_date, 'dd-MON-yyyy') AS "Enter Date",
             to_char(i.start_date, 'dd-MON-yyyy') AS "Start Date",
             to_char(i.end_date, 'dd-MON-yyyy') AS "End Date",
             TO_char(nvl(i.ENERGY_CHARGES_AMOUNT, 0), '999,999,999,999.99') AS "Invoice Amount#",
             CP.PER_INVOICE_PERCENTAGE_AMOUNT AS "Commission Rate",
             TO_char(CP.PER_INVOICE_PERCENTAGE_AMOUNT *
                     nvl(I.ENERGY_CHARGES_AMOUNT, 0),
                     '999,999,999,999.99') AS "Commission Amount#",
             CASE
                WHEN reports.getCommissionRate(cp.commission_plan_id,
                                               s.service_id) = 0 THEN
                 to_char(0, '999,999,999,999.99')
                ELSE
                 TO_char(CP.PER_INVOICE_PERCENTAGE_AMOUNT *
                         nvl(I.ENERGY_CHARGES_AMOUNT, 0),
                         '999,999,999,999.99')
              END AS "Actual Commission Amount#",
             cp.charge_back_days_amount AS "Charge back days",
             cb.event_description AS "Charge back event",
             reports.GetChargeBackEventDate(cb.event_name, s.service_id) AS "Event Date",
             to_char(s.end_service_date, 'dd-MON-yyyy') AS "Cancel date",
             cp.min_yearly_usage_amount AS "Min Yearly Usage Required",
             to_char(usAGE.GET_YEARLY_USAGE_AMOUNT(s.service_id),
                     '999,999,999,999.99') AS "Yearly Usage"
      FROM   invoice i
      INNER  JOIN (SELECT MAX(iv.invoice_id) InvoiceID, iv.service_id
                   FROM   invoice iv
                   WHERE  TRUNC(iv.transaction_date) BETWEEN
                          to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
                          to_Date(ipsdtEndDate, 'dd-MON-yyyy')
                   GROUP  BY iv.start_date, iv.service_id) p
      ON     p.invoiceid = i.invoice_id
             AND p.service_id = i.service_id
      INNER  JOIN service s
      ON     s.service_id = i.service_id
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      INNER  JOIN sales_source ss
      ON     ss.sales_source_id = s.sales_source_id
      INNER  JOIN commission_plan cp
      ON     ss.commission_plan_id = cp.commission_plan_id
      INNER  JOIN commission_types ct
      ON     ct.commission_types_id = cp.commission_types_id
      INNER  JOIN Charge_Back_From_Events cb
      ON     cb.charge_back_from_events_id = cp.charge_back_from_event
      INNER  JOIN UTL_OUT_814_EDI utl
      ON     utl.utl_id = i.utl_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = ss.sales_company_id
      WHERE  1 = 1
             AND ct.commission_type = 'PERCENTAGE_OF_INVOICE'
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND utl.utl_id = nvl(ipsUtlId, utl.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'));
  END;
  -----------------------------------------------------------------------------------------------
  PROCEDURE CommissionOneTimeFlatAmount(ipsdtBeginDate    IN VARCHAR2,
                                        ipsdtEndDate      IN VARCHAR2,
                                        ipsCommodity      IN VARCHAR2,
                                        ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                        ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                        ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                        ipnServiceid      IN service.service_id%TYPE,
                                        ipsServiceType    IN Service.Service_Type%TYPE,
                                        rfcReport         OUT global.refCur) IS
    --This report calculates OneTimeFlatAmount commissions. 
    --It also needs to take into account One and Two Meter Amounts.
    --We need to look for a 2nd meter in the following ways (simpler & more reliable to more complex):
    --FIRST:  Does this CUSTOMER have 2 services. If YES, then we have a 2 meter; Look no further.
    --SECOND: Not the same customer, but the UTL_ID and UTL_ACCT_ID is the same across 2 commodites. If YES, then we have a 2 meter; Look no further.
    --THIRD and final: None of the above, but the SERVICE_ADDRESS is the same across 2 commodites. If YES, then we have a 2 meter; Look no further.
    --Per FF, the way we handle a 2 meter payment is by applying 1/2 for each service record. (This greatly simplifies everything)
    --Furthermore, check that the 2 meter is valid (days between signups are within spec)
    --ALSO and IMPORTANT, if the 2 commission plans for the shidduch we just created are divergent and contradictory and therefore we dont know how much to pay
    --Then we need to determine a course of action, possibly a note or an exception or both.
  
  BEGIN
    OPEN rfcReport FOR
      SELECT sc.sales_company_name AS "Company Name",
             ct.commission_type AS "Commission Type",
             c.first_name AS "Customer First Name",
             c.last_name AS "Customer Last Name",
             utl.utl_short_name AS "UTL Name",
             s.utl_acct_id AS "UTL Account Id",
             s.commodity AS "Commodity",
             s.service_id AS "Service Id",
             to_char(s.entered_date, 'dd-MON-yyyy') AS "Enter Date",
             to_char(s.start_service_date, 'dd-MON-yyyy') AS "Start Date",
             CASE
                WHEN REPORTS.GetTwoMeterCommission(s.service_id) IS NOT NULL THEN
                 'TWO-METER'
                ELSE
                 'ONE-METER'
              END AS "Type of Commission",
             TO_char(nvl(getTwoMeterCommission(s.service_id),
                         cp.one_meter_amount),
                     '999,999,999,999.99') AS "Commission Amount#",
             CASE
                WHEN reports.getCommissionRate(cp.commission_plan_id,
                                               s.service_id) = 0 THEN
                 to_char(0, '999,999,999,999.99')
                ELSE
                 TO_char(nvl(getTwoMeterCommission(s.service_id),
                             cp.one_meter_amount),
                         '999,999,999,999.99')
              END AS "Actual Commission Amount#",
             cp.charge_back_days_amount AS "Charge back days",
             cb.event_description AS "Charge back event",
             reports.GetChargeBackEventDate(cb.event_name, s.service_id) AS "Event Date",
             to_char(s.end_service_date, 'dd-MON-yyyy') AS "Cancel date",
             cp.min_yearly_usage_amount AS "Min Yearly Usage Required",
             to_char(usAGE.GET_YEARLY_USAGE_AMOUNT(s.service_id),
                     '999,999,999,999.99') AS "Yearly Usage"
      FROM   service s
      INNER  JOIN customer c
      ON     s.customer_id = c.customer_id
      INNER  JOIN sales_source src
      ON     src.sales_source_id = s.sales_source_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = src.sales_company_id
      INNER  JOIN commission_plan cp
      ON     src.commission_plan_id = cp.commission_plan_id
      INNER  JOIN commission_types ct
      ON     ct.commission_types_id = cp.commission_types_id
      INNER  JOIN Charge_Back_From_Events cb
      ON     cb.charge_back_from_events_id = cp.charge_back_from_event
      INNER  JOIN UTL_OUT_814_EDI utl
      ON     utl.utl_id = s.utl_id
      WHERE  1 = 1
             AND TRUNC(s.start_service_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND ct.commission_type = 'ONE_TIME_FLAT_AMOUNT'
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND utl.utl_id = nvl(ipsUtlId, utl.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND s.service_type = nvl(ipsServiceType, s.service_type);
  END;
  -----------------------------------------------------------------------------------------------

  PROCEDURE CommissionsReportDetail(ipsdtBeginDate    IN VARCHAR2,
                                    ipsdtEndDate      IN VARCHAR2,
                                    ipsCommodity      IN VARCHAR2,
                                    ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                    ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                    ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                    ipnServiceid      IN service.service_id%TYPE,
                                    ipsServiceType    IN Service.Service_Type%TYPE,
                                    ipsStates         IN utl_rpm.state%TYPE,
                                    rfcReport         OUT global.refCur) IS
  
  BEGIN
    OPEN rfcReport FOR
      SELECT ct.commission_transaction_id   AS "Commission Transaction ID",
             sc.sales_company_name          AS "Sales Company",
             ct.sales_agent_name            AS "Sales Agent",
             ct.commission_plan_id          AS "Commission Plan ID",
             ct.commission_description      AS "Commission Description",
             u.utl_short_name               AS "Utility Name",
             s.commodity                    AS "Commodity",
             s.utl_acct_id                  AS "Utility Account ID",
             s.service_type                 AS "Service Type",
             s.acceptance_conn_receipt_date AS "Connection Accepted Date",
             ct.customer_id                 AS "Customer ID",
             ct.service_id                  AS "Service ID",
             ct.invoice_id                  AS "Invoice ID",
             c.last_name                    AS "Last Name",
             c.first_name                   AS "First Name",
             s.start_service_date           AS "Start Service Date",
             s.end_service_date             AS "End Service Date",
             ct.commission_date             AS "Commission Date",
             ct.commission_transaction_type AS "Commission Type", --Feel free to decode here as needed
             --ct.description                     as "Notes", --Feel free to decode here as needed
             ct.amount AS "Commission Amount~~c2#",
             decode(ct.payment_id, NULL, ct.amount, 0) AS "Commission Amount Owed~~c2#",
             decode(ct.payment_id, NULL, 0, ct.amount) AS "Commission Amount Paid~~c2#",
             ct.payment_ref_id AS "Payment Reference ID",
             ct.payment_date AS "Payment Date",
             ct.payment_entered_by AS "Payment Entered By",
             ct.yearly_usage_amount AS "Yearly Usage Amount~~d4",
             ct.min_yearly_usage_amount AS "Min Yearly Usage Amount~~d4",
             ct.monthly_usage_amount AS "Monthly Usage~~d4",
             ct.ineligible_reason AS "Ineligible Reason",
             ct.ineligible_amount AS "Ineligible Amount~~d2",
             
             DECODE(ct.payment_id, NULL, 0, 1) AS "Paid"
      FROM   COMMISSION_TRANSACTION ct
      INNER  JOIN SALES_COMPANY sc
      ON     ct.sales_company_id = sc.sales_company_id
      INNER  JOIN CUSTOMER c
      ON     ct.customer_id = c.customer_id
      LEFT   JOIN SERVICE s
      ON     ct.service_id = s.service_id
      LEFT   JOIN UTL_RPM u
      ON     s.utl_id = u.utl_id
      WHERE  1 = 1
             AND TRUNC(ct.commission_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy') -- FF changed Nov/5/14 to commission date
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             u.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         u.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017 = nvl(ipsUtlId,u.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             u.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         u.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL)
      ORDER  BY ct.customer_id, ct.service_id, ct.entered_date;
  END;
  -----------------------------------------------------------------------------------------------------------

  PROCEDURE CommissionsShortDetail(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                                   rfcReport         OUT global.refCur) IS
  BEGIN
    OPEN rfcReport FOR
      SELECT sc.sales_company_name AS "Sales Company",
             ct.sales_agent_name AS "Sales Agent",
             c.first_name AS "Customer First Name",
             c.last_name AS "Customer Last Name",
             ct.amount AS "Commission Amount~~c2#",
             decode(ct.payment_id, NULL, ct.amount, 0) AS "Commission Amount Owed~~c2#",
             decode(ct.payment_id, NULL, 0, ct.amount) AS "Commission Amount Paid~~c2#",
             ct.payment_ref_id AS "Payment Reference ID",
             ct.commission_description AS "Commission Description",
             u.utl_short_name AS "Utility Name",
             s.commodity AS "Commodity",
             s.utl_acct_id AS "Utility Account ID",
             s.service_type AS "Service Type",
             ct.invoice_id AS "Invoice ID",
             i.start_date AS "Invoice Start Date",
             i.end_date AS "Invoice End Date",
             
             s.start_service_date           AS "Start Service Date",
             s.end_service_date             AS "End Service Date",
             ct.commission_date             AS "Commission Date",
             ct.commission_transaction_type AS "Commission Type",
             ct.service_id                  AS "Service ID",
             ct.payment_entered_by          AS "Payment Entered By",
             ct.ineligible_reason           AS "Ineligible Reason",
             ct.ineligible_amount           AS "Ineligible Amount~~d2"
      FROM   COMMISSION_TRANSACTION ct
      INNER  JOIN SALES_COMPANY sc
      ON     ct.sales_company_id = sc.sales_company_id
      INNER  JOIN CUSTOMER c
      ON     ct.customer_id = c.customer_id
      LEFT   JOIN SERVICE s
      ON     ct.service_id = s.service_id
      LEFT   JOIN UTL_RPM u
      ON     s.utl_id = u.utl_id
      LEFT   JOIN invoice i
      ON     i.invoice_id = ct.invoice_id
      WHERE  1 = 1
             AND TRUNC(ct.commission_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             u.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         u.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017 = nvl(ipsUtlId,u.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             u.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         u.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY sc.sales_company_name, ct.commission_date DESC;
  
  END;

  -----------------------------------------------------------------------------------------------------------

  PROCEDURE CommissionsReportDetail_OLD(ipsdtBeginDate    IN VARCHAR2,
                                        ipsdtEndDate      IN VARCHAR2,
                                        ipsCommodity      IN VARCHAR2,
                                        ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                        ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                        ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                        ipnServiceid      IN service.service_id%TYPE,
                                        ipsServiceType    IN Service.Service_Type%TYPE,
                                        rfcReport         OUT global.refCur) IS
  
  BEGIN
    OPEN rfcReport FOR
      SELECT ct.commission_transaction_id   AS "Commission Transaction ID",
             sc.sales_company_name          AS "Sales Company",
             ct.commission_plan_id          AS "Commission Plan ID",
             ct.commission_description      AS "Commission Description",
             u.utl_short_name               AS "Utility Name",
             s.commodity                    AS "Commodity",
             s.utl_acct_id                  AS "Utility Account ID",
             s.service_type                 AS "Service Type",
             s.acceptance_conn_receipt_date AS "Connection Accepted Date",
             ct.customer_id                 AS "Customer ID",
             ct.service_id                  AS "Service ID",
             ct.invoice_id                  AS "Invoice ID",
             c.last_name                    AS "Last Name",
             c.first_name                   AS "First Name",
             s.start_service_date           AS "Start Service Date",
             s.end_service_date             AS "End Service Date",
             --ct.entered_date                    as "Commission Date",
             ct.commission_transaction_type AS "Commission Type", --Feel free to decode here as needed
             --ct.description                     as "Notes", --Feel free to decode here as needed
             ct.amount AS "Commission Amount~~c2#",
             ct.yearly_usage_amount AS "Yearly Usage Amount~~d4",
             ct.min_yearly_usage_amount AS "Min Yearly Usage Amount~~d4",
             ct.monthly_usage_amount AS "Monthly Usage~~d4",
             ct.ineligible_reason AS "Ineligible Reason",
             ct.ineligible_amount AS "Ineligible Amount~~d2",
             ct.payment_ref_id AS "Payment Reference ID",
             ct.payment_date AS "Payment Date",
             ct.payment_entered_by AS "Payment Entered By",
             DECODE(ct.payment_id, NULL, 0, 1) AS "Paid"
      FROM   COMMISSION_TRANSACTION ct
      INNER  JOIN SALES_COMPANY sc
      ON     ct.sales_company_id = sc.sales_company_id
      INNER  JOIN CUSTOMER c
      ON     ct.customer_id = c.customer_id
      LEFT   JOIN SERVICE s
      ON     ct.service_id = s.service_id
      LEFT   JOIN UTL_RPM u
      ON     s.utl_id = u.utl_id
      WHERE  1 = 1
             AND TRUNC(ct.commission_date) <=
             to_Date(ipsdtEndDate, 'dd-MON-yyyy') -- FF changed Nov/5/14 to commission date
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND u.utl_id = nvl(ipsUtlId, u.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND s.service_type = nvl(ipsServiceType, s.service_type)
      ORDER  BY ct.customer_id, ct.service_id, ct.entered_date;
  END;
  -----------------------------------------------------------------------------------------------
  PROCEDURE OpenCommissionsReport(ipsdtBeginDate    IN VARCHAR2,
                                  ipsdtEndDate      IN VARCHAR2,
                                  ipsCommodity      IN VARCHAR2,
                                  ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                  ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                  ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                  ipnServiceid      IN service.service_id%TYPE,
                                  ipsServiceType    IN Service.Service_Type%TYPE,
                                  ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                                  rfcReport         OUT global.refCur) IS
  
  BEGIN
    OPEN rfcReport FOR
      SELECT ipsdtEndDate AS "As Of Date",
             sc.sales_company_name AS "Sales Company",
             ct.sales_agent_name AS "Sales Agent",
             ct.commission_description AS "Commission Description",
             ct.amount AS "Commission Amount~~c2#",
             ct.commission_date AS "Commission Date",
             ct.commission_transaction_type AS "Commission Type",
             DECODE(ct.payment_id, NULL, 0, 1) AS "Paid",
             c.last_name AS "Last Name",
             c.first_name AS "First Name",
             u.utl_short_name AS "Utility Name",
             s.commodity AS "Commodity",
             s.utl_acct_id AS "Utility Account ID",
             s.service_type AS "Service Type",
             i.start_date AS "Invoice Start Date",
             i.end_date AS "Invoice End Date",
             s.start_service_date AS "Start Service Date",
             s.end_service_date AS "End Service Date",
             ct.period_usage_amount AS "Period Usage Amount~~d4",
             ct.eligible_period_usage_amount AS "Elig Period Usage Amount~~d4",
             ct.period_invoice_charge AS "Period Invoice Chrg~~c2#",
             ct.eligible_period_invoice_charge AS "Elig Period Invoice Chrg~~c2#",
             ct.yearly_usage_amount AS "Yearly Usage Amount~~d4",
             ct.min_yearly_usage_amount AS "Min Yearly Usage Amount~~d4",
             ct.monthly_usage_amount AS "Monthly Usage~~d4",
             ct.ineligible_reason AS "Ineligible Reason",
             ct.ineligible_amount AS "Ineligible Amount~~d2",
             ct.payment_ref_id AS "Payment Reference ID",
             ct.payment_date AS "Payment Date",
             ct.payment_entered_by AS "Payment Entered By",
             s.acceptance_conn_receipt_date AS "Connection Accepted Date",
             ct.customer_id AS "Customer ID",
             ct.service_id AS "Service ID",
             ct.invoice_id AS "Invoice ID",
             ct.commission_transaction_id AS "Commission Transaction ID",
             ct.commission_plan_id AS "Commission Plan ID"
      FROM   COMMISSION_TRANSACTION ct
      INNER  JOIN SALES_COMPANY sc
      ON     ct.sales_company_id = sc.sales_company_id
      INNER  JOIN CUSTOMER c
      ON     ct.customer_id = c.customer_id
      LEFT   JOIN SERVICE s
      ON     ct.service_id = s.service_id
      LEFT   JOIN UTL_RPM u
      ON     s.utl_id = u.utl_id
      LEFT   JOIN invoice i
      ON     i.invoice_id = ct.invoice_id
      WHERE  1 = 1
             AND TRUNC(ct.commission_date) <=
             to_Date(ipsdtEndDate, 'dd-MON-yyyy') -- FF changed Nov/5/14 to commission date
             AND ct.payment_date IS NULL
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             u.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         u.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017= nvl(ipsUtlId,u.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             u.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         u.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY ct.commission_date, ct.customer_id, ct.service_id;
  END;
  -----------------------------------------------------------------------------------------------
  PROCEDURE OpenCommissionsReport_OLD(ipsdtBeginDate    IN VARCHAR2,
                                      ipsdtEndDate      IN VARCHAR2,
                                      ipsCommodity      IN VARCHAR2,
                                      ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                      ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                      ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                      ipnServiceid      IN service.service_id%TYPE,
                                      ipsServiceType    IN Service.Service_Type%TYPE,
                                      rfcReport         OUT global.refCur) IS
  
  BEGIN
    OPEN rfcReport FOR
      SELECT ipsdtEndDate                   AS "As Of Date",
             ct.commission_transaction_id   AS "Commission Transaction ID",
             sc.sales_company_name          AS "Sales Company",
             ct.commission_plan_id          AS "Commission Plan ID",
             ct.commission_description      AS "Commission Description",
             u.utl_short_name               AS "Utility Name",
             s.commodity                    AS "Commodity",
             s.utl_acct_id                  AS "Utility Account ID",
             s.service_type                 AS "Service Type",
             s.acceptance_conn_receipt_date AS "Connection Accepted Date",
             ct.customer_id                 AS "Customer ID",
             ct.service_id                  AS "Service ID",
             ct.invoice_id                  AS "Invoice ID",
             c.last_name                    AS "Last Name",
             c.first_name                   AS "First Name",
             s.start_service_date           AS "Start Service Date",
             s.end_service_date             AS "End Service Date",
             --ct.entered_date                    as "Commission Date",
             ct.commission_transaction_type AS "Commission Type", --Feel free to decode here as needed
             --ct.description                     as "Notes", --Feel free to decode here as needed
             ct.amount AS "Commission Amount~~c2#",
             ct.yearly_usage_amount AS "Yearly Usage Amount~~d4",
             ct.min_yearly_usage_amount AS "Min Yearly Usage Amount~~d4",
             ct.monthly_usage_amount AS "Monthly Usage~~d4",
             ct.ineligible_reason AS "Ineligible Reason",
             ct.ineligible_amount AS "Ineligible Amount~~d2",
             ct.payment_ref_id AS "Payment Reference ID",
             ct.payment_date AS "Payment Date",
             ct.payment_entered_by AS "Payment Entered By",
             DECODE(ct.payment_id, NULL, 0, 1) AS "Paid"
      FROM   COMMISSION_TRANSACTION ct
      INNER  JOIN SALES_COMPANY sc
      ON     ct.sales_company_id = sc.sales_company_id
      INNER  JOIN CUSTOMER c
      ON     ct.customer_id = c.customer_id
      LEFT   JOIN SERVICE s
      ON     ct.service_id = s.service_id
      LEFT   JOIN UTL_RPM u
      ON     s.utl_id = u.utl_id
      WHERE  1 = 1
             AND
             TRUNC(ct.entered_date) <= to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND ct.payment_date IS NULL
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND u.utl_id = nvl(ipsUtlId, u.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND s.service_type = nvl(ipsServiceType, s.service_type)
      ORDER  BY ct.customer_id, ct.service_id, ct.entered_date;
  END;
  -----------------------------------------------------------------------------------------------

  PROCEDURE get_UTL_Names(rfcUTLName OUT global.refcur) IS
  BEGIN
    OPEN rfcUTLName FOR
      SELECT DISTINCT u.UTL_short_Name, u.utl_id
      FROM   UTL_OUT_814_EDI u
      WHERE  u.display_flag = 'Y'
      --union
      --select Display, to_char(Value) from Constants where name = 'All' --YB 12/4/2017
      ORDER  BY 1 ASC;
  END;

  ---------------------------------------------------------------------------------------------------
  PROCEDURE ChurnReport(ipsdtBeginDate    IN VARCHAR2,
                        ipsdtEndDate      IN VARCHAR2,
                        ipsCommodity      IN VARCHAR2,
                        ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                        ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                        ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                        ipnServiceid      IN service.service_id%TYPE,
                        ipsServiceType    IN Service.Service_Type%TYPE,
                        ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                        rfcReport         OUT global.refCur) IS
  BEGIN
    /*
    user                      date          comment
    rp                        7/21/2013     this report returns data giving you info about the cancel information
    FF/RL                     7/19/2017     Modified to join the out_814 and the inb_814_req to include the cancel reason
    */
  
    OPEN rfcReport FOR
      SELECT s.customer_id "Customer ID",
             s.service_id "Service ID",
             s.utl_acct_id "Utility Account ID",
             u.utl_short_name "Utility Name",
             s.commodity "Commodity",
             c.first_name AS "First Name",
             c.last_name AS "Last Name/Company Name",
             s.cancel_req_source AS "Cancel Request Source",
             s.cancel_req_date AS "Cancel Request Date",
             (ou.cancel_reason_code ||
             decode(ou.cancel_reason_description,
                     NULL,
                     '',
                     ' - ' || ou.cancel_reason_description)) "Cancel Reason Description",
             s.start_service_date "Start Service Date",
             s.end_service_date AS "End Service Date",
             st.status AS "Status",
             sc.sales_company_name "Sales Company",
             c.phone "Phone Number",
             c.email "Email"
      FROM   service s
      JOIN   customer c
      ON     s.customer_id = c.customer_id
      JOIN   utl_out_814_edi u
      ON     s.utl_id = u.utl_id
             AND s.commodity = u.commodity
      JOIN   sales_source ss
      ON     s.sales_source_id = ss.sales_source_id
      JOIN   sales_company sc
      ON     sc.sales_company_id = ss.sales_company_id
      JOIN   service_status st
      ON     st.service_id = s.service_id -- FF Jul/12/2017 take out get_status - is too slow
             AND st.service_status_id =
             (SELECT MAX(service_status_id)
                  FROM   service_status
                  WHERE  service_id = s.service_id)
      INNER  JOIN OUT_814 ou --ff/rl 7/19/2017
      ON     ou.scheduled_date = s.cancel_req_date
             AND ou.service_id = s.service_id
             AND ou.transaction_purpose_code = 'DQ'
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = s.utl_id --YB 12/4/2017
      
      WHERE  TRUNC(s.cancel_req_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017   = nvl(ipsUtlId,s.utl_id)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
                  ipnSalesCompanyId = 0)
             AND
             u.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         u.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017= nvl(ipsUtlId,u.utl_id) --?  YB 12/4/2017 seems redundant of AND s.utl_id = nvl(ipsUtlId,s.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity) --? is this written twice
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      
      UNION --ff/rl 7/19/2017
      
      SELECT s.customer_id         "Customer ID",
             s.service_id          "Service ID",
             s.utl_acct_id         "Utility Account ID",
             u.utl_short_name      "Utility Name",
             s.commodity           "Commodity",
             c.first_name          AS "First Name",
             c.last_name           AS "Last Name/Company Name",
             s.cancel_req_source   AS "Cancel Request Source",
             s.cancel_req_date     AS "Cancel Request Date",
             ib.status_description "Cancel Reason Description",
             s.start_service_date  "Start Service Date",
             s.end_service_date    AS "End Service Date",
             st.status             AS "Status",
             sc.sales_company_name "Sales Company",
             c.phone               "Phone Number",
             c.email               "Email"
      FROM   service s
      JOIN   customer c
      ON     s.customer_id = c.customer_id
      JOIN   utl_out_814_edi u
      ON     s.utl_id = u.utl_id
             AND s.commodity = u.commodity
      JOIN   sales_source ss
      ON     s.sales_source_id = ss.sales_source_id
      JOIN   sales_company sc
      ON     sc.sales_company_id = ss.sales_company_id
      JOIN   service_status st
      ON     st.service_id = s.service_id -- FF Jul/12/2017 take out get_status - is too slow
             AND st.service_status_id =
             (SELECT MAX(service_status_id)
                  FROM   service_status
                  WHERE  service_id = s.service_id)
      
      INNER  JOIN inb_814_req ib --ff/rl 7/19/2017
      ON     ib.transaction_date = nvl(s.cancel_req_date, SYSDATE + 100000)
             AND ib.service_id = s.service_id
             AND ib.end_service_date = s.end_service_date
             AND ib.transaction_purpose_code = 'DQ'
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = s.utl_id --YB 12/4/2017
      
      WHERE  TRUNC(s.cancel_req_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017   = nvl(ipsUtlId,s.utl_id)= nvl(ipsUtlId,s.utl_id)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
                  ipnSalesCompanyId = 0)
             AND
             u.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         u.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017= nvl(ipsUtlId,u.utl_id) --?  YB 12/4/2017 seems redundant of AND s.utl_id = nvl(ipsUtlId,s.utl_id)= nvl(ipsUtlId,u.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity) --? is this written twice
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY 9 DESC;
  
  END;
  -----------------------------------------------------------------------------------------------
  PROCEDURE ChurnReportSummary(ipsdtBeginDate    IN VARCHAR2,
                               ipsdtEndDate      IN VARCHAR2,
                               ipsCommodity      IN VARCHAR2,
                               ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                               ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                               ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                               ipnServiceid      IN service.service_id%TYPE,
                               ipsServiceType    IN Service.Service_Type%TYPE,
                               ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                               rfcReport         OUT global.refCur) IS
  BEGIN
    /*
    user                      date          comment
    rp                        7/21/2013     this report returns data summing up how many records with the  cancel_req_date
                                             fall into the date range parameters
    */
    OPEN rfcReport FOR
      SELECT '' AS " ",
             COUNT(*) "Count#",
             upper(u.utl_short_name) "Utility Name",
             s.commodity "Commodity",
             upper(sc.sales_company_name) "Sales Company"
      FROM   service s
      JOIN   utl_out_814_edi u
      ON     s.utl_id = u.utl_id
             AND s.commodity = u.commodity
      JOIN   sales_source ss
      ON     ss.sales_source_id = s.sales_source_id
      JOIN   sales_company sc
      ON     sc.sales_company_id = ss.sales_company_id
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = s.utl_id
      /*LEFT JOIN sales_agent   a
      ON  s.sales_agent_id = a.sales_agent_id
      LEFT JOIN sales_company sc
      ON a.sales_company_id = sc.sales_company_id*/
      WHERE  TRUNC(s.cancel_req_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         u.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017= nvl(ipsUtlId,s.utl_id)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
                  ipnSalesCompanyId = 0)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      GROUP  BY upper(u.utl_short_name),
                s.commodity,
                upper(sc.sales_company_name);
  END;
  -------------------------------------------------------------------------------
  PROCEDURE GetListOfReports(rfcReports        OUT global.refCur,
                             ipsReportCategory IN VARCHAR2) IS
  BEGIN
  
    OPEN rfcReports FOR
      SELECT *
      FROM   (SELECT r.report_def_id || '-' || r.package_name || '.' ||
                     r.procedure_name "report_def_id",
                     r.report_name,
                     r.package_name || '.' || r.procedure_name "FullReportName"
              FROM   report_def r
              WHERE  (r.report_Category = ipsReportCategory OR
                     ipsReportCategory = '--ALL--')
                     AND r.display_flag = 'Y' -- FF changed mar/11/2014
              UNION ALL
              SELECT VALUE || '-.', DISPLAY, ' '
              FROM   CONSTANTS
              WHERE  NAME = 'SelectReport')
      ORDER  BY REPORT_NAME ASC;
  END;
  --------------------------------------------------------------------------------
  FUNCTION GetTwoMeterCommission(ipnServiceId IN service.service_id%TYPE)
    RETURN NUMBER IS
    bIsValidTwoMeter VARCHAR2(1) := 0;
  
    nFirstTwoMeterAmount     NUMBER := 0;
    nFirstDaysBetweenSignups NUMBER := 0;
    dtFirstMeterSignupDate   DATE;
  
    nSecondMeterServiceID     service.service_id%TYPE := 0;
    nSecondTwoMeterAmount     NUMBER := 0;
    nSecondDaysBetweenSignups NUMBER := 0;
    dtSecondMeterSignupDate   DATE;
  
  BEGIN
    --FIRST:  Does this CUSTOMER have 2 services. If YES, then we have a 2 meter; Look no further.                  
    BEGIN
      SELECT s1.Service_ID
      INTO   nSecondMeterServiceID
      FROM   SERVICE s1
      INNER  JOIN SERVICE s2
      ON     s1.customer_id = s2.customer_id
      WHERE  1 = 1
             AND s1.service_id <> s2.service_id
             AND s1.commodity <> s2.commodity
            --AND SERVICE_IS_VALID_AND_ELIGIBLE_FOR_COMMISSION-----IMPORTANT!!
            --SAME SALES COMPANY?!!?
             AND ROWNUM < 2 --FOR NOW JUST TAKE THE FIRST GUY
             AND s2.service_id = ipnServiceId;
      bIsValidTwoMeter := 1;
    EXCEPTION
      WHEN no_data_found THEN
        --SECOND: Not the same customer, but the UTL_ID and UTL_ACCT_ID is the same across 2 commodites. If YES, then we have a 2 meter; Look no further.
        BEGIN
          SELECT s1.Service_ID
          INTO   nSecondMeterServiceID
          FROM   SERVICE s1
          INNER  JOIN SERVICE s2
          ON     s1.utl_id = s2.utl_id
                 AND s1.utl_acct_id = s2.utl_acct_id
          WHERE  1 = 1
                 AND s1.service_id <> s2.service_id
                 AND s1.commodity <> s2.commodity
                --AND SERVICE_IS_VALID_AND_ELIGIBLE_FOR_COMMISSION-----IMPORTANT!!
                --SAME SALES COMPANY?!!?
                 AND ROWNUM < 2 --FOR NOW JUST TAKE THE FIRST GUY
                 AND s2.service_id = ipnServiceId;
          bIsValidTwoMeter := 1;
        EXCEPTION
          WHEN no_data_found THEN
            --THIRD and final: None of the above, but the SERVICE_ADDRESS is the same across 2 commodites. If YES, then we have a 2 meter; Look no further.
            BEGIN
              SELECT s1.Service_ID
              INTO   nSecondMeterServiceID
              FROM   SERVICE s1
              INNER  JOIN SERVICE s2
              ON     s1.street = s2.street
                     AND s1.suite = s2.suite
                     AND s1.city = s2.city
                     AND s1.state = s2.state
                     AND s1.zip_code = s2.zip_code
              WHERE  1 = 1
                     AND s1.service_id <> s2.service_id
                     AND s1.commodity <> s2.commodity
                    --AND SERVICE_IS_VALID_AND_ELIGIBLE_FOR_COMMISSION-----IMPORTANT!!
                    --SAME SALES COMPANY?!!?
                     AND ROWNUM < 2 --FOR NOW JUST TAKE THE FIRST GUY
                     AND s2.service_id = ipnServiceId;
              bIsValidTwoMeter := 1;
            EXCEPTION
              WHEN no_data_found THEN
                RETURN NULL;
            END;
        END;
    END;
  
    IF nSecondMeterServiceID > 0 THEN
      --Lets get all the details for each service (can we avoid these extra queries in a sensible way?)
      SELECT s.entered_date, cp.two_meters_amount, cp.days_between_signups
      INTO   dtFirstMeterSignupDate,
             nFirstTwoMeterAmount,
             nFirstDaysBetweenSignups
      FROM   service s
      INNER  JOIN sales_source src
      ON     s.sales_source_id = src.sales_source_id
      INNER  JOIN commission_plan cp
      ON     src.commission_plan_id = cp.commission_plan_id
      WHERE  s.service_id = ipnServiceId;
    
      SELECT s.entered_date, cp.two_meters_amount, cp.days_between_signups
      INTO   dtSecondMeterSignupDate,
             nSecondTwoMeterAmount,
             nSecondDaysBetweenSignups
      FROM   service s
      INNER  JOIN sales_source src
      ON     s.sales_source_id = src.sales_source_id
      INNER  JOIN commission_plan cp
      ON     src.commission_plan_id = cp.commission_plan_id
      WHERE  s.service_id = nSecondMeterServiceID;
    
      --CHECK IF PLANS ARE COMPATIBLE (for now if 2 meter amount is the same)
      IF (nFirstTwoMeterAmount <> nSecondTwoMeterAmount) OR
         (nFirstDaysBetweenSignups <> nSecondDaysBetweenSignups) THEN
        bIsValidTwoMeter := 0;
      END IF;
    
      --CHECK IF MEETS TWO-METER SIGNUP CRITERIA
      IF ABS(TRUNC(dtSecondMeterSignupDate) - TRUNC(dtFirstMeterSignupDate)) >
         nFirstDaysBetweenSignups THEN
        bIsValidTwoMeter := 0;
      END IF;
    
      IF bIsValidTwoMeter = 1 THEN
        RETURN nFirstTwoMeterAmount * .5; --RETURN 50% OF TWO-METER-AMOUNT
      ELSE
        RETURN NULL;
      END IF;
    ELSE
      RETURN NULL;
    END IF;
  END;
  --------------------------------------------------------------------------------
  FUNCTION GetCommissionRate(ipnCommissionPlanId IN commission_plan.commission_plan_id%TYPE,
                             ipnServiceId        IN service.service_id%TYPE)
  
   RETURN NUMBER IS
    ChargeBackFieldName VARCHAR2(100);
    ChargeBackDays      NUMBER;
    NumberOfDays        NUMBER;
    MinYearlyUsage      NUMBER;
  
  BEGIN
    SELECT cp.charge_back_days_amount,
           ce.event_name,
           cp.min_yearly_usage_amount
    INTO   ChargeBackDays, ChargeBackFieldName, MinYearlyUsage
    FROM   commission_plan cp
    INNER  JOIN charge_back_from_events ce
    ON     ce.charge_back_from_events_id = cp.charge_back_from_event
    WHERE  cp.commission_plan_id = ipnCommissionPlanId;
  
    IF ChargeBackFieldName = 'START_SERVICE_DATE' THEN
      SELECT nvl(s.end_service_date - s.START_SERVICE_DATE, ChargeBackDays)
      INTO   NumberOfDays
      FROM   service s
      WHERE  s.service_id = ipnServiceId;
    ELSIF ChargeBackFieldName = 'ENTERED_DATE' THEN
      SELECT nvl(s.end_service_date - s.ENTERED_DATE, ChargeBackDays)
      INTO   NumberOfDays
      FROM   service s
      WHERE  s.service_id = ipnServiceId;
    ELSIF ChargeBackFieldName = 'HST_REQ_DATE' THEN
      SELECT nvl(s.end_service_date - s.HST_REQ_DATE, ChargeBackDays)
      INTO   NumberOfDays
      FROM   service s
      WHERE  s.service_id = ipnServiceId;
    ELSIF ChargeBackFieldName = 'ACCEPTANCE_CONN_RECEIPT_DATE' THEN
      SELECT nvl(s.end_service_date - s.ACCEPTANCE_CONN_RECEIPT_DATE,
                 ChargeBackDays)
      INTO   NumberOfDays
      FROM   service s
      WHERE  s.service_id = ipnServiceId;
    ELSIF ChargeBackFieldName = 'ENR_REQ_DATE' THEN
      SELECT nvl(s.end_service_date - s.ENR_REQ_DATE, ChargeBackDays)
      INTO   NumberOfDays
      FROM   service s
      WHERE  s.service_id = ipnServiceId;
    ELSE
      SELECT ChargeBackDays
      INTO   NumberOfDays
      FROM   dual;
    END IF;
  
    IF NumberOfDays <= ChargeBackDays OR
       USAGE.GET_YEARLY_USAGE_AMOUNT(ipnServiceId) < MinYearlyUsage THEN
      RETURN 0;
    ELSE
      RETURN 1;
    END IF;
  END;
  -----------------------------------------------------------------------
  PROCEDURE ChargeBackReport(ipsdtBeginDate    IN VARCHAR2,
                             ipsdtEndDate      IN VARCHAR2,
                             ipsCommodity      IN VARCHAR2,
                             ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                             ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                             ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                             ipnServiceid      IN service.service_id%TYPE,
                             ipsServiceType    IN Service.Service_Type%TYPE,
                             rfcReports        OUT global.refCur) IS
  BEGIN
  
    OPEN rfcReports FOR
      SELECT sc.sales_company_name "Company Name",
             SA.SALES_AGENT_USER_NAME "Sales Agent User Name",
             SA.FIRST_NAME "Sales Agent First Name",
             SA.LAST_NAME "Sales Agent Last Name",
             c.first_name "First Name",
             c.last_name "Last Name",
             sv.utl_acct_id "Utlility Account ID",
             u.utl_short_name "Utility Name",
             cp.charge_back_days_amount "Charge back days",
             cb.event_description "Charge back event",
             sv.end_service_date "Cancel date",
             cp.min_yearly_usage_amount "Min Yearly Usage Required",
             usAGE.GET_YEARLY_USAGE_AMOUNT(sv.service_id) "Yearly Usage",
             nvl(GetChargeBackEventDate(cb.event_name, sv.service_id), '') "Event Date"
      FROM   service sv
      INNER  JOIN sales_source ss
      ON     sv.sales_source_id = ss.sales_source_id
      INNER  JOIN commission_plan cp
      ON     cp.commission_plan_id = ss.commission_plan_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = ss.sales_company_id
      INNER  JOIN charge_back_from_events cb
      ON     cb.charge_back_from_events_id = cp.charge_back_from_event
      INNER  JOIN customer c
      ON     c.customer_id = sv.customer_id
      INNER  JOIN utl_out_814_edi u
      ON     u.utl_id = sv.utl_id
      LEFT   JOIN sales_agent sa
      ON     sa.sales_company_id = sc.sales_company_id
      WHERE  1 = 1
             AND TRUNC(sv.end_service_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND u.utl_id = nvl(ipsUtlId, u.utl_id)
             AND sv.commodity = nvl(ipsCommodity, sv.commodity)
             AND sv.utl_acct_id = nvl(ipsUTLAccountId, sv.utl_acct_id)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND (sv.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(sv.service_type, '~') =
             nvl(ipsServiceType, nvl(sv.service_type, '~'))
             AND
             GetCommissionRate(cp.commission_plan_id, sv.service_id) = 0;
  END;

  -------------------------------------------------------------------------------------------
  FUNCTION GetChargeBackEventDate(ipsEventName IN charge_back_from_events.event_name%TYPE,
                                  ipnServiceId IN service.service_id%TYPE)
  
   RETURN VARCHAR2
  
   IS
    ChargeBackFieldName VARCHAR2(100);
  BEGIN
    SELECT CASE
             WHEN TRIM(ipsEventName) = 'START_SERVICE_DATE' THEN
              to_char(sv.start_service_date, 'dd-MON-yyyy')
             WHEN TRIM(ipsEventName) = 'ENTERED_DATE' THEN
              to_char(sv.entered_date, 'dd-MON-yyyy')
             WHEN TRIM(ipsEventName) = 'ENR_REQ_DATE' THEN
              to_char(sv.enr_req_date, 'dd-MON-yyyy')
             WHEN TRIM(ipsEventName) = 'ACCEPTANCE_CONN_RECEIPT_DATE' THEN
              to_char(sv.acceptance_conn_receipt_date, 'dd-MON-yyyy')
             WHEN TRIM(ipsEventName) = 'HST_REQ_DATE' THEN
              to_char(sv.hst_req_date, 'dd-MON-yyyy')
           END
    INTO   ChargeBackFieldName
    FROM   service sv
    WHERE  sv.service_id = ipnServiceId;
  
    RETURN nvl(ChargeBackFieldName, '');
  END;
  --------------------------------------------------------------------------------------------

  PROCEDURE GetReportParam(ipnReportDefId IN report_def.report_def_id%TYPE,
                           rfcReportParam OUT global.refCur) IS
  BEGIN
  
    OPEN rfcReportParam FOR
      SELECT *
      FROM   report_param r
      WHERE  r.report_def_id = ipnReportDefId;
  
  END;
  ---------------------------------------------------------------------------------------------
  PROCEDURE GetListOfReportCategory(rfcReportCategory OUT global.refCur)
  
   IS
  BEGIN
  
    OPEN rfcReportCategory FOR
      SELECT DISTINCT r.report_category ReportCategory
      FROM   report_def r
      UNION
      SELECT Display
      FROM   Constants
      WHERE  NAME = 'All';
    -- UNION
    -- SELECT ' ' FROM dual;
  END;
  ---------------------------------------------------------------------------------------------
  PROCEDURE GetListOfStates(rfcListOfStates OUT global.refCur)
  -- YB NOv/27/17 This is for a new dropdown in the reports form front end to display and select states
   IS
  BEGIN
  
    OPEN rfcListOfStates FOR
      SELECT DISTINCT state
      FROM   utl_rpm
      WHERE  display_flag = 'Y'
      --UNION
      --SELECT Display FROM Constants where Name = 'All'
      ORDER  BY state;
  
  END;
  ------------------------------------------------------------------------------------------
  PROCEDURE BillingDetail(ipsdtBeginDate    IN VARCHAR2,
                          ipsdtEndDate      IN VARCHAR2,
                          ipsCommodity      IN VARCHAR2,
                          ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                          ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                          ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                          ipnServiceid      IN service.service_id%TYPE,
                          ipsServiceType    IN Service.Service_Type%TYPE,
                          ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                          
                          rfcReport OUT global.refCur)
  
   IS
  
    /* 28 July 2014 FF AH
    Original code returned results using an inner join on inb_824, which left out
    rate ready entries that don't have an inbound 824.
    in addition, pending inbound entries were also left out.
    a union select was added to retrieve Rate Ready entries, and pending action code
    entries was also added.
    an additional invoice status column was added.*/
  
    /* FF Apr/20/2015 ****IMPORTANT NOTE:****
    When calculating Billing - Total Current Charges,  we actually need to INCLUDE the invoices that 
    got a cancel,re-read because since we place that whole amount in the re-read invoice as an adjustment
    the original invoice is needed for the final calculation to cancel out,  so if
    we exclude the invoice that was cancelled the total amounts will show wrong  
     that's why the statement is wrong here and correct by the tax calculation.
    ...AND NOT EXISTS (SELECT 1 FROM inb_867_mu mu WHERE service_id = i.service_id AND mu.cancelled_utl_tracking_id = i.mu_utl_tracking_id)   --EXCLUDE CANCELED-FOR-REREAD INVOICES
     (Consider changing the whole billing to be with cancelled invoices and then thhis issue will disapear)
    */
  
  BEGIN
    OPEN rfcReport FOR
      SELECT --ss 2/03/2014
       decode(i824.action_code,
              'CF',
              'Accepted',
              NULL,
              'Pending',
              '82',
              'Rejected') AS "Invoice Status", -- FF modified added the code 82 for rejections. Need to make sure is the same code for all utilities.
       i.transaction_date AS "Invoice Date",
       s.customer_id AS "Customer ID",
       s.service_id AS "Service ID",
       u814.utl_short_name AS "Utility Name",
       i.utl_acct_id AS "Utility Account ID",
       i.commodity AS "Commodity",
       s.service_type AS "Service Type",
       s.utl_rate_class AS "Utility Rate Class", --NM 8/11/2015 
       i.invoice_id AS "Invoice ID",
       c.last_name AS "Last Name",
       c.first_name AS "First Name",
       s.street AS "Address",
       s.city AS "City",
       rpm.state AS "State", --YB 12/5/2017 changed from s.state because s.state entries where inaccurate
       s.zip_code AS "Zip",
       i.rate_amount AS "Rate",
       i.state_sales_tax_rate AS "State Tax Rate",
       nvl(i.total_usage_amount, 0) AS "Total Usage~~d4#",
       i.start_date AS "Start Date",
       i.end_date AS "End Date",
       nvl(i.rate_amount, 0) AS "Energy Rate Amount",
       nvl(i.state_sales_tax_rate, 0) AS "State Sales Tax Rate",
       nvl(i.energy_charges_amount, 0) AS "Energy Charges~~d2#",
       nvl(i.miscelanous_charge_amount, 0) AS "Misc. Charges~~d2#",
       nvl(i.adjustment_amount, 0) AS "Adjustments~~d2#",
       nvl(i.total_cancelled_charges_amount, 0) AS "Canceled Charges~~d2#",
       nvl(i.state_sales_tax_amount, 0) AS "Tax~~d2#",
       nvl(i.total_current_charges_amount, 0) AS "Total Current Charges~~c2#",
       rp.rate_plan_description AS "Current Rate Plan",
       nvl(rp.rate_code, rp.rate_amount) AS "Rate Amount or Code",
       rp.rate_plan_type AS "Rate Plan Type",
       rp.rate_plan_id AS "Rate Plan ID", -- NM 8/11/2015
       rp.utl_zone AS "Utility Zone"
      FROM   invoice i
      LEFT   JOIN inb_824 i824
      ON     i.invoice_id = i824.invoice_id
      -- and ( NVL(i824.action_code,'Pending') = 'CF'           -- FF taken out nov/11/2014
      --      OR NVL(i824.action_code,'Pending') = 'Pending')  -- FF taken out nov/11/2014 
      INNER  JOIN service s
      ON     s.service_id = i.service_id
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      INNER  JOIN utl_out_814_edi u814
      ON     u814.utl_id = i.utl_id
             AND u814.commodity = i.commodity
      INNER  JOIN sales_source ssrc
      ON     ssrc.sales_source_id = s.sales_source_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = ssrc.sales_company_id
      INNER  JOIN service_rate_plan srp
      ON     srp.service_id = i.service_id
      INNER  JOIN rate_plan rp
      ON     rp.rate_plan_id = srp.rate_plan_id
      INNER  JOIN utl_rpm rpm
      ON     rpm.utl_id = u814.utl_id
      WHERE  1 = 1
             AND u814.billing_method = 'UBR'
             AND srp.expired_date IS NULL
             AND TRUNC(i.transaction_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017 = nvl(ipsUtlId,s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      UNION
      SELECT 'Rate Ready' AS "Invoice Status",
             i.transaction_date AS "Invoice Date",
             s.customer_id AS "Customer ID",
             s.service_id AS "Service ID",
             u814.utl_short_name AS "Utility Name",
             i.utl_acct_id AS "Utility Account ID",
             i.commodity AS "Commodity",
             s.service_type AS "Service Type",
             s.utl_rate_class AS "Utility Rate Class",
             i.invoice_id AS "Invoice ID",
             c.last_name AS "Last Name",
             c.first_name AS "First Name",
             s.street AS "Address",
             s.city AS "City",
             rpm.state AS "State", --YB 12/5/2017 changed from s.state because s.state entries where inaccurate
             s.zip_code AS "Zip",
             i.rate_amount AS "Rate",
             i.state_sales_tax_rate AS "State Tax Rate",
             nvl(i.total_usage_amount, 0) AS "Total Usage~~d4#",
             i.start_date AS "Start Date",
             i.end_date AS "End Date",
             nvl(i.rate_amount, 0) AS "Energy Rate Amount",
             nvl(i.state_sales_tax_rate, 0) AS "State Sales Tax Rate",
             nvl(i.energy_charges_amount, 0) AS "Energy Charges~~d2#",
             nvl(i.miscelanous_charge_amount, 0) AS "Misc. Charges~~d2#",
             nvl(i.adjustment_amount, 0) AS "Adjustments~~d2#",
             nvl(i.total_cancelled_charges_amount, 0) AS "Canceled Charges~~d2#",
             nvl(i.state_sales_tax_amount, 0) AS "Tax~~d2#",
             nvl(i.total_current_charges_amount, 0) AS "Total Current Charges~~c2#",
             rp.rate_plan_description AS "Current Rate Plan",
             nvl(rp.rate_code, rp.rate_amount) AS "Rate Amount or Code",
             rp.rate_plan_type AS "Rate Plan Type",
             rp.rate_plan_id AS "Rate Plan ID", -- NM 8/11/2015
             rp.utl_zone AS "Utility Zone"
      FROM   invoice i
      INNER  JOIN service s
      ON     s.service_id = i.service_id
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      INNER  JOIN utl_out_814_edi u814
      ON     u814.utl_id = i.utl_id
             AND u814.commodity = i.commodity
      INNER  JOIN sales_source ssrc
      ON     ssrc.sales_source_id = s.sales_source_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = ssrc.sales_company_id
      INNER  JOIN service_rate_plan srp
      ON     srp.service_id = i.service_id
      INNER  JOIN rate_plan rp
      ON     rp.rate_plan_id = srp.rate_plan_id
      INNER  JOIN utl_rpm rpm
      ON     rpm.utl_id = u814.utl_id
      WHERE  1 = 1
             AND u814.billing_method <> 'UBR'
             AND srp.expired_date IS NULL
             AND TRUNC(i.transaction_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017 replaced = nvl(ipsUtlId,s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY "Invoice Date", "Utility Name", "Commodity", "Invoice ID";
  END;
  --------------------------------------------------------------------------------------
  PROCEDURE BillingSummary(ipsdtBeginDate    IN VARCHAR2,
                           ipsdtEndDate      IN VARCHAR2,
                           ipsCommodity      IN VARCHAR2,
                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                           ipnServiceid      IN service.service_id%TYPE,
                           ipsServiceType    IN Service.Service_Type%TYPE,
                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                           rfcReport         OUT global.refCur) AS
    /*  28 July 2014 FF AH
    Original code returned results using an inner join on inb_824, which left out
    rate ready entries that don't have an inbound 824.
    in addition, pending inbound entries were also left out.
    a union select was added to retrieve Rate Ready entries, and pending action code
    entries was also added.*/
  
    /* FF Apr/20/2015 ****IMPORTANT NOTE:****
    When calculating Billing - Total Current Charges,  we actually need to INCLUDE the invoices that 
    got a cancel,re-read because since we place that whole amount in the re-read invoice as an adjustment
    the original invoice is needed for the final calculation to cancel out,  so if
    we exclude the invoice that was cancelled the total amounts will show wrong  
     that's why the statement is wrong here and correct by the tax calculation.
    ...AND NOT EXISTS (SELECT 1 FROM inb_867_mu mu WHERE service_id = i.service_id AND mu.cancelled_utl_tracking_id = i.mu_utl_tracking_id)   --EXCLUDE CANCELED-FOR-REREAD INVOICES
     (Consider changing the whole billing to be with cancelled invoices and then thhis issue will disapear)
    */
    /*
    BK Mar/1/2016 Fixed the average value for the state sales tax. It was showing the wrong amount
    */
  
  BEGIN
  
    OPEN rfcReport FOR
      SELECT u814.utl_short_name AS "Utility Name",
             i.commodity AS "Commodity",
             s.service_type AS "Service Type",
             COUNT(DISTINCT i.service_id) AS "Amount of Services#",
             SUM(nvl(i.total_usage_amount, 0)) AS "Total Usage~~d4#",
             round(AVG(nvl(i.total_usage_amount, 0)), 4) AS "Average Usage~~d4",
             round(AVG(i.rate_amount), 4) AS "Average Rate Amount~~d4",
             round(AVG(nvl(i.state_sales_tax_rate, 0)), 4) AS "Average State Sales Tax Rate",
             SUM(nvl(i.energy_charges_amount, 0)) AS "Energy Charges~~d2#",
             round(AVG(nvl(i.energy_charges_amount, 0)), 4) AS "Average Energy Charges~~d2#",
             SUM(nvl(i.miscelanous_charge_amount, 0)) AS "Misc. Charges~~d2#",
             SUM(nvl(i.adjustment_amount, 0)) AS "Adjustments~~d2#",
             SUM(nvl(i.total_cancelled_charges_amount, 0)) AS "Canceled Charges~~d2#",
             SUM(nvl(i.state_sales_tax_amount, 0)) AS "Tax~~d2#",
             SUM(nvl(i.total_current_charges_amount, 0)) AS "Total Current Charges~~c2#",
             round(AVG(nvl(i.total_current_charges_amount, 0)), 2) AS "Average Total Charges~~d2#"
      
      FROM   invoice i
      INNER  JOIN service s
      ON     s.service_id = i.service_id
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      INNER  JOIN utl_out_814_edi u814
      ON     u814.utl_id = i.utl_id
             AND u814.commodity = i.commodity
      INNER  JOIN utl_rpm rpm
      ON     rpm.utl_id = u814.utl_id
      WHERE  1 = 1
             AND u814.billing_method = 'UBR'
             AND TRUNC(i.transaction_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017 = nvl(ipsUtlId,s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      GROUP  BY u814.utl_short_name, i.commodity, s.service_type
      
      UNION
      
      SELECT u814.utl_short_name AS "Utility Name",
             i.commodity AS "Commodity",
             s.service_type AS "Service Type",
             COUNT(DISTINCT i.service_id) AS "Amount of Services#",
             SUM(nvl(i.total_usage_amount, 0)) AS "Total Usage~~d4#",
             round(AVG(nvl(i.total_usage_amount, 0)), 4) AS "Average Usage~~d4",
             round(AVG(i.rate_amount), 4) AS "Average Rate Amount~~d4",
             round(AVG(nvl(i.state_sales_tax_rate, 0)), 4) AS "Average State Sales Tax Rate",
             SUM(nvl(i.energy_charges_amount, 0)) AS "Energy Charges~~d2#",
             round(AVG(nvl(i.energy_charges_amount, 0)), 2) AS "Average Energy Charges~~d2#",
             SUM(nvl(i.miscelanous_charge_amount, 0)) AS "Misc. Charges~~d2#",
             SUM(nvl(i.adjustment_amount, 0)) AS "Adjustments~~d2#",
             SUM(nvl(i.total_cancelled_charges_amount, 0)) AS "Canceled Charges~~d2#",
             SUM(nvl(i.state_sales_tax_amount, 0)) AS "Tax~~d2#",
             SUM(nvl(i.total_current_charges_amount, 0)) AS "Total Current Charges~~c2#",
             round(AVG(nvl(i.total_current_charges_amount, 0)), 2) AS "Average Total Charges~~d2#"
      FROM   invoice i
      INNER  JOIN service s
      ON     s.service_id = i.service_id
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      INNER  JOIN utl_out_814_edi u814
      ON     u814.utl_id = i.utl_id
             AND u814.commodity = i.commodity
      INNER  JOIN utl_rpm rpm
      ON     rpm.utl_id = u814.utl_id
      WHERE  1 = 1
             AND u814.billing_method <> 'UBR'
             AND TRUNC(i.transaction_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017 = nvl(ipsUtlId,s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      GROUP  BY u814.utl_short_name, i.commodity, s.service_type;
  END;
  ---------------------------------------------------------------------------------------------
  PROCEDURE UnBilledDetail(ipsdtBeginDate    IN VARCHAR2,
                           ipsdtEndDate      IN VARCHAR2, -- this is as_of_date
                           ipsCommodity      IN VARCHAR2,
                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                           ipnServiceid      IN service.service_id%TYPE,
                           ipsServiceType    IN Service.Service_Type%TYPE,
                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                           rfcReport         OUT global.refCur) AS
  
    -- TRUNC(SYSDATE) to be replaced by AS_OF_DATE
  BEGIN
  
    OPEN rfcReport FOR
      SELECT first_name     AS "First Name",
             last_name      AS "Last Name",
             street         AS "Service Street",
             suite          AS "Service Suite",
             city           AS "Service City",
             state          AS "Service State",
             zip_code       AS "service Zip Code",
             utl_short_name AS "Utility Name",
             utl_acct_id    AS "Utility Account Id",
             commodity      AS "Commodity",
             UnBilledDays   AS "UnBilled Days",
             
             GetProratedBillingAmount(ipdAsOfDate            => to_date(ipsdtEndDate,
                                                                        'DD-MON-YYYY'),
                                      ipdEndServiceDate      => end_service_date,
                                      ipdInvoiceStartDate    => start_date,
                                      ipdInvoiceEndDate      => end_date,
                                      ipnUnbilledDays        => UnBilledDays,
                                      ipnTotalInvoiceUsage   => total_usage_amount,
                                      ipnEnergyChargesAmount => energy_charges_amount,
                                      ipnInvoiceRate         => rate_amount,
                                      ipsCommodity           => commodity,
                                      ipsUtlId               => utl_id,
                                      ipnCurrentRatePlanRate => current_rate_amount,
                                      ipsServiceType         => 'Residential') AS "UnBilled Amount",
             
             total_usage_amount AS "Latest Invoice Usage Amount",
             energy_charges_amount AS "Latest Invoice Energy Charges",
             end_date AS "Latest Invoice End Date",
             start_date AS "Latest Invoice Start Date",
             service_type AS "Service Type",
             end_service_date AS "End Service Date",
             round(rate_amount, 4) AS "Latest Invoice Rate Amount",
             current_rate_amount AS "Current Rate Plan Amount",
             service_id AS "Service Id",
             customer_id AS "Customer Id",
             utl_id AS "UTL ID"
      FROM   (SELECT GetUnbilledDays(ipdAsOfDate       => to_date(ipsdtEndDate,
                                                                  'DD-MON-YYYY'),
                                     ipdEndServiceDate => s.end_service_date,
                                     ipdInvoiceEndDate => i.end_date) UnBilledDays,
                     TRUNC(SYSDATE) AsOfDate,
                     --TRUNC(SYSDATE) - DECODE(nvl(s.end_service_date,SYSDATE + 1000),i.end_date,TRUNC(SYSDATE),i.end_date)  UnbilledDays,
                     i.end_date,
                     s.end_service_date,
                     i.start_date,
                     s.service_type,
                     s.start_service_date,
                     i.total_usage_amount,
                     i.energy_charges_amount,
                     i.rate_amount,
                     i.commodity,
                     i.utl_id,
                     c.first_name,
                     c.last_name,
                     s.street,
                     s.suite,
                     s.city,
                     utl_rpm.state,
                     s.zip_code,
                     rp.rate_amount          current_rate_amount,
                     s.service_id,
                     c.customer_id,
                     s.utl_acct_id,
                     utl_rpm.utl_short_name
              --YB 12/5/2017 changed s.state to utl_rpm.state because s.state was not accurate
              FROM   invoice i
              
              JOIN   (SELECT MAX(iMax.end_date) mxEndDate, service_id
                     FROM   invoice iMax
                     WHERE  iMax.end_date >= /*ipsAsOfDate*/
                            trunc(SYSDATE) - 70
                            AND iMax.transaction_purpose = '00' -- not cancelled invoices
                     GROUP  BY iMax.service_id) curMax
              ON     i.service_id = curMax.service_id
                     AND i.end_date = curMax.mxEndDate
              JOIN   service s
              ON     s.service_id = i.service_id
              JOIN   customer c
              ON     c.customer_id = s.customer_id
              JOIN   service_rate_plan srp
              ON     srp.service_id = s.service_id
              JOIN   rate_plan rp
              ON     rp.rate_plan_id = srp.rate_plan_id
              JOIN   utl_rpm
              ON     utl_rpm.utl_id = s.utl_id
              WHERE  i.transaction_purpose = '00'
                     AND srp.expired_date IS NULL -- make sure we get the current value
              ORDER  BY i.end_date)
      WHERE  1 = 1
             AND commodity = nvl(ipscommodity, commodity)
             AND
             utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL), utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017 = nvl(ipsUtlId,utl_id)
             AND utl_acct_id = nvl(ipsUTLAccountId, utl_acct_id)
             AND nvl(service_type, '~') =
             nvl(ipsServiceType, nvl(service_type, '~'))
             AND (service_ID = ipnServiceid OR ipnServiceid = 0)
             AND
             state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL), state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY last_name;
  
  END;

  ---------------------------------------------------------------------------------------------
  FUNCTION GetUnbilledDays(ipdAsOfDate       IN DATE,
                           ipdEndServiceDate IN service.end_service_date%TYPE,
                           ipdInvoiceEndDate IN invoice.end_date%TYPE)
    RETURN NUMBER AS
  
    -- This function claculates the unbilled daye based on an Invoice end date, end of service date and an AS_OF_DATE
    -- FF Dec/6/2015
  
    nUnbilledDays NUMBER;
  
  BEGIN
    -- Now calculate
    IF ipdEndServiceDate IS NULL THEN
      nUnbilledDays := ipdAsOfDate - ipdInvoiceEndDate;
    ELSE
      IF ipdInvoiceEndDate >= ipdEndServiceDate THEN
        nUnbilledDays := 0;
      ELSE
        -- Which means that ipdInvoiceEndDate < ipdEndServiceDate
        IF ipdAsOfDate <= ipdEndServiceDate THEN
          nUnbilledDays := 0;
        ELSE
          nUnbilledDays := ipdEndServiceDate - ipdInvoiceEndDate;
        END IF;
      END IF;
    END IF;
    RETURN nUnbilledDays;
  
  END;
  --------------------------------------------------------------------------------------------
  FUNCTION GetProratedBillingAmount(ipdAsOfDate            IN DATE,
                                    ipdEndServiceDate      IN service.end_service_date%TYPE,
                                    ipdInvoiceStartDate    IN invoice.start_date%TYPE,
                                    ipdInvoiceEndDate      IN invoice.end_date%TYPE,
                                    ipnUnbilledDays        IN NUMBER,
                                    ipnTotalInvoiceUsage   IN invoice.total_usage_amount%TYPE,
                                    ipnEnergyChargesAmount IN invoice.energy_charges_amount%TYPE,
                                    ipnInvoiceRate         IN invoice.rate_amount%TYPE,
                                    ipsCommodity           IN service.commodity%TYPE,
                                    ipsUtlId               IN service.utl_id%TYPE,
                                    ipnCurrentRatePlanRate IN rate_plan.rate_amount%TYPE,
                                    ipsServiceType         IN service.service_type%TYPE)
    RETURN NUMBER AS
  
    -- This function claculates the unbilled days based on an Invoice end date, end of service date and an AS_OF_DATE
    -- FF Dec/6/2015
  
    nUnbilledDays      NUMBER;
    nUnbilledCharges   NUMBER := 0;
    i                  NUMBER;
    dAdjInvoiceEndDate DATE := ipdInvoiceEndDate - 1; -- We are adjusting the invoice end date because utilities will use
    -- this date for the next month so is really not part of THE invoice
    dLastDayInCalMonthInvSvc DATE;
    nDaysLeftInMonthOfSvc    NUMBER;
    nDailyInvoiceCharge      NUMBER;
    nDailyInvoiceUsage       NUMBER;
    nResInvPctOfYear         NUMBER;
    nComInvPctOfYear         NUMBER;
    nInvoicePctOfYear        NUMBER;
    nResPctOfYear            NUMBER;
    nComPctOfYear            NUMBER;
    sPriorPctMonth           VARCHAR2(10);
    nPriorPctOfYear          NUMBER;
    nCurrentPctOfYear        NUMBER;
    dCurrentDayDate          DATE;
    sCurrentIterationMonth   VARCHAR2(10);
    nNewPctOfYear            NUMBER;
    sCurrentPctMonth         VARCHAR2(10);
    nDaysInInvoice           NUMBER;
  
  BEGIN
  
    /*
    sEndInvoiceMonth := to_char(dAdjInvoiceEndDate,'MON'); -- get the month of the last invoice date
    nDaysInLastInvoiceMonth :=  dAdjInvoiceEndDate - (to_date('1-'|| to_char(dAdjInvoiceEndDate,'MON-YYYY')) );
    -- Calculate how many days from the unBilled Days in the Month of the EndInvoicedate are left in that month
    -- E.G. EndInvoiceDate = Jan/23/2015 and we have 70 unbilled days, so there will be Jan/31 minus Jan/23 = 8
    -- Now those days will be multiplied/prorated by the Daily Charges in that invoice and applied accordingly
    -- We might need to see if the rate changed in the Rate Plan and is different than the Rate in the invoice
    -- Also we might need to check the pct in this month as opposed of the invoice month, depending in the amount 
    --    of totals days of that invoice in that month... that might be an overkill
    */
    dLastDayInCalMonthInvSvc := last_day(dAdjInvoiceEndDate);
    nDaysLeftInMonthOfSvc    := dLastDayInCalMonthInvSvc -
                                dAdjInvoiceEndDate;
    nDaysInInvoice           := dAdjInvoiceEndDate - ipdInvoiceStartDate;
    IF nDaysInInvoice = 0 THEN
      nDaysInInvoice := 1;
    END IF;
    nDailyInvoiceCharge := ipnEnergyChargesAmount / nDaysInInvoice;
    nDailyInvoiceUsage  := ipnTotalInvoiceUsage / nDaysInInvoice;
  
    -- Query the PCT_OF_YEAR for the Invoice Month
    BEGIN
      SELECT RES_PCT_OF_YR, COM_PCT_OF_YR
      INTO   nResInvPctOfYear, nComInvPctOfYear
      FROM   UTL_USAGE_PERCENTAGE usp
      WHERE  usp.commodity = ipsCommodity
             AND usp.utl_id = ipsUtlId
             AND upper(to_char(usp.month_year, 'MON')) =
             upper(to_char(to_date(dAdjInvoiceEndDate), 'MON'))
             AND month_year > to_date('31-dec-2012');
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.Put_Line(SQLERRM);
        DBMS_OUTPUT.Put_Line(to_char(to_date(dAdjInvoiceEndDate), 'MON') || ' ' ||
                             ipsCommodity || ' ' || ipsUtlId);
        RAISE;
    END;
    IF ipsServiceType = 'Residential' THEN
      nInvoicePctOfYear := nResInvPctOfYear;
    ELSE
      nInvoicePctOfYear := nComInvPctOfYear;
    END IF;
    sPriorPctMonth    := to_char(dAdjInvoiceEndDate, 'MON');
    nPriorPctOfYear   := nInvoicePctOfYear;
    nCurrentPctOfYear := nPriorPctOfYear;
    FOR i IN 1 .. ipnUnbilledDays LOOP
      dCurrentDayDate        := dAdjInvoiceEndDate + i;
      sCurrentIterationMonth := to_char(dCurrentDayDate, 'MON');
      IF sCurrentIterationMonth <> sPriorPctMonth THEN
        -- Query the new percentage
        sPriorPctMonth := sCurrentIterationMonth;
        SELECT RES_PCT_OF_YR, COM_PCT_OF_YR
        INTO   nResPctOfYear, nComPctOfYear
        FROM   UTL_USAGE_PERCENTAGE usp
        WHERE  usp.commodity = ipsCommodity
               AND usp.utl_id = ipsUtlId
               AND upper(to_char(usp.month_year, 'MON')) =
               upper(to_char(to_date(dCurrentDayDate), 'MON'))
               AND month_year > '31-dec-2012';
        IF ipsServiceType = 'Residential' THEN
          nNewPctOfYear := nResPctOfYear;
        ELSE
          nNewPctOfYear := nComPctOfYear;
        END IF;
        sCurrentPctMonth  := to_char(dCurrentDayDate, 'MON'); -- Adjust right away for next iteration
        nPriorPctOfYear   := nCurrentPctOfYear;
        nCurrentPctOfYear := nNewPctOfYear;
      END IF;
      nUnbilledCharges := nUnbilledCharges +
                          (nDailyInvoiceUsage * ipnCurrentRatePlanRate *
                          (nCurrentPctOfYear / nPriorPctOfYear));
    END LOOP;
  
    /*        
    
      nUsageInEndServiceMonth := reports.getproratedmonthlyamount(ipdperiodenddate => ipdInvoiceEndDate,
                                                                    ipdinvoicestartdate => ipdinvoicestartdate,
                                                                    ipdinvoiceenddate => ipdInvoiceEndDate,
                                                                    ipntotaltoprorateamount => ipnTotalInvoiceUsage);
      nChargesInEndServiceMonth := reports.getproratedmonthlyamount(ipdperiodenddate => ipdInvoiceEndDate,
                                                                    ipdinvoicestartdate => ipdinvoicestartdate,
                                                                    ipdinvoiceenddate => ipdInvoiceEndDate,
                                                                    ipntotaltoprorateamount => ipnEnergyChargesAmount);
    */
  
    RETURN round(nUnbilledCharges, 2);
  
  END;
  ---------------------------------------------------------------------------------------------
  PROCEDURE RateChangeDetailReportAll(ipsdtBeginDate    IN VARCHAR2,
                                      ipsdtEndDate      IN VARCHAR2,
                                      ipsCommodity      IN VARCHAR2,
                                      ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                      ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                      ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                      ipnServiceid      IN service.service_id%TYPE,
                                      ipsServiceType    IN Service.Service_Type%TYPE,
                                      rfcReport         OUT global.refCur) IS
    /*AH   7/17/2014
    Addition of rate change detail report, matching the results of the rate change summary report.
    AH   7/30/2014
    Start Service date, and billing cycle colummns added.
    Column display order modified.*/
  
  BEGIN
    OPEN rfcReport FOR
      SELECT
      
       C.LAST_NAME AS "Last Name",
       C.FIRST_NAME AS "First Name",
       O.RATE_AMOUNT AS "Rate Amount",
       TRUNC(O.ENTERED_DATE) AS "Request Date",
       DECODE(O.UTL_NAME,
              'Coned',
              TO_DATE(TO_CHAR(TO_DATE(O.EFFECTIVE_DATE, 'YYYYMMDD'),
                              'MM/DD/YYYY'),
                      'MM/DD/YYYY'),
              'OandR',
              TRUNC(O.SCHEDULED_DATE),
              TRUNC(O.SCHEDULED_DATE)) AS "Effective_Date",
       NVL(I.STATUS_CODE, 'Pending') AS "Status Code",
       I.STATUS_DESCRIPTION AS "Status Description",
       NVL(I.TRANSACTION_DATE, NULL) AS "Response Date",
       s.start_service_date AS "Start Service Date",
       s.billing_cycle AS "Billing Cycle",
       S.SERVICE_TYPE AS "Service Type",
       O.SERVICE_ID AS "Service ID",
       O.UTL_NAME AS "Util. Name",
       O.UTL_ACCT_ID AS "Util. Account ID",
       O.COMMODITY AS "Commodity",
       C.CUSTOMER_ID AS "Customer ID",
       IPSDTBEGINDATE AS "Start Date",
       IPSDTENDDATE AS "End Date",
       'Rate Amount Change' AS "Change Request"
      FROM   OUT_814 o
      INNER  JOIN service s
      ON     s.service_id = o.service_id
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      LEFT   OUTER JOIN inb_814_rsp i
      ON     o.esco_tracking_id = i.esco_tracking_id
      WHERE  trunc(o.entered_date) BETWEEN ipsdtBeginDate AND ipsdtEndDate
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND s.utl_id = nvl(ipsUtlId, s.utl_id)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (i.service_id = ipnServiceid OR ipnServiceid = 0)
             AND o.transaction_purpose_code = 'CQ'
             AND o.change_reason_code = 'AMTRJ'
      ORDER  BY o.rate_amount, i.status_code, o.utl_name;
  
  END;

  ---------------------------------------------------------------------------------------------
  PROCEDURE RateChangeDetailReport(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/4/2017
                                   rfcReport         OUT global.refCur) IS
  
    --CU 1/22/15 changed that only the most recent rate change shows because if there were many rejections and then an
    --acceptance, only the acceptance will show(it's not neccessary to show all of the rejections
    /*AH   7/17/2014
    Addition of rate change detail report, matching the results of the rate change summary report.
    AH   7/30/2014
    Start Service date, and billing cycle colummns added.
    Column display order modified.*/
  
  BEGIN
    OPEN rfcReport FOR
      SELECT
      
       C.LAST_NAME AS "Last Name",
       C.FIRST_NAME AS "First Name",
       O.RATE_AMOUNT AS "Rate Amount",
       TRUNC(O.ENTERED_DATE) AS "Request Date",
       DECODE(O.UTL_NAME,
              'Coned',
              TO_DATE(TO_CHAR(TO_DATE(O.EFFECTIVE_DATE, 'YYYYMMDD'),
                              'MM/DD/YYYY'),
                      'MM/DD/YYYY'),
              'OandR',
              TRUNC(O.SCHEDULED_DATE),
              TRUNC(O.SCHEDULED_DATE)) AS "Effective_Date",
       NVL(I.STATUS_CODE, 'Pending') AS "Status Code",
       I.STATUS_DESCRIPTION AS "Status Description",
       NVL(I.TRANSACTION_DATE, NULL) AS "Response Date",
       s.start_service_date AS "Start Service Date",
       s.billing_cycle AS "Billing Cycle",
       S.SERVICE_TYPE AS "Service Type",
       O.SERVICE_ID AS "Service ID",
       O.UTL_NAME AS "Util. Name",
       O.UTL_ACCT_ID AS "Util. Account ID",
       O.COMMODITY AS "Commodity",
       C.CUSTOMER_ID AS "Customer ID",
       IPSDTBEGINDATE AS "Start Date",
       IPSDTENDDATE AS "End Date",
       'Rate Amount Change' AS "Change Request"
      FROM   OUT_814 o
      INNER  JOIN service s
      ON     s.service_id = o.service_id
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      LEFT   OUTER JOIN inb_814_rsp i
      ON     o.esco_tracking_id = i.esco_tracking_id
      INNER  JOIN (SELECT MAX(o8.out_814_id) out_max_id
                   FROM   OUT_814 o8
                   WHERE  trunc(o8.entered_date) BETWEEN ipsdtBeginDate AND
                          ipsdtEndDate
                          AND o8.transaction_purpose_code = 'CQ'
                          AND o8.change_reason_code = 'AMTRJ'
                   GROUP  BY service_id, rate_amount) OUT_MAX
      ON     o.out_814_id = out_max.out_max_id
      INNER  JOIN utl_rpm rpm
      ON     rpm.utl_id = o.utl_id --YB 12/6/2017
      
      WHERE  trunc(o.entered_date) BETWEEN ipsdtBeginDate AND ipsdtEndDate
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017 = nvl(ipsUtlId, s.utl_id)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (i.service_id = ipnServiceid OR ipnServiceid = 0)
             AND o.transaction_purpose_code = 'CQ'
             AND o.change_reason_code = 'AMTRJ'
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY o.rate_amount, i.status_code, o.utl_name;
  
  END;
  ---------------------------------------------------------------------------------------------
  PROCEDURE RateChangeSummaryReport_old(ipsdtBeginDate    IN VARCHAR2,
                                        ipsdtEndDate      IN VARCHAR2,
                                        ipsCommodity      IN VARCHAR2,
                                        ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                        ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                        ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                        ipnServiceid      IN service.service_id%TYPE,
                                        ipsServiceType    IN Service.Service_Type%TYPE,
                                        rfcReport         OUT global.refCur) IS
  BEGIN
    OPEN rfcReport FOR
      SELECT ipsdtBeginDate AS "Start Date",
             ipsdtEndDate AS "End Date",
             COUNT(o.utl_acct_id) AS "Count",
             o.rate_amount AS "Rate Amount",
             o.utl_name AS "Utility Name",
             nvl(i.status_code, 'Pending') AS "Status Code",
             nvl(i.status_description, '') AS "Status Description",
             o.commodity AS "Commodity"
      FROM   OUT_814 o
      LEFT   OUTER JOIN inb_814_rsp i
      ON     o.esco_tracking_id = i.esco_tracking_id
      INNER  JOIN service s
      ON     s.service_id = o.service_id
      WHERE  trunc(o.entered_date) BETWEEN ipsdtBeginDate AND ipsdtEndDate
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND s.utl_id = nvl(ipsUtlId, s.utl_id)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (i.service_id = ipnServiceid OR ipnServiceid = 0)
             AND o.transaction_purpose_code = 'CQ'
             AND o.change_reason_code = 'AMTRJ'
      GROUP  BY o.commodity,
                o.utl_name,
                o.rate_amount,
                i.status_description,
                i.status_code,
                ipsdtBeginDate,
                ipsdtEndDate;
  
  END;

  ---------------------------------------------------------------------------------------------
  PROCEDURE RateChangeSummaryReport(ipsdtBeginDate    IN VARCHAR2,
                                    ipsdtEndDate      IN VARCHAR2,
                                    ipsCommodity      IN VARCHAR2,
                                    ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                    ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                    ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                    ipnServiceid      IN service.service_id%TYPE,
                                    ipsServiceType    IN Service.Service_Type%TYPE,
                                    ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                    rfcReport         OUT global.refCur) IS
  BEGIN
    OPEN rfcReport FOR
      SELECT ipsdtBeginDate AS "Start Date",
             ipsdtEndDate AS "End Date",
             COUNT(o.utl_acct_id) AS "Count",
             o.rate_amount AS "Rate Amount",
             o.utl_name AS "Utility Name",
             nvl(i.status_code, 'Pending') AS "Status Code",
             nvl(i.status_description, '') AS "Status Description",
             o.commodity AS "Commodity"
      FROM   OUT_814 o
      LEFT   OUTER JOIN inb_814_rsp i
      ON     o.esco_tracking_id = i.esco_tracking_id
      INNER  JOIN service s
      ON     s.service_id = o.service_id
      INNER  JOIN (SELECT MAX(o8.out_814_id) out_max_id
                   FROM   OUT_814 o8
                   WHERE  trunc(o8.entered_date) BETWEEN ipsdtBeginDate AND
                          ipsdtEndDate
                          AND o8.transaction_purpose_code = 'CQ'
                          AND o8.change_reason_code = 'AMTRJ'
                   GROUP  BY service_id, rate_amount) OUT_MAX
      ON     o.out_814_id = out_max.out_max_id
      INNER  JOIN utl_rpm rpm
      ON     rpm.utl_id = o.utl_id --YB 12/6/2017
      WHERE  trunc(o.entered_date) BETWEEN ipsdtBeginDate AND ipsdtEndDate
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, s.utl_id)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (i.service_id = ipnServiceid OR ipnServiceid = 0)
             AND o.transaction_purpose_code = 'CQ'
             AND o.change_reason_code = 'AMTRJ'
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      
      GROUP  BY o.commodity,
                o.utl_name,
                o.rate_amount,
                i.status_description,
                i.status_code,
                ipsdtBeginDate,
                ipsdtEndDate;
  
  END;

  ----------------------------------------------------------------------------------------
  PROCEDURE AR_RemittanceSummary(ipsdtBeginDate    IN VARCHAR2,
                                 ipsdtEndDate      IN VARCHAR2,
                                 ipsCommodity      IN VARCHAR2,
                                 ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                 ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                 ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                 ipnServiceid      IN service.service_id%TYPE,
                                 ipsServiceType    IN Service.Service_Type%TYPE,
                                 ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                 rfcReport         OUT global.refCur)
  -- FF redone Around Jan/2016, Updated May/3/2016                                   
   IS
  BEGIN
    OPEN rfcReport FOR
      SELECT DISTINCT i820.utl_name                 AS "Utility Name",
                      i820.commodity                AS "Commodity",
                      i820.total_monetary_amount    AS "Total Monetary Amount",
                      i820.intended_settlement_date AS "Intended Settlement Date",
                      i820.credit_debit_flag        AS "Credit Debit Flag",
                      i820.utl_tracking_id          AS "Utility Tracking Id"
      FROM   inb_820 i820
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = i820.utl_id --YB 12/6/2017
      WHERE  1 = 1
             AND trunc(i820.entered_date) BETWEEN ipsdtBeginDate AND
             ipsdtEndDate
             AND i820.commodity = nvl(ipsCommodity, i820.commodity)
             AND
             i820.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         i820.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, i820.utl_id)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      
      ORDER  BY INTENDED_SETTLEMENT_DATE DESC;
  
  END;
  ---------------------------------------------------------------------------------------------

  PROCEDURE AR_RemittanceDetail(ipsdtBeginDate    IN VARCHAR2,
                                ipsdtEndDate      IN VARCHAR2,
                                ipsCommodity      IN VARCHAR2,
                                ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                ipnServiceid      IN service.service_id%TYPE,
                                ipsServiceType    IN Service.Service_Type%TYPE,
                                ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                rfcReport         OUT global.refCur)
  
   IS
  BEGIN
    OPEN rfcReport FOR
      SELECT --ss 1/30/2014
       i820.customer_name AS "Customer Name",
       i820.UTL_NAME AS "Utility Name", --This should probably be joined to Invoices(+) to include more customer info where available
       CASE UPPER(i820.COMMODITY)
         WHEN 'G' THEN
          'Gas'
         WHEN 'E' THEN
          'Electric'
         ELSE
          'Other'
       END AS "Commodity",
       substr(i820.UTL_ACCT_ID,
              1,
              decode(instr(i820.UTL_ACCT_ID, '^'),
                     0,
                     100,
                     instr(i820.UTL_ACCT_ID, '^') - 1)) AS "Utility Account Id", -- FF oct/5/2014 this is necessary because we placed a number next to the utl acct id when is a code not an account and we need to make it unique
       PR_INVOICED_AMOUNT AS "Invoiced Amount~~d2#",
       PR_DISCOUNT_AMOUNT AS "Discounted~~d2#",
       MONETARY_AMOUNT AS "Remitted Amount~~c2#",
       i820.total_monetary_amount AS "Total Monetary Amount",
       i820.intended_settlement_date AS "Intended Settlement Date",
       POSTING_DATE AS "Posting Date",
       i820.utl_tracking_id AS "Utility Tracking ID",
       i820.transaction_date AS "Transaction Date",
       s.customer_id AS "Customer ID",
       s.service_id AS "Service ID"
      FROM   inb_820 i820
      LEFT   JOIN service s
      ON     s.service_id = i820.service_id
      LEFT   JOIN sales_source ssrc
      ON     ssrc.sales_source_id = s.sales_source_id -- changed to Left join - FF - Oct/5/2014 (Left join wouldn;t work any way as is inner join salses source ???)
      LEFT   JOIN sales_company sc
      ON     sc.sales_company_id = ssrc.sales_company_id -- changed to Left join - FF - Oct/5/2014
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = i820.utl_id --YB 12/6/2017
      WHERE  1 = 1
             AND trunc(i820.entered_date) BETWEEN ipsdtBeginDate AND
             ipsdtEndDate
             AND i820.commodity = nvl(ipsCommodity, i820.commodity)
             AND
             i820.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         i820.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, i820.utl_id)
             AND (i820.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND i820.utl_acct_id = nvl(ipsUTLAccountId, i820.utl_acct_id)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY intended_settlement_date DESC,
                i820.Commodity           ASC,
                PR_INVOICED_AMOUNT       DESC;
  END;
  ---------------------------------------------------------------------------------------------

  PROCEDURE AR_AgingSummaryByUtility(ipsdtBeginDate    IN VARCHAR2,
                                     ipsdtEndDate      IN VARCHAR2,
                                     ipsCommodity      IN VARCHAR2,
                                     ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                     ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                     ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                     ipnServiceid      IN service.service_id%TYPE,
                                     ipsServiceType    IN Service.Service_Type%TYPE,
                                     ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                     rfcReport         OUT global.refCur) IS
    dtAsOfDate DATE;
  
  BEGIN
    dtAsOfDate := LEAST(TRUNC(SYSDATE), ipsdtEndDate); --Dont let End date be greater than today
    OPEN rfcReport FOR
    
      SELECT --ss 1/30/2014
       asOfDate AS "As Of Date",
       ur.utl_short_name AS "Utility Name",
       t.COMMODITY AS "Commodity",
       COUNT(*) AS "No. Of Invoices#",
       SUM(TOTAL_BILLED) AS "Total Billed~~d2#",
       SUM(TOTAL_PAID) AS "Total Paid~~d2#",
       SUM(CASE
              WHEN AGE < 30 THEN
               OPEN_BALANCE
              ELSE
               0
            END) AS "<30~~d2#",
       SUM(CASE
              WHEN AGE BETWEEN 30 AND 60 THEN
               OPEN_BALANCE
              ELSE
               0
            END) AS "30-60~~d2#",
       SUM(CASE
              WHEN AGE BETWEEN 61 AND 90 THEN
               OPEN_BALANCE
              ELSE
               0
            END) AS "61-90~~d2#",
       SUM(CASE
              WHEN AGE BETWEEN 91 AND 120 THEN
               OPEN_BALANCE
              ELSE
               0
            END) AS "91-120~~d2#",
       SUM(CASE
              WHEN AGE > 120 THEN
               OPEN_BALANCE
              ELSE
               0
            END) AS ">120~~d2#",
       SUM(OPEN_BALANCE) AS "Total Open Balance~~c2#"
      FROM   utl_rpm ur,
             (SELECT dtAsOfDate AS asOfDate,
                     i.utl_id AS UTL_ID,
                     i.commodity AS COMMODITY,
                     i.transaction_date AS INVOICE_DATE,
                     i.invoice_id AS INVOICE_ID,
                     (i.total_current_charges_amount) AS INVOICE_AMOUNT, --amount a/r payable to ESCO [regardless of amount paid for POR which is an a/p cheshbon]
                     nvl(i820.pr_invoiced_amount, 0) AS PAID_AMOUNT, --danger - using pr_invoiced_amount, this ASSUMES that 820 applied discounts are validated on the way in!!!
                     TO_DATE(dtAsOfDate) - TRUNC(i.transaction_date) AS AGE,
                     i.total_current_charges_amount AS TOTAL_BILLED,
                     nvl(i820.pr_invoiced_amount, 0) AS TOTAL_PAID,
                     (i.total_current_charges_amount) -
                     nvl(i820.pr_invoiced_amount, 0) AS OPEN_BALANCE
              FROM   invoice i
              INNER  JOIN inb_824 i824
              ON     i.invoice_id = i824.invoice_id
                     AND i824.error_code IS NULL
              LEFT   JOIN inb_820 i820
              ON     i820.invoice_id = i.invoice_id --at least temporarily
                     AND i820.utl_id = i.utl_id
                     AND i820.commodity = i.commodity
              INNER  JOIN service s
              ON     s.service_id = i.service_id
              INNER  JOIN sales_source ssrc
              ON     ssrc.sales_source_id = s.sales_source_id
              INNER  JOIN sales_company sc
              ON     sc.sales_company_id = ssrc.sales_company_id
              INNER  JOIN utl_out_814_edi u814
              ON     u814.utl_id = i.utl_id
                     AND u814.commodity = i.commodity --BK
              JOIN   utl_rpm ur
              ON     ur.utl_id = i.utl_id --YB 12/6/2017
              
              WHERE  1 = 1
                     AND u814.billing_method = 'UBR' --BK 03/14/2016
                     AND trunc(i.transaction_date) <= ipsdtEndDate
                     AND trunc(nvl(i820.posting_date, ipsdtEndDate)) <=
                     ipsdtEndDate
                     AND
                     i.utl_id IN
                     (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                                 i.utl_id)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, i.utl_id)
                     AND i.commodity = nvl(ipsCommodity, i.commodity)
                     AND (nvl(i820.service_ID, ipnServiceid) = ipnServiceid OR
                     ipnServiceid = 0)
                     AND (sc.sales_company_id = ipnSalesCompanyId OR
                     ipnSalesCompanyId = 0)
                     AND nvl(s.service_type, '~') =
                     nvl(ipsServiceType, nvl(s.service_type, '~'))
                     AND i.utl_acct_id = nvl(ipsUTLAccountId, i.utl_acct_id)
                     AND
                     ur.state IN
                     (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                                 ur.state)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
              
              UNION --03/14/2016 BK ADDED UNION
              
              SELECT dtAsOfDate AS asOfDate,
                     i.utl_id AS UTL_ID,
                     i.commodity AS COMMODITY,
                     i.transaction_date AS INVOICE_DATE,
                     i.invoice_id AS INVOICE_ID,
                     (i.total_current_charges_amount) AS INVOICE_AMOUNT, --amount a/r payable to ESCO [regardless of amount paid for POR which is an a/p cheshbon]
                     nvl(i820.pr_invoiced_amount, 0) AS PAID_AMOUNT, --danger - using pr_invoiced_amount, this ASSUMES that 820 applied discounts are validated on the way in!!!
                     TO_DATE(dtAsOfDate) - TRUNC(i.transaction_date) AS AGE,
                     i.total_current_charges_amount AS TOTAL_BILLED,
                     nvl(i820.pr_invoiced_amount, 0) AS TOTAL_PAID,
                     (i.total_current_charges_amount) -
                     nvl(i820.pr_invoiced_amount, 0) AS OPEN_BALANCE
              FROM   invoice i
              LEFT   JOIN inb_820 i820
              ON     i820.invoice_id = i.invoice_id --at least temporarily
                     AND i820.utl_id = i.utl_id
                     AND i820.commodity = i.commodity
              INNER  JOIN service s
              ON     s.service_id = i.service_id
              INNER  JOIN sales_source ssrc
              ON     ssrc.sales_source_id = s.sales_source_id
              INNER  JOIN sales_company sc
              ON     sc.sales_company_id = ssrc.sales_company_id
              INNER  JOIN utl_out_814_edi u814
              ON     u814.utl_id = i.utl_id
                     AND u814.commodity = i.commodity --BK
              JOIN   utl_rpm rpm
              ON     rpm.utl_id = i.utl_id --YB 12/6/2017
              
              WHERE  1 = 1
                     AND u814.billing_method <> 'UBR'
                     AND trunc(i.transaction_date) <= ipsdtEndDate
                     AND trunc(nvl(i820.posting_date, ipsdtEndDate)) <=
                     ipsdtEndDate
                     AND
                     i.utl_id IN
                     (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                                 i.utl_id)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, i.utl_id)
                     AND i.commodity = nvl(ipsCommodity, i.commodity)
                     AND (nvl(i820.service_ID, ipnServiceid) = ipnServiceid OR
                     ipnServiceid = 0)
                     AND (sc.sales_company_id = ipnSalesCompanyId OR
                     ipnSalesCompanyId = 0)
                     AND nvl(s.service_type, '~') =
                     nvl(ipsServiceType, nvl(s.service_type, '~'))
                     AND i.utl_acct_id = nvl(ipsUTLAccountId, i.utl_acct_id)
                     AND
                     rpm.state IN
                     (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                                 rpm.state)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
              ) t
      
      WHERE  ur.utl_id = t.utl_id
      GROUP  BY asOfDate, ur.utl_short_name, t.COMMODITY, ur.state;
  END;
  ---------------------------------------------------------------------------------------------

  PROCEDURE AR_AgingDetailByUtlByAcct(ipsdtBeginDate    IN VARCHAR2,
                                      ipsdtEndDate      IN VARCHAR2,
                                      ipsCommodity      IN VARCHAR2,
                                      ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                      ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                      ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                      ipnServiceid      IN service.service_id%TYPE,
                                      ipsServiceType    IN Service.Service_Type%TYPE,
                                      ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                      rfcReport         OUT global.refCur)
  
   IS
    dtAsOfDate DATE;
  
  BEGIN
    dtAsOfDate := LEAST(TRUNC(SYSDATE), ipsdtEndDate); --Dont let End date be greater than today
    OPEN rfcReport FOR
    
    /*EXCLUDE ALL PAID (NO BALANCE) FROM THE RESULT SET           */
    
      SELECT --ss 1/30/2014
       ur.state, --temp
       asOfDate AS "As of Date",
       t.customer_id AS "Customer ID",
       t.service_id AS "Service ID",
       t.utl_acct_id AS "Utility Account ID",
       ur.utl_short_name AS "Utility Name",
       t.COMMODITY AS "Commodity",
       COUNT(*) AS "No. Of Invoices#",
       SUM(TOTAL_BILLED) AS "Total Billed~~d2#",
       SUM(TOTAL_PAID) AS "Total Paid~~d2#",
       SUM(CASE
              WHEN AGE < 30 THEN
               OPEN_BALANCE
              ELSE
               0
            END) AS "<30~~d2#",
       SUM(CASE
              WHEN AGE BETWEEN 30 AND 60 THEN
               OPEN_BALANCE
              ELSE
               0
            END) AS "30-60~~d2#",
       SUM(CASE
              WHEN AGE BETWEEN 61 AND 90 THEN
               OPEN_BALANCE
              ELSE
               0
            END) AS "61-90~~d2#",
       SUM(CASE
              WHEN AGE BETWEEN 91 AND 120 THEN
               OPEN_BALANCE
              ELSE
               0
            END) AS "91-120~~d2#",
       SUM(CASE
              WHEN AGE > 120 THEN
               OPEN_BALANCE
              ELSE
               0
            END) AS ">120~~d2#",
       SUM(OPEN_BALANCE) AS "Total Open Balance~~c2#"
      FROM   utl_rpm ur,
             (SELECT ur.state, --temp
                     dtAsOfDate AS AsOfDate,
                     s.customer_id,
                     s.service_id,
                     i.utl_id AS UTL_ID,
                     i.utl_acct_id AS UTL_ACCT_ID,
                     i.commodity AS COMMODITY,
                     i.transaction_date AS INVOICE_DATE,
                     i.invoice_id AS INVOICE_ID,
                     (i.total_current_charges_amount) AS INVOICE_AMOUNT, --amount a/r payable to ESCO [regardless of amount paid for POR which is an a/p cheshbon]
                     nvl(i820.pr_invoiced_amount, 0) AS PAID_AMOUNT, --danger - using pr_invoiced_amount, this ASSUMES that 820 applied discounts are validated on the way in!!!
                     TO_DATE(dtAsOfDate) - TRUNC(i.transaction_date) AS AGE,
                     i.total_current_charges_amount AS TOTAL_BILLED,
                     nvl(i820.pr_invoiced_amount, 0) AS TOTAL_PAID,
                     (i.total_current_charges_amount) -
                     nvl(i820.pr_invoiced_amount, 0) AS OPEN_BALANCE
              FROM   invoice i
              INNER  JOIN inb_824 i824
              ON     i.invoice_id = i824.invoice_id
                     AND i824.error_code IS NULL
              LEFT   JOIN inb_820 i820
              ON     i820.invoice_id = i.invoice_id
                     AND i820.utl_id = i.utl_id
                     AND i820.commodity = i.commodity
              INNER  JOIN service s
              ON     s.service_id = i.service_id
              INNER  JOIN sales_source ssrc
              ON     ssrc.sales_source_id = s.sales_source_id
              INNER  JOIN sales_company sc
              ON     sc.sales_company_id = ssrc.sales_company_id
              INNER  JOIN utl_out_814_edi u814
              ON     u814.utl_id = i.utl_id
                     AND u814.commodity = i.commodity --BK
              JOIN   utl_rpm ur
              ON     ur.utl_id = i.utl_id --YB 12/6/2017
              WHERE  1 = 1
                     AND u814.billing_method = 'UBR' --BK
                     AND trunc(i.transaction_date) <= ipsdtEndDate
                     AND trunc(nvl(i820.posting_date, ipsdtEndDate)) <=
                     ipsdtEndDate
                     AND
                     i.utl_id IN
                     (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                                 i.utl_id)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, i.utl_id)
                     AND i.commodity = nvl(ipsCommodity, i.commodity)
                     AND (nvl(i820.service_ID, ipnServiceid) = ipnServiceid OR
                     ipnServiceid = 0)
                     AND (sc.sales_company_id = ipnSalesCompanyId OR
                     ipnSalesCompanyId = 0)
                     AND nvl(s.service_type, '~') =
                     nvl(ipsServiceType, nvl(s.service_type, '~'))
                     AND i.utl_acct_id = nvl(ipsUTLAccountId, i.utl_acct_id)
                     AND
                     ur.state IN
                     (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                                 ur.state)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
              
              UNION --03/14/2016 BK ADDED UNION
              
              SELECT ur.state, --temp
                     dtAsOfDate AS AsOfDate,
                     s.customer_id,
                     s.service_id,
                     i.utl_id AS UTL_ID,
                     i.utl_acct_id AS UTL_ACCT_ID,
                     i.commodity AS COMMODITY,
                     i.transaction_date AS INVOICE_DATE,
                     i.invoice_id AS INVOICE_ID,
                     (i.total_current_charges_amount) AS INVOICE_AMOUNT, --amount a/r payable to ESCO [regardless of amount paid for POR which is an a/p cheshbon]
                     nvl(i820.pr_invoiced_amount, 0) AS PAID_AMOUNT, --danger - using pr_invoiced_amount, this ASSUMES that 820 applied discounts are validated on the way in!!!
                     TO_DATE(dtAsOfDate) - TRUNC(i.transaction_date) AS AGE,
                     i.total_current_charges_amount AS TOTAL_BILLED,
                     nvl(i820.pr_invoiced_amount, 0) AS TOTAL_PAID,
                     (i.total_current_charges_amount) -
                     nvl(i820.pr_invoiced_amount, 0) AS OPEN_BALANCE
              FROM   invoice i
              LEFT   JOIN inb_820 i820
              ON     i820.invoice_id = i.invoice_id
                     AND i820.utl_id = i.utl_id
                     AND i820.commodity = i.commodity
              INNER  JOIN service s
              ON     s.service_id = i.service_id
              INNER  JOIN sales_source ssrc
              ON     ssrc.sales_source_id = s.sales_source_id
              INNER  JOIN sales_company sc
              ON     sc.sales_company_id = ssrc.sales_company_id
              INNER  JOIN utl_out_814_edi u814
              ON     u814.utl_id = i.utl_id
                     AND u814.commodity = i.commodity
              JOIN   utl_rpm ur
              ON     ur.utl_id = i.utl_id --YB 12/6/2017
              WHERE  1 = 1
                     AND u814.billing_method <> 'UBR'
                     AND trunc(i.transaction_date) <= ipsdtEndDate
                     AND trunc(nvl(i820.posting_date, ipsdtEndDate)) <=
                     ipsdtEndDate
                     AND
                     i.utl_id IN
                     (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                                 i.utl_id)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, i.utl_id)= nvl(ipsUtlId, i.utl_id)
                     AND i.commodity = nvl(ipsCommodity, i.commodity)
                     AND (nvl(i820.service_ID, ipnServiceid) = ipnServiceid OR
                     ipnServiceid = 0)
                     AND (sc.sales_company_id = ipnSalesCompanyId OR
                     ipnSalesCompanyId = 0)
                     AND nvl(s.service_type, '~') =
                     nvl(ipsServiceType, nvl(s.service_type, '~'))
                     AND i.utl_acct_id = nvl(ipsUTLAccountId, i.utl_acct_id)
                    
                     AND
                     ur.state IN
                     (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                                 ur.state)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
              ) t
      WHERE  ur.utl_id = t.utl_id
      GROUP  BY asOfDate,
                t.customer_id,
                t.service_id,
                t.utl_acct_id,
                ur.utl_short_name,
                t.COMMODITY,
                ur.state;
  END;
  ------------------------------------------------------------------------------------------------------------
  PROCEDURE AR_InvcRemitReconcile(ipsdtBeginDate    IN VARCHAR2,
                                  ipsdtEndDate      IN VARCHAR2,
                                  ipsCommodity      IN VARCHAR2,
                                  ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                  ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                  ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                  ipnServiceid      IN service.service_id%TYPE,
                                  ipsServiceType    IN Service.Service_Type%TYPE,
                                  ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                  rfcReport         OUT global.refCur)
  
   IS
    /*  28 July 2014 FF AH
    Original code returned results using an inner join on inb_824, which left out
    rate ready entries that don't have an inbound 824.
    in addition, pending inbound entries were also left out.
    a union select was added to retrieve Rate Ready entries, and pending action code
    entries was also added.*/
    /* Aug/15/17 FF Took out AND transaction_purpose = '00'
       and also AND NOT EXISTS (SELECT 1 FROM inb_867_mu mu WHERE service_id = i.service_id AND mu.cancelled_utl_tracking_id = i.mu_utl_tracking_id)   --EXCLUDE CANCELED-FOR-REREAD INVOICES       
       this was causing erroneus results. We need to include all invoices (Just like int hebilling detail and
       billing summary report. Logic is: w eget an invoice for 100, w eget a cancel for 100 and a read for 150
       if we include all 3 result = 150 which is correct. When looking at not exists in inb867_mu perhaps sphould have worked as well 
       but it weasn't and this logic makes sense...
    */
  
  BEGIN
    OPEN rfcReport FOR
    
      SELECT --ss 2/05/2014
       u.utl_short_name AS "Utility Name",
       i.commodity AS "Commodity",
       s.customer_id AS "Customer ID",
       s.service_id AS "Service ID",
       i.utl_acct_id AS "Utility Account ID",
       i.invoice_id AS "Invoice ID",
       i.transaction_date AS "Invoice Date",
       i.start_date AS "Start Date",
       i.end_date AS "End Date",
       i820.intended_settlement_date AS "Rem Intended Settlement Date",
       i820.posting_date AS "Rem Posting Date",
       i.total_usage_amount AS "Total Usage Amount~~d2",
       i.energy_charges_amount AS "Energy Charges Amount~~d2#",
       i.adjustment_amount AS "Adjustment Amount",
       i.total_current_charges_amount AS "Invoice Amount~~d2#",
       i.state_sales_tax_rate AS "State Sales Tax Rate",
       i.state_sales_tax_amount AS "State Sales Tax Amount#",
       i820.pr_invoiced_amount AS "Remittance Invoice Amount~~d2#",
       i820.pr_discount_amount AS "POR Discounted Amount~~d2#",
       i820.monetary_amount AS "Remmited Amount~~d2#",
       (i.total_current_charges_amount) - nvl(i820.pr_invoiced_amount, 0) AS "Open Balance~~c2#"
      FROM   invoice i
      LEFT   JOIN inb_824 i824
      ON     i.invoice_id = i824.invoice_id
             AND (NVL(i824.action_code, 'Pending') = 'CF' OR
             NVL(i824.action_code, 'Pending') = 'Pending')
      INNER  JOIN utl_out_814_edi u
      ON     u.utl_id = i.utl_id
             AND u.commodity = i.commodity
      LEFT   JOIN inb_820 i820
      ON     i820.invoice_id = i.invoice_id --at least temporarily
             AND i820.utl_id = i.utl_id
             AND i820.commodity = i.commodity
      INNER  JOIN service s
      ON     s.service_id = i.service_id
      INNER  JOIN sales_source ssrc
      ON     ssrc.sales_source_id = s.sales_source_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = ssrc.sales_company_id
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = i.utl_id --YB 12/6/2017
      WHERE  1 = 1
             AND u.billing_method = 'UBR'
             AND trunc(i.transaction_date) BETWEEN ipsdtBeginDate AND
             ipsdtEndDate
             AND
             i.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         i.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, i.utl_id)
             AND i.commodity = nvl(ipsCommodity, i.commodity)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND i.utl_acct_id = nvl(ipsUTLAccountId, i.utl_acct_id)
             AND (i.service_id = ipnServiceid OR ipnServiceid = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      
      UNION
      SELECT u.utl_short_name AS "Utility Name",
             i.commodity AS "Commodity",
             s.customer_id AS "Customer ID",
             s.service_id AS "Service ID",
             i.utl_acct_id AS "Utility Account ID",
             i.invoice_id AS "Invoice ID",
             i.transaction_date AS "Invoice Date",
             i.start_date AS "Start Date",
             i.end_date AS "End Date",
             i820.intended_settlement_date AS "Rem Intended Settlement Date",
             i820.posting_date AS "Rem Posting Date",
             i.total_usage_amount AS "Total Usage Amount~~d2",
             i.energy_charges_amount AS "Energy Charges Amount~~d2#",
             i.adjustment_amount AS "Adjustment Amount",
             i.total_current_charges_amount AS "Invoice Amount~~d2#",
             i.state_sales_tax_rate AS "State Sales Tax Rate",
             i.state_sales_tax_amount AS "State Sales Tax Amount#",
             i820.pr_invoiced_amount AS "Remittance Invoice Amount~~d2#",
             i820.pr_discount_amount AS "POR Discounted Amount~~d2#",
             i820.monetary_amount AS "Remmited Amount~~d2#",
             (i.total_current_charges_amount) -
             nvl(i820.pr_invoiced_amount, 0) AS "Open Balance~~c2#"
      FROM   invoice i
      INNER  JOIN utl_out_814_edi u
      ON     u.utl_id = i.utl_id
             AND u.commodity = i.commodity
      LEFT   JOIN inb_820 i820
      ON     i820.invoice_id = i.invoice_id --at least temporarily
             AND i820.utl_id = i.utl_id
             AND i820.commodity = i.commodity
      INNER  JOIN service s
      ON     s.service_id = i.service_id
      INNER  JOIN sales_source ssrc
      ON     ssrc.sales_source_id = s.sales_source_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = ssrc.sales_company_id
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = i.utl_id --YB 12/6/2017
      WHERE  1 = 1
             AND u.billing_method <> 'UBR'
             AND trunc(i.transaction_date) BETWEEN ipsdtBeginDate AND
             ipsdtEndDate
             AND
             i.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         i.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, i.utl_id)
             AND i.commodity = nvl(ipsCommodity, i.commodity)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND i.utl_acct_id = nvl(ipsUTLAccountId, i.utl_acct_id)
             AND (i.service_id = ipnServiceid OR ipnServiceid = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY "Invoice Date";
  END;
  ---------------------------------------------------------------------------------------------
  PROCEDURE ENR_ActiveMetersDetail(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                   rfcReport         OUT global.refCur)
  
   IS
  BEGIN
    OPEN rfcReport FOR
    
      SELECT /*+ index(service_status U_IDX_SVC_STAT_ID_SVC) */
       u814.utl_short_name  AS "Utility Name",
       s.commodity          AS "Commodity",
       s.service_type       AS "Service Type",
       s.start_service_date AS "Service Start Date",
       s.utl_acct_id        AS "Utility Account ID",
       c.last_name          AS "Last Name",
       c.first_name         AS "First Name",
       s.street             AS "Service Address",
       s.city               AS "Service City",
       s.state              AS "Service State",
       s.zip_code           AS "Service Zip",
       s.customer_id        AS "Customer ID",
       s.service_id         AS "Service ID",
       1                    AS "Total Active#"
      FROM   service s
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      INNER  JOIN utl_out_814_edi u814
      ON     u814.utl_id = s.utl_id
             AND u814.commodity = s.commodity
      JOIN   service_status st
      ON     st.service_id = s.service_id
             AND st.service_status_id =
             (SELECT MAX(service_status_id)
                  FROM   service_status
                  WHERE  service_id = s.service_id)
      INNER  JOIN sales_source ssrc
      ON     ssrc.sales_source_id = s.sales_source_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = ssrc.sales_company_id
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = s.utl_id --YB 12/6/2017
      WHERE  1 = 1
             AND st.status LIKE 'Active%'
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, s.utl_id)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY u814.utl_short_name, s.commodity;
  END;

  ---------------------------------------------------------------------------------------------
  PROCEDURE ENR_ActiveMetersSummary(ipsdtBeginDate    IN VARCHAR2,
                                    ipsdtEndDate      IN VARCHAR2,
                                    ipsCommodity      IN VARCHAR2,
                                    ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                    ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                    ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                    ipnServiceid      IN service.service_id%TYPE,
                                    ipsServiceType    IN Service.Service_Type%TYPE,
                                    ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                    rfcReport         OUT global.refCur)
  
   IS
  BEGIN
    OPEN rfcReport FOR
    
      SELECT --NEW FF Jul/12/17
       u814.utl_short_name AS "Utility Name",
       s.commodity AS "Commodity",
       st.status AS "Status",
       COUNT(s.service_id) AS "Total Active#"
      FROM   service s
      INNER  JOIN utl_out_814_edi u814
      ON     u814.utl_id = s.utl_id
             AND u814.commodity = s.commodity
      INNER  JOIN service_status st
      ON     st.service_id = s.service_id
             AND st.service_status_id =
             (SELECT MAX(service_status_id)
                  FROM   service_status
                  WHERE  service_id = s.service_id)
      INNER  JOIN sales_source ssrc
      ON     ssrc.sales_source_id = s.sales_source_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = ssrc.sales_company_id
      INNER  JOIN utl_rpm rpm
      ON     rpm.utl_id = s.utl_id
      WHERE  1 = 1
             AND (st.status LIKE 'Active%' OR
             st.status = 'Enrolled - Pending Service')
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, s.utl_id)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND ((ipnSalesCompanyId = 0) OR
             (sc.sales_company_id = ipnSalesCompanyId))
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      GROUP  BY rpm.state, u814.utl_short_name, s.commodity, st.status
      ORDER  BY rpm.state, u814.utl_short_name, s.commodity, st.status;
  END;
  ---------------------------------------------------------------------------------------------
  PROCEDURE ENR_EnrollmentRejectionsDetail(ipsdtBeginDate    IN VARCHAR2,
                                           ipsdtEndDate      IN VARCHAR2,
                                           ipsCommodity      IN VARCHAR2,
                                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                           ipnServiceid      IN service.service_id%TYPE,
                                           ipsServiceType    IN Service.Service_Type%TYPE,
                                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                           rfcReport         OUT global.refCur)
  
   IS
  BEGIN
    OPEN rfcReport FOR
      WITH INB_814_HA AS
       (SELECT o.service_id,
               o.entered_date,
               i.status_code,
               i.status_description
        FROM   out_814 o, inb_814_rsp i
        WHERE  o.transaction_purpose_code = 'HQ'
               AND o.esco_Tracking_Id = i.esco_tracking_id),
      INB_814_EA AS
       (SELECT o.service_id,
               o.entered_date,
               i.status_code,
               i.status_description
        FROM   out_814 o, inb_814_rsp i
        WHERE  o.transaction_purpose_code = 'EQ'
               AND o.esco_Tracking_Id = i.esco_tracking_id)
      
      SELECT rpm.state, --YB 12/6/2017 temp
             c.first_name          AS "First Name",
             c.last_name           AS "Last Name",
             c.street              AS "Address",
             c.phone               AS "Phone Number",
             sc.sales_company_name AS "Sales Company",
             s.utl_acct_id         AS "Utility Account ID",
             u.utl_short_name      AS "Utility Name",
             s.service_id          AS "Service ID",
             s.commodity           AS "Commodity",
             s.entered_date        AS "Service Entered Date",
             s.hst_req_date        AS "Historical Request Date",
             h.entered_date        AS "Historical Request Received",
             h.status_code         AS "Historical Request Response",
             h.status_description  AS "Historical Request Message",
             s.enr_req_date        AS "Enrollment Request Date",
             s.start_service_date  AS "Start Service Date",
             e.entered_date        AS "Enrollment Received Date",
             e.status_code         AS "Enrollment Request Response",
             e.status_description  AS "Enrollment Request Message",
             st.status             AS "Status",
             s.customer_id         AS "Customer ID"
      FROM   service s
      LEFT   JOIN inb_814_ha h
      ON     h.service_id = s.service_id
             AND CAST(h.entered_date AS DATE) = s.hst_req_date --The cast is bec. h is timestamp and s is date
      LEFT   JOIN inb_814_eA e
      ON     e.service_id = s.service_id
             AND CAST(e.entered_date AS DATE) = s.enr_req_date --The cast is bec. h is timestamp and s is date
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      INNER  JOIN sales_source sa
      ON     sa.sales_source_id = s.sales_source_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = sa.sales_company_id
      INNER  JOIN UTL_OUT_814_EDI u
      ON     s.utl_id = u.utl_id
             AND s.commodity = u.commodity
      INNER  JOIN service_status st
      ON     st.service_id = s.service_id
             AND st.service_status_id =
             (SELECT MAX(service_status_id)
                  FROM   service_status
                  WHERE  service_id = s.service_id)
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = s.utl_id --YB 12/6/2017
      WHERE  st.status LIKE '%Reject%' --This is far from optimal and only meant as a placeholder
             AND trunc(s.entered_date) BETWEEN ipsdtBeginDate AND
             ipsdtEndDate
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (sa.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY "Service Entered Date";
  END;
  ----------------------------------------------------------------------------------
  PROCEDURE ENR_EnrollmentExceptionsDetail(ipsdtBeginDate    IN VARCHAR2,
                                           ipsdtEndDate      IN VARCHAR2,
                                           ipsCommodity      IN VARCHAR2,
                                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                           ipnServiceid      IN service.service_id%TYPE,
                                           ipsServiceType    IN Service.Service_Type%TYPE,
                                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                           rfcReport         OUT global.refCur)
  
   IS
  BEGIN
    OPEN rfcReport FOR
    --TODO: Determine which exceptions are not really error conditions and filter out (ie. ReEnrollment)
    --Do we need to be left-joining to Customer/Service etc for conditions where no match can be made?
    
      SELECT --ss 2/05/2014
       rpm.state, --YB 12/6/2017 temp
       se.service_exc_id AS "Svc Exception ID",
       --UTILITY INFO:
       u.utl_name AS "Utility Name",
       se.commodity AS "Commodity",
       nvl(se.service_type, r.service_class) AS "Service Type",
       se.utl_acct_id AS "Utility Account ID",
       --CUSTOMER INFO:
       se.customer_id AS "Customer ID",
       c.last_name    AS "Last Name",
       c.first_name   AS "First Name",
       s.street       AS "Address1",
       s.suite        AS "Address2",
       s.city         AS "City",
       s.state        AS "State",
       s.zip_code     AS "Zip",
       s.customer_id  AS "Customer ID",
       s.service_id   AS "Service ID",
       --SALES INFO:
       sc.sales_company_name AS "Sales Company",
       se.sales_agent_id     AS "Sales Agent Id",
       se.tpv_recording_id   AS "TPV Recording Id",
       --RATE INFO:
       r.rate_amount           AS "Rate Amount",
       r.rate_plan_description AS "Rate Plan Description",
       --SERVICE INFO:
       se.service_id         AS "Service ID",
       se.start_service_date AS "Start Service",
       se.end_service_date   AS "End Service",
       se.hst_req_date       AS "HST Request Date",
       se.enr_req_date       AS "ENR Request Date",
       se.cancel_req_date    AS "CANCEL Request Date",
       --EXCEPTION INFO:
       se.exc_description     AS "Exception Description",
       se.entered_date_actual AS "Exception Date"
      FROM   service_exc se
      LEFT   JOIN utl_out_814_edi u
      ON     u.utl_id = se.utl_id
             AND u.commodity = se.commodity
      LEFT   JOIN service s
      ON     s.service_id = se.service_id
      LEFT   JOIN customer c
      ON     c.customer_id = s.customer_id
      LEFT   JOIN sales_source sl
      ON     sl.sales_source_id = se.sales_source
      LEFT   JOIN sales_company sc
      ON     sc.sales_company_id = sl.sales_company_id
      LEFT   JOIN rate_plan r
      ON     r.rate_plan_id = sl.rate_plan_id
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = se.utl_id --YB 12/6/2017
      WHERE  1 = 1
             AND TRUNC(se.entered_date_actual) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND se.commodity = nvl(ipscommodity, se.commodity)
             AND
             se.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         se.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, se.utl_id)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND se.utl_acct_id = nvl(ipsUTLAccountId, se.utl_acct_id)
             AND (se.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL); --YB 12/4/2017
  END;

  ---------------------------------------------------------------------------------------------
  PROCEDURE ENR_EnrollmentDetail(ipsdtBeginDate    IN VARCHAR2,
                                 ipsdtEndDate      IN VARCHAR2,
                                 ipsCommodity      IN VARCHAR2,
                                 ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                 ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                 ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                 ipnServiceid      IN service.service_id%TYPE,
                                 ipsServiceType    IN Service.Service_Type%TYPE,
                                 ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                 rfcReport         OUT global.refCur)
  
   IS
  
    /*  4 Aug 2014 AH
    cancel date,end of service date, service duration (end service - start service), 
    usage columns added. Status codes now retrieved from 814_inb_rsp,
    not from rejection_codes table. */
  
  BEGIN
    OPEN rfcReport FOR
      WITH INB_814_HA AS
       (SELECT o.service_id,
               o.entered_date       ou_entered_date,
               i.entered_date       inb_resp_date,
               i.status_code,
               i.status_description status_description
        FROM   out_814 o, inb_814_rsp i
        WHERE  o.transaction_purpose_code = 'HQ'
               AND o.esco_Tracking_Id = i.esco_tracking_id),
      INB_814_EA AS
       (SELECT o.rate_amount,
               o.rate_code,
               o.service_id,
               o.entered_date       ou_entered_date,
               i.entered_date       inb_resp_date,
               i.status_code,
               i.status_description status_description
        FROM   out_814 o, inb_814_rsp i
        WHERE  o.transaction_purpose_code = 'EQ'
               AND o.esco_Tracking_Id = i.esco_tracking_id)
      
      SELECT DISTINCT rpm.state, --YB 12/6/2017 temp
                      c.first_name AS "First Name",
                      c.last_name AS "Last Name",
                      s.street AS "Address", -- FF 7/20/17  using the service address
                      s.city AS "City",
                      s.state AS "State",
                      s.zip_code AS "Zip Code",
                      c.phone AS "Phone Number",
                      sc.sales_company_name AS "Sales Company",
                      s.sales_agent_id AS "Sales Agent Id",
                      s.tpv_recording_id AS "TPV Recording Id",
                      s.utl_acct_id AS "Utility Account ID",
                      u.utl_short_name AS "Utility Name",
                      s.commodity AS "Commodity",
                      s.service_id AS "Service ID",
                      s.entered_date AS "System Entry Date",
                      s.hst_req_date AS "Historical Req Date",
                      h.inb_resp_date AS "Historical Resp Date",
                      h.status_code AS "Historical Resp Status",
                      h.status_description AS "Historical Resp Message",
                      s.enr_req_date AS "Enrollment Req Date",
                      e.inb_resp_date AS "Enrollment Resp Date",
                      e.status_code AS "Enrollment Resp Status",
                      e.status_description AS "Enrollment Resp Message",
                      e.rate_amount AS "Rate Amount",
                      e.rate_code AS "Rate Code",
                      s.Utl_Rate_Class AS "Utl Rate Class",
                      s.start_service_date AS "Start Service Date",
                      s.end_service_date AS "End Service Date",
                      CASE
                         WHEN nvl(s.end_service_date, trunc(SYSDATE)) -
                              s.start_service_date >= 0 THEN
                          round(months_between(nvl(s.end_service_date,
                                                   trunc(SYSDATE)),
                                               s.start_service_date))
                         WHEN (s.end_service_date IS NULL OR
                              s.start_service_date IS NULL) THEN
                          NULL
                         ELSE
                          0
                       END AS "Service Duration (in Months)",
                      usage.GET_YEARLY_USAGE_AMOUNT(s.service_id) AS "Yearly Usage~~d2#",
                      s.cancel_req_date AS "Cancel Req Date",
                      s.cancel_req_source AS "Cancel Req Source",
                      st.status AS "Status",
                      NULL AS "Service Exc Message",
                      s.customer_id AS "Customer ID",
                      s.suite AS "Suite",
                      s.tax_exempt_percentage AS "Tax Exempt Percentage",
                      -- FF jan/17/17 took out bcs of new tax field in service...DECODE(c.tax_exempt_request_date,NULL,'Not Exempt','Tax Exempt as of ' || c.tax_exempt_request_date)  AS "Tax Exempt Status" ,
                      usc.service_class AS "Service Class"
      FROM   service s
      LEFT   JOIN inb_814_ha h
      ON     h.service_id = s.service_id
             AND CAST(h.ou_entered_date AS DATE) = s.hst_req_date --The cast is bec. h is timestamp and s is date
      LEFT   JOIN inb_814_EA e
      ON     e.service_id = s.service_id
             AND CAST(e.ou_entered_date AS DATE) = s.enr_req_date --The cast is bec. h is timestamp and s is date
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      INNER  JOIN sales_source sa
      ON     sa.sales_source_id = s.sales_source_id
      INNER  JOIN sales_company sc
      ON     sc.sales_company_id = sa.sales_company_id
      INNER  JOIN UTL_OUT_814_EDI u
      ON     s.utl_id = u.utl_id
             AND s.commodity = u.commodity
      INNER  JOIN service_status st
      ON     st.service_id = s.service_id
             AND st.service_status_id =
             (SELECT MAX(service_status_id)
                  FROM   service_status
                  WHERE  service_id = s.service_id)
      LEFT   JOIN utl_service_class usc
      ON     usc.utl_rate_class = s.utl_rate_class
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = s.utl_id --YB 12/6/2017
      -- FF May/11/2016 Changed to left join utl_service_class usc because when data is missing really affects the report
      WHERE  1 = 1
             AND trunc(s.entered_date) BETWEEN ipsdtBeginDate AND
             ipsdtEndDate
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (sa.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      
      UNION ALL
      
      SELECT DISTINCT rpm.state, --YB 12/6/2017 temp
                      c.first_name AS "First Name", -- FF 7/20/17 took out the nvl
                      c.last_name AS "Last Name", -- FF 7/20/17 took out the nvl
                      se.street AS "Address", -- FF 7/20/17 using the service address
                      se.city AS "City",
                      se.state AS "State",
                      se.zip_code AS "Zip Code",
                      c.phone AS "Phone Number",
                      sc.sales_company_name AS "Sales Company",
                      se.sales_agent_id AS "Sales Agent Id",
                      se.tpv_recording_id AS "TPV Recording Id",
                      se.utl_acct_id AS "Utility Account ID",
                      u.utl_short_name AS "Utility Name",
                      se.commodity AS "Commodity",
                      se.service_id AS "Service ID",
                      se.entered_date AS "Service Entered Date",
                      NULL AS "Historical Req Date",
                      NULL AS "Historical Resp Date",
                      NULL AS "Historical Resp Status",
                      NULL AS "Historical Resp Message",
                      NULL AS "Enrollment Req Date",
                      NULL AS "Enrollment Resp Date",
                      NULL AS "Enrollment Resp Status",
                      NULL AS "Enrollment Resp Message",
                      NULL AS "Rate Amount",
                      NULL AS "Rate Code",
                      NULL AS "Utl Rate Class",
                      NULL AS "Start Service Date",
                      NULL AS "End Service Date",
                      NULL AS "Service Duration",
                      NULL AS "Yearly Usage",
                      NULL AS "Cancel Req Date",
                      NULL AS "Cancel Req Source",
                      'EXCEPTION' AS "Status",
                      CASE UPPER(SUBSTR(se.exc_description, 0, 9))
                        WHEN 'ORA-01400' THEN
                         'Invalid Commodity'
                        WHEN 'ORA-00001' THEN
                         'AccountID must be unique'
                        WHEN 'ORA-01403' THEN
                         'Missing Data'
                        ELSE
                         se.exc_description
                      END AS "service exc message",
                      se.customer_id AS "Customer ID",
                      se.suite AS "Suite",
                      NULL AS "Tax Exempt Percentage",
                      '' AS "Service Class"
      FROM   service_exc se
      LEFT   JOIN service s1
      ON     s1.service_id = se.service_id
      LEFT   JOIN customer c
      ON     c.customer_id = s1.customer_id -- ff 7/20/17 we took out se.customer id because sometimes is not the same as the service id and the customer does not exists
      LEFT   JOIN utl_out_814_edi u
      ON     se.utl_id = u.utl_id AND se.commodity = u.commodity
      LEFT   JOIN sales_source sa
      ON     sa.sales_source_id = se.sales_source
      LEFT   JOIN sales_company sc
      ON     sc.sales_company_id = sa.sales_company_id
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = se.utl_id --YB 12/6/2017
      WHERE  1 = 1 AND se.exc_description <> 'ReEnrollment' AND
       trunc(se.entered_date) BETWEEN ipsdtBeginDate AND ipsdtEndDate AND
       (se.commodity IS NULL OR
       se.commodity = nvl(ipsCommodity, se.commodity)) --since missing commodity itself can cause exception
       AND
       (se.utl_id IS NULL OR
       se.utl_id IN
       (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                    se.utl_id)
         FROM   dual
         CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL)) --YB 12/6/2017 = nvl(ipsUtlId, se.utl_id)) --since missing UTL itself can cause exception
       AND (se.utl_acct_id IS NULL OR
       se.utl_acct_id = nvl(ipsUTLAccountId, se.utl_acct_id)) --since missing UTL_AcctID itself can cause exception
       AND (sa.sales_company_id = ipnSalesCompanyId OR
       ipnSalesCompanyId = 0) AND
       (se.service_id IS NULL OR se.service_id = ipnServiceid OR
       ipnServiceid = 0) --very often a record is here bec. it wasnt valid enough to get a service
       AND nvl(se.service_type, '~') =
       nvl(ipsServiceType, nvl(se.service_type, '~')) AND
       rpm.state IN
       (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                   rpm.state)
        FROM   dual
        CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
      ORDER  BY "System Entry Date", "Sales Company";
  END;
  ---------------------------------------------------------------------------------------------
  PROCEDURE ENR_EnrollmentSummary(ipsdtBeginDate    IN VARCHAR2,
                                  ipsdtEndDate      IN VARCHAR2,
                                  ipsCommodity      IN VARCHAR2,
                                  ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                  ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                  ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                  ipnServiceid      IN service.service_id%TYPE,
                                  ipsServiceType    IN Service.Service_Type%TYPE,
                                  ipsStates         IN utl_rpm.state%TYPE, --YB 12/6/2017
                                  rfcReport         OUT global.refCur)
  
   IS
    /* 4 Aug 2014 AH   Sales company column added*/
  
  BEGIN
    OPEN rfcReport FOR
      WITH INB_814_HA AS
       (SELECT o.service_id,
               o.entered_date,
               i.status_code,
               i.status_description
        FROM   out_814 o, inb_814_rsp i
        WHERE  o.transaction_purpose_code = 'HQ'
               AND o.esco_Tracking_Id = i.esco_tracking_id),
      INB_814_EA AS
       (SELECT o.service_id,
               o.entered_date,
               i.status_code,
               i.status_description
        FROM   out_814 o, inb_814_rsp i
        WHERE  o.transaction_purpose_code = 'EQ'
               AND o.esco_Tracking_Id = i.esco_tracking_id)
      
      SELECT "Utility Name",
             "Commodity",
             "Global Status",
             "Service Exc Message" AS "Message",
             "Sales Company",
             COUNT(*) AS "Count#"
      FROM   (SELECT c.first_name AS "First Name",
                     c.last_name AS "Last Name",
                     c.street AS "Address",
                     s.utl_acct_id AS "Utility Account ID",
                     u.utl_short_name AS "Utility Name",
                     s.commodity AS "Commodity",
                     s.entered_date AS "Service Entered Date",
                     s.hst_req_date AS "Historical Request Date",
                     h.entered_date AS "Historical Request Received",
                     h.status_code AS "Historical Request Response",
                     h.status_description AS "Historical Request Message",
                     s.enr_req_date AS "Enrollment Request Date",
                     s.start_service_date AS "Start Service Date",
                     e.entered_date AS "Enrollment Received Date",
                     e.status_code AS "Enrollment Request Response",
                     e.status_description AS "Enrollment Request Message",
                     (SELECT st.status
                      FROM   service_status st
                      WHERE  service_id = s.service_id
                             AND st.service_status_id =
                             (SELECT MAX(service_status_id)
                                  FROM   service_status
                                  WHERE  service_id = s.service_id)) AS "Global Status", -- ff May/12/2017 much quicker
                     NULL AS "Service Exc Message",
                     sc.sales_company_name AS "Sales Company"
              FROM   service s
              LEFT   JOIN inb_814_ha h
              ON     h.service_id = s.service_id
                     AND CAST(h.entered_date AS DATE) = s.hst_req_date --The cast is bec. h is timestamp and s is date
              LEFT   JOIN inb_814_eA e
              ON     e.service_id = s.service_id
                     AND CAST(e.entered_date AS DATE) = s.enr_req_date --The cast is bec. h is timestamp and s is date
              INNER  JOIN customer c
              ON     c.customer_id = s.customer_id
              INNER  JOIN sales_source sa
              ON     sa.sales_source_id = s.sales_source_id
              INNER  JOIN sales_company sc
              ON     sc.sales_company_id = sa.sales_company_id
              INNER  JOIN UTL_OUT_814_EDI u
              ON     s.utl_id = u.utl_id
                     AND s.commodity = u.commodity
              JOIN   utl_rpm rpm
              ON     rpm.utl_id = s.utl_id --YB 12/6/2017
              WHERE  1 = 1
                     AND trunc(s.entered_date) BETWEEN ipsdtBeginDate AND
                     ipsdtEndDate
                     AND s.commodity = nvl(ipsCommodity, s.commodity)
                     AND
                     s.utl_id IN
                     (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                                 s.utl_id)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/6/2017 = nvl(ipsUtlId, s.utl_id)
                     AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
                     AND (sa.sales_company_id = ipnSalesCompanyId OR
                     ipnSalesCompanyId = 0)
                     AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
                     AND nvl(s.service_type, '~') =
                     nvl(ipsServiceType, nvl(s.service_type, '~'))
                     AND
                     rpm.state IN
                     (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                                 rpm.state)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/4/2017
              
              UNION ALL
              
              SELECT c.first_name AS "First Name",
                     c.last_name AS "Last Name",
                     c.street AS "Address",
                     se.utl_acct_id AS "Utility Account ID",
                     u.utl_short_name AS "Utility Name",
                     se.commodity AS "Commodity",
                     se.entered_date AS "Service Entered Date",
                     NULL AS "Historical Request Date",
                     NULL AS "Historical Request Received",
                     NULL AS "Historical Request Response",
                     NULL AS "Historical Request Message",
                     NULL AS "Enrollment Request Date",
                     NULL AS "Start Service Date",
                     NULL AS "Enrollment Received Date",
                     NULL AS "Enrollment Request Response",
                     NULL AS "Enrollment Request Message",
                     'EXCEPTION' AS "Global Status",
                     CASE UPPER(SUBSTR(se.exc_description, 0, 9))
                       WHEN 'ORA-01400' THEN
                        'Invalid Commodity'
                       WHEN 'ORA-00001' THEN
                        'AccountID must be unique'
                       WHEN 'ORA-01403' THEN
                        'Missing Data'
                       ELSE
                        se.exc_description
                     END AS "service exc message",
                     NULL AS "Sales Company"
              FROM   service_exc se
              LEFT   JOIN customer c
              ON     c.customer_id = se.customer_id
              LEFT   JOIN utl_out_814_edi u
              ON     se.utl_id = u.utl_id
                     AND se.commodity = u.commodity
              LEFT   JOIN sales_source sa
              ON     sa.sales_source_id = se.sales_source
              LEFT   JOIN sales_company sc
              ON     sc.sales_company_id = sa.sales_company_id
              JOIN   utl_rpm rpm
              ON     rpm.utl_id = se.utl_id --YB 12/6/2017
              WHERE  1 = 1
                     AND se.exc_description <> 'ReEnrollment'
                     AND trunc(se.entered_date) BETWEEN ipsdtBeginDate AND
                     ipsdtEndDate
                     AND (se.commodity IS NULL OR
                     se.commodity = nvl(ipsCommodity, se.commodity)) --since missing commodity itself can cause exception
                     AND
                     (se.utl_id IS NULL OR
                     se.utl_id IN
                     (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                                  se.utl_id)
                       FROM   dual
                       CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL)) --YB 12/6/2017 = nvl(ipsUtlId, se.utl_id) --since missing UTL itself can cause exception
                     AND
                     (se.utl_acct_id IS NULL OR
                     se.utl_acct_id = nvl(ipsUTLAccountId, se.utl_acct_id)) --since missing UTL_AcctID itself can cause exception
                     AND (sa.sales_company_id = ipnSalesCompanyId OR
                     ipnSalesCompanyId = 0)
                     AND (se.service_id IS NULL OR
                     se.service_id = ipnServiceid OR ipnServiceid = 0) --very often a record is here bec. it wasnt valid enough to get a service
                     AND nvl(se.service_type, '~') =
                     nvl(ipsServiceType, nvl(se.service_type, '~'))
                     AND
                     rpm.state IN
                     (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                                 rpm.state)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL)) --YB 12/4/2017
      GROUP  BY "Utility Name",
                "Commodity",
                "Global Status",
                "Service Exc Message",
                "Sales Company"
      ORDER  BY "Global Status",
                "Service Exc Message",
                "Utility Name",
                "Commodity",
                "Sales Company";
  END;
  ---------------------------------------------------------------------------------------------
  PROCEDURE EXC_ActiveButNoUsage(ipsdtBeginDate    IN VARCHAR2,
                                 ipsdtEndDate      IN VARCHAR2,
                                 ipsCommodity      IN VARCHAR2,
                                 ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                 ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                 ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                 ipnServiceid      IN service.service_id%TYPE,
                                 ipsServiceType    IN Service.Service_Type%TYPE,
                                 ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                 rfcReport         OUT global.refCur)
  
   IS
  BEGIN
    OPEN rfcReport FOR
    
      SELECT s.service_id                   AS "Service ID",
             s.customer_id                  AS "Customer ID",
             c.last_name                    AS "Last Name",
             c.first_name                   AS "First Name",
             u.utl_short_name               AS "Utility Name",
             s.utl_acct_id                  AS "Utility Account ID",
             s.utl_id                       AS "Utility ID",
             s.commodity                    AS "Commodity",
             s.street                       AS "Service Address",
             s.suite                        AS "Service Suite",
             s.city                         AS "Service City",
             s.state                        AS "Service State",
             s.zip_code                     AS "Service Zip",
             s.zip_plus4                    AS "Service Zip Plus",
             s.hst_req_date                 AS "Historical Request Date",
             s.enr_req_date                 AS "Enrollment Request Date",
             s.start_service_date           AS "Service Start Date",
             s.end_service_date             AS "End Service Date",
             s.cancel_req_date              AS "Cancel Request Date",
             s.cancel_req_source            AS "Cancel Request Source",
             s.utl_rate_class               AS "Utility Rate Class",
             s.utl_zone                     AS "Utility Zone",
             s.service_type                 AS "Service Type",
             s.sales_source_id              AS "Sales Source ID",
             s.sales_agent_id               AS "Sales Agent ID",
             s.entered_date                 AS "Entered Date",
             s.entered_by                   AS "Entered By",
             s.billing_cycle                AS "Billing Cycle",
             s.load_profile                 AS "Load Profile",
             s.service_class                AS "Service Class",
             s.acceptance_conn_receipt_date AS "Acceptance Receipt Date",
             s.delay_enrollment_until_date  AS "Delay Enrolllment Until"
      FROM   service s
      INNER  JOIN customer c
      ON     c.customer_id = s.customer_id
      INNER  JOIN utl_rpm u
      ON     u.utl_id = s.utl_id
      WHERE  1 = 1
             AND
             nvl(s.start_service_date,
                 to_date(ipsdtEndDate, 'DD-MON-YYYY') + 10) < SYSDATE - 60
             AND s.end_service_date IS NULL
             AND NOT EXISTS
       (SELECT 1
              FROM   inb_867_mu
              WHERE  service_id = s.service_id)
             AND s.commodity = nvl(ipscommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
            /*AND (sc.sales_company_id = ipnSalesCompanyId OR ipnSalesCompanyId = 0)*/ -- No reason to have this as the report doesn't require it
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             u.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         u.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
      
      ORDER  BY u.utl_short_name, s.commodity;
  END;

  ---------------------------------------------------------------------------------------------

  PROCEDURE AP_SalesTaxSummary(ipsdtBeginDate    IN VARCHAR2,
                               ipsdtEndDate      IN VARCHAR2,
                               ipsCommodity      IN VARCHAR2,
                               ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                               ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                               ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                               ipnServiceid      IN service.service_id%TYPE,
                               ipsServiceType    IN Service.Service_Type%TYPE,
                               ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                               rfcReport         OUT global.refCur)
  
    -- IMPORTANT NOTE: FF Jul/28/2014
    -- Since we are taking the TOTAL_CURRENT_CHARGES_AMOUNT from the rejected invoice, 
    -- and we are not charging new taxes in the new invoices we need to keep the tax charges in 
    -- the calculation, so we should not take it out because of its rejected status.                                   
  
    /* FF Apr/20/2015 ****IMPORTANT NOTE:****
    When calculating TAXES, for !!** UBR ONLY **!! we actually do need to exclude the invoices that 
    got a cancel,re-read because sicne we place that whole amount in the re-eread invoice as an adjustment
    there is not actual cancel amount for the TAX amount, just for the total current charges amount, so if
    we do not exclude the invoice that was cancelled the taxes will show wrong as we will add the taxes for 
    the cancelled invoice as well, that's why we need teh statement
    ...AND NOT EXISTS (SELECT 1 FROM inb_867_mu mu WHERE service_id = i.service_id AND mu.cancelled_utl_tracking_id = i.mu_utl_tracking_id)   --EXCLUDE CANCELED-FOR-REREAD INVOICES
    HOWEVER in the Billing detail we SHOULD NOT DO THAT AS THERE THE CALCULATION OF THE TOTAL CURRENT CHARGES 
    WOULD BE THEN WRONG. again this !!! %%% $$$ #### is only for UBR !!! %%% $$$ ####
    SEE NOTE IN THE BILLING REPORTS
    */
  
   IS
  BEGIN
  
    OPEN rfcReport FOR
      SELECT ipsdtBeginDate AS "From",
             ipsdtEndDate AS "To",
             "State" AS "State",
             "County" AS "County",
             "Service Type" AS "Service Type",
             SUM(nvl("Total Sales Tax Amount~~c2#", 0)) AS "Total Sales Tax Amount~~c2#",
             --  SUM(i.total_current_charges_amount) - SUM(i.energy_charges_amount) AS "Diff~~c2#",
             SUM("Total Energy Charges~~c2#") AS "Total Energy Charges~~c2#",
             SUM("Total Current Charges Amt~~c2#") AS "Total Current Charges~~c2#",
             SUM(nvl("Total Cancel Amount~~c2#", 0)) AS "Total Cancel Amount~~c2#",
             SUM(nvl("Total Adjustment Amount~~c2#", 0)) AS "Total Adjustment Amount~~c2#"
      
      FROM   (
              
              SELECT ipsdtBeginDate                   AS "From",
                      ipsdtEndDate                     AS "To",
                      s.customer_id                    AS "Customer ID",
                      s.service_id                     AS "Service ID",
                      s.utl_acct_id                    AS "Utility Account ID",
                      s.commodity                      AS "Commodity",
                      e.utl_short_name                 AS "Utility Name",
                      i.invoice_id                     AS "Invoice ID",
                      i.energy_charges_amount          AS "Total Energy Charges~~c2#",
                      i.state_sales_tax_rate           AS "Sales Tax Rate",
                      STATE_SALES_TAX_AMOUNT           AS "Total Sales Tax Amount~~c2#",
                      i.total_cancelled_charges_amount AS "Total Cancel Amount~~c2#",
                      i.adjustment_amount              AS "Total Adjustment Amount~~c2#",
                      i.total_current_charges_amount   AS "Total Current Charges Amt~~c2#",
                      z.primary_city                   AS "City",
                      rpm.state                        AS "State",
                      z.county                         AS "County",
                      s.service_type                   AS "Service Type"
              
              FROM   invoice i
              --      INNER JOIN inb_824 i824 on i.invoice_id = i824.invoice_id and i824.error_code is null --SS COMMENTED OUT SINCE THESE NEED TO BE IN FOR MISSED WINDOW TAX AMOUNTS 
              --TO BE PAID (SINCE SUBSEQUENTLY THEY ARE ONLY TOTALED AS ADJUSTMENTS)
              INNER  JOIN service s
              ON     i.service_id = s.service_id
              INNER  JOIN zip_code z
              ON     s.zip_code = z.zip_code
              INNER  JOIN sales_source sa
              ON     sa.sales_source_id = s.sales_source_id
              INNER  JOIN utl_out_814_edi e
              ON     s.utl_id = e.utl_id
                     AND s.commodity = e.commodity
              INNER  JOIN utl_rpm rpm
              ON     rpm.utl_id = s.utl_id -- ff Oct/17/17 state from service are many times entered very wrong            
              WHERE  1 = 1
                     AND e.billing_method = 'UBR'
                     AND NOT EXISTS
               (SELECT 1
                      FROM   inb_867_mu mu
                      WHERE  service_id = i.service_id
                             AND mu.cancelled_utl_tracking_id =
                             i.mu_utl_tracking_id) -- SEE NOTE ON TOP: EXCLUDE CANCELED-FOR-REREAD INVOICES
                     AND trunc(i.transaction_date) BETWEEN ipsdtBeginDate AND
                     ipsdtEndDate
                     AND s.commodity = nvl(ipsCommodity, s.commodity)
                     AND
                     s.utl_id IN
                     (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                                 s.utl_id)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
                     AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
                     AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
                     AND nvl(s.service_type, '~') =
                     nvl(ipsServiceType, nvl(s.service_type, '~'))
                     AND (sa.sales_company_id = ipnSalesCompanyId OR
                     ipnSalesCompanyId = 0)
                     AND
                     rpm.state IN
                     (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                                 rpm.state)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
              
              UNION
              SELECT ipsdtBeginDate                   AS "From",
                      ipsdtEndDate                     AS "To",
                      s.customer_id                    AS "Customer ID",
                      s.service_id                     AS "Service ID",
                      s.utl_acct_id                    AS "Utility Account ID",
                      s.commodity                      AS "Commodity",
                      e.utl_short_name                 AS "Utility Name",
                      i.invoice_id                     AS "Invoice ID",
                      i.energy_charges_amount          AS "Total Energy Charges~~c2#",
                      i.state_sales_tax_rate           AS "Sales Tax Rate",
                      STATE_SALES_TAX_AMOUNT           AS "Total Sales Tax Amount~~c2#",
                      i.total_cancelled_charges_amount AS "Total Cancel Amount~~c2#",
                      i.adjustment_amount              AS "Total Adjustment Amount~~c2#",
                      i.total_current_charges_amount   AS "Total Current Charges Amt~~c2#",
                      z.primary_city                   AS "City",
                      rpm.state                        AS "State",
                      z.county                         AS "County",
                      s.service_type                   AS "Service Type"
              FROM   invoice i
              --      INNER JOIN inb_824 i824 on i.invoice_id = i824.invoice_id and i824.error_code is null --SS COMMENTED OUT SINCE THESE NEED TO BE IN FOR MISSED WINDOW TAX AMOUNTS 
              --TO BE PAID (SINCE SUBSEQUENTLY THEY ARE ONLY TOTALED AS ADJUSTMENTS)
              INNER  JOIN service s
              ON     i.service_id = s.service_id
              INNER  JOIN zip_code z
              ON     s.zip_code = z.zip_code
              INNER  JOIN sales_source sa
              ON     sa.sales_source_id = s.sales_source_id
              INNER  JOIN utl_out_814_edi e
              ON     s.utl_id = e.utl_id
                     AND s.commodity = e.commodity
              INNER  JOIN utl_rpm rpm
              ON     rpm.utl_id = s.utl_id -- ff Oct/17/17 state from service are many times entered very wrong            
              WHERE  1 = 1
                     AND e.billing_method <> 'UBR'
                     AND trunc(i.transaction_date) BETWEEN ipsdtBeginDate AND
                     ipsdtEndDate
                     AND s.commodity = nvl(ipsCommodity, s.commodity)
                     AND
                     s.utl_id IN
                     (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                                 s.utl_id)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
                     AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
                     AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
                     AND nvl(s.service_type, '~') =
                     nvl(ipsServiceType, nvl(s.service_type, '~'))
                     AND (sa.sales_company_id = ipnSalesCompanyId OR
                     ipnSalesCompanyId = 0)
                     AND
                     rpm.state IN
                     (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                                 rpm.state)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL)) --YB 12/7/2017
      GROUP  BY "State", "County", "Service Type"
      ORDER  BY "State", "County", "Service Type";
  
  END;
  -----------------------------------------------------------------------------------------------
  PROCEDURE AP_SalesTaxDetail(ipsdtBeginDate    IN VARCHAR2,
                              ipsdtEndDate      IN VARCHAR2,
                              ipsCommodity      IN VARCHAR2,
                              ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                              ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                              ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                              ipnServiceid      IN service.service_id%TYPE,
                              ipsServiceType    IN Service.Service_Type%TYPE,
                              ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                              rfcReport         OUT global.refCur)
  
   IS
  BEGIN
    /* FF Apr/20/2015 ****IMPORTANT NOTE:****
    When calculating TAXES, for !!** UBR ONLY **!! we actually do need to exclude the invoices that 
    got a cancel,re-read because sicne we place that whole amount in the re-eread invoice as an adjustment
    there is not actual cancel amount for the TAX amount, just for the total current charges amount, so if
    we do not exclude the invoice that was cancelled the taxes will show wrong as we will add the taxes for 
    the cancelled invoice as well, that's why we need teh statement
    ...AND NOT EXISTS (SELECT 1 FROM inb_867_mu mu WHERE service_id = i.service_id AND mu.cancelled_utl_tracking_id = i.mu_utl_tracking_id)   --EXCLUDE CANCELED-FOR-REREAD INVOICES
    HOWEVER in the Billing detail we SHOULD NOT DO THAT AS THERE THE CALCULATION OF THE TOTAL CURRENT CHARGES 
    WOULD BE THEN WRONG. again this !!! %%% $$$ #### is only for UBR !!! %%% $$$ ####
    SEE NOTE IN THE BILLING REPORTS
    */
  
    OPEN rfcReport FOR
      SELECT ipsdtBeginDate                   AS "From",
             ipsdtEndDate                     AS "To",
             s.customer_id                    AS "Customer ID",
             s.service_id                     AS "Service ID",
             s.utl_acct_id                    AS "Utility Account ID",
             s.commodity                      AS "Commodity",
             e.utl_short_name                 AS "Utility Name",
             i.invoice_id                     AS "Invoice ID",
             i.energy_charges_amount          AS "Total Energy Charges~~c2#",
             i.state_sales_tax_rate           AS "Sales Tax Rate",
             STATE_SALES_TAX_AMOUNT           AS "Total Sales Tax Amount~~c2#",
             i.total_cancelled_charges_amount AS "Total Cancel Amount~~c2#",
             i.adjustment_amount,
             0                                AS "Total Adjustment Amount~~c2#",
             i.total_current_charges_amount   AS "Total Current Charges Amt~~c2#",
             z.primary_city                   AS "City",
             rpm.state                        AS "State",
             z.county                         AS "County",
             s.service_type                   AS "Service Type"
      
      FROM   invoice i
      --      INNER JOIN inb_824 i824 on i.invoice_id = i824.invoice_id and i824.error_code is null --SS COMMENTED OUT SINCE THESE NEED TO BE IN FOR MISSED WINDOW TAX AMOUNTS 
      --TO BE PAID (SINCE SUBSEQUENTLY THEY ARE ONLY TOTALED AS ADJUSTMENTS)
      INNER  JOIN service s
      ON     i.service_id = s.service_id
      INNER  JOIN zip_code z
      ON     s.zip_code = z.zip_code
      INNER  JOIN sales_source sa
      ON     sa.sales_source_id = s.sales_source_id
      INNER  JOIN utl_out_814_edi e
      ON     s.utl_id = e.utl_id
             AND s.commodity = e.commodity
      INNER  JOIN utl_rpm rpm
      ON     rpm.utl_id = s.utl_id -- ff Oct/17/17 state from service are many times entered very wrong                    
      WHERE  1 = 1
             AND e.billing_method = 'UBR'
             AND NOT EXISTS
       (SELECT 1
              FROM   inb_867_mu mu
              WHERE  service_id = i.service_id
                     AND mu.cancelled_utl_tracking_id = i.mu_utl_tracking_id) -- SEE NOTE ON TOP: EXCLUDE CANCELED-FOR-REREAD INVOICES
             AND trunc(i.transaction_date) BETWEEN ipsdtBeginDate AND
             ipsdtEndDate
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND (sa.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
      UNION
      SELECT ipsdtBeginDate                   AS "From",
             ipsdtEndDate                     AS "To",
             s.customer_id                    AS "Customer ID",
             s.service_id                     AS "Service ID",
             s.utl_acct_id                    AS "Utility Account ID",
             s.commodity                      AS "Commodity",
             e.utl_short_name                 AS "Utility Name",
             i.invoice_id                     AS "Invoice ID",
             i.energy_charges_amount          AS "Total Energy Charges~~c2#",
             i.state_sales_tax_rate           AS "Sales Tax Rate",
             STATE_SALES_TAX_AMOUNT           AS "Total Sales Tax Amount~~c2#",
             i.total_cancelled_charges_amount AS "Total Cancel Amount~~c2#",
             i.adjustment_amount,
             0                                AS "Total Adjustment Amount~~c2#",
             i.total_current_charges_amount   AS "Total Current Charges Amt~~c2#",
             z.primary_city                   AS "City",
             rpm.state                        AS "State",
             z.county                         AS "County",
             s.service_type                   AS "Service Type"
      FROM   invoice i
      --      INNER JOIN inb_824 i824 on i.invoice_id = i824.invoice_id and i824.error_code is null --SS COMMENTED OUT SINCE THESE NEED TO BE IN FOR MISSED WINDOW TAX AMOUNTS 
      --TO BE PAID (SINCE SUBSEQUENTLY THEY ARE ONLY TOTALED AS ADJUSTMENTS)
      INNER  JOIN service s
      ON     i.service_id = s.service_id
      INNER  JOIN zip_code z
      ON     s.zip_code = z.zip_code
      INNER  JOIN sales_source sa
      ON     sa.sales_source_id = s.sales_source_id
      INNER  JOIN utl_out_814_edi e
      ON     s.utl_id = e.utl_id
             AND s.commodity = e.commodity
      INNER  JOIN utl_rpm rpm
      ON     rpm.utl_id = s.utl_id -- ff Oct/17/17 state from service are many times entered very wrong            
      WHERE  1 = 1
             AND e.billing_method <> 'UBR'
             AND trunc(i.transaction_date) BETWEEN ipsdtBeginDate AND
             ipsdtEndDate
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND (sa.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
      ORDER  BY "State", "County", "Service Type";
  END;
  -----------------------------------------------------------------------------------------------
  PROCEDURE ProratedMonthlyUsageAndBilling(ipsdtBeginDate    IN VARCHAR2,
                                           ipsdtEndDate      IN VARCHAR2,
                                           ipsCommodity      IN VARCHAR2,
                                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                           ipnServiceid      IN service.service_id%TYPE,
                                           ipsServiceType    IN Service.Service_Type%TYPE,
                                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                           rfcReport         OUT global.refCur)
  
   IS
    /*  28 July 2014 FF AH
    Original code returned results using an inner join on inb_824, which left out
    rate ready entries that don't have an inbound 824.
    in addition, pending inbound entries were also left out.
    a union select was added to retrieve Rate Ready entries, and pending action code
    entries was also added.*/
  
  BEGIN
    OPEN rfcReport FOR
      SELECT s.customer_id AS "Customer ID",
             s.service_id AS "Service ID",
             c.first_name AS "First Name",
             c.last_name AS "Last Name",
             s.service_type AS "Service Type",
             uo.utl_short_name AS "Utility Name",
             s.utl_acct_id AS "Utility Account ID",
             s.commodity AS "Commodity",
             reports.GetProratedMonthlyAmount(ipdPeriodEndDate        => LAST_DAY(to_date(ipsdtEndDate,
                                                                                          'DD-MON-YYYY')),
                                              ipdInvoiceStartDate     => i.start_date,
                                              ipdInvoiceEndDate       => i.end_date,
                                              ipnTotalToProrateAmount => i.total_usage_amount) "Prorated Usage Amount",
             reports.GetProratedMonthlyAmount(ipdPeriodEndDate        => LAST_DAY(to_date(ipsdtEndDate,
                                                                                          'DD-MON-YYYY')),
                                              ipdInvoiceStartDate     => i.start_date,
                                              ipdInvoiceEndDate       => i.end_date,
                                              ipnTotalToProrateAmount => i.energy_charges_amount) "Prorated Energy Charges Amount",
             reports.GetProratedMonthlyAmount(ipdPeriodEndDate        => LAST_DAY(to_date(ipsdtEndDate,
                                                                                          'DD-MON-YYYY')),
                                              ipdInvoiceStartDate     => i.start_date,
                                              ipdInvoiceEndDate       => i.end_date,
                                              ipnTotalToProrateAmount => i8.pr_invoiced_amount) "Prorated Tot Curr Charges Amt",
             reports.GetProratedMonthlyAmount(ipdPeriodEndDate        => LAST_DAY(to_date(ipsdtEndDate,
                                                                                          'DD-MON-YYYY')),
                                              ipdInvoiceStartDate     => i.start_date,
                                              ipdInvoiceEndDate       => i.end_date,
                                              ipnTotalToProrateAmount => i8.monetary_amount) "Prorated Discounted Rem Amt",
             START_date AS "Start Date",
             end_date AS "End Date",
             total_usage_amount AS "Total Usage Amount",
             i.energy_charges_amount AS "Energy Charges Amount"
      FROM   invoice i
      LEFT   JOIN inb_824 i824
      ON     i.invoice_id = i824.invoice_id
             AND (NVL(i824.action_code, 'Pending') = 'CF' OR
             NVL(i824.action_code, 'Pending') = 'Pending')
      INNER  JOIN service s
      ON     i.service_id = s.service_id
      INNER  JOIN customer c
      ON     s.customer_id = c.customer_id
      INNER  JOIN utl_out_814_edi uo
      ON     s.utl_id = uo.utl_id
             AND s.commodity = uo.commodity
      INNER  JOIN sales_source sa
      ON     sa.sales_source_id = s.sales_source_id
      INNER  JOIN inb_820 i8
      ON     i8.invoice_id = i.invoice_id
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = i.utl_id --YB 12/7/2017
      WHERE  1 = 1
             AND uo.billing_method = 'UBR'
             AND
             (START_date <= LAST_DAY(to_date(ipsdtEndDate, 'DD-MON-YYYY')) AND
             end_date >= trunc(to_date(ipsdtEndDate, 'DD-MON-YYYY'), 'MM')) --This will filter for only invoices which overlap the period we are working in
             AND
             i.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         i.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, i.utl_id)
             AND i.commodity = nvl(ipsCommodity, i.commodity)
             AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND i.utl_acct_id = nvl(ipsUTLAccountId, i.utl_acct_id)
             AND (sa.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
             AND NOT EXISTS
       (SELECT 1
              FROM   inb_867_mu mu
              WHERE  service_id = i.service_id
                     AND mu.cancelled_utl_tracking_id = i.mu_utl_tracking_id) --EXCLUDE CANCELED-FOR-REREAD INVOICES        
      UNION
      SELECT s.customer_id AS "Customer ID",
             s.service_id AS "Service ID",
             c.first_name AS "First Name",
             c.last_name AS "Last Name",
             s.service_type AS "Service Type",
             uo.utl_short_name AS "Utility Name",
             s.utl_acct_id AS "Utility Account ID",
             s.commodity AS "Commodity",
             reports.GetProratedMonthlyAmount(ipdPeriodEndDate        => LAST_DAY(to_date(ipsdtEndDate,
                                                                                          'DD-MON-YYYY')),
                                              ipdInvoiceStartDate     => i.start_date,
                                              ipdInvoiceEndDate       => i.end_date,
                                              ipnTotalToProrateAmount => i.total_usage_amount) "Prorated Usage Amount",
             reports.GetProratedMonthlyAmount(ipdPeriodEndDate        => LAST_DAY(to_date(ipsdtEndDate,
                                                                                          'DD-MON-YYYY')),
                                              ipdInvoiceStartDate     => i.start_date,
                                              ipdInvoiceEndDate       => i.end_date,
                                              ipnTotalToProrateAmount => i.energy_charges_amount) "Prorated Energy Charges Amount",
             reports.GetProratedMonthlyAmount(ipdPeriodEndDate        => LAST_DAY(to_date(ipsdtEndDate,
                                                                                          'DD-MON-YYYY')),
                                              ipdInvoiceStartDate     => i.start_date,
                                              ipdInvoiceEndDate       => i.end_date,
                                              ipnTotalToProrateAmount => i8.pr_invoiced_amount) "Prorated Tot Curr Charges Amt",
             reports.GetProratedMonthlyAmount(ipdPeriodEndDate        => LAST_DAY(to_date(ipsdtEndDate,
                                                                                          'DD-MON-YYYY')),
                                              ipdInvoiceStartDate     => i.start_date,
                                              ipdInvoiceEndDate       => i.end_date,
                                              ipnTotalToProrateAmount => i8.monetary_amount) "Prorated Discounted Rem Amt",
             START_date AS "Start Date",
             end_date AS "End Date",
             total_usage_amount AS "Total Usage Amount",
             i.energy_charges_amount AS "Energy Charges Amount"
      FROM   invoice i
      INNER  JOIN service s
      ON     i.service_id = s.service_id
      INNER  JOIN customer c
      ON     s.customer_id = c.customer_id
      INNER  JOIN utl_out_814_edi uo
      ON     s.utl_id = uo.utl_id
             AND s.commodity = uo.commodity
      INNER  JOIN sales_source sa
      ON     sa.sales_source_id = s.sales_source_id
      INNER  JOIN inb_820 i8
      ON     i8.invoice_id = i.invoice_id
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = i.utl_id --YB 12/7/2017
      WHERE  1 = 1
             AND uo.billing_method <> 'UBR'
             AND
             (START_date <= LAST_DAY(to_date(ipsdtEndDate, 'DD-MON-YYYY')) AND
             end_date >= trunc(to_date(ipsdtEndDate, 'DD-MON-YYYY'), 'MM')) --This will filter for only invoices which overlap the period we are working in
             AND
             i.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         i.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, i.utl_id)
             AND i.commodity = nvl(ipsCommodity, i.commodity)
             AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND i.utl_acct_id = nvl(ipsUTLAccountId, i.utl_acct_id)
             AND (sa.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
             AND NOT EXISTS
       (SELECT 1
              FROM   inb_867_mu mu
              WHERE  service_id = i.service_id
                     AND mu.cancelled_utl_tracking_id = i.mu_utl_tracking_id) --EXCLUDE CANCELED-FOR-REREAD INVOICES        
      ORDER  BY "Utility Account ID";
  
  END;

  -----------------------------------------------------------------------------------------------
  PROCEDURE RP_ServiceClassIncompatible(ipsdtBeginDate    IN VARCHAR2,
                                        ipsdtEndDate      IN VARCHAR2,
                                        ipsCommodity      IN VARCHAR2,
                                        ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                        ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                        ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                        ipnServiceid      IN service.service_id%TYPE,
                                        ipsServiceType    IN Service.Service_Type%TYPE,
                                        ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                        rfcReport         OUT global.refCur)
  
   IS
  BEGIN
    OPEN rfcReport FOR
    
      SELECT c.first_name             AS "First Name",
             c.last_name              AS "Last Name/Company Name",
             c.street                 AS "Street",
             c.suite                  AS "Suite",
             c.city                   AS "City",
             c.state                  AS "State",
             c.zip_code               AS "Zip Code",
             s.service_class          AS "Service Class In Service",
             rp.service_class         AS "Service Class In Rate Plan",
             rp.rate_plan_description AS "Rate Plan Description",
             uo.utl_short_name        AS "Utility Name",
             sc.sales_company_name    AS "Sales Company",
             s.utl_acct_id            AS "Utility Account ID",
             s.commodity              AS "Commodity",
             s.service_id             AS "Service Id",
             c.customer_id            AS "Customer Id"
      FROM   customer          c,
             service           s,
             service_rate_plan srp,
             rate_plan         rp,
             utl_out_814_edi   uo,
             sales_source      sr,
             sales_company     sc,
             utl_rpm           rpm
      WHERE  c.customer_id = s.customer_id
             AND s.service_id = srp.service_id
             AND srp.rate_plan_id = rp.rate_plan_id
             AND uo.utl_id = s.utl_id
             AND uo.commodity = s.commodity
             AND sr.sales_company_id = sc.sales_company_id
             AND s.sales_source_id = sr.sales_source_id
             AND s.utl_id = rpm.utl_id
             AND srp.expired_date IS NULL
             AND s.service_type IS NOT NULL
             AND s.service_class <> rp.service_class
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
             AND trunc(s.entered_date) BETWEEN
             to_date(ipsdtBeginDate, 'DD-MON-YYYY') AND
             to_date(ipsdtEndDate, 'DD-MON-YYYY')
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (sr.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL); --YB 12/7/2017
  
  END;
  -------------------------------------------------------------------------------------------------------
  PROCEDURE RatePlan_InvoiceRateComparison(ipsdtBeginDate    IN VARCHAR2,
                                           ipsdtEndDate      IN VARCHAR2,
                                           ipsCommodity      IN VARCHAR2,
                                           ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                           ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                           ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                           ipnServiceid      IN service.service_id%TYPE,
                                           ipsServiceType    IN Service.Service_Type%TYPE,
                                           ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                           rfcReport         OUT global.refCur) IS
  BEGIN
  
    OPEN rfcReport FOR
      SELECT urp.state, --YB 12/7/2017 temp
             i.service_id AS "Service ID",
             c.first_name AS "First Name",
             c.last_name AS "Last Name",
             round(nvl(i.rate_amount,
                       i.energy_charges_amount / i.total_usage_amount),
                   4) AS "Invoice Rate Amount",
             rp.rate_amount AS "Rate Plan Rate Amount",
             (SELECT rs.rate_amount
              FROM   inb_814_rsp rs
              WHERE  service_id = i.service_id
                     AND inb_814_rsp_id =
                     (SELECT MAX(inb_814_rsp_id)
                          FROM   inb_814_rsp
                          WHERE  service_id = i.service_id
                                 AND rs.change_reason_code = 'AMTRJ'
                                 AND rs.status_code = 'ACCEPTANCE')) AS "Accepted Last Month",
             -1 * (ROUND((100 - (nvl(i.rate_amount,
                                     i.energy_charges_amount /
                                     i.total_usage_amount) * 100) /
                         rp.rate_amount),
                         2)) AS "Percentage Difference",
             i.start_date AS "Invoice Start Date",
             i.end_date AS "Invoice End Date",
             urp.utl_short_name AS "Utl Name",
             i.energy_charges_amount AS "Energy Charges Amount",
             i.total_usage_amount AS "Total Usage Amount",
             i.total_current_charges_amount AS "Total Current Charges Amount",
             i.invoice_id AS "Invoice ID",
             c.customer_id AS "Customer ID"
      FROM   rate_plan         rp,
             service_rate_plan srp,
             invoice           i,
             customer          c,
             service           s,
             utl_rpm           urp
      WHERE  rp.rate_plan_id = srp.rate_plan_id
             AND srp.service_id = i.service_id
             AND s.service_id = i.service_id
             AND c.customer_id = s.customer_id
             AND urp.utl_id = i.utl_id
             AND rp.rate_amount <>
             nvl(i.rate_amount,
                     i.energy_charges_amount / i.total_usage_amount)
             AND srp.expired_date IS NULL
             AND i.end_date =
             (SELECT MAX(end_date)
                  FROM   invoice
                  WHERE  service_id = i.service_id
                         AND TRANSACTION_PURPOSE = '00')
             AND nvl(i.total_usage_amount, 0) <> 0
             AND TRUNC(i.end_date) BETWEEN
             to_Date(ipsdtBeginDate, 'dd-MON-yyyy') AND
             to_Date(ipsdtEndDate, 'dd-MON-yyyy')
             AND
             i.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         i.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, i.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             urp.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         urp.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
      ORDER  BY "Percentage Difference";
  END;

  -----------------------------------------------------------------------------------------------
  PROCEDURE RatePlanNotMinMax( --SB 8/6/2015   created this procedure for report that shows
                              -- all accounts with rate amounts not in min/max amounts
                              ipsdtBeginDate    IN VARCHAR2,
                              ipsdtEndDate      IN VARCHAR2,
                              ipsCommodity      IN VARCHAR2,
                              ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                              ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                              ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                              ipnServiceid      IN service.service_id%TYPE,
                              ipsServiceType    IN Service.Service_Type%TYPE,
                              ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                              rfcReport         OUT global.refCur) IS
  BEGIN
  
    OPEN rfcReport FOR
      SELECT "Status",
             "Service ID",
             "First Name",
             "Last Name",
             "Min Rate Amount",
             "Max Rate Amount",
             "Invoice Rate Amount",
             "Accepted Last Month",
             abs(ROUND((100 - (("Invoice Rate Amount" * 100) /
                       DECODE("Status",
                                      'Less Than Min',
                                      "Min Rate Amount",
                                      "Max Rate Amount"))),
                       2)) AS "Percentage Difference",
             
             "Rate Plan Rate Amount",
             "Invoice Start Date",
             "Invoice End Date",
             "Utl Name",
             "Commodity",
             "Energy Charges Amount",
             "Total Usage Amount",
             "Total Current Charges Amount",
             "Invoice ID",
             "Customer ID"
      
      FROM   (SELECT DISTINCT /*
                                                                                                                                                              Placed in subquery to facilitate 'WHERE "Status" IS NOT NULL' clause.
                                                                                                                                                              Was originally a union of two quries one for min and one for max, and the "checking" was done in
                                                                                                                                                              WHERE clause. Reason for change: to shorten length of code by removing the union.
                                                                                                                                                              Incidentally performance seemed to improve by more than %20.
                                                                                                                                                              NOTE: originally there was a "round" function which was removed because purpose was not recognized
                                                                                                                                                              */
                              
                               CASE
                                 WHEN (i.Commodity = 'G' AND
                                      nvl(i.rate_amount,
                                           i.energy_charges_amount /
                                           i.total_usage_amount) <
                                      se.rate_amount_min_gas) OR
                                      (i.Commodity = 'E' AND
                                      nvl(i.rate_amount,
                                           i.energy_charges_amount /
                                           i.total_usage_amount) <
                                      se.rate_amount_min_elec) THEN
                                  'Less Than Min'
                                 WHEN (i.Commodity = 'G' AND
                                      nvl(i.rate_amount,
                                           i.energy_charges_amount /
                                           i.total_usage_amount) >
                                      se.rate_amount_max_gas) OR
                                      (i.Commodity = 'E' AND
                                      nvl(i.rate_amount,
                                           i.energy_charges_amount /
                                           i.total_usage_amount) >
                                      se.rate_amount_max_elec) --YB 12/11/2017 round seems unnecessary 
                                  THEN
                                  'More Than Max'
                               END AS "Status",
                              
                              i.service_id AS "Service ID",
                              c.first_name AS "First Name",
                              c.last_name AS "Last Name",
                              DECODE(i.commodity,
                                     'G',
                                     se.rate_amount_min_gas,
                                     se.rate_amount_min_elec) AS "Min Rate Amount",
                              DECODE(i.commodity,
                                     'G',
                                     se.rate_amount_max_gas,
                                     se.rate_amount_max_elec) AS "Max Rate Amount",
                              round(nvl(i.rate_amount,
                                        i.energy_charges_amount /
                                        i.total_usage_amount),
                                    4) AS "Invoice Rate Amount",
                              (SELECT rs.rate_amount
                               FROM   inb_814_rsp rs
                               WHERE  service_id = i.service_id
                                      AND inb_814_rsp_id =
                                      (SELECT MAX(inb_814_rsp_id)
                                           FROM   inb_814_rsp
                                           WHERE  service_id = i.service_id
                                                  AND rs.change_reason_code =
                                                  'AMTRJ'
                                                  AND rs.status_code =
                                                  'ACCEPTANCE')) AS "Accepted Last Month",
                              
                              rp.rate_amount                 AS "Rate Plan Rate Amount",
                              i.start_date                   AS "Invoice Start Date",
                              i.end_date                     AS "Invoice End Date",
                              urp.utl_short_name             AS "Utl Name",
                              i.commodity                    AS "Commodity",
                              i.energy_charges_amount        AS "Energy Charges Amount",
                              i.total_usage_amount           AS "Total Usage Amount",
                              i.total_current_charges_amount AS "Total Current Charges Amount",
                              i.invoice_id                   AS "Invoice ID",
                              c.customer_id                  AS "Customer ID"
              FROM   customer          c,
                     rate_plan         rp,
                     service_rate_plan srp,
                     invoice           i,
                     service           s,
                     utl_rpm           urp,
                     SETTINGS          se
              WHERE  rp.rate_plan_id = srp.rate_plan_id
                     AND srp.service_id = i.service_id
                     AND s.service_id = i.service_id
                     AND c.customer_id = s.customer_id
                     AND urp.utl_id = i.utl_id
                     AND
                     rp.rate_amount <>
                     nvl(i.rate_amount,
                         i.energy_charges_amount / i.total_usage_amount)
                     AND srp.expired_date IS NULL
                     AND i.end_date =
                     (SELECT MAX(end_date)
                          FROM   invoice
                          WHERE  service_id = i.service_id
                                 AND TRANSACTION_PURPOSE = '00')
                     AND nvl(i.total_usage_amount, 0) <> 0
                    
                    /* YB 12/11/2017 
                    Added WHERE clauses to accomadate user selected filters. For some unknown reason they did not previously exist*/
                     AND trunc(i.end_date) BETWEEN ipsdtBeginDate AND
                     ipsdtEndDate
                     AND s.commodity = nvl(ipsCommodity, s.commodity)
                     AND
                     s.utl_id IN
                     (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                                 s.utl_id)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL)
                     AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
                     AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
                     AND nvl(s.service_type, '~') =
                     nvl(ipsServiceType, nvl(s.service_type, '~'))
                     AND
                     urp.state IN
                     (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                                 urp.state)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL))
      WHERE  "Status" IS NOT NULL
      ORDER  BY "Percentage Difference" DESC;
  
  END;
  -----------------------------------------------------------------------------------------------
  PROCEDURE USG_YearlyUsageSummary(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                   rfcReport         OUT global.refCur) IS
  BEGIN
  
    OPEN rfcReport FOR
      SELECT COUNT(*) AS "Service Count",
             round(to_number(SUM(YearlyUsagAmount) / COUNT(*)), 4) AS "Average Usage Amount~~d2#", /*SB 7/20/2015  Added rounding to 4 in the usage summary reports so that the frontend calculates it correctly. 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     Otherwise the frontend does not work because there are too many decimols.*/
             SUM(YearlyUsagAmount) AS "Yearly Usage Amount~~d2#",
             "Utility Name",
             "Service Type",
             "Commodity",
             "Status"
      FROM   (SELECT nvl(USAGE.GET_YEARLY_USAGE_AMOUNT(s.service_id), 0) AS YearlyUsagAmount,
                     uo.utl_short_name AS "Utility Name",
                     s.service_type AS "Service Type",
                     s.commodity AS "Commodity",
                     st.status AS "Status"
              
              FROM   service        s,
                     sales_source   sr,
                     utl_rpm        uo,
                     customer       c,
                     service_status st
              WHERE  s.service_id = st.service_id
                     AND st.service_status_id =
                     (SELECT MAX(service_status_id)
                          FROM   service_status
                          WHERE  service_id = s.service_id)
                     AND st.status NOT LIKE 'Cancelled%'
                     AND st.status NOT LIKE '%Rejected%'
                     AND st.status NOT LIKE '%Rescind%'
                     AND uo.utl_id = s.utl_id
                     AND s.customer_id = c.customer_id
                     AND s.utl_id = uo.utl_id
                     AND s.sales_source_id = sr.sales_source_id
                     AND
                     s.utl_id IN
                     (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                                 s.utl_id)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
                     AND s.commodity = nvl(ipsCommodity, s.commodity)
                     AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
                     AND nvl(s.service_type, '~') =
                     nvl(ipsServiceType, nvl(s.service_type, '~'))
                     AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
                     AND (sr.sales_company_id = ipnSalesCompanyId OR
                     ipnSalesCompanyId = 0)
                     AND
                     uo.state IN
                     (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                                 uo.state)
                      FROM   dual
                      CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL)) --YB 12/7/2017
      WHERE  YearlyUsagAmount > 0
      GROUP  BY "Utility Name", "Service Type", "Commodity", "Status"
      HAVING COUNT(*) > 0
      ORDER  BY "Utility Name";
  
  END;
  -----------------------------------------------------------------------------------------------

  PROCEDURE USG_YearlyUsageDetail(ipsdtBeginDate    IN VARCHAR2,
                                  ipsdtEndDate      IN VARCHAR2,
                                  ipsCommodity      IN VARCHAR2,
                                  ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                  ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                  ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                  ipnServiceid      IN service.service_id%TYPE,
                                  ipsServiceType    IN Service.Service_Type%TYPE,
                                  ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                  rfcReport         OUT global.refCur) IS
  BEGIN
  
    OPEN rfcReport FOR
      SELECT c.first_name AS "First Name",
             c.last_name AS "Last_Name",
             s.street AS "Street",
             s.suite AS "Suite",
             s.city AS "City",
             s.state AS "State",
             s.zip_code AS "Zip",
             uo.utl_short_name AS "Utility Name",
             USAGE.GET_YEARLY_USAGE_AMOUNT(s.service_id) AS "Yearly Usage Amount",
             s.service_type AS "Service Type",
             s.UTL_RATE_CLASS AS "Utility Rate Class",
             s.start_service_date AS "Start Service Date",
             st.status AS "Status",
             s.service_id AS "Service ID",
             s.customer_id AS "Customer ID",
             s.utl_acct_id AS "Utility Account ID",
             s.commodity AS "Commodity"
      FROM   service         s,
             customer        c,
             utl_out_814_edi uo,
             sales_source    sr,
             service_status  st,
             utl_rpm         rpm --YB 12/7/2017
      WHERE  s.customer_id = c.customer_id
             AND s.utl_id = uo.utl_id
             AND s.utl_id = rpm.utl_id --YB 12/7/2017
             AND s.commodity = uo.commodity
             AND s.sales_source_id = sr.sales_source_id
             AND s.service_id = st.service_id
             AND st.service_status_id =
             (SELECT MAX(service_status_id)
                  FROM   service_status
                  WHERE  service_id = s.service_id)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (sr.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL); --YB 12/7/2017
  END;

  -----------------------------------------------------------------------------------------------
  PROCEDURE USG_MonthlyUsageDetail(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                   rfcReport         OUT global.refCur) IS
  BEGIN
  
    OPEN rfcReport FOR
      SELECT c.first_name         AS "First Name",
             c.last_name          AS "Last_Name",
             s.street             AS "Street",
             s.suite              AS "Suite",
             s.city               AS "City",
             s.state              AS "State",
             s.zip_code           AS "Zip",
             uo.utl_short_name    AS "Utility Name",
             smu.month_year       AS "Month Year Of Usage",
             smu.amount           AS "Amount Of Usage",
             smu.uom              AS "UOM",
             s.service_type       AS "Service Type",
             s.UTL_RATE_CLASS     AS "Utility Rate Class",
             s.start_service_date AS "Start Service Date",
             st.status            AS "Status",
             s.service_id         AS "Service ID",
             s.customer_id        AS "Customer ID",
             s.utl_acct_id        AS "Utility Account ID",
             s.commodity          AS "Commodity"
      FROM   service               s,
             customer              c,
             utl_out_814_edi       uo,
             sales_source          sr,
             service_monthly_usage smu,
             service_status        st,
             utl_rpm               rpm --YB 12/7/2017
      WHERE  s.customer_id = c.customer_id
             AND s.utl_id = uo.utl_id
             AND s.utl_id = rpm.utl_id --YB 12/7/2017
             AND s.commodity = uo.commodity
             AND s.sales_source_id = sr.sales_source_id
             AND s.service_id = smu.service_id
             AND s.service_id = st.service_id -- FF JUL/12/17
             AND st.service_status_id =
             (SELECT MAX(service_status_id)
                  FROM   service_status
                  WHERE  service_id = s.service_id)
             AND smu.month_year >= ipsdtBeginDate
             AND smu.month_year <= ipsdtEndDate
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (sr.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
      ORDER  BY s.service_id, smu.month_year;
  END;

  -----------------------------------------------------------------------------------------------
  PROCEDURE USG_MonthlyUsageSummary(ipsdtBeginDate    IN VARCHAR2,
                                    ipsdtEndDate      IN VARCHAR2,
                                    ipsCommodity      IN VARCHAR2,
                                    ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                    ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                    ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                    ipnServiceid      IN service.service_id%TYPE,
                                    ipsServiceType    IN Service.Service_Type%TYPE,
                                    ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                    rfcReport         OUT global.refCur) IS
  BEGIN
  
    OPEN rfcReport FOR
      SELECT COUNT(*) AS "Service Count",
             uo.utl_short_name AS "Utility Name",
             smu.month_year AS "Month Year Of Usage",
             round(to_number(SUM(smu.amount) / COUNT(*)), 4) AS "Average Amount Of Usage~~d2#", -- Added the rounding to 4 because otherwise the frontend wasn't workinig - too many decimols. SB 7/20/2015
             SUM(smu.amount) AS "Amount Of Usage~~d2#",
             smu.uom AS "UOM",
             s.service_type AS "Service Type",
             st.status,
             s.commodity AS "Commodity"
      FROM   service               s,
             customer              c,
             utl_out_814_edi       uo,
             service_monthly_usage smu,
             service_status        st,
             utl_rpm               rpm --YB 12/7/2017
      WHERE  s.service_id = smu.service_id
             AND s.utl_id = uo.utl_id
             AND s.utl_id = rpm.utl_id --YB 12/7/2017
             AND s.commodity = uo.commodity
             AND st.service_status_id =
             (SELECT MAX(service_status_id)
                  FROM   service_status
                  WHERE  service_id = s.service_id)
             AND st.status NOT LIKE 'Cancelled%'
             AND st.status NOT LIKE '%Rejected%'
             AND st.status NOT LIKE '%Rescind%'
             AND smu.month_year BETWEEN SYSDATE - 365 AND SYSDATE
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND (s.service_ID = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
      GROUP  BY rpm.state, --YB 12/7/2017 temp
                uo.utl_short_name,
                smu.month_year,
                smu.uom,
                s.service_type,
                s.commodity,
                status
      ORDER  BY "Month Year Of Usage" DESC;
  END;

  -----------------------------------------------------------------------------------------------
  PROCEDURE GetSalesCompanyList(rfcSalesCompany OUT global.refCur) IS
  BEGIN
  
    OPEN rfcSalesCompany FOR
      SELECT sc.sales_company_id, sc.sales_company_name
      FROM   sales_company sc
      
      UNION
      SELECT VALUE, Display
      FROM   constants
      WHERE  NAME = 'All'
      ORDER  BY sales_company_name;
  END;
  ------------------------------------------------------------------------------------------------
  PROCEDURE GetReportConstants(rfcSalesCompany OUT global.refCur) IS
  BEGIN
  
    OPEN rfcSalesCompany FOR
      SELECT Display, VALUE
      FROM   CONSTANTS
      WHERE  NAME = 'All';
  END;
  ------------------------------------------------------------------------------------------------
  FUNCTION GetProratedMonthlyAmount(ipdPeriodEndDate        IN DATE,
                                    ipdInvoiceStartDate     IN invoice.start_date%TYPE,
                                    ipdInvoiceEndDate       IN invoice.end_date%TYPE,
                                    ipnTotalToProrateAmount IN NUMBER)
    RETURN NUMBER AS
  
    -- This function prorates any amount given in, wether it receives usage, or cahrge amounts, etc.
    -- FF/SS  Feb 19 2014                                      
  
    dPeriodStartDate    DATE := TO_DATE('1-' || TO_CHAR(ipdPeriodEndDate,
                                                        'MON-YYYY'),
                                        'DD-MON-YYYY');
    dStartOfPeriod      DATE;
    dEndOfPeriod        DATE;
    nTotalDaysInInvoice NUMBER := 0;
    nDailyAverageAmount NUMBER := 0;
    nTotalDaysInPeriod  NUMBER := 0;
    dAdjInvoiceEndDate  DATE := ipdInvoiceEndDate - 1; -- We are adjusting the invoice end date because utilities will use 
    -- this date for the next month so is really not part of THE invoice
  
  BEGIN
    -- Now calculate
    nTotalDaysInInvoice := ipdInvoiceEndDate - ipdInvoiceStartDate;
  
    IF ipdInvoiceStartDate <= dPeriodStartDate THEN
      dStartOfPeriod := dPeriodStartDate;
    ELSE
      dStartOfPeriod := ipdInvoiceStartDate;
    END IF;
  
    IF dAdjInvoiceEndDate >= ipdPeriodEndDate THEN
      dEndOfPeriod := ipdPeriodEndDate;
    ELSE
      dEndOfPeriod := dAdjInvoiceEndDate;
    END IF;
  
    IF nTotalDaysInInvoice = 0 THEN
      nTotalDaysInInvoice := 1;
    END IF; --Minimum period is 1 day, this has to be set due to the potential (and actual) incoming of inconsistent and/or unstable data from other providers (ehem)
  
    nDailyAverageAmount := ipnTotalToProrateAmount / nTotalDaysInInvoice;
    nTotalDaysInPeriod  := dEndOfPeriod - dStartOfPeriod + 1;
    IF nTotalDaysInPeriod = 0 THEN
      nTotalDaysInPeriod := 1; -- also here see comment below
    END IF; --Minimum period is 1 day, this has to be set due to the potential (and actual) incoming of inconsistent and/or unstable data from other providers (ehem)
  
    RETURN round(nTotalDaysInPeriod * nDailyAverageAmount, 2);
  
  END;
  ---------------------------------------------------------------------------------------------------------------------
  PROCEDURE rp_ContractExpirations(ipsdtBeginDate    IN VARCHAR2,
                                   ipsdtEndDate      IN VARCHAR2,
                                   ipsCommodity      IN VARCHAR2,
                                   ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                   ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                   ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                   ipnServiceid      IN service.service_id%TYPE,
                                   ipsServiceType    IN Service.Service_Type%TYPE,
                                   ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                   rfcReport         OUT global.refCur) IS
    /*NM  11/6/14
    Addition of claim expiration report
    */
  
  BEGIN
    OPEN rfcReport FOR
      SELECT c.Customer_id         AS "Customer ID",
             c.First_Name          AS "First Name",
             c.Last_Name           AS "Last Name",
             c.phone               AS "Phone Number",
             s.Service_id          AS "Service ID",
             s.Utl_Acct_id         AS "Account ID",
             s.utl_id              AS "Utility ID",
             u.utl_short_name      AS "Utility Name",
             s.Commodity           AS "Commodity",
             sr.end_date           AS "Rate Plan Expiration Date",
             sc.sales_company_name AS "Sales Company",
             s.service_type        AS "Service Type",
             st.status             AS "Service Status"
      
      FROM   Service s
      JOIN   Customer c
      ON     c.Customer_id = s.Customer_id
      JOIN   Service_Rate_Plan sr
      ON     s.Service_id = sr.Service_id
      JOIN   Utl_Out_814_Edi u
      ON     s.utl_id = u.utl_id
             AND s.commodity = u.commodity
      JOIN   service_status st
      ON     st.service_id = s.service_id
             AND st.service_status_id =
             (SELECT MAX(service_status_id)
                  FROM   service_status
                  WHERE  service_id = s.service_id)
      JOIN   sales_source so
      ON     so.sales_source_id = s.sales_source_id
      JOIN   sales_company sc
      ON     sc.sales_company_id = so.sales_company_id
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = s.utl_id --YB 12/7/2017
      JOIN   rate_plan rp
      ON     rp.rate_plan_id = sr.rate_plan_id --YB 12/11/2017
      
      WHERE  sr.end_date BETWEEN ipsdtBeginDate AND ipsdtEndDate
             AND sr.expired_date IS NULL
             AND trunc(sr.end_date) BETWEEN ipsdtBeginDate AND ipsdtEndDate
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
             AND rp.rate_plan_type = 'Fixed' --YB 12/11/2017
      ORDER  BY sr.end_date;
  END;
  ---------------------------------------------------------------------------------------------------------------------
  PROCEDURE rp_FixedPlanAcctCancelWarning(ipsdtBeginDate    IN VARCHAR2,
                                          ipsdtEndDate      IN VARCHAR2,
                                          ipsCommodity      IN VARCHAR2,
                                          ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                          ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                          ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                          ipnServiceid      IN service.service_id%TYPE,
                                          ipsServiceType    IN Service.Service_Type%TYPE,
                                          ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                          rfcReport         OUT global.refCur) IS
    /*FS  05/22/15
    Warning on accounts cancelling with fixed plan
    */
  BEGIN
    OPEN rfcReport FOR
      SELECT DISTINCT c.Customer_id         AS "Customer ID",
                      c.First_Name          AS "First Name",
                      c.Last_Name           AS "Last Name",
                      s.Service_id          AS "Service ID",
                      s.Utl_Acct_id         AS "Account ID",
                      s.utl_id              AS "Utility ID",
                      u.utl_short_name      AS "Utility Name",
                      s.Commodity           AS "Commodity",
                      r.rate_plan_type      AS "Rate Plan Type",
                      sr.start_date         AS "Start Date",
                      sr.end_date           AS "End Date",
                      s.end_service_date    AS "End Service Date",
                      s.cancel_req_date     AS "Cancel Request Date",
                      sc.sales_company_name AS "Sales Company",
                      i.status_code         AS "Response",
                      i.status_description  AS "Reason"
      FROM   Service s
      JOIN   Customer c
      ON     c.Customer_id = s.Customer_id
      JOIN   Service_Rate_Plan sr
      ON     s.Service_id = sr.Service_id
      JOIN   Utl_Out_814_Edi u
      ON     s.utl_id = u.utl_id
             AND s.commodity = u.commodity
      JOIN   sales_source so
      ON     so.sales_source_id = s.sales_source_id
      JOIN   sales_company sc
      ON     sc.sales_company_id = so.sales_company_id
      JOIN   rate_plan r
      ON     r.rate_plan_id = sr.rate_plan_id
      JOIN   inb_814_rsp i
      ON     i.service_id = s.service_id
      JOIN   utl_rpm rpm
      ON     rpm.utl_id = s.utl_id --YB 12/7/2017
      WHERE  s.end_service_date BETWEEN ipsdtBeginDate AND ipsdtEndDate
             AND sr.expired_date IS NULL
             AND sr.end_date > s.end_service_date
             AND s.start_service_date < s.end_service_date -- FF Sep/8/2015 (And put in on Dec/28/2015)
             AND UPPER(r.rate_plan_type) = 'FIXED'
             AND s.end_service_date IS NOT NULL
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (sc.sales_company_id = ipnSalesCompanyId OR
             ipnSalesCompanyId = 0)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             rpm.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         rpm.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
      ORDER  BY s.end_service_date;
  END;
  ---------------------------------------------------------------------------------------------------
  PROCEDURE xc_InbTransAccountNotFound(ipsdtBeginDate    IN VARCHAR2,
                                       ipsdtEndDate      IN VARCHAR2,
                                       ipsCommodity      IN VARCHAR2,
                                       ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                                       ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                                       ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                                       ipnServiceid      IN service.service_id%TYPE,
                                       ipsServiceType    IN Service.Service_Type%TYPE,
                                       ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                                       rfcReport         OUT global.refCur) IS
    /*FS Apr/30/2015
     This report is for transactions in which accounts are not found.   
    */
  BEGIN
    OPEN rfcReport FOR
      SELECT ix.Utl_Acct_id    AS "Utility Account ID",
             ix.utl_id         AS "Utility ID",
             ur.utl_short_name AS "Utility Name",
             ix.commodity      AS "Commodity",
             ix.raw_record     AS "Raw Record",
             ix.File_Name      AS "Transaction Type",
             ix.entered_date   AS "Entered Date"
      FROM   inb_exc ix
      JOIN   utl_rpm ur
      ON     ix.utl_id = ur.utl_id
      WHERE  trunc(ix.entered_date) BETWEEN ipsdtBeginDate AND ipsdtEndDate
             AND ix.reprocessed_date IS NULL
             AND
             ur.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         ur.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/11/2017 
      
      ORDER  BY ix.entered_date;
  END;
  ---------------------------------------------------------------------------------------------------------------------
  PROCEDURE rp_CallLogFollowUp(ipsdtBeginDate    IN VARCHAR2,
                               ipsdtEndDate      IN VARCHAR2,
                               ipsCommodity      IN VARCHAR2,
                               ipsUtlId          IN utl_out_814_edi.utl_id%TYPE,
                               ipsUTLAccountId   IN service.utl_acct_id%TYPE,
                               ipnSalesCompanyId IN sales_company.sales_company_id%TYPE,
                               ipnServiceid      IN service.service_id%TYPE,
                               ipsServiceType    IN Service.Service_Type%TYPE,
                               ipsStates         IN utl_rpm.state%TYPE, --YB 12/7/2017
                               rfcReport         OUT global.refCur) IS
    /* FS May/4/2015
    Report to returns follow up date info
    */
  BEGIN
    OPEN rfcReport FOR
      SELECT c.First_Name      AS "First Name",
             c.Last_Name       AS "Last Name",
             s.Utl_Acct_id     AS "Account ID",
             ur.utl_short_name AS "Utility Name",
             s.Commodity       AS "Commodity",
             s.street          AS "Street",
             s.suite           AS "Suite",
             s.city            AS "City",
             s.state           AS "State",
             s.zip_code        AS "zip_code",
             cl.call_type      AS "Call Type",
             cl.call_subtype   AS "Call Subtype",
             cl.notes          AS "Notes",
             cl.resolution     AS "Resolution",
             cl.entered_date   AS "Enter Date",
             cl.follow_up_date AS "Follow Up Date"
      FROM   Service s
      JOIN   Customer c
      ON     c.Customer_id = s.Customer_id
      JOIN   Call_Log cl
      ON     cl.customer_id = c.customer_id
      JOIN   utl_rpm ur
      ON     s.utl_id = ur.utl_id
      WHERE  trunc(cl.follow_up_date) BETWEEN ipsdtBeginDate AND
             ipsdtEndDate
             AND cl.follow_up_date IS NOT NULL
             AND s.commodity = nvl(ipsCommodity, s.commodity)
             AND
             s.utl_id IN
             (SELECT nvl(regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL),
                         s.utl_id)
              FROM   dual
              CONNECT BY regexp_substr(ipsUtlId, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017 = nvl(ipsUtlId, s.utl_id)
             AND s.utl_acct_id = nvl(ipsUTLAccountId, s.utl_acct_id)
             AND (s.service_id = ipnServiceid OR ipnServiceid = 0)
             AND nvl(s.service_type, '~') =
             nvl(ipsServiceType, nvl(s.service_type, '~'))
             AND
             ur.state IN
             (SELECT nvl(regexp_substr(ipsStates, '[^,]+', 1, LEVEL),
                         ur.state)
              FROM   dual
              CONNECT BY regexp_substr(ipsStates, '[^,]+', 1, LEVEL) IS NOT NULL) --YB 12/7/2017
      ORDER  BY cl.follow_up_date;
  END;
  ---------------------------------------------------------------------------------------------------
  PROCEDURE InsertReportDefAndParam(ipsReportCatergory      IN VARCHAR2,
                                    ipsReportName           IN VARCHAR2,
                                    ipsReportDescription    IN VARCHAR2,
                                    ipsPackageName          IN VARCHAR2 DEFAULT 'Reports',
                                    ipsProcedureName        IN VARCHAR2,
                                    ipsRefcursorName        IN VARCHAR2 DEFAULT 'rfcCursor',
                                    ipnEnersoftSystemRoleID NUMBER DEFAULT NULL,
                                    ipsEnteredBy            IN VARCHAR2,
                                    ipdExpiredDate          IN DATE,
                                    ipsExpiredBy            VARCHAR2,
                                    ipsDisplayFlag          VARCHAR2,
                                    ipsControlInitialValue  IN VARCHAR2,
                                    
                                    ipbtxtUTLAccountId IN BOOLEAN,
                                    ipblblUtlAccountId IN BOOLEAN,
                                    
                                    ipbdtpEndDate IN BOOLEAN,
                                    ipblblEndDate IN BOOLEAN,
                                    
                                    ipblstCommodity IN BOOLEAN,
                                    ipblblCommodity IN BOOLEAN,
                                    
                                    ipbtxtServiceId IN BOOLEAN,
                                    ipblblServiceId IN BOOLEAN,
                                    
                                    ipblstUtilityName IN BOOLEAN,
                                    ipblblUtilityName IN BOOLEAN,
                                    
                                    ipbdtpStartDate IN BOOLEAN,
                                    ipblblStartDate IN BOOLEAN,
                                    
                                    ipblstSalesCompany  IN BOOLEAN,
                                    ipblblStatusCompany IN BOOLEAN,
                                    
                                    ipblstCustomerType IN BOOLEAN,
                                    ipblblCustomerType IN BOOLEAN)
  
   IS
    nReportDefId report_def.report_def_id%TYPE;
  
  BEGIN
  
    SELECT seq_report_def_id.nextval
    INTO   nReportDefId
    FROM   dual;
  
    INSERT INTO report_def
      (REPORT_DEF_ID,
       REPORT_CATEGORY,
       REPORT_NAME,
       REPORT_DESCRIPTION,
       PACKAGE_NAME,
       PROCEDURE_NAME,
       REFCURSOR_NAME,
       ENERSOFT_SYSTEM_ROLE_ID,
       ENTERED_DATE,
       ENTERED_BY,
       EXPIRED_DATE,
       EXPIRED_BY,
       DISPLAY_FLAG)
    
    VALUES
      (nReportDefId,
       ipsReportCatergory,
       ipsReportName,
       ipsReportDescription,
       ipsPackageName,
       ipsProcedureName,
       ipsRefcursorName,
       ipnEnersoftSystemRoleID,
       SYSDATE,
       ipsEnteredBy,
       ipdExpiredDate,
       ipsExpiredBy,
       ipsDisplayFlag);
  
    IF ipbtxtUTLAccountId = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_txtUTLAccountId',
         'TextBox',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblblUtlAccountId = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lblUtlAccountId',
         'Label',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipbdtpEndDate = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_dtpEndDate',
         'DateTimePicker',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblstCommodity = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lstCommodity',
         'ComboBox',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipbtxtServiceId = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_txtServiceId',
         'TextBox',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblblUtilityName = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lblUtilityName',
         'Label',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblblServiceId = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lblServiceId',
         'Label',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipbdtpStartDate = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_dtpStartDate',
         'DateTimePicker',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblblEndDate = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lblEndDate',
         'Label',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblstSalesCompany = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lstSalesCompany',
         'Combobox',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblstCustomerType = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lstCustomerType',
         'ComboBox',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblblStartDate = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lblStartDate',
         'Label',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblstUtilityName = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lstUtilityName',
         'ComboBox',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblblCommodity = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lblCommodity',
         'Label',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblblStatusCompany = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lblStatusCompany',
         'Label',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    END IF;
    IF ipblblCustomerType = TRUE THEN
      INSERT INTO Report_Param
        (REPORT_PARAM_ID,
         REPORT_DEF_ID,
         CONTROL_NAME,
         CONTROL_TYPE,
         CONTROL_INITIAL_VALUE,
         ENTERED_DATE,
         ENTERED_BY)
      VALUES
        (Seq_Report_Param_Id.Nextval,
         nReportDefId,
         'rp_lblCustomerType',
         'Label',
         ipsControlInitialValue,
         SYSDATE,
         ipsEnteredBy);
    
    END IF;
    COMMIT;
  END;
  ------------------------------------------------------------------------------------------------

END REPORTS;
/
