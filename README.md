public DataSet UpdateLicenseValidity(string licNo, DateTime validityToDate)
{
    string strSQL = "UPDATE App_LabourLicenseSubmission SET LToDate = @ToDate WHERE LicNo = @LicNo";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("@ToDate", validityToDate);
    objParam.Add("@LicNo", licNo);

    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "App_LabourLicenseSubmission", objParam);
}


public void UpdateLicenseAndCheck(string licNo, DateTime validityToDate)
{
    // First update license validity
    string strSQL = "UPDATE App_LabourLicenseSubmission SET LToDate = @ToDate WHERE LicNo = @LicNo";
    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("@ToDate", validityToDate);
    objParam.Add("@LicNo", licNo);

    DataHelper dh = new DataHelper();
    dh.ExecuteNonQuery(strSQL, objParam);

    // Then check condition (pseudo SQL, adjust to your logic)
    string checkSQL = @"
        UPDATE App_LabourLicenseSubmission 
        SET c3closer = 'Yes'
        WHERE LicNo = @LicNo 
          AND (WONo_ToDate < @ToDate OR LicNo_ToDate < @ToDate)";

    Dictionary<string, object> checkParam = new Dictionary<string, object>();
    checkParam.Add("@LicNo", licNo);
    checkParam.Add("@ToDate", validityToDate);

    dh.ExecuteNonQuery(checkSQL, checkParam);
}
