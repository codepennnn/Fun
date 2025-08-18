public DataSet GetStatus(string reason, int r_id)
{
    string strSQL = "SELECT Type FROM VENDORUNBLOCKREASON WHERE Reason = @Reason AND R_ID = @R_ID";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("Reason", reason);
    objParam.Add("R_ID", r_id);

    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "VENDORUNBLOCKREASON", objParam);
}



protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
{
    string reason = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).SelectedValue;

    // Example: Assuming R_ID comes from somewhere (hidden field, dropdown, session, etc.)
    int r_id = Convert.ToInt32(((HiddenField)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("R_ID")).Value);

    BL_Vendor_RFQ_Block_Unblock blobj = new BL_Vendor_RFQ_Block_Unblock();
    DataSet ds = blobj.GetStatus(reason, r_id);

    if (ds.Tables[0].Rows.Count > 0)
    {
        ((TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Status")).Text = ds.Tables[0].Rows[0]["Type"].ToString();
    }
}
