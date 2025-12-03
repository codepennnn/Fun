   ((Button)Half_Yearly_Record.Rows[0].FindControl("btnSave")).Visible=false;

   System.ArgumentOutOfRangeException: 'Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index'

             <cc1:FormCointainer ID="Half_Yearly_Record" runat="server" AllowPaging="True" AutoGenerateColumns="False"
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
                                             <div class="form-group col-md-6 mb-1 mt-2">
                                                 <label for="Status" class="m-0 mr-0 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start">Action<span style="color: #FF0000;">*</span>:</label>
                                                 <asp:RadioButtonList ID="Status" runat="server" CssClass="form-check-input col-sm-8 radio" RepeatColumns="2" RepeatDirection="Horizontal">
                                                     <asp:ListItem Value="Approved">&nbsp&nbsp Approved</asp:ListItem>
                                                     <asp:ListItem Value="Return">&nbsp&nbsp Return</asp:ListItem>
                                                 </asp:RadioButtonList>
                                                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="Status" ErrorMessage="Please Select Radiobutton !!" ValidationGroup="Save" ForeColor="Red"></asp:RequiredFieldValidator>
                                             </div>

                                         </div>




                                         <div class="form-inline row">
                                             <div class="form-group col-md-8 mb-3">
                                                 <label for="Remarks" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Remarks:<span style="color: #FF0000;">*</span></label>
                                                 <asp:TextBox ID="Remarks" runat="server" CssClass="form-control form-control-sm col-sm-10" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                 <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="Remarks" ValidateEmptyText="true"></asp:CustomValidator>

                                             </div>
                                         </div>

                                      
                                            <asp:Button ID="btnSave" runat="server" Text="Submit" Style="margin-top: 4px;" CssClass="btn btn-sm btn-primary" OnClick="btnSave_Click" ValidationGroup="Save" />
                                       

                                     </ItemTemplate>
                                 </asp:TemplateField>

                             </Columns>
                     <PagerSettings Visible="False" />
                 </cc1:FormCointainer>
