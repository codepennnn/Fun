    public DataSet GetRecords(System.Collections.Specialized.StringDictionary FilterConditions, int totalPagesize, string sortExpression)
    {

        string strSQL = "select " + (totalPagesize == 0 ? "" : "top " + totalPagesize.ToString()) + " * from App_Vendor_Reg ";
        DataHelper dh = new DataHelper();
        Dictionary<string, object> objParam = null;
        if (FilterConditions != null && FilterConditions.Count > 0)
        {
            strSQL += " where ";
            objParam = new Dictionary<string, object>();
            int cnt = FilterConditions.Count;
            foreach (string dickey in FilterConditions.Keys)
            {
                objParam.Add(dickey, FilterConditions[dickey] + '%');
                if (cnt > 0 && cnt != FilterConditions.Count)
                    strSQL += " and " + dickey + " like @" + dickey;
                else
                    strSQL += dickey + " like @" + dickey;
                cnt--;
            }
        }
        strSQL += " order by CREATEDON desc";
        return dh.GetDataset(strSQL, "App_Vendor_Reg", objParam);

    }
