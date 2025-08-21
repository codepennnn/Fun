        <div>
            <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px">
                <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Form C3 Records</b></legend>

                <div class="scrollable-grid" style="overflow: auto;height:350px;">
                 
              <asp:GridView ID="C3_Records_Grid" CssClass="grid"  runat="server" 
            DataKeyNames="ID" 
       GridLines="None" Width="100%" AllowPaging="false"
        ForeColor="#333333" ShowHeaderWhenEmpty="True"
        PageSize="10"
        PagerSettings-Visible="True"
        PagerStyle-HorizontalAlign="Center"
        PagerStyle-Wrap="False"
        HeaderStyle-Font-Size="Smaller"
        RowStyle-Font-Size="Smaller"
        HeaderStyle-HorizontalAlign="Center"
        RowStyle-HorizontalAlign="Center"
        OnPageIndexChanging="C3_Records_Grid_PageIndexChanging"
        OnSelectedIndexChanged="C3_Records_Grid_SelectedIndexChanged">

     <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerSettings Mode="Numeric" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" CssClass="pager1" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

    </asp:GridView>

                </div>

            </fieldset>
        </div>
  




    <div>
        <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px">
            <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Form C3 Workman Category </b></legend>

            <div class="scrollable-grid" style="overflow: auto;height:350px;">
             
          <asp:GridView ID="C3_Workman_Grid" CssClass="grid"  runat="server" 

   GridLines="None" Width="100%" AllowPaging="false"
    ForeColor="#333333" ShowHeaderWhenEmpty="True"
    PageSize="10"
    PagerSettings-Visible="True"
    PagerStyle-HorizontalAlign="Center"
    PagerStyle-Wrap="False"
    HeaderStyle-Font-Size="Smaller"
    RowStyle-Font-Size="Smaller"
    HeaderStyle-HorizontalAlign="Center"
    RowStyle-HorizontalAlign="Center">

 <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <EditRowStyle BackColor="#999999" />
    <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <PagerSettings Mode="Numeric" />
    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" CssClass="pager1" />
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
    <SortedAscendingCellStyle BackColor="#E9E7E2" />
    <SortedAscendingHeaderStyle BackColor="#506C8C" />
    <SortedDescendingCellStyle BackColor="#FFFDF8" />
    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

</asp:GridView>

            </div>

        </fieldset>
    </div>

   protected void C3_Records_Grid_SelectedIndexChanged(object sender, EventArgs e)
  {
      // Get Master ID (REFNO from DataKeyNames)
      string ID = C3_Records_Grid.SelectedDataKey.Value.ToString();

      BL_FormC3DS blobj = new BL_FormC3DS();
      DataSet ds_Workman = blobj.GetC3WorkmanCatDetail(ID);

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

          C3_Workman_Grid.Visible = false; 
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

   public DataSet GetC3WorkmanCatDetail(string ID)
   {
       string strSQL = "SELECT * FROM App_Vendor_FormC3_WorkManCat WHERE Master_ID = @Master_ID";
       Dictionary<string, object> objParam = new Dictionary<string, object>();
       objParam.Add("Master_ID", ID);

       DataHelper dh = new DataHelper();
       return dh.GetDataset(strSQL, "App_Vendor_FormC3_WorkManCat", objParam);
   }
why my second grid not open when open first grid
