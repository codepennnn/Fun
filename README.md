protected void WorkOrder_Exemption_Records_SelectedIndexChanged(object sender, EventArgs e)
{
    // Find textbox inside your record form
    TextBox txtWO = (TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo");

    // Find CheckBoxList inside Action_Record
    CheckBoxList chkWO = (CheckBoxList)Action_Record.Rows[0].FindControl("WorkOrderNo");

    chkWO.Items.Clear();   // Clear old items

    if (!string.IsNullOrEmpty(txtWO.Text))
    {
        chkWO.Items.Add(new ListItem(txtWO.Text, txtWO.Text));
        chkWO.Items[0].Selected = true; // Optional
    }
}
