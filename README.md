protected void Action_Record_RowDataBound(object sender, EventArgs e)
{
    // 1. Get CONTROL from FIRST FormContainer (WorkOrder textbox)
    TextBox txtWO = (TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo");

    // 2. Get CONTROL from SECOND FormContainer (CheckBoxList)
    CheckBoxList chkWO = (CheckBoxList)Action_Record.Rows[0].FindControl("cc_wo");

    if (txtWO == null || chkWO == null)
        return;

    chkWO.Items.Clear();

    if (!string.IsNullOrWhiteSpace(txtWO.Text))
    {
        string[] arr = txtWO.Text.Split(new char[] { ',', '|' }, StringSplitOptions.RemoveEmptyEntries);

        foreach (string item in arr)
        {
            chkWO.Items.Add(new ListItem(item.Trim(), item.Trim()));
        }

        // preselect all
        foreach (ListItem li in chkWO.Items)
            li.Selected = true;
    }
}
