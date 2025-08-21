<!-- Master Grid -->
<div class="scrollable-grid" style="overflow: auto; height:350px;">
    <asp:GridView ID="C3_Records_Grid" CssClass="grid" runat="server"
        GridLines="None" Width="100%"
        ForeColor="#333333" ShowHeaderWhenEmpty="True"
        PageSize="10"
        AutoGenerateSelectButton="True" 
        DataKeyNames="REFNO" 
        OnPageIndexChanging="C3_Records_Grid_PageIndexChanging"
        OnSelectedIndexChanged="C3_Records_Grid_SelectedIndexChanged">

        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
    </asp:GridView>
</div>

<!-- Detail Grid (Initially Hidden) -->
<div class="scrollable-grid" style="overflow: auto; height:250px; margin-top:10px;">
    <asp:GridView ID="Workman_Grid" CssClass="grid" runat="server"
        GridLines="None" Width="100%"
        ForeColor="#333333" ShowHeaderWhenEmpty="True"
        Visible="false">
        
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    </asp:GridView>
</div>





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
        C3_Records_Grid.DataSource = ds_L1.Tables[0];
        C3_Records_Grid.DataBind();

        Workman_Grid.Visible = false; // Hide detail grid until user selects a row
    }
    else
    {
        C3_Records_Grid.DataSource = null;
        C3_Records_Grid.DataBind();
        Workman_Grid.DataSource = null;
        Workman_Grid.DataBind();
        Workman_Grid.Visible = false;

        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Warning, "No Data Found !!!");
    }
}

protected void C3_Records_Grid_SelectedIndexChanged(object sender, EventArgs e)
{
    // Get Master ID (REFNO from DataKeyNames)
    string masterId = C3_Records_Grid.SelectedDataKey.Value.ToString();

    BL_FormC3DS blobj = new BL_FormC3DS();
    DataSet ds_Workman = blobj.GetC3WorkmanCatDetail(masterId);

    if (ds_Workman != null && ds_Workman.Tables.Count > 0 && ds_Workman.Tables[0].Rows.Count > 0)
    {
        Workman_Grid.DataSource = ds_Workman.Tables[0];
        Workman_Grid.DataBind();
        Workman_Grid.Visible = true; // show after binding
    }
    else
    {
        Workman_Grid.DataSource = null;
        Workman_Grid.DataBind();
        Workman_Grid.Visible = false;
    }
}



public DataSet GetC3WorkmanCatDetail(string masterId)
{
    string strSQL = "SELECT * FROM App_Vendor_FormC3_WorkManCat WHERE Master_ID = @MasterID";
    Dictionary<string, object> objParam = new Dictionary<string, object>();
    objParam.Add("MasterID", masterId);

    DataHelper dh = new DataHelper();
    return dh.GetDataset(strSQL, "App_Vendor_FormC3_WorkManCat", objParam);
}
