DECLARE @columns NVARCHAR(MAX), @sql NVARCHAR(MAX);

-- Generate dynamic column list (i.e., dates for the month)
SELECT @columns = STRING_AGG(QUOTENAME(CONVERT(VARCHAR, ML.Dates, 23)), ', ') 
FROM dbo.ListOfDaysByEngagementType('10','2024') AS ML
WHERE DATEPART(month, ML.Dates) = 10 AND DATEPART(year, ML.Dates) = 2024;

-- Generate the dynamic SQL query
SET @sql = '
SELECT 
    ad.WorkManSL AS WorkManSLNo,
    ad.WorkManName AS WorkManName, ' + @columns + '
FROM 
    dbo.ListOfDaysByEngagementType(''10'', ''2024'') AS ML
LEFT JOIN 
    App_AttendanceDetails AS ad ON ML.Dates = ad.Dates
WHERE 
    ad.VendorCode = ''17201'' 
    AND DATEPART(month, ad.Dates) = 10 
    AND DATEPART(year, ad.Dates) = 2024 
    AND ad.AadharNo = ''275225445020''
GROUP BY 
    ad.WorkManSL, ad.WorkManName
ORDER BY 
    ad.WorkManSL;';

-- Execute the dynamic SQL
EXEC sp_executesql @sql;
