// 1. Get the WorkOrder TextBox from first FormContainer
TextBox txtWO = (TextBox)WorkOrder_Exemption_Record.FindControl("WorkOrderNo");

// 2. Get the CheckBoxList from second FormContainer
CheckBoxList chkWO = (CheckBoxList)Action_Record.FindControl("cc_wo");

chkWO.Items.Clear(); // clear previous values

// 3. If WorkOrder textbox has values
if (txtWO != null && !string.IsNullOrWhiteSpace(txtWO.Text))
{
    // Support both comma and | separated values
    string[] workorders = txtWO.Text.Split(new char[] { ',', '|'},
                                           StringSplitOptions.RemoveEmptyEntries);

    foreach (string wo in workorders)
    {
        string cleanWO = wo.Trim();
        chkWO.Items.Add(new ListItem(cleanWO, cleanWO));
    }

    // Optional: preselect all
    foreach (ListItem item in chkWO.Items)
        item.Selected = true;
}
