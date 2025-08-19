protected void Block_unblock_SelectedIndexChanged(object sender, EventArgs e)
{
    DropDownList ddl = (DropDownList)sender;
    string type = ddl.SelectedValue;

    Dictionary<string, object> ddlParams = new Dictionary<string, object>();
    ddlParams.Add("type", type);

    GetDropdowns("Reason", ddlParams);
    Reason.DataBind();
}
