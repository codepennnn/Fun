protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
{
    // Get the Block/Unblock dropdown and Status textbox directly
    DropDownList ddlBlockUnblock = (DropDownList)FindControl("Block_unblock");
    TextBox txtStatus = (TextBox)FindControl("Status");

    if (ddlBlockUnblock != null && txtStatus != null)
    {
        string type = ddlBlockUnblock.SelectedValue;

        if (type == "RFQ_B")      // Block selected
        {
            txtStatus.Text = "RFQ_B";
        }
        else if (type == "RFQ_U") // Unblock selected
        {
            txtStatus.Text = "RFQ_U";
        }
        else
        {
            txtStatus.Text = "";
        }

        txtStatus.Visible = true;
    }
}
