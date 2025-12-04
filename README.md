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
                            <div class="form-group col-md-4 mb-2">
                                <label for="lbl_Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Upload Attachment:</label>
                                <asp:FileUpload ID="Final_Attachment" runat="server" AllowMultiple="true" Font-Size="Small" />
                                <asp:BulletedList ID="Bull_Attach" runat="server" CssClass="font-smaller text-primary attachment-list" DisplayMode="HyperLink" Target="_blank" />


                            </div>
                            <div class="form-group col-md-2">
                                <asp:Button ID="btnSave" runat="server" Text="Upload" Style="margin-top: 4px;" CssClass="btn btn-sm btn-warning" OnClick="btnSave_Click" OnClientClick="return validateCompliance();" />
                            </div>


                        </div>
                           
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
            <PagerSettings Visible="False" />
        </cc1:FormCointainer>



  protected void Search_Click(object sender, EventArgs e)
  {
      if (Session["UserName"] == null)
          return;

      string vcode = Session["UserName"].ToString();
      int year = Convert.ToInt32(Year.SelectedValue);
      string period = SearchPeriod.SelectedValue;

      BL_Half_Yearly blobj = new BL_Half_Yearly();

     
      DataSet dsRef = blobj.Get_Ref_NoDDL(vcode, period, year);

    
      if (dsRef == null || dsRef.Tables[0].Rows.Count == 0)
      {

          SearchLLBtn.Enabled = false;

          MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
              "No record found! Please submit Half Yearly Entry first, then upload attachment.");

          return;
      }

   
      divLL.Style["display"] = "flex";
      SearchLLBtn.Visible = true;

      BindRefNoDropdown(dsRef);


      string latestRefNo = dsRef.Tables[0].Rows[0]["RefNo"].ToString();

    
      DataSet dsStatus = blobj.Get_Data_By_RefNo(latestRefNo, vcode);

      if (dsStatus.Tables[0].Rows.Count > 0)
      {
          string status = dsStatus.Tables[0].Rows[0]["Status"].ToString();

      
          if (status == "Approved" || status == "Pending With CC")
          {
              SearchLLBtn.Enabled = false;

              MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
                  "This record is already " + status + ". You cannot upload again.");
          }
          else
          {
              SearchLLBtn.Enabled = true;
          }
      }
  }



  protected void SearchLLBtn_Click(object sender, EventArgs e)
  {
      
      if (string.IsNullOrEmpty(SearchLL.SelectedValue))
      {
          divLL.Style["display"] = "flex";

          MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
                        "Please select a Ref No first.");
          return;
      }

 
      PageRecordDataSet.EnforceConstraints = false;

      string refno = SearchLL.SelectedValue;
      string vcode = Session["UserName"].ToString();

      BL_Half_Yearly blobj = new BL_Half_Yearly();
      DataSet ds = blobj.Get_Data_By_RefNo(refno, vcode);

    
      PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();
      PageRecordDataSet.Merge(ds);

 
      Upload_Half_Yearly_Record.Visible = true;
      Upload_Half_Yearly_Record.BindData();

 
      divLL.Style["display"] = "flex";
  }





    </fieldset>
    </div>
