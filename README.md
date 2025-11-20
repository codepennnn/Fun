protected void WorkOrder_Exemption_Record_DataBound(object sender, EventArgs e)
{
    TextBox txtWO = (TextBox)WorkOrder_Exemption_Record.FindControl("WorkOrderNo");

    if (txtWO != null)
        ViewState["WO_LIST"] = txtWO.Text;
}

protected void Action_Record_DataBound(object sender, EventArgs e)
{
    // Get CheckBoxList
    CheckBoxList chkWO = (CheckBoxList)Action_Record.FindControl("cc_wo");
    if (chkWO == null) return;

    chkWO.Items.Clear();

    if (ViewState["WO_LIST"] != null)
    {
        string[] array = ViewState["WO_LIST"].ToString()
                          .Split(new char[] { ',', '|'}, StringSplitOptions.RemoveEmptyEntries);

        foreach (string wo in array)
        {
            chkWO.Items.Add(new ListItem(wo.Trim(), wo.Trim()));
        }
    }
}
