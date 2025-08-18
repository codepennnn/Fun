     <div class="form-group col-md-4 col-margin mb-1">
         <asp:Label for="Reason" runat="server" CssClass="m-0 mr-2 p-0 col-form-label-sm col-sm-3 font-weight-bold fs-6">Reason:</asp:Label>
         <asp:DropDownList ID="Reason" runat="server" CssClass="form-control form-control-sm col-sm-8" OnSelectedIndexChanged="Reason_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
         <asp:TextBox ID="Status" runat="server" CssClass="form-control form-control-sm col-sm-8" Visible="false"></asp:TextBox>
     </div>
