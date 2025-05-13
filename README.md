string strSQL = @"
DECLARE @DynamicColumns NVARCHAR(MAX);
DECLARE @SQLQuery NVARCHAR(MAX);

SELECT @DynamicColumns = STRING_AGG(QUOTENAME(DAY(ML.Dates)), ',')
FROM (
    SELECT DISTINCT ML.Dates
    FROM dbo.ListOfDaysByEngagementType('" + monthwithprefix + "', '" + year + @"') AS ML
    LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates
    WHERE AD.VendorCode = '" + vcode + @"'
      AND MONTH(AD.Dates) = " + monthwithprefix + @"
      AND YEAR(AD.Dates) = " + year + @"
) AS Days;

SET @SQLQuery = '
    WITH AttendanceData AS (
        SELECT 
            DAY(ML.Dates) AS DayOfMonth,
            AD.WorkManSl,
            AD.WorkManName,
            AD.EngagementType,
            MONTH(ML.Dates) AS Month,
            YEAR(ML.Dates) AS Year,
            CASE 
                WHEN AD.DayDef = ''WD'' AND AD.Present = ''True'' THEN ''P''
                WHEN AD.DayDef = ''WD'' AND AD.Present = ''False'' THEN ''A''
                WHEN AD.DayDef = ''OD'' AND AD.Present = ''True'' THEN ''OP''
                WHEN AD.DayDef = ''HD'' AND AD.Present = ''True'' THEN ''HP''
                WHEN AD.DayDef = ''HD'' AND AD.Present = ''False'' THEN ''HD''
                WHEN AD.DayDef = ''LV'' THEN ''LV''
                WHEN AD.DayDef = ''HF'' AND AD.Present = ''True'' THEN ''HF''
            END AS AttendanceStatus
        FROM dbo.ListOfDaysByEngagementType(''" + monthwithprefix + @"'', ''" + year + @"'') AS ML
        LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates
        WHERE AD.VendorCode = '''" + vcode + @"'''
          AND MONTH(AD.Dates) = " + monthwithprefix + @"
          AND YEAR(AD.Dates) = " + year + @"
    )
    SELECT 
        WorkManSl,
        WorkManName,
        EngagementType,
        Month,
        Year,
        ' + @DynamicColumns + '
    FROM AttendanceData
    PIVOT (
        MAX(AttendanceStatus)
        FOR DayOfMonth IN (' + @DynamicColumns + ')
    ) AS PivotTable
    ORDER BY WorkManSl;
';

EXEC sp_executesql @SQLQuery;
";
