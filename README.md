<script type="text/javascript">
document.getElementById('<%= btnSave.ClientID %>').addEventListener('click', function (e) {
    let isValid = true;

    // Reset all borders first
    document.querySelectorAll('input, select').forEach(el => {
        el.style.border = '';
    });

    // Required fields (use ClientID so they match rendered HTML IDs)
    let requiredFields = [
        document.getElementById('<%= V_Code.ClientID %>'),
        document.getElementById('<%= Block_unblock.ClientID %>'),
        document.getElementById('<%= Reason.ClientID %>'),
        document.getElementById('<%= Block_From.ClientID %>'),
        document.getElementById('<%= Block_To.ClientID %>')
    ];

    requiredFields.forEach(field => {
        if (field && !field.value.trim()) {
            field.style.border = '2px solid red';
            isValid = false;
        }
    });

    // PDF attachment check
    let fileFields = [
        document.getElementById('<%= Attachment_Vendor.ClientID %>'),
        document.getElementById('<%= Attachment_Dept.ClientID %>')
    ];
    fileFields.forEach(fileInput => {
        if (fileInput && fileInput.value) {
            let ext = fileInput.value.split('.').pop().toLowerCase();
            if (ext !== 'pdf') {
                fileInput.style.border = '2px solid red';
                isValid = false;
            }
        }
    });

    if (!isValid) {
        e.preventDefault(); // Stop form submission
    }
});
</script>
