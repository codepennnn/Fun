protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
{
    string reason = Reason.SelectedItem.Text;   // This will be saved in your table
    int r_id = Convert.ToInt32(Reason.SelectedValue); // This will be used for lookup

    BL_Vendor_RFQ_Block_Unblock blobj = new BL_Vendor_RFQ_Block_Unblock();
    DataSet ds = blobj.GetStatus(reason, r_id);

    if (ds.Tables[0].Rows.Count > 0)
    {
        Status.Text = ds.Tables[0].Rows[0]["Type"].ToString();
        Status.Visible = true;
    }
}




public DataSet GetStatus(string reason, int r_id)
{
    string strSQL = "SELECT Type FROM VENDORUNBLOCKREASON WHERE Reason = @Reason AND R_ID = @R_ID";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("Reason", reason);
    objParam.Add("R_ID", r_id);

    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "VENDORUNBLOCKREASON", objParam);
}

private void BindReasonDropdown()
{
    string sql = "SELECT R_ID, Reason FROM VENDORUNBLOCKREASON";
    DataHelper dh = new DataHelper();

    Reason.DataSource = dh.GetDataset(sql, "VENDORUNBLOCKREASON").Tables[0];
    Reason.DataTextField = "Reason";   // user sees this
    Reason.DataValueField = "R_ID";    // hidden value (used internally)
    Reason.DataBind();

    Reason.Items.Insert(0, new ListItem("--Select Reason--", "0")); // optional placeholder
}
