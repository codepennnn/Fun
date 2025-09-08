public int UpdateLicenseValidity(string licNo, string validityToDate)
{
    string strSQL = "UPDATE App_Vendor_form_C3_Dtl " +
                    "SET LL_VALID_UPTO = @LL_VALID_UPTO " +
                    "WHERE ll_no = @ll_no";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("@LL_VALID_UPTO", validityToDate);
    objParam.Add("@ll_no", licNo);

    DataHelper dh = new DataHelper();
    return dh.ExecuteNonQuery(strSQL, objParam);  // Better than GetDataset
}
