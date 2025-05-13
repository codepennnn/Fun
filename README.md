public DataSet GetTotal(string vcode, string month, string year)
{
    // Extract numeric month and year
    month = month.Substring(4, 2); // MM
    year = year.Substring(0, 4);   // YYYY
    int monthInt = int.Parse(month); // Remove leading zero

    string strSQL = $@"
        SELECT 
            WorkManSl AS WorkManSLNo,
            WorkManName AS WorkManName,
            EngagementType AS Eng_Type,
            {monthInt} AS Month,
            {year} AS Year,
            SUM(CASE WHEN Present = 'True' THEN 1 ELSE 0 END) AS TotalPresent,
            SUM(CASE WHEN DayDef = 'LV' THEN 1 ELSE 0 END) AS Leave,
            SUM(CASE WHEN DayDef = 'HD' THEN 1 ELSE 0 END) AS Holiday,
            SUM(
                CASE WHEN Present = 'True' THEN 1 ELSE 0 END +
                CASE WHEN DayDef = 'LV' THEN 1 ELSE 0 END +
                CASE WHEN DayDef = 'HD' THEN 1 ELSE 0 END
            ) AS Total
        FROM App_AttendanceDetails
        WHERE VendorCode = '{vcode}' 
            AND DATEPART(MONTH, Dates) = {monthInt} 
            AND DATEPART(YEAR, Dates) = {year}
        GROUP BY WorkManSl, WorkManName, EngagementType
        ORDER BY WorkManSLNo;
    ";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "App_AttendanceDetails", objParam);
}
