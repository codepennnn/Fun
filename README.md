  <cc1:formcointainer ID="WorkOrder_Exemption_Record" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnNewRowCreatingEvent="WorkOrder_Exemption_Record_NewRowCreatingEvent"
                           PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>" 
                          DataMember="App_WorkOrder_Exemption" DataKeyNames="ID" 
                           BindingErrorMessage="aaaaaaaaa" GridLines="None"  OnPreRender="WorkOrder_Exemption_Record_PreRender" OnRowDataBound="WorkOrder_Exemption_Record_RowDataBound">
                           
                        <Columns>
                            <asp:TemplateField SortExpression="ID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="ID" runat="server" ></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <ItemTemplate>
                                <%--OnRowDataBound="WorkOrder_Exemption_Record_RowDataBound"--%>
                       
                                  <div class="form-inline row">

                                       <div class="form-group col-md-6 mb-1">
                                        <label for="VendorCode" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Vendor Code:<span style="color: #FF0000;">*</span></label>
                                        <asp:TextBox ID="VendorCode" runat="server" CssClass="form-control form-control-sm col-sm-6"  Enabled="false" ></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="VendorCode" ValidateEmptyText="true"></asp:CustomValidator>

                                     </div>

                                      <div class="form-group col-md-6 mb-1">
                                        <label for="VendorName" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Vendor Name:<span style="color: #FF0000;">*</span></label>
                                        <asp:TextBox ID="VendorName" runat="server" CssClass="form-control form-control-sm col-sm-6" Enabled="false"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="VendorName" ValidateEmptyText="true"></asp:CustomValidator>

                                     </div>
                                       </div>










                                    <div class="form-inline row">

                                        

                                       <%--<div class="form-group col-md-6 mb-1">
                                        <label for="WorkOrderNo" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">WorkOrder No.:
                                            <span style="color: #FF0000;">*</span></label>
                                        <asp:DropDownList ID="WorkOrderNo" runat="server" CssClass="form-control form-control-sm col-sm-6" DataMember="Exp_Wo_No" 
                                            DataSource="<%# PageDDLDataset %>" DataTextField="Workorder" DataValueField="WO_NO" SelectionMode="Multiple" >
                                            </asp:DropDownList>

                                     </div>--%>

                                      
                              <div class="form-group col-md-6 mb-2">
                                       <label for="lblWorkOrderNo" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5  font-weight-bold fs-6 justify-content-start">WorkOrder No.:
                                           <span style="color: #FF0000;">*</span></label>
                                           <div class="form-group col-md-6 mb-2" style="margin-left:-14px">
                                            <div>
                                          <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <div class="SearchCheckBoxList" style="width:287%;">
                                                          <button class="btn btn-sm btn-default selectArea w-100" type="button"  onclick="togglefloatDiv(this);" 
                                                              id="btn-dwn1" style="border:0.5px solid #ced2d5;">
                                                      <span  class="filter-option float-left">No item Selected</span>
                                                            <span class="caret" ></span>
                                                          </button>
                                                          <div class="floatDiv" runat="server"  style="border:1px solid #ced2d5;position:absolute;z-index:1000;
                                                            box-shadow:0 6px 12px rgb(0 0 0 / 18%);background-color:white;padding:5px;display:none;width:100%;">
                                                           <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control form-control-sm col-sm-12" 
                                                               oninput="filterCheckBox(this)" AutoComplete="off" ViewStateMode="Disabled" placeholder="Enter Workorder" Font-Size="Smaller" />
                                                    <div  style="overflow:auto;max-height:210px;overflow-y:auto;overflow-x:hidden"; class="searchList p-0" >
                                                                  <asp:CheckBoxList ID="WorkOrderNo" runat="server" DataMember="Exp_Wo_No" DataSource="<%# PageDDLDataset %>"
                                                                       DataTextField="Workorder"
                                                                     DataValueField="WO_NO"  CssClass="form-control-sm radio" >
                                             </asp:CheckBoxList>

                                                           </div>
                                                              <asp:TextBox runat="server" ID="TextBox3"  Width="0%" style="display:none" />
                                            </div>
                                                      </div>
                                                </ContentTemplate>
                                               </asp:UpdatePanel>
                                             </div>
                                          </div>
                              </div>

                                         







                                      <div class="form-group col-md-6 mb-1">
                                        <label for="Exemption_Vendor" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">No. Of Exemption Days:<span style="color: #FF0000;">*</span></label>
                                      
                                          <asp:TextBox ID="Exemption_Vendor" runat="server" CssClass="form-control form-control-sm col-sm-6" TextMode="Number"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator4" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="Exemption_Vendor" ValidateEmptyText="true"></asp:CustomValidator>
                                          <asp:RegularExpressionValidator ID="RegValue" runat="server" ControlToValidate="Exemption_Vendor" ValidationExpression="^\d+$" ErrorMessage="Please enter a positive integer value." ValidationGroup="Save" ForeColor="Red" Font-Size="Medium" ></asp:RegularExpressionValidator>
                                     </div>


                                        <div class="form-group col-md-12 mb-1">


                                               <label for="lblComplianceType" class="m-0 mr-5 p-0 col-form-label-sm col-sm-2  font-weight-bold fs-6 justify-content-start">Compliance Type:
                                                     <span style="color: #FF0000;">*</span>
                                                </label>


                                                <asp:CheckBoxList ID="ComplianceType" runat="server" 
                                                                     CssClass="form-control-sm radio col-sm-5"
                                                                     RepeatDirection="Horizontal">
                                                    <asp:ListItem> Wage</asp:ListItem>
                                                    <asp:ListItem> PF & ESI</asp:ListItem>
                                                    <asp:ListItem> Leave</asp:ListItem>
                                                    <asp:ListItem> Bonus</asp:ListItem>
                                                    <asp:ListItem> Labour License</asp:ListItem>
                                                    <asp:ListItem> Grievance</asp:ListItem>
                                                    <asp:ListItem> Notice</asp:ListItem>
                                                </asp:CheckBoxList>


                                            </div>







                                       </div>

                



                                           

                                        








                                      <div class="form-inline row">
                                        <div class="form-group col-md-8 mb-3">
                                        <label for="Remarks" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Remarks:<span style="color: #FF0000;">*</span></label>
                                         <asp:TextBox ID="Remarks" runat="server" CssClass="form-control form-control-sm col-sm-10" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="Remarks" ValidateEmptyText="true"></asp:CustomValidator>

                                        </div> 
                                     </div>

                                     <div class="form-inline row">
                                          <div class="form-group col-md-6 mb-2">
                                                <label for="lbl_Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start" >Attachment:</label>
                                        <asp:FileUpload ID="Attachment" runat="server" AllowMultiple="true" Font-Size="Small"/>
                                        <asp:BulletedList ID="Bull_Attach" runat="server" CssClass="font-smaller text-primary attachment-list" DisplayMode="HyperLink" Target="_blank"/>

                         
                                             <%--   <asp:Button ID="btndownload" runat="server" Text="Download" OnClick="btndownload_Click" />--%>
                                              </div>

                                 

                                        </div>
                               

                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <PagerSettings Visible="False" />
                    </cc1:formcointainer>
                       
