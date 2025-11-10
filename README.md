SELECT *
FROM
(
    /* --- FIRST QUERY (YOUR ORIGINAL) --- */
    SELECT    
        0.00 AS EL_FINAL,
        0.00 AS CL_FINAL,
        0.00 AS FL_FINAL,
        0.00 AS Total_Leave, 
        w1.WorkManName AS Workman_Name,
        w1.WorkManSl AS workman_slno,
        w1.WorkManCategory AS Workman_Category, 
        L.Location AS Location,
        w1.AadharNo,
        VendorCode,
        YearWage, 
        WorkOrderNo AS work_order,  
        ISNULL(SUM(ISNULL(w1.NoOfDaysWorkedMP,0)+ISNULL(w1.NoOfDaysWorkedRate,0)), 0) AS WorkOrder_WorkingDays,   

        IIF(SUM(ISNULL(w1.NoOfDaysWorkedMP,0)+ISNULL(w1.NoOfDaysWorkedRate,0))/20.0 <=15.0,
            SUM(ISNULL(w1.NoOfDaysWorkedMP,0)+ISNULL(w1.NoOfDaysWorkedRate,0))/20.0 , 15) AS EL,   

        IIF(SUM(ISNULL(w1.NoOfDaysWorkedMP,0)+ISNULL(w1.NoOfDaysWorkedRate,0)) / 35.00 <= 7, 
            (SUM(ISNULL(w1.NoOfDaysWorkedMP,0)+ISNULL(w1.NoOfDaysWorkedRate,0)) / 35.00), 7)  AS CL, 

        IIF(SUM(ISNULL(w1.NoOfDaysWorkedMP,0)+ISNULL(w1.NoOfDaysWorkedRate,0)) / 60.00 <= 4, 
            (SUM(ISNULL(w1.NoOfDaysWorkedMP,0)+ISNULL(w1.NoOfDaysWorkedRate,0)) / 60.00), 4)  AS FL,  

        (SELECT DISTINCT MAX(BasicRate+DARate) 
         FROM App_WagesDetailsJharkhand 
         WHERE YearWage='2024' AND VendorCode='17201'
           AND AadharNo=w1.AadharNo AND WorkManSl=w1.WorkManSl 
           AND WorkManCategory=w1.WorkManCategory AND LocationNM =L.Location 
           AND TotPaymentDays !=0.00  AND WorkOrderNo=w1.WorkOrderNo) AS MAX_RATE,  

        (SELECT DISTINCT MAX(MonthWage) 
         FROM App_WagesDetailsJharkhand 
         WHERE YearWage='2024' AND VendorCode='17201'
           AND AadharNo=w1.AadharNo AND WorkManSl=w1.WorkManSl 
           AND WorkManCategory=w1.WorkManCategory AND LocationNM =L.Location 
           AND TotPaymentDays!= 0.00  AND WorkOrderNo=w1.WorkOrderNo ) AS last_wage_month,

        CONVERT(VARCHAR(10),wr.TO_DATE,103) AS to_date

    FROM App_WagesDetailsJharkhand w1  
    LEFT JOIN App_LocationMaster L ON L.LocationCode = w1.LocationCode   
    LEFT JOIN App_WorkOrder_Reg Wr ON Wr.WO_NO=w1.WorkOrderNo   

    WHERE VendorCode = '17201' AND YearWage = '2024' AND TotPaymentDays != 0.00     

    GROUP BY w1.AadharNo, w1.VendorCode, w1.YearWage, 
             w1.WorkOrderNo, w1.WorkManName, w1.WorkManSl, w1.WorkManCategory, 
             L.Location, wr.TO_DATE  

    UNION ALL

    /* --- SECOND QUERY (WAGE SUPPLEMENT DATA) --- */
    SELECT
        0.00 AS EL_FINAL,
        0.00 AS CL_FINAL,
        0.00 AS FL_FINAL,
        0.00 AS Total_Leave,
        ws.WorkManName,
        ws.WorkManSl,
        ws.WorkManCategory,
        L.Location,
        ws.AadharNo,
        ws.VendorCode,
        ws.YearWage,
        ws.WorkOrderNo AS work_order,
        ws.Days AS WorkOrder_WorkingDays,   -- Change to correct column from wage_supplement
        0 AS EL,
        0 AS CL,
        0 AS FL,
        ws.SupplementRate AS MAX_RATE,      -- Change if needed
        ws.SupplementMonth AS last_wage_month,
        CONVERT(VARCHAR(10),ws.To_Date,103) AS to_date

    FROM wage_supplement ws
    LEFT JOIN App_LocationMaster L ON L.LocationCode = ws.LocationCode
    WHERE ws.VendorCode='17201' AND ws.YearWage='2024'
)x

GROUP BY 
x.AadharNo,x.last_wage_month,x.Location,x.MAX_RATE,x.to_date,x.Total_Leave,
x.VendorCode,x.work_order,x.Workman_Category,x.Workman_Name,x.workman_slno,
x.WorkOrder_WorkingDays,x.YearWage,x.CL_FINAL,x.EL_FINAL,x.FL_FINAL,x.EL,x.CL,x.FL

ORDER BY x.Workman_Name
