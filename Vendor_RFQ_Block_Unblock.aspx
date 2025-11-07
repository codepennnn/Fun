<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Vendor_RFQ_Block_Unblock.aspx.cs" Inherits="CLMS.App.Input.Vendor_RFQ_Block_Unblock" %>

<%@ Register Assembly="CustomControls" Namespace="GridViewasContainer" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ask" %>
<%@ Register Src="~/Control/MyMsgBox.ascx" TagName="MyMsgBox" TagPrefix="uc1" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">




    <div class="card m-2 shadow-lg">
        <div>
            <uc1:MyMsgBox ID="MyMsgBox" runat="server" />
        </div>
        <div class="card-header bg-info text-light">
            <h6 class="m-0">Vendor RFQ Block Unblock</h6>
        </div>
        <div class="card-body pt-1">
            <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px">
                <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Details</b></legend>

                <cc1:FormCointainer ID="Vendor_Block_Unblock_RFQ_record" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>"
                    DataMember="App_RFQ_Block_Unblock" DataKeyNames="ID"
                    OnNewRowCreatingEvent="Vendor_Block_Unblock_RFQ_record_NewRowCreatingEvent"
                    BindingErrorMessage="aaaaaaaa" GridLines="None">
                    <Columns>
                        <asp:TemplateField SortExpression="ID" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="ID" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>

                                <div class="form-inline row">


                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="V_Code" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Vendor Code:</asp:Label>
                                        <asp:TextBox ID="V_Code" runat="server" autocomplete="off"  CssClass="form-control form-control-sm col-sm-8" OnTextChanged="V_Code_TextChanged" AutoPostBack="true" ></asp:TextBox>
                                    </div>


                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="V_Name" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Vendor Name:</asp:Label>
                                        <asp:TextBox ID="V_Name" runat="server" CssClass="form-control form-control-sm col-sm-8" Enabled="false"></asp:TextBox>
                                    </div>

                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="Block_unblock" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Block/unblock:</asp:Label>
                                        <asp:DropDownList ID="Block_unblock" runat="server"
                                            CssClass="form-control form-control-sm col-sm-8"
                                            OnSelectedIndexChanged="Block_unblock_SelectedIndexChanged"
                                            AutoPostBack="true">

                                            <asp:ListItem Text="--Select--" Value="M"></asp:ListItem>
                                            <asp:ListItem Text="Block" Value="RFQ_B"></asp:ListItem>
                                            <asp:ListItem Text="Unblock" Value="RFQ_U"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>



                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="Email" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Vendor Email:</asp:Label>
                                        <asp:TextBox ID="Email" runat="server" CssClass="form-control form-control-sm col-sm-8" Enabled="false"></asp:TextBox>
                                    </div>


              <%--                      <div class="form-group col-md-4 col-margin mb-1">
                                         <asp:Label for="CONTACT_NO" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Vendor CONTACT_NO:</asp:Label>
                                       <asp:TextBox ID="CONTACT_NO" runat="server" CssClass="form-control form-control-sm col-sm-8" Enabled="false"></asp:TextBox>
                                  </div>--%>



                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="Reason" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Reason:</asp:Label>
                                        <asp:DropDownList ID="Reason" runat="server"
                                             DataMember="RFQ_Reason" 

                                            DataTextField="Reason"
                                            DataValueField="Reason" 

                                            AutoPostBack="true"
                                            DataSource="<%# PageDDLDataset %>" 
                                            CssClass="form-control form-control-sm col-sm-8"
                                            OnSelectedIndexChanged="Reason_SelectedIndexChanged"
                                           ></asp:DropDownList>
                                        <asp:TextBox ID="Status" runat="server" CssClass="form-control form-control-sm col-sm-8" Visible="false"></asp:TextBox>
                                    </div>


                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="Internal_Remarks" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Remarks:</asp:Label>
                                        <asp:TextBox ID="Internal_Remarks" runat="server" autocomplete="off"  CssClass="form-control form-control-sm col-sm-8" Rows="2" TextMode="MultiLine"></asp:TextBox>
                                    </div>






                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="Block_From" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6"> From Date :</asp:Label>
                                        <asp:TextBox ID="Block_From" runat="server" autocomplete="off" CssClass="form-control form-control-sm col-sm-8"></asp:TextBox>
                                        <ask:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" Format="dd/MM/yyyy" PopupPosition="TopRight" TargetControlID="Block_From" TodaysDateFormat="dd/MM/yyyy"></ask:CalendarExtender>
                                    </div>


                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="Block_To" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">To Date:</asp:Label>
                                        <asp:TextBox ID="Block_To" runat="server"  autocomplete="off"  CssClass="form-control form-control-sm col-sm-8"></asp:TextBox>
                                        <ask:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" Format="dd/MM/yyyy" PopupPosition="TopRight" TargetControlID="Block_To" TodaysDateFormat="dd/MM/yyyy"></ask:CalendarExtender>
                                    </div>




                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="Createdon" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Action Date:</asp:Label>
                                        <asp:TextBox ID="Createdon" runat="server" CssClass="form-control form-control-sm col-sm-8" Enabled="false"></asp:TextBox>
                                    </div>


                                </div>

                                <div class="form-inline row mt-2">


                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="Createdby" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Action Taken By:</asp:Label>
                                        <asp:TextBox ID="Createdby" runat="server" CssClass="form-control form-control-sm col-sm-8" Enabled="false"></asp:TextBox>
                                    </div>



                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="Attachment_Vendor" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">For Vendor Purpose:</asp:Label>
                                        <asp:FileUpload ID="Attachment_Vendor" AllowMultiple="true" runat="server" />
                                    </div>


                                    <div class="form-group col-md-4 col-margin mb-1">
                                        <asp:Label for="Attachment_Dept" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">For Department Purpose:</asp:Label>
                                        <asp:FileUpload ID="Attachment_Dept" AllowMultiple="true" runat="server" />
                                    </div>






                                </div>



                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <PagerSettings Visible="False" />
                </cc1:FormCointainer>
            </fieldset>
        </div>
        <div class="row m-0 justify-content-center mt-1 mb-2 ">

            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" OnClientClick="return validate();" CssClass="btn btn-info btn-sm" Width="100px" />&nbsp
                          
        </div>



        <div class="w-100 border" style="height: 350px; overflow: auto">
            <cc1:DetailsContainer ID="Vendor_Block_Unblock_RFQ_recordsGrid" runat="server" AutoGenerateColumns="False"
                OnRowDataBound="Vendor_Block_Unblock_RFQ_recordsGrid_RowDataBound"
                AllowPaging="false" CellPadding="4" GridLines="None" Width="120%" DataMember="App_RFQ_Block_Unblock"
                DataKeyNames="ID" DataSource="<%# PageRecordsDataSet %>"
                ForeColor="#333333" ShowHeaderWhenEmpty="True"
                PageSize="8" PagerSettings-Visible="True" PagerStyle-HorizontalAlign="Center"
                PagerStyle-Wrap="false" HeaderStyle-Font-Size="Smaller" RowStyle-Font-Size="Smaller">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:TemplateField HeaderText="ID" SortExpression="ID" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="ID" runat="server" Visible="False"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Sl No." SortExpression="Sl_No"
                        HeaderStyle-Width="50px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate><%# Container.DataItemIndex + 1 + "."%></ItemTemplate>
                    </asp:TemplateField>


                    <asp:BoundField DataField="V_Code" HeaderText="Vendor Code"
                        SortExpression="V_Code" HeaderStyle-HorizontalAlign="Left"
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>

                    <asp:BoundField DataField="V_NAME" HeaderText="Vendor Name"
                        SortExpression="V_Name" HeaderStyle-HorizontalAlign="Left"
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Email" HeaderText="Vendor Email"
                        SortExpression="Email" HeaderStyle-HorizontalAlign="Left"
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CONTACT_NO" HeaderText="Contact No."
                        SortExpression="CONTACT_NO" HeaderStyle-HorizontalAlign="Left"
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Reason" HeaderText="Reason"
                        SortExpression="Reason" HeaderStyle-HorizontalAlign="Left"
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Status" HeaderText="Status"
                        SortExpression="Status" HeaderStyle-HorizontalAlign="Left"
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>

                    <asp:BoundField DataField="Internal_Remarks" HeaderText="Remarks"
                        SortExpression="Internal_Remarks" HeaderStyle-HorizontalAlign="Left"
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>


                    <asp:BoundField DataField="Block_From" HeaderText="From Date" ItemStyle-Width="200px"
                        SortExpression="Block_From" HeaderStyle-HorizontalAlign="Left"
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>



                    <asp:BoundField DataField="Block_To" HeaderText="To Date" ItemStyle-Width="200px"
                        SortExpression="Block_To" HeaderStyle-HorizontalAlign="Left"
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>





                       <asp:TemplateField HeaderText="For Department Purpose" SortExpression="Attachment_Dept" >
                                            <ItemTemplate>
                                                <asp:BulletedList runat="server" ID="Attachment_Dept" CssClass="attachment-list" DisplayMode="HyperLink" OnClick="Attachment_Dept_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField> 


                                      <%--   <asp:TemplateField HeaderText="For Vendor Purpose" SortExpression="Attachment_Vendor" >
                                            <ItemTemplate>
                                                <asp:BulletedList runat="server" CssClass="attachment-list" ID="Attachment_VendorLink" DisplayMode="HyperLink"/>
                                            </ItemTemplate>
                                        </asp:TemplateField> --%>


                    <asp:BoundField DataField="Createdon" HeaderText="Date" ItemStyle-Width="150px"
                        SortExpression="Createdon" HeaderStyle-HorizontalAlign="Left"
                        ItemStyle-HorizontalAlign="Left">
                        <HeaderStyle HorizontalAlign="Left" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:BoundField>



                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerSettings Mode="Numeric" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" Font-Bold="True" CssClass="pager1" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="true" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </cc1:DetailsContainer>
        </div>




    </div>

 <script>
     function validate() {

      

         let isValid = true;

       
         ['MainContent_Vendor_Block_Unblock_RFQ_record_V_Code_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Internal_Remarks_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Block_unblock_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Reason_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Block_From_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Block_To_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Attachment_Vendor_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Attachment_Dept_0']
             .forEach(id => {
                 let el = document.querySelector("[id$='" + id + "']");
                 if (el) el.style.border = '';
             });

       
         ['MainContent_Vendor_Block_Unblock_RFQ_record_V_Code_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Internal_Remarks_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Reason_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Block_From_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Block_To_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Attachment_Vendor_0',
             'MainContent_Vendor_Block_Unblock_RFQ_record_Attachment_Dept_0']
             .forEach(id => {
                 let el = document.querySelector("[id$='" + id + "']");
                 if (el && !el.value.trim()) {
                     el.style.border = '2px solid red';
                     isValid = false;
                 }
             });

         ['MainContent_Vendor_Block_Unblock_RFQ_record_Block_unblock_0','MainContent_Vendor_Block_Unblock_RFQ_record_Reason_0'].forEach(id => {
             let el = document.querySelector("[id$='" + id + "']");
             if (el) {
                 if (el.tagName === 'SELECT' && el.value === "M") {
                     el.style.border = '2px solid red';
                     isValid = false;
                 }
             }
         });





         ['MainContent_Vendor_Block_Unblock_RFQ_record_Attachment_Vendor_0', 'MainContent_Vendor_Block_Unblock_RFQ_record_Attachment_Dept_0']
             .forEach(id => {
                 let fileInput = document.querySelector("[id$='" + id + "']");
                 if (fileInput && fileInput.value) {
                     let ext = fileInput.value.split('.').pop().toLowerCase();
                     if (ext !== 'pdf') {
                         fileInput.style.border = '2px solid red';
                         alert("Please Provide Only PDF Attachment To Proceed !!!")
                         isValid = false;
                     }
                 }
             });

         return isValid; 
     }
</script>


 


    <asp:Literal ID="Literal1" runat="server"></asp:Literal>

</asp:Content>
