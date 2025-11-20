    protected void WorkOrder_Exemption_Record_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (WorkOrder_Exemption_Record.Rows.Count > 0)
        {

                TextBox txtWO = (TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo");

                CheckBoxList chkWO = (CheckBoxList)Action_Record.Rows[0].FindControl("cc_wo");

                if (chkWO != null)
                    chkWO.Items.Clear();

                if (txtWO != null && !string.IsNullOrWhiteSpace(txtWO.Text))
                {
                    string[] workorders = txtWO.Text.Split(new char[] { ',', '|' },
                                                           StringSplitOptions.RemoveEmptyEntries);

                    foreach (string wo in workorders)
                    {
                        chkWO.Items.Add(new ListItem(wo.Trim(), wo.Trim()));
                    }

                    foreach (ListItem item in chkWO.Items)
                        item.Selected = true;
                }

                
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


                                <div id="div_newRemarks" runat="server" class="form-group col-md-10 mb-2">
                                    <label for="lblRemarks" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Remarks:<span style="color: #FF0000;">*</span></label>
                                    <asp:TextBox ID="NewRemarks" runat="server" CssClass="form-control form-control-sm col-sm-10" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                    <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="NewRemarks" ValidateEmptyText="true"></asp:CustomValidator>

                                </div>


                            </div>






                          <div class="form-group col-md-6 mb-2">
                                <label for="lblWorkOrderNo" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5  font-weight-bold fs-6 justify-content-start">WorkOrder No.:
                                    <span style="color: #FF0000;">*</span></label>
                                <div class="form-group col-md-6 mb-2" style="margin-left:-14px">
                                    <div>
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <div class="SearchCheckBoxList" style="width:287%;">
                                                    <button class="btn btn-sm btn-default selectArea w-100" type="button" onclick="togglefloatDiv(this);" id="btn-dwn1" style="border:0.5px solid #ced2d5;">
                                                        <span class="filter-option float-left">No item Selected</span>
                                                        <span class="caret"></span>
                                                    </button>
                                                    <div class="floatDiv" runat="server" style="border:1px solid #ced2d5;position:absolute;z-index:1000;
                                                                                        box-shadow:0 6px 12px rgb(0 0 0 / 18%);background-color:white;padding:5px;display:none;width:100%;">
                                                        <asp:TextBox runat="server" ID="CC_WorkOrderNo" CssClass="form-control form-control-sm col-sm-12" oninput="filterCheckBox(this)" AutoComplete="off" ViewStateMode="Disabled" placeholder="Enter Workorder" Font-Size="Smaller" />
                                                        <div style="overflow:auto;max-height:210px;overflow-y:auto;overflow-x:hidden" ; class="searchList p-0">
                                                            <asp:CheckBoxList ID="cc_wo" runat="server"  CssClass="form-control-sm radio">
                                                            </asp:CheckBoxList>

                                                        </div>
                                                        <asp:TextBox runat="server" ID="TextBox3" Width="0%" style="display:none" />
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>







                            <div id="div_ReturnAttachment" class="form-inline row mt-2" runat="server" visible="false">
                                <div class="form-group col-md-6 mb-2">
                                    <label for="Return_Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Return Attachment:</label>
                                    <asp:FileUpload ID="ReturnAttachment" runat="server" AllowMultiple="true" Font-Size="Small" />
                                    <asp:BulletedList ID="BulletedList1" runat="server" CssClass="font-smaller text-primary attachment-list" DisplayMode="HyperLink" Target="_blank" />


                                </div>
                            </div>











                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
                <PagerSettings Visible="False" />
            </cc1:FormCointainer>
