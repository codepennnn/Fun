public DataSet GetRecords(StringDictionary FilterConditions, int totalPagesize, string sortExpression)
{
    string strSQL = @"
        SELECT *
        FROM (
            SELECT *,
                   DATEDIFF(day, CreatedOn, GETDATE()) AS dayscountCreatedOn,
                   DATEDIFF(day, ResubmitedOn, GETDATE()) AS dayscountResub,
                   ROW_NUMBER() OVER (PARTITION BY RefNo ORDER BY CreatedOn DESC) AS rn
            FROM App_Half_Yearly_Details
        ) A
        WHERE A.rn = 1
    ";

    DataHelper dh = new DataHelper();
    Dictionary<string, object> objParam = null;

    // Add filters
    if (FilterConditions != null && FilterConditions.Count > 0)
    {
        if (FilterConditions["Status"] != null && FilterConditions["Status"] != "")
        {
            strSQL += " AND A.Status = '" + FilterConditions["Status"] + "' ";
        }

        if (FilterConditions["Search_With"] != null && FilterConditions["Enter_Detail"] != null)
        {
            strSQL += " AND A." + FilterConditions["Search_With"] + 
                      " LIKE '%" + FilterConditions["Enter_Detail"] + "%' ";
        }
    }

    // Sorting
    if (!string.IsNullOrEmpty(sortExpression))
    {
        strSQL += " ORDER BY " + sortExpression;
    }

    return dh.GetDataset(strSQL, "App_Half_Yearly_Details", objParam);
}
