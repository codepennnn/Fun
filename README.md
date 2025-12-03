if (Half_Yearly_Record.Rows.Count > 0)
{
    Button btn = (Button)Half_Yearly_Record.Rows[0].FindControl("btnSave");
    if (btn != null)
        btn.Visible = false;
}
