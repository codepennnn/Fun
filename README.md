protected void Reason_SelectedIndexChanged(object sender, EventArgs e)
{
    // Get the selected Reason (if needed)
    string reason = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Reason")).SelectedValue;

    // Get the selected Block/Unblock type
    string type = ((DropDownList)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Block_unblock")).SelectedValue;

    // Set Status textbox directly based on Block/Unblock selection
    TextBox txtStatus = (TextBox)Vendor_Block_Unblock_RFQ_record.Rows[0].FindControl("Status");
    txtStatus.Text = type;   // RFQ_B or RFQ_U
    txtStatus.Visible = true;
}
