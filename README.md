public DataSet getgmail(string[] pno)
{
    string strsql = string.Empty;

    strsql = @"
        SELECT EmailID 
        FROM UserLoginDB.dbo.App_EmployeeMaster 
        WHERE pno IN (SELECT value FROM STRING_SPLIT(@Pno, ','))";

    Dictionary<string, object> objparam = new Dictionary<string, object>();
    objparam.Add("Pno", string.Join(",", pno)); // no quotes needed

    DataHelper dh = new DataHelper();
    return GetDataset1(strsql, "App_EmployeeMAster", objparam);
}
