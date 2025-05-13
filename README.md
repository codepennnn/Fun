public DataSet getattdancedata(string vcode, string month, string year)
{
    month = month.Substring(4, 2);
    year = year.Substring(0, 4);
    string monthwithprefix = month.PadLeft(2, '0');

    string strSQL = @"
        DECLARE @DynamicColumns NVARCHAR(MAX);
        DECLARE @SQLQuery NVARCHAR(MAX);

        SELECT @DynamicColumns = STRING_AGG(QUOTENAME(DayOfMonth), ',')
        FROM (
            SELECT DISTINCT DATEPART(DAY, ML.Dates) AS DayOfMonth
            FROM dbo.ListOfDaysByEngagementType('" + monthwithprefix + "', '" + year + @"') AS ML
            LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates
            WHERE AD.VendorCode = '" + vcode + @"'
              AND DATEPART(MONTH, AD.Dates) = " + int.Parse(monthwithprefix) + @"
              AND DATEPART(YEAR, AD.Dates) = " + int.Parse(year) + @"
        ) AS Days;

        SET @SQLQuery = '
        SELECT *
        FROM (
            SELECT 
                AD.WorkManSl AS WorkManSLNo,
                AD.WorkManName AS WorkManName,
                AD.EngagementType AS Eng_Type,
                ''' + '" + monthwithprefix + @"' + ''' AS Month,
                ''' + '" + year + @"' + ''' AS Year,
                DATEPART(DAY, ML.Dates) AS DayOfMonth,
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
            WHERE AD.VendorCode = ''" + vcode + @"''
              AND DATEPART(MONTH, AD.Dates) = " + int.Parse(monthwithprefix) + @"
              AND DATEPART(YEAR, AD.Dates) = " + int.Parse(year) + @"
        ) AS SourceTable
        PIVOT (
            MAX(AttendanceStatus)
            FOR DayOfMonth IN (' + @DynamicColumns + ')
        ) AS PivotTable
        ORDER BY WorkManSLNo;';

        EXEC sp_executesql @SQLQuery;
    ";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("vcode", vcode);
    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "App_AttendanceDetails", objParam);
}




public DataSet gettot(string vcode, string month, string year)
{
    month = month.Substring(4, 2);
    year = year.Substring(0, 4);
    string monthwithprefix = month.PadLeft(2, '0');

    string strSQL = @"
        SELECT 
            WorkManSl AS WorkManSLNo,
            WorkManName AS WorkManName,
            EngagementType AS Eng_Type,
            '" + monthwithprefix + @"' AS Month,
            '" + year + @"' AS Year,
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
          AND DATEPART(MONTH, Dates) = " + int.Parse(monthwithprefix) + @"
          AND DATEPART(YEAR, Dates) = " + int.Parse(year) + @"
        GROUP BY WorkManSl, WorkManName, EngagementType
    ";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "App_AttendanceDetails", objParam);
}
