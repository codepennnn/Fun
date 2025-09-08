  public DataSet UpdateLicenseValidity(string licNo, DateTime validityToDate)
        {
            string strSQL = "UPDATE App_Vendor_form_C3_Dtl SET LL_VALID_UPTO = @validityToDate WHERE LicNo = @LicNo";

            Dictionary<string, object> objParam = new Dictionary<string, object>();
            objParam.Add("@LL_VALID_UPTO", validityToDate);
            objParam.Add("@LicNo", licNo);

            DataHelper dh = new DataHelper();
            return dh.GetDataset(strSQL, "App_Vendor_form_C3_Dtl", objParam);
        }
System.Data.SqlClient.SqlException: 'Must declare the scalar variable "@validityToDate".'
