<script>
document.addEventListener("DOMContentLoaded", function () {
    // Only run validation if this section exists
    if (!document.getElementById("Vendor_Block_Unblock_RFQ_record")) return;

    document.getElementById("form1").onsubmit = function () {
        let isValid = true;

        // Reset borders
        ['V_Code', 'Block_unblock', 'Reason', 'Block_From', 'Block_To', 'Attachment_Vendor', 'Attachment_Dept']
        .forEach(id => {
            let el = document.querySelector("[id$='" + id + "']");
            if (el) el.style.border = '';
        });

        // Required fields check
        ['V_Code', 'Block_unblock', 'Reason', 'Block_From', 'Block_To']
        .forEach(id => {
            let el = document.querySelector("[id$='" + id + "']");
            if (el && !el.value.trim()) {
                el.style.border = '2px solid red';
                isValid = false;
            }
        });

        // PDF only check
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

        if (!isValid) {
            // Stop postback
            return false;
        }

        // Allow postback
        return true;
    };
});
</script>
