<cc1:FormCointainer ID="Vendor_Block_Unblock_RFQ_record" runat="server" AllowPaging="True" AutoGenerateColumns="False"
    PageSize="1" ShowHeader="False" Width="100%" DataSource="<%# PageRecordDataSet %>"
     DataMember="App_RFQ_Block_Unblock" DataKeyNames="ID"
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

             
                        <div class="form-group col-md-3 col-margin mb-1">
                         <asp:Label for="V_Code" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Vendor Code:</asp:Label>
                         <asp:TextBox ID="V_Code" runat="server" CssClass="form-control form-control-sm col-sm-8" AutoPostBack="true"></asp:TextBox>
                       </div>


                     <div class="form-group col-md-3 col-margin mb-1">
                     <asp:Label for="V_Name" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Vendor Name:</asp:Label>
                     <asp:TextBox ID="V_Name" runat="server" CssClass="form-control form-control-sm col-sm-8" Enabled="false"></asp:TextBox>
                 </div>

                    <div class="form-group col-md-6 col-margin mb-1">
                        <asp:Label for="Block_unblock" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Block/unblock:</asp:Label>
                        <asp:DropDownList ID="Block_unblock" runat="server" CssClass="form-control form-control-sm col-sm-8"  AutoPostBack="true">
                            <asp:ListItem Text="--Select--" Value="M"></asp:ListItem>
                            <asp:ListItem Text="Block" Value="Block"></asp:ListItem>
                            <asp:ListItem Text="Unblock" Value="Unblock"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

               
                   
                    <div class="form-group col-md-4 col-margin mb-1">
                        <asp:Label for="Email" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Vendor Email:</asp:Label>
                        <asp:TextBox ID="Email" runat="server" CssClass="form-control form-control-sm col-sm-8" Enabled="false"></asp:TextBox>
                    </div>



                    <div class="form-group col-md-4 col-margin mb-1">
                        <asp:Label for="Reason" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Reason:</asp:Label>
                        <asp:DropDownList ID="ReasonDropdown" runat="server" CssClass="form-control form-control-sm col-sm-8"  AutoPostBack="true"></asp:DropDownList>
                        <asp:TextBox ID="Reason" runat="server" CssClass="form-control form-control-sm col-sm-8" Visible="false"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-4 col-margin mb-1">
                        <asp:Label for="Internal_Remarks" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Remarks:</asp:Label>
                        <asp:TextBox ID="Internal_Remarks" runat="server" CssClass="form-control form-control-sm col-sm-8" Rows="2" TextMode="MultiLine"></asp:TextBox>
                    </div>




                    <div class="form-group col-md-4 col-margin mb-1">
                        <asp:Label for="Attachment_Vendor" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">For Department Purpose:</asp:Label>
                        <asp:FileUpload ID="Attachment_Vendor" runat="server" />
                    </div>
                   

                          <div class="form-group col-md-4 col-margin mb-1">
                          <asp:Label for="Attachment_Dept" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">For Department Purpose:</asp:Label>
                          <asp:FileUpload ID="Attachment_Dept" runat="server" />
                      </div>

                    <div class="form-group col-md-4 col-margin mb-1">
                        <asp:Label for="Block_From" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Target Date For Unblock :</asp:Label>
                        <asp:TextBox ID="Block_From" runat="server" CssClass="form-control form-control-sm col-sm-8"></asp:TextBox>
                        <ask:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" Format="dd/MM/yyyy" PopupPosition="TopRight" TargetControlID="T_Date" TodaysDateFormat="dd/MM/yyyy"></ask:CalendarExtender>
                    </div>
                

                       <div class="form-group col-md-4 col-margin mb-1">
                       <asp:Label for="Block_To" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Target Date For Unblock :</asp:Label>
                       <asp:TextBox ID="Block_To" runat="server" CssClass="form-control form-control-sm col-sm-8"></asp:TextBox>
                       <ask:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" Format="dd/MM/yyyy" PopupPosition="TopRight" TargetControlID="T_Date" TodaysDateFormat="dd/MM/yyyy"></ask:CalendarExtender>
                   </div>
                
                
                
                </div>

                <div class="form-inline row">
                    <div class="form-group col-md-6 col-margin mb-1">
                        <asp:Label for="Createdby" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Action Taken By:</asp:Label>
                        <asp:TextBox ID="Createdby" runat="server" CssClass="form-control form-control-sm col-sm-8" Enabled="false"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-6 col-margin mb-1">
                        <asp:Label for="Createdon" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Action Date:</asp:Label>
                        <asp:TextBox ID="Createdon" runat="server" CssClass="form-control form-control-sm col-sm-8" Enabled="false"></asp:TextBox>
                    </div>
                </div>



            </ItemTemplate>
        </asp:TemplateField>
    </Columns>

    <PagerSettings Visible="False" />
</cc1:FormCointainer>
