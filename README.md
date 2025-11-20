protected void WorkOrder_Exemption_Records_SelectedIndexChanged(object sender, EventArgs e)
{
    GetRecord(WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());
    WorkOrder_Exemption_Record.BindData();

    Dictionary<string, object> ddlParams = new Dictionary<string, object>();
    ddlParams.Add("ID", WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());
    
    // Call GetDropdowns
    DataSet ds = GetDropdowns("CC_Wo_No", ddlParams);

    // Bind CheckBoxList
    CheckBoxList chk = (CheckBoxList)Action_Record.FindControl("WorkOrderNo");
    if (chk != null)
    {
        chk.DataSource = ds.Tables["CC_Wo_No"];
        chk.DataTextField = "WorkOrderNo";
        chk.DataValueField = "WorkOrderNo";
        chk.DataBind();
    }

    // Refresh UpdatePanel so UI updates
    UpdatePanel up = (UpdatePanel)Action_Record.FindControl("UpdatePanel2");
    if (up != null) up.Update();

    Action_Record.DataBind();
}


<asp:CheckBoxList ID="WorkOrderNo" runat="server"
    CssClass="form-control-sm radio"
    DataTextField="Workorder"
    DataValueField="WO_NO">
</asp:CheckBoxList>
