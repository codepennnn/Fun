string strSQL =
    "DECLARE @DynamicColumns NVARCHAR(MAX); " +
    "DECLARE @SQLQuery NVARCHAR(MAX); " +

    "SELECT @DynamicColumns = STRING_AGG(QUOTENAME(DayOfMonth), ',') FROM (" +
    "SELECT DISTINCT DATEPART(DAY, ML.Dates) AS DayOfMonth " +
    "FROM dbo.ListOfDaysByEngagementType(" + int.Parse(monthwithprefix) + ", " + int.Parse(year) + ") AS ML " +
    "LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates " +
    "WHERE AD.VendorCode = '" + vcode + "' " +
    "AND DATEPART(MONTH, AD.Dates) = " + int.Parse(monthwithprefix) + " " +
    "AND DATEPART(YEAR, AD.Dates) = " + int.Parse(year) + ") AS Days; " +

    "SET @SQLQuery = 'WITH AttendanceData AS ( " +
    "SELECT DATEPART(DAY, ML.Dates) AS DayOfMonth, " +
    "AD.WorkManSl AS WorkManSLNo, " +
    "AD.WorkManName AS WorkManName, " +
    "AD.EngagementType AS Eng_Type, " +
    "DATEPART(MONTH, AD.Dates) AS Month, " +
    "DATEPART(YEAR, AD.Dates) AS Year, " +
    "CASE " +
    "WHEN AD.DayDef = ''''WD'''' AND AD.Present = ''''True'''' THEN ''''P'''' " +
    "WHEN AD.DayDef = ''''WD'''' AND AD.Present = ''''False'''' THEN ''''A'''' " +
    "WHEN AD.DayDef = ''''OD'''' AND AD.Present = ''''True'''' THEN ''''OP'''' " +
    "WHEN AD.DayDef = ''''HD'''' AND AD.Present = ''''True'''' THEN ''''HP'''' " +
    "WHEN AD.DayDef = ''''HD'''' AND AD.Present = ''''False'''' THEN ''''HD'''' " +
    "WHEN AD.DayDef = ''''LV'''' THEN ''''LV'''' " +
    "WHEN AD.DayDef = ''''HF'''' AND AD.Present = ''''True'''' THEN ''''HF'''' " +
    "END AS AttendanceStatus " +
    "FROM dbo.ListOfDaysByEngagementType(" + int.Parse(monthwithprefix) + ", " + int.Parse(year) + ") AS ML " +
    "LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates " +
    "WHERE AD.VendorCode = '''" + vcode + "''' " + // Properly escaped inside dynamic SQL
    "AND DATEPART(MONTH, AD.Dates) = " + int.Parse(monthwithprefix) + " " +
    "AND DATEPART(YEAR, AD.Dates) = " + int.Parse(year) + ") " +

    "SELECT WorkManSLNo, WorkManName, Eng_Type, Month, Year, ' + @DynamicColumns + ' " +
    "FROM AttendanceData " +
    "PIVOT(MAX(AttendanceStatus) FOR DayOfMonth IN (' + @DynamicColumns + ')) AS PivotTable " +
    "ORDER BY WorkManSLNo, WorkManName, Month, Year, Eng_Type;'; " +

    "EXEC sp_executesql @SQLQuery;";
