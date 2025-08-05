if (ds_L1 != null && ds_L1.Tables.Count > 0 && ds_L1.Tables[0].Rows.Count > 0)
{
    Mis_Grid.DataSource = ds_L1.Tables[0];
    Mis_Grid.DataBind();

    ViewState["MisData"] = ds_L1.Tables[0];

    // Inject JavaScript to show the button
    ScriptManager.RegisterStartupScript(this, this.GetType(), "showBtnExport", "$('#btnExport').show();", true);
}
