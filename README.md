      <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px">
          <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Search</b></legend>
          <div class="form-inline row">
              <div class="form-group col-md-3 mb-1">
                  <label for="txtDivision" class="m-0 mr-5 p-0 col-form-label-sm  font-weight-bold fs-6">Division:</label>
                  <asp:DropDownList ID="txtDivision" runat="server" CssClass="form-control form-control-sm"
                      DataSource="<%# PageDDLDataset %>" DataMember="txtDivision"
                      DataTextField="ema_exec_head_desc" DataValueField="ema_exec_head_desc"
                      OnSelectedIndexChanged="division_SelectedIndexChanged"
                      AutoPostBack="true">
                  </asp:DropDownList>
              </div>
              <div class="form-group col-md-3 mb-1">
                  <label for="txtDepartment" class="m-0 mr-5 p-0 col-form-label-sm  font-weight-bold fs-6">Department:</label>
                  <asp:DropDownList ID="txtDepartment" runat="server" CssClass="form-control form-control-sm"
                      DataSource="<%# PageDDLDataset %>" DataMember="txtDepartment"
                      DataTextField="ema_dept_desc" DataValueField="ema_dept_desc"
                      OnSelectedIndexChanged="department_SelectedIndexChanged"
                      AutoPostBack="true">
                  </asp:DropDownList>
              </div>
              <div class="form-group col-md-3 mb-1">
                  <label for="txtSection" class="m-0 mr-5 p-0 col-form-label-sm  font-weight-bold fs-6">Section:</label>
                  <asp:DropDownList ID="txtSection" runat="server" CssClass="form-control form-control-sm"
                      DataSource="<%# PageDDLDataset %>" DataMember="txtSection"
                      DataTextField="ema_section_desc" DataValueField="ema_section_desc"
                      AutoPostBack="true">
                  </asp:DropDownList>
              </div>
              <div class="form-group col-md-3 mb-1">
                   <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="BtnSearch_Click" CssClass="btn btn-sm btn-info" />
              </div>
          </div>
      </fieldset>


                    <cc1:formcointainer ID="HOD_Record" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                  OnNewRowCreatingEvent="HOD_Record_NewRowCreatingEvent"
                  PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>"
                  DataMember="App_HOD_Master" DataKeyNames="ID"
                  BindingErrorMessage="aaaaaaaaa" GridLines="None">
                  <Columns>
                      <asp:TemplateField SortExpression="ID" Visible="False">
                          <ItemTemplate>
                              <asp:Label ID="ID" runat="server"></asp:Label>
                          </ItemTemplate>
                      </asp:TemplateField>

                      <asp:TemplateField>
                          <ItemTemplate>
                              <div class="form-inline row">
                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Division :</label>
                                      <asp:TextBox ID="Division" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>
                              </div>

                              <div class="form-inline row">
                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">HOD PNO :<span class="text-danger">*</span></label>
                                      <asp:TextBox ID="Div_HOD_Pno" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>

                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">HOD Name :</label>
                                      <asp:TextBox ID="Div_HOD_Name" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>

                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">HOD Email :</label>
                                      <asp:TextBox ID="Div_HOD_Email" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>
                              </div>

                              <div class="form-inline row">
                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Department :</label>
                                      <asp:TextBox ID="Department" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>
                              </div>

                              <div class="form-inline row">
                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">HOD PNO :<span class="text-danger">*</span></label>
                                      <asp:TextBox ID="Dept_HOD_Pno" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>

                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">HOD Name :</label>
                                      <asp:TextBox ID="Dept_HOD_Name" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>

                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">HOD Email :</label>
                                      <asp:TextBox ID="Dept_HOD_Email" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>
                              </div>

                              <div class="form-inline row">
                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Section :</label>
                                      <asp:TextBox ID="Section" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>
                              </div>

                              <div class="form-inline row">
                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">HOD PNO :<span class="text-danger">*</span></label>
                                      <asp:TextBox ID="Sect_HOD_Pno" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>

                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">HOD Name :</span></label>
                                      <asp:TextBox ID="Sect_HOD_Name" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>

                                  <div class="form-group col-md-4 mb-1">
                                      <label class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">HOD Email :</span></label>
                                      <asp:TextBox ID="Sect_HOD_Email" runat="server" CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"> </asp:TextBox>
                                  </div>
                              </div>

                          </ItemTemplate>
                      </asp:TemplateField>

                  </Columns>
              <PagerSettings Visible="False" />
</cc1:formcointainer>


  protected void Page_Load(object sender, EventArgs e)
  {
     //HOD_Records.DataSource = PageRecordsDataSet;
      HOD_Record.DataSource = PageRecordDataSet;
      //Deployment_Records.DataSource = PageRecordsDataSet;
      //  HOD_Record.DataSource = PageRecordDataSet;
      if (!IsPostBack)
      {
      
          Dictionary<string, object> objParam = new Dictionary<string, object>();
          GetDropdowns("txtDivision");
          objParam.Add("txtDivision", "");
       
      
          txtDivision.DataBind();
         // GetRecords(GetFilterCondition(), Deployment_Records.PageSize, 10, "");
         // Deployment_Records.DataBind();
         // btnSave.Visible = false;

      }
  }


       protected void BtnSearch_Click(object sender, EventArgs e)
     {
         //string division = txtDivision.SelectedItem.Text;
         //txtDivision.Text = division;

         //string reason = txtDivision.SelectedValue;
         // String id = "";
         // String find = btnSearch.Text.Substring(btnSearch.Text.LastIndexOf("-") + 1);
         // PageRecordDataSet.Clear();
         // PageRecordDataSet.EnforceConstraints = false;
         HOD_Record.NewRecord();
         HOD_Record.DataBind();
         txtDivision.Text = txtDivision.SelectedItem.Text;
         //TextBox div = (TextBox)HOD_Record.Rows[0].FindControl("Division");
         //div.Text = reason;

         DataSet ds1 = new DataSet();
         BL_HOD_Master blobj = new BL_HOD_Master();
       //  ds1 = blobj.Get_Division_Code(find);
     }

     when i search my form should appear with filled selected dropdown data in my textbox
