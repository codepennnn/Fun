protected void btnSearch_Click(object sender, EventArgs e)
{
    BL_FormC3DS blobj = new BL_FormC3DS();
    DataSet ds_L1 = new DataSet();

    string searchBy = ddlSearch.SelectedValue;
    string searchText = txtSearch.Text.Trim();

    string licno = string.Empty;
    string wo = string.Empty;

    if (searchBy == "WorkOrderNo")
        wo = searchText;
    else if (searchBy == "LicNo")
        licno = searchText;

    string username = Session["Username"]?.ToString();

    ds_L1 = blobj.GetC3Detail(licno, wo, username);

    if (ds_L1 != null && ds_L1.Tables.Count > 0 && ds_L1.Tables[0].Rows.Count > 0)
    {
        // ✅ Bind first grid
        C3_Records_Grid.DataSource = ds_L1.Tables[0];
        C3_Records_Grid.DataBind();

        // ✅ Automatically bind second grid using the first row's Master_ID (REFNO or ID)
        string firstID = ds_L1.Tables[0].Rows[0]["ID"].ToString();   // or REFNO if that's the key
        DataSet ds_Workman = blobj.GetC3WorkmanCatDetail(firstID);

        if (ds_Workman != null && ds_Workman.Tables.Count > 0 && ds_Workman.Tables[0].Rows.Count > 0)
        {
            C3_Workman_Grid.DataSource = ds_Workman.Tables[0];
            C3_Workman_Grid.DataBind();
            C3_Workman_Grid.Visible = true;
        }
        else
        {
            C3_Workman_Grid.DataSource = null;
            C3_Workman_Grid.DataBind();
            C3_Workman_Grid.Visible = false;
        }
    }
    else
    {
        C3_Records_Grid.DataSource = null;
        C3_Records_Grid.DataBind();

        C3_Workman_Grid.DataSource = null;
        C3_Workman_Grid.DataBind();
        C3_Workman_Grid.Visible = false;

        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Warning, "No Data Found !!!");
    }
}
