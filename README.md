<div class="form-group col-md-12 mb-1">
    <label class="m-0 mr-5 p-0 col-form-label-sm col-sm-2 font-weight-bold fs-6">
        Compliance Type: <span style="color:#FF0000;">*</span>
    </label>

    <asp:CheckBox ID="Wage"     CssClass="mr-2 compliance-check" runat="server" />
    <label class="form-check-label mr-3" for="Wage">Wage</label>

    <asp:CheckBox ID="PfEsi"    CssClass="mr-2 compliance-check" runat="server" />
    <label class="form-check-label mr-3" for="PfEsi">PF &amp; ESI</label>

    <asp:CheckBox ID="Leave"    CssClass="mr-2 compliance-check" runat="server" />
    <label class="form-check-label mr-3" for="Leave">Leave</label>

    <asp:CheckBox ID="Bonus"    CssClass="mr-2 compliance-check" runat="server" />
    <label class="form-check-label mr-3" for="Bonus">Bonus</label>

    <asp:CheckBox ID="LL"       CssClass="mr-2 compliance-check" runat="server" />
    <label class="form-check-label mr-3" for="LL">Labour License</label>

    <asp:CheckBox ID="Grievance" CssClass="mr-2 compliance-check" runat="server" />
    <label class="form-check-label mr-3" for="Grievance">Grievance</label>

    <asp:CheckBox ID="Notice"   CssClass="mr-2 compliance-check" runat="server" />
    <label class="form-check-label mr-3" for="Notice">Notice</label>
</div>

<asp:Button ID="btnSave" runat="server" Text="Save"
            CssClass="btn btn-primary"
            OnClientClick="return validateCompliance();" 
            OnClick="btnSave_Click" />
            
