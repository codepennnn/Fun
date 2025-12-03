  <div class="card-body pt-1">
      <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px; overflow: auto">
          <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: darkslategray"><b>Upload License</b></legend>


          <div class="form-inline row">


              <div class="form-group col-md-4" runat="server" id="divLL" style="display:none;">
                  <label for="lblSearchLL" class="m-0 mr-0 p-0 col-form-label-sm col-sm-1 font-weight-bold fs-6">Select Ref No:</label>
                  <asp:DropDownList ID="SearchLL" runat="server"
                      CssClass="form-control form-control-sm col-sm-6">

                      <asp:ListItem Value=""></asp:ListItem>


                  </asp:DropDownList>


              </div>

                <div class="form-group col-md-2">
                <asp:Button ID="SearchLLBtn" runat="server" Text="Search" Style="margin-top: 4px;" CssClass="btn btn-sm btn-primary" OnClick="SearchLLBtn_Click" Visible="false" />
            </div>



          </div>

          <br />

          <cc1:FormCointainer ID="Upload_Half_Yearly_Record" runat="server" AllowPaging="True" AutoGenerateColumns="False"
              PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>"
              DataMember="App_Half_Yearly_Details" DataKeyNames="ID"
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
                              <div class="form-group col-md-6 mb-2">
                                  <label for="lbl_Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Upload Attachment:</label>
                                  <asp:FileUpload ID="Final_Attachment" runat="server" AllowMultiple="true" Font-Size="Small" />
                                  <asp:BulletedList ID="Bull_Attach" runat="server" CssClass="font-smaller text-primary attachment-list" DisplayMode="HyperLink" Target="_blank" />


                              </div>



                          </div>

                           <asp:Button ID="btnSave" runat="server" Text="Upload" Style="margin-top: 4px;" CssClass="btn btn-sm btn-primary" OnClick="btnSave_Click" OnClientClick="return validateCompliance();" />

                      </ItemTemplate>
                  </asp:TemplateField>

              </Columns>
              <PagerSettings Visible="False" />
          </cc1:FormCointainer>


  protected void SearchLLBtn_Click(object sender, EventArgs e)
  {
      PageRecordDataSet.EnforceConstraints = false;
      Upload_Half_Yearly_Record.NewRecord();
      Upload_Half_Yearly_Record.BindData();
      string script14 = "document.getElementById('" + divLL.ClientID + "').style.display = 'flex';";
      ScriptManager.RegisterStartupScript(this, this.GetType(), "showBtnExportsum14", script14, true);
      SearchLLBtn.Visible = true;


  }



      </fieldset>
      </div>
