protected void WorkOrder_Exemption_Record_RowDataBound(object sender, EventArgs e)
{
    if (WorkOrder_Exemption_Record.Rows.Count > 0)
    {
        // 1. Get textbox from FIRST FormCointainer
        TextBox txtWO = (TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo");

        // 2. Get CheckBoxList from SECOND FormCointainer
        CheckBoxList chkWO = (CheckBoxList)Action_Record.Rows[0].FindControl("cc_wo");

        if (chkWO != null)
            chkWO.Items.Clear();

        if (txtWO != null && !string.IsNullOrWhiteSpace(txtWO.Text))
        {
            string[] workorders = txtWO.Text.Split(new char[] { ',', '|' },
                                                   StringSplitOptions.RemoveEmptyEntries);

            foreach (string wo in workorders)
            {
                chkWO.Items.Add(new ListItem(wo.Trim(), wo.Trim()));
            }

            foreach (ListItem item in chkWO.Items)
                item.Selected = true;
        }

        // Your existing attachment code…
    }
}
