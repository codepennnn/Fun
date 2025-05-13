DECLARE @DynamicColumns NVARCHAR(MAX); 
DECLARE @SQLQuery NVARCHAR(MAX); 

SELECT @DynamicColumns = STRING_AGG(QUOTENAME(DayOfMonth), ',') 
FROM (
    SELECT DISTINCT DATEPART(DAY, ML.Dates) AS DayOfMonth 
    FROM dbo.ListOfDaysByEngagementType('04', '2025') AS ML 
    LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates
    WHERE AD.VendorCode = '15233' 
      AND DATEPART(MONTH, AD.Dates) = 4 
      AND DATEPART(YEAR, AD.Dates) = 2025
) AS Days;    

SET @SQLQuery = '
WITH AttendanceData AS (
    SELECT 
        DATEPART(DAY, ML.Dates) AS DayOfMonth,
        AD.WorkManSl AS WorkManSLNo,
        RTRIM(LTRIM(AD.WorkManName)) AS WorkManName,
        AD.EngagementType AS Eng_Type, 
        DATEPART(MONTH, ML.Dates) AS Month,
        DATEPART(YEAR, ML.Dates) AS Year,
        CASE 
            WHEN AD.DayDef = ''WD'' AND AD.Present = ''True'' THEN ''P''   
            WHEN AD.DayDef = ''WD'' AND AD.Present = ''False'' THEN ''A''   
            WHEN AD.DayDef = ''OD'' AND AD.Present = ''True'' THEN ''OP''  
            WHEN AD.DayDef = ''HD'' AND AD.Present = ''True'' THEN ''HP''  
            WHEN AD.DayDef = ''HD'' AND AD.Present = ''False'' THEN ''HD''  
            WHEN AD.DayDef = ''LV'' THEN ''LV''    
            WHEN AD.DayDef = ''HF'' AND AD.Present = ''True'' THEN ''HF''    
        END AS AttendanceStatus 
    FROM dbo.ListOfDaysByEngagementType(''04'', ''2025'') AS ML
    LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates 
    WHERE AD.VendorCode = ''15233''
      AND DATEPART(MONTH, AD.Dates) = 4 
      AND DATEPART(YEAR, AD.Dates) = 2025
) 
SELECT 
    WorkManSLNo, 
    WorkManName, 
    Eng_Type, 
    Month, 
    Year, 
    ' + @DynamicColumns + ' 
FROM AttendanceData
PIVOT (
    MAX(AttendanceStatus) FOR DayOfMonth IN (' + @DynamicColumns + ')
) AS PivotTable 
ORDER BY WorkManSLNo;
';




SELECT
    AD.WorkManSl AS WorkManSLNo,
    RTRIM(LTRIM(AD.WorkManName)) AS WorkManName,
    AD.EngagementType AS Eng_Type,
    DATEPART(MONTH, AD.Dates) AS Month,
    DATEPART(YEAR, AD.Dates) AS Year,
    SUM(CASE WHEN AD.Present = 'True' THEN 1 ELSE 0 END) AS TotalPresent,
    SUM(CASE WHEN AD.DayDef = 'LV' THEN 1 ELSE 0 END) AS Leave,
    SUM(CASE WHEN AD.DayDef = 'HD' THEN 1 ELSE 0 END) AS Holiday,
    SUM(
        CASE WHEN AD.Present = 'True' THEN 1 ELSE 0 END +
        CASE WHEN AD.DayDef = 'LV' THEN 1 ELSE 0 END +
        CASE WHEN AD.DayDef = 'HD' THEN 1 ELSE 0 END
    ) AS Total
FROM App_AttendanceDetails AS AD
WHERE AD.VendorCode = '15233'
  AND DATEPART(MONTH, AD.Dates) = 4
  AND DATEPART(YEAR, AD.Dates) = 2025
GROUP BY 
    AD.WorkManSl,
    RTRIM(LTRIM(AD.WorkManName)),
    AD.EngagementType,
    DATEPART(MONTH, AD.Dates),
    DATEPART(YEAR, AD.Dates)
ORDER BY WorkManSl;

EXEC sp_executesql @SQLQuery;
