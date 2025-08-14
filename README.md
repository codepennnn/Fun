<script>
document.getElementById('<%= btnSave.ClientID %>').addEventListener('click', function (e) {
    let isValid = true;

    // Reset all borders first
    document.querySelectorAll('input, select').forEach(el => {
        el.style.border = '';
    });

    // Required fields
    let requiredFields = [
        '<%= V_Code.ClientID %>',
        '<%= Block_unblock.ClientID %>',
        '<%= Reason.ClientID %>',
        '<%= Block_From.ClientID %>',
        '<%= Block_To.ClientID %>'
    ];

    requiredFields.forEach(id => {
        let field = document.getElementById(id);
        if (!field.value.trim()) {
            field.style.border = '2px solid red';
            isValid = false;
        }
    });

    // PDF attachment check
    let fileFields = [
        '<%= Attachment_Vendor.ClientID %>',
        '<%= Attachment_Dept.ClientID %>'
    ];
    fileFields.forEach(id => {
        let fileInput = document.getElementById(id);
        if (fileInput.value) {
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
