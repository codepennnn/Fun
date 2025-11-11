 DECLARE 
    @VendorCode VARCHAR(10) = '15503',
    @LeaveYear INT = 2024;
 

with ActiveWorkOrders as (
    select V_CODE, START_DATE, END_DATE, WO_NO from App_vendorwodetails
    where V_CODE = @VendorCode
      and ((YEAR(START_DATE) = @LeaveYear OR YEAR(END_DATE) = @LeaveYear) 
      OR (START_DATE <= DATEFROMPARTS(@LeaveYear, 12, 31) and END_DATE >= DATEFROMPARTS(@LeaveYear, 1, 1)) ) 
    
    and WO_NO not in 
      (select WO_NO from APP_RECOGNIZED_WO where WO_NO is not null and WO_NO <> '')

     ),


ActiveMonths as (
    select distinct 
        MONTH(DATEADD(MONTH, n.number, DATEFROMPARTS(YEAR(a.START_DATE), MONTH(a.START_DATE), 1))) AS MonthWage,
        YEAR(DATEADD(MONTH, n.number, DATEFROMPARTS(YEAR(a.START_DATE), MONTH(a.START_DATE), 1))) AS YearWage,
        a.V_CODE,
        a.WO_NO
    from ActiveWorkOrders a
    join master..spt_values n  
        ON n.type = 'P'  
       and DATEADD(MONTH, n.number, a.START_DATE) <= a.END_DATE
    where 
        YEAR(DATEADD(MONTH, n.number, DATEFROMPARTS(YEAR(a.START_DATE), MONTH(a.START_DATE), 1))) = @LeaveYear
),



FilteredMonths as (
    select am.* from ActiveMonths am where NOT EXISTS 
   
   (select 1 from App_WO_Nil n where n.WO_NO = am.WO_NO and n.NO_WORK = 'Temporary'
          and n.TEMPORARY_YEAR = am.YearWage
          and n.TEMPORARY_MONTH = am.MonthWage and n.STATUS = 'Approved' )


          and NOT EXISTS (
            SELECT 1 
            FROM App_WO_Nil n
            WHERE n.WO_NO = am.WO_NO
              and n.V_CODE = am.V_CODE
              and n.NO_WORK = 'Permanent'
              and n.STATUS = 'Approved'
              and CONVERT(INT, n.TEMPORARY_YEAR + FORMAT(CONVERT(INT, n.CLOSER_DATE), '00'))
                  <= (am.YearWage * 100 + am.MonthWage)
        )

)


select f.YearWage,f.MonthWage,f.WO_NO as WorkOrderNo,
    DATENAME(MONTH, DATEFROMPARTS(f.YearWage, f.MonthWage, 1)) as MonthName,
    case when
    EXISTS (select 1 from App_Online_Wages_Details d inner join App_Online_Wages w 
                ON w.V_CODE = d.VendorCode and w.MonthWage = d.MonthWage and w.YearWage = d.YearWage
                and w.STATUS = 'Request Closed'
           
           where d.VendorCode = f.V_CODE and d.YearWage = f.YearWage and d.MonthWage = f.MonthWage 
            and d.WorkOrderNo = f.WO_NO
        ) THEN 'Y' ELSE 'N' END as ComplianceStatus 
        from FilteredMonths f
order by  f.WO_NO , f.MonthWage



in this i want to also check y n in supplement wage that is similar to wage so just check in this table exist data like you do already with wage
App_Online_Wages_Details_Supplement
App_Online_WagesSupplement
