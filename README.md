now giving this error  '<target>.Month and <source>.Month have conflicting properties: DataType property mismatch.'
  
  
  BL_WageComplience_Approval blobj = new BL_WageComplience_Approval();
  string strmonth = Wage_ComplienceRecords.SelectedDataKey.Values[0].ToString();
  string vcode = Wage_ComplienceRecords.SelectedDataKey.Values[1].ToString();
  DataSet ds_att = new DataSet();
  DataSet ds_tot = new DataSet();
  ds_att = blobj.getattdancedata(vcode, strmonth, strmonth);


 

  ds_att.Tables[0].PrimaryKey = new DataColumn[] { ds_att.Tables[0].Columns["WorkManSLNo"], ds_att.Tables[0].Columns["WorkManName"], ds_att.Tables[0].Columns["Eng_Type"], ds_att.Tables[0].Columns["Month"], ds_att.Tables[0].Columns["Year"] };
 
  
  ds_tot = blobj.gettot(vcode, strmonth, strmonth);
      

  ds_tot.Tables[0].PrimaryKey = new DataColumn[] { ds_tot.Tables[0].Columns["WorkManSLNo"], ds_tot.Tables[0].Columns["WorkManName"], ds_tot.Tables[0].Columns["Eng_Type"], ds_tot.Tables[0].Columns["Month"], ds_tot.Tables[0].Columns["Year"] };

  ds_att.Merge(ds_tot, true, MissingSchemaAction.AddWithKey);


 








    string strSQL = "   DECLARE @DynamicColumns NVARCHAR(MAX); DECLARE @SQLQuery NVARCHAR(MAX);  "

                  + "  SELECT @DynamicColumns = STRING_AGG(QUOTENAME(DayOfMonth), ',') FROM(SELECT DISTINCT DATEPART(DAY, ML.Dates) AS DayOfMonth FROM dbo.ListOfDaysByEngagementType('" + monthwithprefix + "', '" + year + "')  "
                  + "  AS ML LEFT JOIN   "
                  + "  App_AttendanceDetails AS ad ON ML.Dates = AD.Dates WHERE AD.VendorCode = '" + vcode + "' AND DATEPART(MONTH, AD.Dates) = '" + monthwithprefix + "' AND DATEPART(YEAR, AD.Dates) = '" + year + "') AS Days;  "
                  + "   "
                  + "             SET @SQLQuery = ' WITH AttendanceData AS ( SELECT DATEPART(DAY, ML.Dates) AS DayOfMonth, ad.WorkManSl AS WorkManSLNo, ad.WorkManName AS WorkManName, ad.EngagementType AS Eng_Type,  "
                  + "  Convert(varchar, DATEPART(MONTH, ML.Dates)) AS Month, Convert(varchar,DATEPART(YEAR, ML.Dates)) AS Year,  "
                  + "  CASE WHEN AD.DayDef = ''WD'' AND AD.Present = ''True'' THEN ''P''  "
                  + "   "
                  + " WHEN AD.DayDef = ''WD'' AND AD.Present = ''False'' THEN ''A''  "
                  + "   "
                  + " WHEN AD.DayDef = ''OD'' AND AD.Present = ''True'' THEN ''OP'' "
                  + "   "
                  + " WHEN AD.DayDef = ''HD'' AND AD.Present = ''True'' THEN ''HP''  "
                  + "   "
                  + "   "
                  + "  WHEN AD.DayDef = ''HD'' AND AD.Present = ''False'' THEN ''HD''  "
                  + "   "
                  + "   "
                  + "  WHEN AD.DayDef = ''LV'' THEN ''LV''   "
                  + "   "
                  + " WHEN AD.DayDef = ''HF'' AND AD.Present = ''True'' THEN ''HF''  "
                  + "   "
                  + "   END AS AttendanceStatus FROM dbo.ListOfDaysByEngagementType(''" + monthwithprefix + "'', ''" + year + "'') AS ML  "
                  + "  LEFT JOIN App_AttendanceDetails AS ad ON ML.Dates = AD.Dates WHERE AD.VendorCode = ''" + vcode + "'' AND DATEPART(MONTH, AD.Dates) = ''" + monthwithprefix + "'' AND DATEPART(YEAR, AD.Dates) = ''" + year + "'' )  "
                  + "   "
                  + " SELECT WorkManSLNo, WorkManName, Eng_Type, Month, Year, ' + @DynamicColumns + ' FROM AttendanceData PIVOT(MAX(AttendanceStatus) FOR DayOfMonth IN(' + @DynamicColumns + '))  "
                  + " AS PivotTable order by WorkManSLNo,WorkManName,Month,Year,Eng_Type ; ';  "
                  + "   "
                  + "  EXEC sp_executesql @SQLQuery; ";



                              string strSQL = @"
SELECT
    WorkManSl,
    WorkManName,
    EngagementType,
    " + int.Parse(monthwithprefix) + @" AS Month,
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
  AND MONTH(Dates) = " + int.Parse(monthwithprefix) + @"
  AND YEAR(Dates) = '" + year + @"'
GROUP BY WorkManSl, WorkManName, EngagementType
ORDER BY WorkManSl;
";

