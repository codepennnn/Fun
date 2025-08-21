Session["Username"] = txtUserName.Text.Trim();

protected void btnSearch_Click(object sender, EventArgs e)
{
    BL_FormC3DS blobj = new BL_FormC3DS();
    DataSet ds_L1 = new DataSet();

    string searchBy = ddlSearch.SelectedValue;
    string searchText = txtSearch.Text.Trim();

    string licno = string.Empty;
    string wo = string.Empty;

    if (searchBy == "WorkOrderNo")
        wo = searchText;
    else if (searchBy == "LicNo")
        licno = searchText;

    // Get logged in username from session
    string username = Session["Username"]?.ToString();

    // Pass username along with search
    ds_L1 = blobj.GetC3Detail(licno, wo, username);

    if (ds_L1 != null && ds_L1.Tables.Count > 0 && ds_L1.Tables[0].Rows.Count > 0)
    {
        C3_Records_Grid.DataSource = ds_L1.Tables[0];
        C3_Records_Grid.DataBind();
    }
    else
    {
        C3_Records_Grid.DataSource = null;
        C3_Records_Grid.DataBind();
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Warning, "No Data Found !!!");
    }
}




public DataSet GetC3Detail(string LicNo, string wo, string username)
{
    string strSQL = "SELECT * FROM App_Vendor_form_C3_Dtl WHERE 1=1 ";
    Dictionary<string, object> objParam = new Dictionary<string, object>();

    // Vendor usernames = 5 digits → force filter to only their data
    if (username.Length == 5)
    {
        strSQL += " AND VendorID = @VendorID ";  // Assuming column name is VendorID or similar
        objParam.Add("VendorID", username);
    }

    // Contractor usernames = 6 digits → they can see all, just apply search filter
    if (!string.IsNullOrEmpty(LicNo))
    {
        strSQL += " AND LL_NO = @LicNo ";
        objParam.Add("LicNo", LicNo);
    }

    if (!string.IsNullOrEmpty(wo))
    {
        strSQL += " AND WorkOrderNo = @wo ";
        objParam.Add("wo", wo);
    }

    DataHelper dh = new DataHelper();
    DataSet ds = dh.GetDataset(strSQL, "App_Vendor_form_C3_Dtl", objParam);
    return ds;
}
