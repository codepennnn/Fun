 CASE 
    WHEN 
        EXISTS (
            SELECT 1 
            FROM App_Online_Wages_Details d 
            INNER JOIN App_Online_Wages w 
                ON w.V_CODE = d.VendorCode 
                AND w.MonthWage = d.MonthWage 
                AND w.YearWage = d.YearWage
                AND w.STATUS = 'Request Closed'
            WHERE d.VendorCode = f.V_CODE 
              AND d.YearWage = f.YearWage 
              AND d.MonthWage = f.MonthWage 
              AND d.WorkOrderNo = f.WO_NO
        )
        OR
        EXISTS (
            SELECT 1 
            FROM App_Online_Wages_Details_Supplement sd
            INNER JOIN App_Online_WagesSupplement sw
                ON sw.V_CODE = sd.VendorCode 
                AND sw.MonthWage = sd.MonthWage 
                AND sw.YearWage = sd.YearWage
                AND sw.STATUS = 'Request Closed'
            WHERE sd.VendorCode = f.V_CODE 
              AND sd.YearWage = f.YearWage 
              AND sd.MonthWage = f.MonthWage 
              AND sd.WorkOrderNo = f.WO_NO
        )
        THEN 'Y' 
    ELSE 'N' 
END AS ComplianceStatus
