<script type="text/javascript">
    function validateCompliance() {
        // Find all compliance checkboxes by class
        var checks = document.querySelectorAll(".compliance-check");
        var atLeastOne = Array.from(checks).some(cb => cb.checked);

        if (!atLeastOne) {
            alert("Please select at least one Compliance Type.");
            return false; // stops form submission
        }
        return true; // allow postback
    }
</script>


<asp:Button ID="btnSave" runat="server" Text="Save" 
            CssClass="btn btn-primary"
            OnClientClick="return validateCompliance();" 
            OnClick="btnSave_Click" />
