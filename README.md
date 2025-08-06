<script>
    // Delimiter for separating department names in hidden input
    const DEPT_DELIMITER = "||";

    // Update hidden and visible inputs when checkboxes are changed
    function updateDeptFields() {
        const selectedValues = [];
        const selectedLabels = [];

        document.querySelectorAll(".Dept-checkbox:checked").forEach(cb => {
            selectedValues.push(cb.value);
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label) selectedLabels.push(label.textContent.trim());
        });

        // Save to hidden field using safe delimiter
        document.getElementById("Dept").value = selectedLabels.join(DEPT_DELIMITER);

        // Display labels in visible input (you can use .value or .placeholder)
        document.getElementById("DeptDropdown").value = selectedLabels.join(", ");
    }

    // On page load: restore checkbox states from Dept hidden field
    document.addEventListener("DOMContentLoaded", function () {
        const saved = document.getElementById("Dept").value;
        const savedLabels = saved.split(DEPT_DELIMITER).map(s => s.trim());

        document.querySelectorAll(".Dept-checkbox").forEach(cb => {
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label && savedLabels.includes(label.textContent.trim())) {
                cb.checked = true;
            }

            // Attach change handler
            cb.addEventListener("change", updateDeptFields);
        });

        // Initialize display
        updateDeptFields();
    });
</script>
