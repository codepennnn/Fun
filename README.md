DECLARE @DynamicColumns NVARCHAR(MAX);
DECLARE @SQLQuery NVARCHAR(MAX);

SELECT @DynamicColumns = STRING_AGG(QUOTENAME(DayOfMonth), ',')
FROM (
    SELECT DISTINCT DATEPART(DAY, ML.Dates) AS DayOfMonth
    FROM dbo.ListOfDaysByEngagementType('<monthwithprefix>', '<year>') AS ML
    LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates
    WHERE AD.VendorCode = '<vcode>'
        AND DATEPART(MONTH, AD.Dates) = <monthwithprefix>
        AND DATEPART(YEAR, AD.Dates) = <year>
) AS Days;

SET @SQLQuery = '
    WITH AttendanceData AS (
        SELECT
            DATEPART(DAY, ML.Dates) AS DayOfMonth,
            AD.WorkManSl AS WorkManSLNo,
            AD.WorkManName AS WorkManName,
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
        FROM dbo.ListOfDaysByEngagementType(''' + CAST(<monthwithprefix> AS VARCHAR) + ''', ''' + CAST(<year> AS VARCHAR) + ''') AS ML
        LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates
        WHERE AD.VendorCode = ''' + <vcode> + '''
            AND DATEPART(MONTH, AD.Dates) = ' + CAST(<monthwithprefix> AS VARCHAR) + '
            AND DATEPART(YEAR, AD.Dates) = ' + CAST(<year> AS VARCHAR) + '
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
        MAX(AttendanceStatus)
        FOR DayOfMonth IN (' + @DynamicColumns + ')
    ) AS PivotTable
    ORDER BY WorkManSLNo, WorkManName, Month, Year, Eng_Type;
';






SELECT
    WorkManSl AS WorkManSLNo,
    WorkManName,
    EngagementType AS Eng_Type,
    " + int.Parse(monthwithprefix) + @" AS Month,
    " + int.Parse(year) + @" AS Year,
    SUM(CASE WHEN Present = 'True' THEN 1 ELSE 0 END) AS TotalPresent,
    SUM(CASE WHEN DayDef = 'LV' THEN 1 ELSE 0 END) AS Leave,
    SUM(CASE WHEN DayDef = 'HD' THEN 1 ELSE 0 END) AS Holiday,
    SUM(
        CASE WHEN Present = 'True' THEN 1 ELSE 0 END +
        CASE WHEN DayDef = 'LV' THEN 1 ELSE 0 END +
        CASE WHEN DayDef = 'HD' THEN 1 ELSE 0 END
    ) AS Total
FROM App_AttendanceDetails
WHERE VendorCode = '" + vcode + @"'
    AND MONTH(Dates) = " + int.Parse(monthwithprefix) + @"
    AND YEAR(Dates) = " + int.Parse(year) + @"
GROUP BY WorkManSl, WorkManName, EngagementType
ORDER BY WorkManSl;

EXEC sp_executesql @SQLQuery;
