DECLARE @columns NVARCHAR(MAX), @sql NVARCHAR(MAX);

-- Step 1: Get the list of unique dates and convert them into column names
SELECT @columns = STRING_AGG(QUOTENAME(CONVERT(VARCHAR, ML.Dates, 101)), ', ')
FROM (
    SELECT DISTINCT ML.Dates
    FROM dbo.ListOfDaysByEngagementType('10', '2024') AS ML
    LEFT JOIN App_AttendanceDetails AS ad ON ML.Dates = ad.Dates
    WHERE ad.VendorCode = '17201'
    AND DATEPART(month, ad.Dates) = '10'
    AND DATEPART(year, ad.Dates) = '2024'
    AND ad.AadharNo = '275225445020'
) AS DatesList;

-- Step 2: Create the dynamic SQL for pivoting
SET @sql = '
SELECT 
    ''10'' AS month,
    ''2024'' AS year,
    ad.WorkManSl AS WorkManSLNo,
    ad.WorkManName AS WorkManName,
    ad.DayDef AS DayDef,
    ad.EngagementType AS Eng_Type, 
    ' + @columns + ' 
FROM dbo.ListOfDaysByEngagementType(''10'', ''2024'') AS ML
LEFT JOIN App_AttendanceDetails AS ad ON ML.Dates = ad.Dates
WHERE ad.VendorCode = ''17201''
    AND DATEPART(month, ad.Dates) = ''10''
    AND DATEPART(year, ad.Dates) = ''2024''
    AND ad.AadharNo = ''275225445020''
GROUP BY 
    ad.WorkManSl,
    ad.WorkManName,
    ad.DayDef,
    ad.EngagementType
ORDER BY ad.WorkManSl;';

-- Step 3: Execute the dynamic SQL
EXEC sp_executesql @sql;
