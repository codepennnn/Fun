...
<script>
    const DEPT_DELIMITER = "||";

    // Update hidden input + visible text field when checkboxes change
    function updateDeptFields() {
        const selectedLabels = [];

        document.querySelectorAll(".Dept-checkbox:checked").forEach(cb => {
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label) selectedLabels.push(label.textContent.trim());
        });

        // Use || to join labels in hidden field
        document.getElementById("Dept").value = selectedLabels.join(DEPT_DELIMITER);

        // For display: show them comma-separated, just for UI
        document.getElementById("DeptDropdown").value = selectedLabels.join(", ");
    }

    // On load: restore checkbox state from hidden field
    document.addEventListener("DOMContentLoaded", function () {
        const saved = document.getElementById("Dept").value;
        const savedLabels = saved.split(DEPT_DELIMITER).map(s => s.trim());

        document.querySelectorAll(".Dept-checkbox").forEach(cb => {
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label && savedLabels.includes(label.textContent.trim())) {
                cb.checked = true;
            }

            cb.addEventListener("change", updateDeptFields);
        });

        updateDeptFields(); // Initialize display
    });
</script>
