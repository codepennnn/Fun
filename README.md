public DataSet GetC3WorkmanCatDetail(List<string> ids)
{
    if (ids == null || ids.Count == 0)
        return null;

    // Create parameter placeholders (@id0, @id1, ...)
    List<string> paramNames = new List<string>();
    Dictionary<string, object> objParam = new Dictionary<string, object>();

    for (int i = 0; i < ids.Count; i++)
    {
        string paramName = "@id" + i;
        paramNames.Add(paramName);
        objParam.Add("id" + i, ids[i]);
    }

    string inClause = string.Join(",", paramNames);

    string strSQL = $@"
        SELECT * 
        FROM App_Vendor_FormC3_WorkManCat 
        WHERE Master_ID IN ({inClause})";

    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "App_Vendor_FormC3_WorkManCat", objParam);
}
