public DataSet getattdancedata(string vcode, string month, string year)
{
    month = month.Substring(4, 2); // MM
    year = year.Substring(0, 4);   // YYYY
    int intMonth = int.Parse(month);
    int intYear = int.Parse(year);

    string strSQL = @"
        DECLARE @Month INT = @paramMonth;
        DECLARE @Year INT = @paramYear;
        DECLARE @VendorCode NVARCHAR(50) = @paramVendorCode;

        DECLARE @DynamicColumns NVARCHAR(MAX); 
        DECLARE @SQLQuery NVARCHAR(MAX);  

        SELECT @DynamicColumns = STRING_AGG(QUOTENAME(DayOfMonth), ',')
        FROM (
            SELECT DISTINCT DATEPART(DAY, ML.Dates) AS DayOfMonth 
            FROM dbo.ListOfDaysByEngagementType(@Month, @Year) AS ML 
            LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates 
            WHERE AD.VendorCode = @VendorCode 
              AND DATEPART(MONTH, AD.Dates) = @Month 
              AND DATEPART(YEAR, AD.Dates) = @Year
        ) AS Days;              

        SET @SQLQuery = '
            WITH AttendanceData AS ( 
                SELECT 
                    DATEPART(DAY, ML.Dates) AS DayOfMonth,
                    AD.WorkManSl AS WorkManSLNo, 
                    AD.WorkManName AS WorkManName, 
                    AD.EngagementType AS Eng_Type,  
                    CONVERT(VARCHAR, DATEPART(MONTH, ML.Dates)) AS Month, 
                    CONVERT(VARCHAR, DATEPART(YEAR, ML.Dates)) AS Year, 
                    CASE 
                        WHEN AD.DayDef = ''''WD'''' AND AD.Present = ''''True'''' THEN ''''P'''' 
                        WHEN AD.DayDef = ''''WD'''' AND AD.Present = ''''False'''' THEN ''''A''''    
                        WHEN AD.DayDef = ''''OD'''' AND AD.Present = ''''True'''' THEN ''''OP''''  
                        WHEN AD.DayDef = ''''HD'''' AND AD.Present = ''''True'''' THEN ''''HP''''  
                        WHEN AD.DayDef = ''''HD'''' AND AD.Present = ''''False'''' THEN ''''HD''''  
                        WHEN AD.DayDef = ''''LV'''' THEN ''''LV''''       
                        WHEN AD.DayDef = ''''HF'''' AND AD.Present = ''''True'''' THEN ''''HF''''  
                    END AS AttendanceStatus 
                FROM dbo.ListOfDaysByEngagementType(@Month, @Year) AS ML 
                LEFT JOIN App_AttendanceDetails AS AD ON ML.Dates = AD.Dates 
                WHERE AD.VendorCode = @VendorCode 
                  AND DATEPART(MONTH, AD.Dates) = @Month 
                  AND DATEPART(YEAR, AD.Dates) = @Year 
            )   
            SELECT WorkManSLNo, WorkManName, Eng_Type, Month, Year, ' + @DynamicColumns + '
            FROM AttendanceData 
            PIVOT(
                MAX(AttendanceStatus) FOR DayOfMonth IN(' + @DynamicColumns + ')
            ) AS PivotTable 
            ORDER BY WorkManSLNo, WorkManName, Month, Year, Eng_Type; 
        ';

        EXEC sp_executesql @SQLQuery,
            N'@Month INT, @Year INT, @VendorCode NVARCHAR(50)',
            @Month = @Month, @Year = @Year, @VendorCode = @VendorCode;
    ";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("paramMonth", intMonth);
    objParam.Add("paramYear", intYear);
    objParam.Add("paramVendorCode", vcode);

    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "App_AttendanceDetails", objParam);
}
