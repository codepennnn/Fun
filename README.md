protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
{
    // Get the current row and controls
    GridViewRow row = Vendor_Block_Unblock_RFQ_record.Rows[0]; // adjust if multiple rows
    DropDownList ddlBlockUnblock = (DropDownList)row.FindControl("Block_unblock");
    TextBox txtStatus = (TextBox)row.FindControl("Status");

    // Set Status based on Block/Unblock dropdown
    string type = ddlBlockUnblock.SelectedValue;

    if (type == "RFQ_B")
    {
        txtStatus.Text = "RFQ_B"; // Block
    }
    else if (type == "RFQ_U")
    {
        txtStatus.Text = "RFQ_U"; // Unblock
    }
    else
    {
        txtStatus.Text = ""; // default/fallback
    }

    txtStatus.Visible = true;
}
