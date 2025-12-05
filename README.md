


string displayPeriod = "";

if (period == "Jan-June")
{
    displayPeriod = $"Jan{year.ToString().Substring(2)} - June{year.ToString().Substring(2)}";
}
else
{
    displayPeriod = $"July{year.ToString().Substring(2)} - Dec{year.ToString().Substring(2)}";
}


--------------


SET DATEFIRST 7;  -- Sunday = 1  (important for DATEPART)

;WITH d AS (
    SELECT CAST(@FromDate AS date) AS dt
    UNION ALL
    SELECT DATEADD(DAY, 1, dt)
    FROM d
    WHERE dt < @ToDate
),
WorkDays AS (
    SELECT COUNT(*) AS Max_No_Contractor_Labour_
    FROM d
    WHERE DATEPART(WEEKDAY, dt) <> 1   -- exclude Sundays
)
SELECT 
    NEWID() AS ID,
    l.LicNo AS LabourLicNo,
    l.FromDate,
    l.ToDate,
    l.workerno as License_Capacity,

    CONVERT(varchar(10),
        DATEDIFF(DAY, CONVERT(datetime, l.FromDate, 103), CONVERT(datetime, l.ToDate, 103))
    ) AS Duration_Of_Contract,

    (SELECT CONCAT(R.V_NAME, ', ', R.ADDRESS) 
     FROM App_Vendor_Reg AS R 
     WHERE R.V_CODE = l.VCode
    ) AS Name_Address_Of_Contractor,

    0.00 as Amount_Of_Wages_Paid_Children,

    c3.wo_no As WorkOrderNo,
    FORMAT (R.FROM_DATE,'dd/MM/yyyy') as Workorder_FromDate,
    FORMAT (R.TO_DATE,'dd/MM/yyyy') as Workorder_ToDate,

    -- 👇 NEW COLUMN: working days in selected period (same for all rows)
    wds.Max_No_Contractor_Labour_,

    -- sex_M
    ISNULL((
        SELECT TOP 1 COUNT(DISTINCT w.AadharNo)
        FROM App_Wagesdetailsjharkhand AS w
        INNER JOIN App_EmployeeMaster AS em
            ON em.AadharCard = w.AadharNo AND em.Sex = 'M'
        WHERE w.workorderno = c3.wo_no
          AND w.vendorcode  = @Vcode
          AND w.yearwage    = @Year
          AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ',' + @wageMonth + ',') > 0
        GROUP BY MonthWage
        ORDER BY COUNT(DISTINCT w.AadharNo) DESC
    ), 0) AS sex_M,

    -- sex_F
    ISNULL((
        SELECT TOP 1 COUNT(DISTINCT w.AadharNo)
        FROM App_Wagesdetailsjharkhand AS w
        INNER JOIN App_EmployeeMaster AS em
            ON em.AadharCard = w.AadharNo AND em.Sex = 'F'
        WHERE w.workorderno = c3.wo_no
          AND w.vendorcode  = @Vcode
          AND w.yearwage    = @Year
          AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ',' + @wageMonth + ',') > 0
        GROUP BY MonthWage
        ORDER BY COUNT(DISTINCT w.AadharNo) DESC
    ), 0) AS sex_F,

    -- No_Of_Mandays_Worked_Men
    (SELECT ISNULL(SUM(tab.TotalMandays), 0)
     FROM (
        SELECT w.AadharNo, SUM(ISNULL(w.TotPaymentDays, 0)) AS TotalMandays
        FROM app_wagesdetailsjharkhand AS w
        INNER JOIN app_employeemaster AS em
            ON em.aadharcard = w.aadharno AND em.sex = 'M'
        WHERE w.workorderno = c3.wo_no
          AND w.vendorcode  = @Vcode
          AND w.yearwage    = @Year
          AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ',' + @wageMonth + ',') > 0
        GROUP BY w.AadharNo
     ) AS tab
    ) AS No_Of_Mandays_Worked_Men,

    -- No_Of_Mandays_Worked_Women
    (SELECT ISNULL(SUM(tab.TotalMandays), 0)
     FROM (
        SELECT w.AadharNo, SUM(ISNULL(w.TotPaymentDays, 0)) AS TotalMandays
        FROM app_wagesdetailsjharkhand AS w
        INNER JOIN app_employeemaster AS em
            ON em.aadharcard = w.aadharno AND em.sex = 'F'
        WHERE w.workorderno = c3.wo_no
          AND w.vendorcode  = @Vcode
          AND w.yearwage    = @Year
          AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ',' + @wageMonth + ',') > 0
        GROUP BY w.AadharNo
     ) AS tab
    ) AS No_Of_Mandays_Worked_Women,

    -- Amt_Of_Deduct_From_Wages_Men
    (SELECT ISNULL(SUM(tab.Male_Deduction), 0)
     FROM (
        SELECT w.AadharNo, 
               SUM(ISNULL(w.PFAmt,0) + ISNULL(w.ESIAmt,0)) AS Male_Deduction
        FROM app_wagesdetailsjharkhand AS w
        INNER JOIN app_employeemaster AS em
            ON em.aadharcard = w.aadharno AND em.sex = 'M'
        WHERE w.workorderno = c3.wo_no
          AND w.vendorcode  = @Vcode
          AND w.yearwage    = @Year
          AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ',' + @wageMonth + ',') > 0
        GROUP BY w.AadharNo
     ) AS tab
    ) AS Amt_Of_Deduct_From_Wages_Men,

    -- Amt_Of_Deduct_From_Wages_Women
    (SELECT ISNULL(SUM(tab.Female_Deduction), 0)
     FROM (
        SELECT w.AadharNo, 
               SUM(ISNULL(w.PFAmt,0) + ISNULL(w.ESIAmt,0)) AS Female_Deduction
        FROM app_wagesdetailsjharkhand AS w
        INNER JOIN app_employeemaster AS em
            ON em.aadharcard = w.aadharno AND em.sex = 'F'
        WHERE w.workorderno = c3.wo_no
          AND w.vendorcode  = @Vcode
          AND w.yearwage    = @Year
          AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ',' + @wageMonth + ',') > 0
        GROUP BY w.AadharNo
     ) AS tab
    ) AS Amt_Of_Deduct_From_Wages_Women,

    -- Amount_Of_Wages_Paid_Men
    (SELECT ISNULL(SUM(tab.Male_Gross), 0)
     FROM (
        SELECT w.AadharNo, SUM(ISNULL(w.TotalWages,0)) AS Male_Gross
        FROM app_wagesdetailsjharkhand AS w
        INNER JOIN app_employeemaster AS em
            ON em.aadharcard = w.aadharno AND em.sex = 'M'
        WHERE w.workorderno = c3.wo_no
          AND w.vendorcode  = @Vcode
          AND w.yearwage    = @Year
          AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ',' + @wageMonth + ',') > 0
        GROUP BY w.AadharNo
     ) AS tab
    ) AS Amount_Of_Wages_Paid_Men,

    -- Amount_Of_Wages_Paid_Women
    (SELECT ISNULL(SUM(tab.Female_Gross), 0)
     FROM (
        SELECT w.AadharNo, SUM(ISNULL(w.TotalWages,0)) AS Female_Gross
        FROM app_wagesdetailsjharkhand AS w
        INNER JOIN app_employeemaster AS em
            ON em.aadharcard = w.aadharno AND em.sex = 'F'
        WHERE w.workorderno = c3.wo_no
          AND w.vendorcode  = @Vcode
          AND w.yearwage    = @Year
          AND CHARINDEX(',' + CAST(w.monthwage AS VARCHAR(10)) + ',', ',' + @wageMonth + ',') > 0
        GROUP BY w.AadharNo
     ) AS tab
    ) AS Amount_Of_Wages_Paid_Women,

    -- Existing fields from App_Half_Yearly_Details
    (SELECT Name_Address_Of_Establishment 
     FROM App_Half_Yearly_Details 
     WHERE Year=@Year AND Period=@Period AND VCode=@VCode AND c3.wo_no=WorkOrderNo
    ) as Name_Address_Of_Establishment,

    (SELECT Name_and_Address_Of_PrincipalEmp 
     FROM App_Half_Yearly_Details 
     WHERE Year=@Year AND Period=@Period AND VCode=@VCode AND c3.wo_no=WorkOrderNo
    ) as Name_and_Address_Of_PrincipalEmp,

    (SELECT Weekly_Holiday 
     FROM App_Half_Yearly_Details 
     WHERE Year=@Year AND Period=@Period AND VCode=@VCode AND c3.wo_no=WorkOrderNo
    ) as Weekly_Holiday,

    (SELECT Status 
     FROM App_Half_Yearly_Details 
     WHERE Year=@Year AND Period=@Period AND VCode=@VCode AND c3.wo_no=WorkOrderNo
    ) as Status,

    (SELECT State 
     FROM App_Half_Yearly_Details 
     WHERE Year=@Year AND Period=@Period AND VCode=@VCode AND c3.wo_no=WorkOrderNo
    ) as State,

    (SELECT Welfare_Canteen 
     FROM App_Half_Yearly_Details 
     WHERE Year=@Year AND Period=@Period AND VCode=@VCode AND c3.wo_no=WorkOrderNo
    ) as Welfare_Canteen,

    (SELECT Welfare_RestRoom 
     FROM App_Half_Yearly_Details 
     WHERE Year=@Year AND Period=@Period AND VCode=@VCode AND c3.wo_no=WorkOrderNo
    ) as Welfare_RestRoom,

    (SELECT Welfare_DrinkingWater 
     FROM App_Half_Yearly_Details 
     WHERE Year=@Year AND Period=@Period AND VCode=@VCode AND c3.wo_no=WorkOrderNo
    ) as Welfare_DrinkingWater,

    (SELECT Welfare_Creches 
     FROM App_Half_Yearly_Details 
     WHERE Year=@Year AND Period=@Period AND VCode=@VCode AND c3.wo_no=WorkOrderNo
    ) as Welfare_Creches,

    (SELECT Welfare_FirstAid 
     FROM App_Half_Yearly_Details 
     WHERE Year=@Year AND Period=@Period AND VCode=@VCode AND c3.wo_no=WorkOrderNo
    ) as Welfare_FirstAid

FROM App_LabourLicenseSubmission AS l
LEFT JOIN App_vendor_form_c3_dtl AS c3
    ON c3.ll_no = l.LicNo
LEFT JOIN App_WorkOrder_Reg R 
    ON c3.WO_NO = R.WO_NO
CROSS JOIN WorkDays wds
WHERE
    c3.status = 'Approved'
    AND l.FromDate <  @ToDate
    AND l.ToDate   >= @FromDate
    AND l.VCode = @VCode
    AND l.WorkLocation IN ('Jamshedpur', 'Saraiekela')
OPTION (MAXRECURSION 0);
