<asp:TemplateField>
    <ItemTemplate>
        <asp:HiddenField ID="hfRID" runat="server" Value='<%# Eval("R_ID") %>' />
    </ItemTemplate>
</asp:TemplateField>

protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
{
    GridViewRow row = Vendor_Block_Unblock_RFQ_record.Rows[0]; // adjust index if multiple rows
    string reason = ((DropDownList)row.FindControl("Reason")).SelectedValue;
    int r_id = Convert.ToInt32(((HiddenField)row.FindControl("hfRID")).Value);

    BL_Vendor_RFQ_Block_Unblock blobj = new BL_Vendor_RFQ_Block_Unblock();
    DataSet ds = blobj.GetStatus(reason, r_id);

    if (ds.Tables[0].Rows.Count > 0)
    {
        ((TextBox)row.FindControl("Status")).Text = ds.Tables[0].Rows[0]["Type"].ToString();
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
