<div class="form-group col-md-6 mb-2">
    <label for="lblComplianceType" 
           class="m-0 mr-2 p-0 col-form-label-sm col-sm-5 font-weight-bold fs-6 justify-content-start">
        Compliance Type: <span style="color: #FF0000;">*</span>
    </label>

    <div class="form-group col-md-6 mb-2" style="margin-left:-14px">
        <asp:RadioButtonList ID="ComplianceType" runat="server" 
                             CssClass="form-control-sm radio"
                             RepeatDirection="Vertical">
            <asp:ListItem>Wage</asp:ListItem>
            <asp:ListItem>PF & ESI</asp:ListItem>
            <asp:ListItem>Leave</asp:ListItem>
            <asp:ListItem>Bonus</asp:ListItem>
            <asp:ListItem>Labour License</asp:ListItem>
            <asp:ListItem>Grievance</asp:ListItem>
            <asp:ListItem>Notice</asp:ListItem>
        </asp:RadioButtonList>
    </div>
</div>
