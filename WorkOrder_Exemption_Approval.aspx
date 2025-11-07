<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="WorkOrder_Exemption_Approval.aspx.cs" Inherits="CLMS.App.Input.WorkOrder_Exemption_Approval" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="CustomControls" Namespace="GridViewasContainer" TagPrefix="cc1" %>
<%@ Register Src="~/Control/MyMsgBox.ascx" TagName="MyMsgBox" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ask" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">




       <script type="text/javascript">

       document.addEventListener('DOMContentLoaded', function () {

       var allBox = document.querySelector('.select-all input[type="checkbox"]');
      
       var itemBoxes = document.querySelectorAll('.item-check input[type="checkbox"]');

  
       allBox.addEventListener('change', function () {
           itemBoxes.forEach(function (cb) {
               cb.checked = allBox.checked;
           });
       });

     
       itemBoxes.forEach(function (cb) {
           cb.addEventListener('change', function () {
        
               allBox.checked = Array.from(itemBoxes).every(function (c) { return c.checked; });
           });
       });
 


       });


       function validateCompliance() {
           
           var checks = document.querySelectorAll(".compliance-check input[type='checkbox']");
           var atLeastOne = Array.from(checks).some(cb => cb.checked);

           if (!atLeastOne) {
               alert("Please select at least one Compliance Type.");
               return false; 
           }
           return true; 
       }
       </script>
 





    <div>
        <uc1:MyMsgBox ID="MyMsgBox" runat="server" />
    </div>

      <div class="card m-2 shadow-lg">
        <div class="card-header bg-info text-light">
            <h6 class="m-0">Work order exemption for Billing Approval</h6>
        </div>
    </div>

    <div class="card-body pt-1">

             <fieldset class="" style="border:1px solid #bfbebe;padding:5px 20px 5px 20px;border-radius:6px">
                <legend style="width:auto;border:0;font-size:14px;margin:0px 6px 0px 6px;padding:0px 5px 0px 5px;color:#0000FF"><b> Search </b></legend>

                <div class="form-inline row">


                       <div class="form-group col-md-3 mb-1">
                                <label for="STATUS_search"  class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6" >Status:</label>
                                 <asp:DropDownList  ID="STATUS_search" runat="server" CssClass="form-control form-control-sm col-sm-8" >

                                              
                                 <asp:ListItem Value="Pending with CC">Pending with CC</asp:ListItem>
                                 <asp:ListItem Value="Approved">Approved</asp:ListItem>
                                 <asp:ListItem Value="Return">Return</asp:ListItem>        
                                                    
                                      </asp:DropDownList>
                                       </div>

                       <div class="form-group col-md-3 mb-1">
                                 <label for="Search_With"  class="m-0 mr-2 p-0 col-form-label-sm  font-weight-bold fs-6" >Search With:</label>
                                 <asp:DropDownList  ID="Search_With" runat="server" 
                                             CssClass="form-control form-control-sm col-sm-8" >
                                                    
                                                    <asp:ListItem Value=""></asp:ListItem>
                                                    <asp:ListItem Value="VendorCode">Vendor Code</asp:ListItem>
                                                    <asp:ListItem Value="WorkOrderNo">Workorder No.</asp:ListItem>
                                                 
                                                </asp:DropDownList>
                             </div>

                       <div class="form-group col-md-3 mb-1">
                                <label for="Enter_Detail" class="m-0 mr-0 p-0 col-form-label-sm col-sm-4 font-weight-bold fs-6">Enter Detail:</label>
                                <asp:TextBox ID="Enter_Detail" runat="server" CssClass="form-control form-control-sm col-sm-8"></asp:TextBox>
                            </div>


                    <div class="col-3">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-sm btn-success"  />&nbsp&nbsp
                    </div>


                     </div>
                 </fieldset>
           




         <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px; overflow: auto">
            <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: darkslategray"><b>Records</b></legend>
            
                   <div class="w-100 border" style="overflow:auto;height:250px;">
                <cc1:DetailsContainer ID="WorkOrder_Exemption_Records" runat="server" AutoGenerateColumns="False"
                    AllowPaging="true" CellPadding="4" GridLines="None" Width="100%" DataMember="App_WorkOrder_Exemption"
                    DataKeyNames="ID" DataSource="<%# PageRecordsDataSet %>"
                    ForeColor="#333333" ShowHeaderWhenEmpty="True" 
                    OnSelectedIndexChanged="WorkOrder_Exemption_Records_SelectedIndexChanged" PageSize="10" PagerSettings-Visible="True" PagerStyle-HorizontalAlign="Center"
                    PagerStyle-Wrap="False" HeaderStyle-Font-Size="Smaller" RowStyle-Font-Size="Smaller">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID" SortExpression="ID" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="ID" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Sl No." SortExpression="Sl_No"
                            HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate><%# Container.DataItemIndex + 1 + "."%> </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Created On" SortExpression="CreatedOn">
                            <ItemTemplate>
                                <asp:Label ID="CreatedOn" runat="server"></asp:Label>&nbsp
                            </ItemTemplate>
                        </asp:TemplateField>

                            <asp:TemplateField HeaderText="Days Count" SortExpression="dayscountCreatedOn">
                            <ItemTemplate>
                                <asp:Label ID="dayscountCreatedOn" runat="server"></asp:Label>&nbsp
                            </ItemTemplate>
                        </asp:TemplateField>

                        
                        <asp:TemplateField HeaderText="Resubmitted On" SortExpression="ResubmittedOn">
                            <ItemTemplate>
                                <asp:Label ID="ResubmittedOn" runat="server"></asp:Label>&nbsp
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Resubmitted Days Count" SortExpression="dayscountResub">
                            <ItemTemplate>
                                <asp:Label ID="dayscountResub" runat="server"></asp:Label>&nbsp
                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Vendor Code" SortExpression="VendorCode">
                            <ItemTemplate>
                                <asp:Label ID="VendorCode" runat="server"></asp:Label>&nbsp
                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:TemplateField HeaderText="Vendor Name" SortExpression="VendorName">
                            <ItemTemplate>
                                <asp:Label ID="VendorName" runat="server"></asp:Label>&nbsp
                            </ItemTemplate>
                        </asp:TemplateField>



                          <asp:TemplateField HeaderText="WorkOrder No." 
                               SortExpression="WorkOrderNo">
                               <ItemTemplate>
                               <B> <asp:LinkButton ID="LinkButton1"  runat="server"  CommandName="select" ForeColor="#003399" Text='<%# Bind("WorkOrderNo") %>' ></asp:LinkButton> </B>
                               </ItemTemplate>
                               <HeaderStyle HorizontalAlign="Left" />
                           </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status" SortExpression="Status">
                            <ItemTemplate>
                                <asp:Label ID="Status" runat="server"></asp:Label>&nbsp
                            </ItemTemplate>
                        </asp:TemplateField>


                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerSettings Mode="Numeric" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" CssClass="pager1" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="False" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </cc1:DetailsContainer>

            </div>
        </fieldset>


        
       <%-- formc--%>

        <%--<div id="DivInputFields" runat="server" >--%>
                  <fieldset class="" style="border:1px solid #bfbebe;padding:5px 20px 5px 20px;border-radius:6px">
                    <legend style="width:auto;border:0;font-size:14px;margin:0px 6px 0px 6px;padding:0px 5px 0px 5px;color:#0000FF"><b>Record</b></legend>
                       
                       <cc1:formcointainer ID="WorkOrder_Exemption_Record" runat="server" AllowPaging="True" AutoGenerateColumns="False" 
                           PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>" 
                          DataMember="App_WorkOrder_Exemption" DataKeyNames="ID" OnRowDataBound="WorkOrder_Exemption_Record_RowDataBound" 
                           BindingErrorMessage="aaaaaaaaa" GridLines="None" >
                           
                        <Columns>
                            <asp:TemplateField SortExpression="ID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="ID" runat="server" ></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <ItemTemplate>
                                
                       
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

                                       <div class="form-group col-md-6 mb-1">
                                        <label for="WorkOrderNo" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">WorkOrder No.:<span style="color: #FF0000;">*</span></label>
                                         <asp:TextBox ID="WorkOrderNo" runat="server" CssClass="form-control form-control-sm col-sm-6" Enabled="false"></asp:TextBox>

                                        <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="WorkOrderNo" ValidateEmptyText="true"></asp:CustomValidator>

                                     </div>

                                      <div class="form-group col-md-6 mb-1">
                                        <label for="Exemption_Vendor" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">No. Of Exemption Days:<span style="color: #FF0000;">*</span></label>
                                        <asp:TextBox ID="Exemption_Vendor" runat="server" CssClass="form-control form-control-sm col-sm-6" TextMode="Number" Enabled="false"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator4" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="Exemption_Vendor" ValidateEmptyText="true"></asp:CustomValidator>

                                     </div>




                                          <div class="form-group col-md-12 mb-1">

                                               <label for="lblComplianceType" class="m-0 mr-5 p-0 col-form-label-sm col-sm-2  font-weight-bold fs-6 justify-content-start">Compliance Type:
                                                     <span style="color: #FF0000;">*</span>
                                                </label>




                                                 <asp:CheckBox ID="All" CssClass="mr-2 compliance-check select-all" runat="server" />
                                            <label class="form-check-label mr-3" for="All">All</label>
                                               
                                        <asp:CheckBox ID="Wage"     CssClass="mr-2 compliance-check item-check" runat="server" />
                                        <label class="form-check-label mr-3" for="Wage">Wage</label>

                                        <asp:CheckBox ID="PfEsi"    CssClass="mr-2 compliance-check item-check" runat="server" />
                                        <label class="form-check-label mr-3" for="PfEsi">PF &amp; ESI</label>

                                        <asp:CheckBox ID="Leave"    CssClass="mr-2 compliance-check item-check" runat="server" />
                                        <label class="form-check-label mr-3" for="Leave">Leave</label>

                                        <asp:CheckBox ID="Bonus"    CssClass="mr-2 compliance-check item-check" runat="server" />
                                        <label class="form-check-label mr-3" for="Bonus">Bonus</label>

                                        <asp:CheckBox ID="LL"       CssClass="mr-2 compliance-check item-check" runat="server" />
                                        <label class="form-check-label mr-3" for="LL">Labour License</label>

                                        <asp:CheckBox ID="Grievance" CssClass="mr-2 compliance-check item-check" runat="server" />
                                        <label class="form-check-label mr-3" for="Grievance">Grievance</label>

                                        <asp:CheckBox ID="Notice"   CssClass="mr-2 compliance-check item-check" runat="server" />
                                        <label class="form-check-label mr-3" for="Notice">Notice</label>

                                     
                                   
                                                  

                                         </div>



                                       </div>

                
                                      


                                      <div class="form-inline row">
                                        <div class="form-group col-md-10 mb-2">
                                        <label for="Remarks" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Remarks:<span style="color: #FF0000;">*</span></label>
                                         <asp:TextBox ID="Remarks" runat="server" CssClass="form-control form-control-sm col-sm-10" TextMode="MultiLine" Enabled="false" Rows="2"></asp:TextBox>
                                    </div> 


                                        
                                         </div>

                                     <div class="form-inline row">
                                         
                                           <div class="form-group col-md-6 mb-2">
                                                <label for="lbl_Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start" >Attachment:</label>
                                         <asp:BulletedList ID="Bull_Attach" runat="server" CssClass="font-smaller text-primary attachment-list" DisplayMode="HyperLink" Target="_blank"/>
<%--                               <button id="AttachDownload" runat="server" class="btn btn-sm btn-warning" onserverclick="AttachDownload_ServerClick"><i class="fa fa-download"></i> | Download Attachment</button>--%>

                                               </div>
                                         </div>


                             



                                 
                                   

                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <PagerSettings Visible="False" />
                    </cc1:formcointainer>
 </fieldset>


                          <%--  <div id="div_RemarksGrid" runat="server">--%>
                  <fieldset class="" style="border:1px solid #bfbebe;padding:5px 20px 5px 20px;border-radius:6px">
                    <legend style="width:auto;border:0;font-size:14px;margin:0px 6px 0px 6px;padding:0px 5px 0px 5px;color:#0000FF"><b>Remarks History</b></legend>
       
                      <asp:GridView ID="Remarks_grid" runat="server" AutoGenerateColumns="false"
                          AllowPaging="false" CellPadding="0" GridLines="Both" Width="100%" 
                                    ForeColor="#333333" ShowHeaderWhenEmpty="False" OnRowDataBound="Remarks_grid_RowDataBound"
                                    PageSize="10" PagerSettings-Visible="false" PagerStyle-HorizontalAlign="Center" 
                                    PagerStyle-Wrap="True" HeaderStyle-Font-Size="Smaller" RowStyle-Font-Size="Small" CssClass="m-auto border border-info" 
                                    HeaderStyle-HorizontalAlign="Center"  RowStyle-ForeColor="Black" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"> 
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                              <Columns> 
                                    <asp:TemplateField  Visible="False">
                                            <ItemTemplate >
                                                <asp:Label ID="ID" runat="server"></asp:Label>
                                                
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" ItemStyle-Width="30" />    
                     
                              </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                                    <HeaderStyle BackColor="#328cda" Font-Bold="True" ForeColor="White" />
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

      
                    </fieldset>
    
             <fieldset id="action" class="" style="border:1px solid #bfbebe;padding:5px 20px 5px 20px;border-radius:6px">
                    <legend style="width:auto;border:0;font-size:14px;margin:0px 6px 0px 6px;padding:0px 5px 0px 5px;color:#0000FF"><b>Action</b></legend>

                  <cc1:formcointainer ID="Action_Record" runat="server" AllowPaging="True" AutoGenerateColumns="False" 
                           PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>" 
                          DataMember="App_WorkOrder_Exemption" DataKeyNames="ID" 
                           BindingErrorMessage="aaaaaaaaa" GridLines="None" >
                           
                        <Columns>
                            <asp:TemplateField SortExpression="ID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="ID" runat="server" ></asp:Label>
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
                         <div  id="div_exp_cc" runat="server" class="form-group col-md-4 mb-2">
                         <label for="Exemption_CC" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">No. of Exemption days:<span style="color: #FF0000;">*</span></label>
                         <asp:TextBox ID="Exemption_CC" runat="server" CssClass="form-control form-control-sm col-sm-6" TextMode="Number"></asp:TextBox>
                         <asp:RegularExpressionValidator ID="RegValue" runat="server" ControlToValidate="Exemption_CC" ValidationExpression="^\d+$" ErrorMessage="Please enter a positive integer value." ValidationGroup="Save" ForeColor="Red" Font-Size="Medium" ></asp:RegularExpressionValidator>
                          <asp:CustomValidator ID="CustomValidator24" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="Exemption_CC" ValidateEmptyText="true"></asp:CustomValidator>
                    </div>         

                       
                     <div id="div_newRemarks" runat="server" class="form-group col-md-10 mb-2">
                     <label for="lblRemarks" class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">Remarks:<span style="color: #FF0000;">*</span></label>
                     <asp:TextBox ID="NewRemarks" runat="server" CssClass="form-control form-control-sm col-sm-10" TextMode="MultiLine"  Rows="2"></asp:TextBox>
                    <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="Validate" ValidationGroup="Save" ControlToValidate="NewRemarks" ValidateEmptyText="true"></asp:CustomValidator>

                         </div>   
                        

                         </div>

                     <div id="div_ReturnAttachment" class="form-inline row mt-2" runat="server" visible="false"> 
             <div class="form-group col-md-6 mb-2">
         <label for="Return_Attachment" class="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6 justify-content-start" >Return Attachment:</label>
             <asp:FileUpload ID="ReturnAttachment" runat="server" AllowMultiple="true" Font-Size="Small"/>
             <asp:BulletedList ID="BulletedList1" runat="server" CssClass="font-smaller text-primary attachment-list" DisplayMode="HyperLink" Target="_blank"/>
                              
    
                     </div>
       </div>











                                     </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <PagerSettings Visible="False" />
                    </cc1:formcointainer>
                 </fieldset>
              

   



                   <div class="row m-0 justify-content-center mt-2">
                          <asp:Button ID="btnSave" runat="server"  Text="Submit" OnClick="btnSave_Click" CssClass="btn btn-sm btn-info" ValidationGroup="Save"/>
                   
                      </div>

                      
        </div>
</asp:Content>
