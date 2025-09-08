public DataSet UpdateC3CloserValidity(string licNo)
{
    // SQL will update C3CloserDate with the minimum of PERIOD_CONTRACT_TO and LL_VALID_UPTO
    string strSQL = @"
        UPDATE App_Vendor_form_C3_Dtl
        SET C3CloserDate = (
            SELECT MIN(v) 
            FROM (VALUES (PERIOD_CONTRACT_TO), (LL_VALID_UPTO)) AS value(v)
        )
        WHERE LicNo = @LicNo";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("@LicNo", licNo);

    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "App_Vendor_form_C3_Dtl", objParam);
}


if (result)
{
    DataSet ds1 = new DataSet();
    BL_LabourApproval blobj1 = new BL_LabourApproval();

    string licNo = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["LicNo"].ToString();
    DateTime validityToDate = Convert.ToDateTime(PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["ToDate"]);

    // Step 1: Update LL_VALID_UPTO
    ds1 = blobj1.UpdateLicenseValidity(licNo, validityToDate);

    // Step 2: Update C3CloserDate based on min(PERIOD_CONTRACT_TO, LL_VALID_UPTO)
    blobj1.UpdateC3CloserValidity(licNo);

    // ... continue with Approved/Rejected email logic
}
