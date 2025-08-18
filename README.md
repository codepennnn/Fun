public DataSet GetStatus(int r_id)
{
    string strSQL = "SELECT Type FROM VENDORUNBLOCKREASON WHERE R_ID = @R_ID";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("R_ID", r_id);

    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "VENDORUNBLOCKREASON", objParam);
}


protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
{
    int r_id = Convert.ToInt32(Reason.SelectedValue); // primary key
    
    BL_Vendor_RFQ_Block_Unblock blobj = new BL_Vendor_RFQ_Block_Unblock();
    DataSet ds = blobj.GetStatus(r_id);   // pass only R_ID now

    if (ds.Tables[0].Rows.Count > 0)
    {
        Status.Text = ds.Tables[0].Rows[0]["Type"].ToString();
        Status.Visible = true;
    }
}


string sql = "SELECT R_ID, Reason FROM VENDORUNBLOCKREASON";
Reason.DataSource = dh.GetDataset(sql, "VENDORUNBLOCKREASON").Tables[0];
Reason.DataTextField = "Reason";   // user sees this
Reason.DataValueField = "R_ID";    // real key
Reason.DataBind();
