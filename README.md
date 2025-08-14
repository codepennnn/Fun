l<script>
document.addEventListener("DOMContentLoaded", function () {
    // Get the first (and only) form on the page
    let form = document.forms[0]; 

    form.onsubmit = function () {
        let isValid = true;

        // Reset borders
        ['V_Code', 'Block_unblock', 'Reason', 'Block_From', 'Block_To', 'Attachment_Vendor', 'Attachment_Dept']
        .forEach(id => {
            let el = document.querySelector("[id$='" + id + "']");
            if (el) el.style.border = '';
        });

        // Check required fields
        ['V_Code', 'Block_unblock', 'Reason', 'Block_From', 'Block_To']
        .forEach(id => {
            let el = document.querySelector("[id$='" + id + "']");
            if (el && !el.value.trim()) {
                el.style.border = '2px solid red';
                isValid = false;
            }
        });

        // Check PDF files
        ['Attachment_Vendor', 'Attachment_Dept']
        .forEach(id => {
            let fileInput = document.querySelector("[id$='" + id + "']");
            if (fileInput && fileInput.value) {
                let ext = fileInput.value.split('.').pop().toLowerCase();
                if (ext !== 'pdf') {
                    fileInput.style.border = '2px solid red';
                    isValid = false;
                }
            }
        });

        return isValid; // if false, form won't submit
    };
});
</script>
