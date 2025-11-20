protected void WorkOrder_Exemption_Record_RowDataBound(object sender, GridViewRowEventArgs e)
{
    if (WorkOrder_Exemption_Record.Rows.Count > 0)
    {
        TextBox txtWO = (TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo");

        if (txtWO != null)
        {
            ViewState["WORKORDER_LIST"] = txtWO.Text;
        }
    }
}

protected void Action_Record_RowDataBound(object sender, GridViewRowEventArgs e)
{
    if (Action_Record.Rows.Count == 0) return;

    // Find dropdown
    CheckBoxList chkWO = (CheckBoxList)Action_Record.Rows[0].FindControl("cc_wo");
    if (chkWO == null) return;

    chkWO.Items.Clear();

    // Read stored work orders
    string woList = ViewState["WORKORDER_LIST"] as string;
    if (string.IsNullOrWhiteSpace(woList)) return;

    // Split and fill
    string[] arr = woList.Split(new char[] { ',', '|' }, StringSplitOptions.RemoveEmptyEntries);

    foreach (string wo in arr)
    {
        chkWO.Items.Add(new ListItem(wo.Trim(), wo.Trim()));
    }

    // Select all
    foreach (ListItem li in chkWO.Items)
        li.Selected = true;
}
