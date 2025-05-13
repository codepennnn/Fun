      public DataSet getattdancedata(string vcode, string month, string year)
      {

          month = month.Substring(4, 2);
          year = year.Substring(0, 4);
          string monthwithprefix = month.PadLeft(2, '0');

   

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
                          + " AS PivotTable ORDER BY WorkManSLNo; ';  "
                          + "   "
                          + "  EXEC sp_executesql @SQLQuery; ";















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

        
          string strSQL = " select      WorkManSl as WorkManSLNo,      WorkManName as WorkManName,       EngagementType as Eng_Type,      '"+ monthwithprefix + "'   As Month,      '" + year + "' As Year,        SUM(CASE WHEN  Present='True' THEN 1 ELSE 0 END ) As TotalPresent ,  "
                          + " SUM(CASE WHEN DayDef = 'LV' THEN 1 ELSE 0 END) As Leave,  "
                          + " SUM(CASE WHEN DayDef = 'HD'  THEN 1 ELSE 0 END ) As Holiday,  "
                          + "   SUM(            CASE WHEN  Present = 'True' THEN 1 ELSE 0 END + CASE WHEN DayDef = 'LV' THEN 1 ELSE 0 END + CASE WHEN DayDef = 'HD'  THEN 1 ELSE 0 END ) As Total  "
                          + " from App_AttendanceDetails where  "
                          + " VendorCode = '"+ vcode + "' and datepart(month, dates)= '"+ monthwithprefix + "' and datepart(year, dates)= '"+year+"'  "
                          + " group by WorkManSl,WorkManName,EngagementType  ";


          Dictionary<string, object> objParam = new Dictionary<string, object>();
          
          DataHelper dh = new DataHelper();
          return dh.GetDataset(strSQL, "App_AttendanceDetails", objParam);

      }

