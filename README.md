DECLARE @DynamicColumns NVARCHAR(MAX);
DECLARE @SQLQuery NVARCHAR(MAX);

-- Step 1: Generate dynamic columns based on actual attendance days in the data
SELECT 
    @DynamicColumns = STRING_AGG(QUOTENAME(DayOfMonth), ',')
FROM (
    SELECT DISTINCT 
        DATEPART(DAY, ML.Dates) AS DayOfMonth
    FROM dbo.ListOfDaysByEngagementType('10', '2024') AS ML
    LEFT JOIN App_AttendanceDetails AS ad 
    ON ML.Dates = AD.Dates
    WHERE 
        AD.VendorCode = '17201' 
        AND DATEPART(MONTH, AD.Dates) = '10' 
        AND DATEPART(YEAR, AD.Dates) = '2024' 
        AND AD.AadharNo = '275225445020'
) AS Days;

-- Step 2: Construct the dynamic SQL query with dynamic columns
SET @SQLQuery = '
WITH AttendanceData AS (
    SELECT 
        DATEPART(DAY, ML.Dates) AS DayOfMonth,
        ad.WorkManSl AS WorkManSLNo,
        ad.WorkManName AS WorkManName,
        CASE 
            WHEN (ML.EngagementType = AD.EngagementType AND AD.Present = ''True'') 
            THEN 1 
            ELSE 0 
        END AS Present
    FROM 
        dbo.ListOfDaysByEngagementType(''10'', ''2024'') AS ML
    LEFT JOIN 
        App_AttendanceDetails AS ad 
    ON 
        ML.Dates = AD.Dates
    WHERE 
        AD.VendorCode = ''17201'' 
        AND DATEPART(MONTH, AD.Dates) = ''10'' 
        AND DATEPART(YEAR, AD.Dates) = ''2024'' 
        AND AD.AadharNo = ''275225445020''
)
SELECT 
    WorkManSLNo,
    WorkManName, ' + @DynamicColumns + '
FROM 
    AttendanceData
PIVOT (
    MAX(Present) 
    FOR DayOfMonth IN (' + @DynamicColumns + ')
) AS PivotTable
ORDER BY 
    WorkManSLNo;
';

-- Step 3: Execute the dynamic SQL query
EXEC sp_executesql @SQLQuery;
