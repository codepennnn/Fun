    if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Return")
    {


        string getFileName = "";
        List<string> FileList = new List<string>();
        if (((FileUpload)Action_Record.Rows[0].FindControl("Attachment")).HasFile)
        {
            foreach (HttpPostedFile htfiles in ((FileUpload)Action_Record.Rows[0].FindControl("Attachment")).PostedFiles)
            {
                getFileName = PageRecordDataSet.Tables["App_WorkOrder_Exemption_remarks"].Rows[0]["ID"].ToString() + "_" + Path.GetFileName(htfiles.FileName);
                getFileName = Regex.Replace(getFileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");
                htfiles.SaveAs((@"D:/Cybersoft_Doc/CLMS/Attachments/" + getFileName));
                FileList.Add(getFileName);
            }
            PageRecordDataSet.Tables["App_WorkOrder_Exemption_remarks"].Rows[0]["Attachment"] = string.Join(",", FileList);
        }

    }

    string attachmentList = string.Join(",", remarkFiles);

    DataTable remarksTable = PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"];
    Guid masterID = Guid.Parse(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString());

    if (remarksTable.Rows.Count == 0)
    {
        DataRow newRow = remarksTable.NewRow();

        newRow["ID"] = Guid.NewGuid();

 
        newRow["MASTER_ID"] = masterID;
        newRow["Remarks"] = NewRemarks.Text;
        newRow["CreatedOn"] = DateTime.Now;
        newRow["CreatedBy"] = Session["UserName"].ToString();
        newRow["Attachment"] = attachmentList;

      
        remarksTable.Rows.Add(newRow);
    }
    else
    {
        remarksTable.Rows[0]["MASTER_ID"] = masterID;
        remarksTable.Rows[0]["Remarks"] = NewRemarks.Text;
        remarksTable.Rows[0]["CreatedOn"] = DateTime.Now;
        remarksTable.Rows[0]["CreatedBy"] = Session["UserName"].ToString();
    }



    <fieldset id="action" class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px">
    <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Action</b></legend>

    <cc1:FormCointainer ID="Action_Record" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>"
        DataMember="App_WorkOrder_Exemption" DataKeyNames="ID" 
         
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
                        <div class="form-group col-md-6 mb-1 mt-2">
                            <label for="Status" class="m-0 mr-0 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Action<span style="color: #FF0000;">*</span>:</label>
                            <asp:RadioButtonList ID="Status" runat="server" CssClass="form-check-input col-sm-8 radio" RepeatColumns="2" RepeatDirection="Horizontal" OnSelectedIndexChanged="Status_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Value="Approved">&nbsp&nbsp Approved</asp:ListItem>
                                <asp:ListItem Value="Return">&nbsp&nbsp Return</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="Status" ErrorMessage="Please Select Radiobutton !!" ValidationGroup="Save" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>

                    </div>
                    <br />

                    <div class="form-inline row">
                                <div id="div_exp_cc" runat="server" class="form-group col-md-4 mb-2">
                                    <label for="Exemption_CC" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">No. of Exemption days:<span style="color: #FF0000;">*</span></label>
                           
                                    <asp:TextBox ID="Exemption_CC" runat="server" CssClass="form-control form-control-sm col-sm-6" TextMode="Number"></asp:TextBox>
                           
                                    <asp:RegularExpressionValidator ID="RegValue" runat="server" ControlToValidate="Exemption_CC" ValidationExpression="^\d+$" ErrorMessage="Please enter a positive integer value." ValidationGroup="Save" ForeColor="Red" Font-Size="Medium"></asp:RegularExpressionValidator>
                                    <asp:CustomValidator ID="CustomValidator24" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="Exemption_CC" ValidateEmptyText="true"></asp:CustomValidator>
                                </div>


    
                                
                                </div>



                        </div>






                    
                    <div class="form-inline row">
                    <div class="form-group col-md-2 mb-2" id="WoDiv" runat="server">
                    <label for="lblWorkOrderNo" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">
                        WorkOrder No.: <span style="color: #FF0000;">*</span>
                    </label>
                         
                            <div class="SearchCheckBoxList" style="width:287%;">
                                <button class="btn btn-sm btn-default selectArea w-100" type="button" onclick="togglefloatDiv(this);" 
                                        id="btn-dwn1" style="border:0.5px solid #ced2d5;">
                                    <span class="filter-option float-left">No item Selected</span>
                                    <span class="caret"></span>
                                </button>
                                <div class="floatDiv" runat="server" style="border:1px solid #ced2d5; position:absolute; z-index:1000;
                                        box-shadow:0 6px 12px rgb(0 0 0 / 18%); background-color:white; padding:5px; display:none; width:100%;">
            
                                    <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control form-control-sm col-sm-6"  
                                                 oninput="filterCheckBox(this)" AutoComplete="off" ViewStateMode="Disabled" 
                                                 placeholder="Enter Workorder" Font-Size="Smaller" />
            
                                    <div style="overflow:auto; max-height:210px; overflow-y:auto; overflow-x:hidden;" class="searchList p-0">
                                        <asp:CheckBoxList ID="CC_WorkOrderNo" runat="server" DataMember="CC_Wo_No" DataSource="<%# PageDDLDataset %>"
                                                          DataTextField="WorkOrderNo" DataValueField="WorkOrderNo" CssClass="form-control-sm radio">
                                        </asp:CheckBoxList>
                                    </div>
            
                                    <asp:TextBox runat="server" ID="TextBox3" Width="0%" style="display:none" />
                                </div>
                            </div>
                              
                    </div>

                        </div>











               


                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
        <PagerSettings Visible="False" />
    </cc1:FormCointainer>


    
                    <div class="form-inline row">

                        <div id="div_newRemarks" runat="server" class="form-group col-md-10 mb-2">
                            <label for="lblRemarks" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Remarks:<span style="color: #FF0000;">*</span></label>
                            <asp:TextBox ID="NewRemarks" runat="server" CssClass="form-control form-control-sm col-sm-10" TextMode="MultiLine" Rows="2"></asp:TextBox>
                            <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="NewRemarks" ValidateEmptyText="true"></asp:CustomValidator>

                        </div>

                        </div>
                    

                         <div id="div_ReturnAttachment" class="form-inline row mt-2" runat="server" visible="false">
                             <div class="form-group col-md-6 mb-2">
                                 <label for="Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Return Attachment:</label>
                                 <asp:FileUpload ID="Attachment" runat="server" AllowMultiple="true" Font-Size="Small" />
                                 <asp:BulletedList ID="BulletedList1" runat="server" CssClass="font-smaller text-primary attachment-list" DisplayMode="HyperLink" Target="_blank" />

                             </div>

                      </div>

                 


</fieldset>
