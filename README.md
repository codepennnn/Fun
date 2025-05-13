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
                     + " group by WorkManSl,WorkManName,EngagementType order by WorkManSLNo ";


     Dictionary<string, object> objParam = new Dictionary<string, object>();
     
     DataHelper dh = new DataHelper();
     return dh.GetDataset(strSQL, "App_AttendanceDetails", objParam);

 }
