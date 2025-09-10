<div class="form-group row mb-3">
    <label for="ComplianceType" 
           class="col-sm-4 col-form-label col-form-label-sm font-weight-bold">
        Compliance Type: <span class="text-danger">*</span>
    </label>
    <div class="col-sm-8">
        <asp:CheckBoxList ID="ComplianceType" runat="server" 
                          CssClass="form-check"
                          RepeatLayout="Flow" 
                          RepeatDirection="Vertical">
            <asp:ListItem CssClass="form-check-input">Wage</asp:ListItem>
            <asp:ListItem CssClass="form-check-input">PF & ESI</asp:ListItem>
            <asp:ListItem CssClass="form-check-input">Leave</asp:ListItem>
            <asp:ListItem CssClass="form-check-input">Bonus</asp:ListItem>
            <asp:ListItem CssClass="form-check-input">Labour License</asp:ListItem>
            <asp:ListItem CssClass="form-check-input">Grievance</asp:ListItem>
            <asp:ListItem CssClass="form-check-input">Notice</asp:ListItem>
        </asp:CheckBoxList>
    </div>
</div>
