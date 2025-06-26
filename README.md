<asp:DropDownList ID="Lic_No" runat="server" CssClass="form-control form-control-sm" Font-Size="Small" Enabled="false">
</asp:DropDownList>


protected void Work_Order_No_SelectedIndexChanged(object sender, EventArgs e)
{
    string selectedWorkOrder = Work_Order_No.SelectedValue;

    if (!string.IsNullOrEmpty(selectedWorkOrder))
    {
        // Fetch Lic No dataset based on selected Work Order
        DataSet ds = GetLicNoDataset(selectedWorkOrder);  // Your existing dataset logic

        if (ds != null && ds.Tables[0].Rows.Count > 0)
        {
            Lic_No.DataSource = ds;
            Lic_No.DataTextField = "licno";
            Lic_No.DataValueField = "licno";
            Lic_No.DataBind();

            Lic_No.Enabled = true;  // Enable dropdown
        }
        else
        {
            Lic_No.Items.Clear();
            Lic_No.Enabled = false;
        }
    }
    else
    {
        Lic_No.Items.Clear();
        Lic_No.Enabled = false;
    }
}
