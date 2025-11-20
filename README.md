protected void WorkOrder_Exemption_Records_SelectedIndexChanged(object sender, EventArgs e)
{
    GetRecord(WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());
    
    WorkOrder_Exemption_Record.BindData();
    
    Dictionary<string, object> ddlParams = new Dictionary<string, object>();
    ddlParams.Add("ID", WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());
    GetDropdowns("CC_Wo_No", ddlParams);

    Action_Record.DataBind(); // THIS CREATES TEMPLATE

    // ⭐ FIX: Rebind the CheckBoxList manually
    CheckBoxList chk = (CheckBoxList)Action_Record.FindControl("WorkOrderNo");
    if (chk != null)
    {
        chk.DataBind();    // <<< THIS LINE MAKES THEM SHOW IN THE UI
    }
}
