protected void WorkOrder_Exemption_Record_RowDataBound(object sender, GridViewRowEventArgs e)
{
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
        // 1. Get WorkOrder textbox
        TextBox txtWO = (TextBox)e.Row.FindControl("WorkOrderNo");

        // 2. Get CheckBoxList in second FormContainer
        CheckBoxList chkWO = (CheckBoxList)Action_Record.FindControl("cc_wo");

        if (chkWO != null)
            chkWO.Items.Clear();

        if (txtWO != null && !string.IsNullOrWhiteSpace(txtWO.Text))
        {
            string[] workorders = txtWO.Text.Split(new char[] { ',', '|'},
                                                   StringSplitOptions.RemoveEmptyEntries);

            foreach (string wo in workorders)
            {
                chkWO.Items.Add(new ListItem(wo.Trim(), wo.Trim()));
            }

            // Optional preselect all
            foreach (ListItem item in chkWO.Items)
                item.Selected = true;
        }
    }
}
