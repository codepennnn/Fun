protected void WorkOrder_Exemption_Records_SelectedIndexChanged(object sender, EventArgs e)
{
    GetRecord(WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());

    WorkOrder_Exemption_Record.BindData();
    Action_Record.BindData();

    // 1. Get WorkOrder No and store
    TextBox txtWO = (TextBox)WorkOrder_Exemption_Record.FindControl("WorkOrderNo");
    if (txtWO != null)
        hdnWorkOrder.Value = txtWO.Text;

    // 2. Fill dropdown
    CheckBoxList chkWO = (CheckBoxList)Action_Record.FindControl("cc_wo");

    if (chkWO != null)
    {
        chkWO.Items.Clear();

        string woText = hdnWorkOrder.Value;

        if (!string.IsNullOrWhiteSpace(woText))
        {
            string[] arr = woText.Split(new char[] { ',', '|' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (string wo in arr)
            {
                chkWO.Items.Add(new ListItem(wo.Trim(), wo.Trim()));
            }
        }
    }
}
<asp:HiddenField ID="hdnWorkOrder" runat="server" />
