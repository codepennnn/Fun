      <div class="">
          <asp:DropDownList ID="LocationCode" runat="server" CssClass="form-control form-control-sm textboxstyle"
              DataSource="<%# PageDDLDataset %>" DataMember="Locations_jhar_report" 
              DataTextField="Location" DataValueField="LocationCode"  
              OnSelectedIndexChanged="Location_SelectedIndexChanged" 
              AutoPostBack="true" ></asp:DropDownList>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator4" class="invalid-tooltip" ValidationGroup="Search" runat="server" ErrorMessage="Required" ControlToValidate="LocationCode" ForeColor="White" Font-Size="X-Small"></asp:RequiredFieldValidator>
      </div>
