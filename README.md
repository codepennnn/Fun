   <div class="form-inline row">
     <div class="form-group col-md-4 mb-1">
         <label for="lblAll" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Search With:</label>
         <asp:DropDownList ID="ddlSearch" runat="server" CssClass="form-control form-control-sm col-sm-5">
             <asp:ListItem Value=""></asp:ListItem>
             <asp:ListItem Value="WorkOrderNo">WorkOrder No</asp:ListItem>
             <asp:ListItem Value="LicNo">Lic No</asp:ListItem>
         </asp:DropDownList>
      
     </div>
     <div class="form-group col-md-4 mb-1">
         <label for="lblSearch" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Enter detail:</label>
         <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm col-sm-8"></asp:TextBox>
       
     </div>
     <div class="form-group col-md-3 mb-1">
         <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-sm btn-info" ValidationGroup="search" />
     </div>
 </div>
    
    when search then show my records as per search
    
    <div class="w-100 border" style="overflow: auto;height:350px;">
     
          <asp:GridView ID="C3_Records_Grid" runat="server" AutoGenerateColumns="False"
              AllowPaging="false" CellPadding="4" 

              GridLines="None" Width="100%" 
              HeaderStyle-Font-Size="Smaller" RowStyle-Font-Size="Smaller" >
<AlternatingRowStyle BackColor="#cccccc" ForeColor="#284775"/>
 <Columns>
              <asp:TemplateField HeaderText="ID" SortExpression="ID" Visible="False">
                  <ItemTemplate>
                      <asp:Label ID="ID" runat="server"></asp:Label>
                  </ItemTemplate>
              </asp:TemplateField>

                   
          </Columns>    
          <EditRowStyle BackColor="#ffffff" />
          <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
          <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
          <PagerSettings Mode="Numeric" />
          <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True"  CssClass="pager1" />
          <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
          <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
          <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
          <SortedAscendingCellStyle BackColor="#E9E7E2" />
          <SortedAscendingHeaderStyle BackColor="#506C8C" />
          <SortedDescendingCellStyle BackColor="#FFFDF8" />
          <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
          </asp:GridView>

    </div>


    and here is cs code -    protected void btnSearch_Click(object sender, EventArgs e)
   {
       BL_FormC3DS blobj = new BL_FormC3DS();
               //string strSql = string.Empty;
       DataSet ds_L1 = new DataSet();
       string licno=

       ds_L1 = blobj.GetC3Detail(string wo,string licno);
       if (ds_L1 != null && ds_L1.Tables.Count > 0 && ds_L1.Tables[0].Rows.Count > 0)
       {
           C3_Records_Grid.DataSource = ds_L1.Tables[0];
           C3_Records_Grid.DataBind();
                       
       }
       else
       {
           MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Warning, "No Data Found !!!");
          
       }

   } and here is BL code -     public DataSet GetC3Detail(string LicNo,string wo)
     {
         string strSQL = "select * from App_Vendor_form_C3_Dtl  WHERE LL_NO = @LicNo and ";
         Dictionary<string, object> objParam = new Dictionary<string, object>();
         objParam.Add("LicNo", LicNo);
         DataHelper dh = new DataHelper();
         DataSet ds = new DataSet();
         ds = dh.GetDataset(strSQL, "App_Vendor_form_C3_Dtl", objParam);
         return ds;
     }
