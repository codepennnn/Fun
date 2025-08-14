<script>
document.getElementById('btnSave').addEventListener('click', function (e) {
    let isValid = true;

    // Reset borders
    ['V_Code', 'Block_unblock', 'Reason', 'Block_From', 'Block_To', 'Attachment_Vendor', 'Attachment_Dept']
    .forEach(id => {
        document.getElementById(id).style.border = '';
    });

    // Check required fields
    ['V_Code', 'Block_unblock', 'Reason', 'Block_From', 'Block_To']
    .forEach(id => {
        let el = document.getElementById(id);
        if (!el.value.trim()) {
            el.style.border = '2px solid red';
            isValid = false;
        }
    });

    // Check PDF files
    ['Attachment_Vendor', 'Attachment_Dept']
    .forEach(id => {
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
        e.preventDefault();
    }
});
</script>
