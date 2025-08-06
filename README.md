<script>
    // Update hidden Dept field + visible dropdown textarea
    function updateHiddenFieldFromCheckboxes() {
        const selectedValues = [];
        const selectedLabels = [];

        document.querySelectorAll(".Dept-checkbox:checked").forEach(cb => {
            selectedValues.push(cb.value);
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label) selectedLabels.push(label.textContent.trim());
        });

        // Use || to separate department names in value
        document.getElementById("Dept").value = selectedLabels.join("||");
        document.getElementById("DeptDropdown").value = selectedLabels.join(", ");
    }

    // On checkbox change, update hidden input
    function updateSelectedDepartments() {
        updateHiddenFieldFromCheckboxes();
    }

    // On page load, pre-check checkboxes if Dept field has saved values
    document.addEventListener("DOMContentLoaded", function () {
        const saved = document.getElementById("Dept").value;
        if (saved) {
            // Use || instead of comma to support comma inside department names
            const savedValues = saved.split("||").map(s => s.trim());

            document.querySelectorAll(".Dept-checkbox").forEach(cb => {
                const label = document.querySelector(`label[for="${cb.id}"]`);
                if (label && savedValues.includes(label.textContent.trim())) {
                    cb.checked = true;
                }
            });

            // Show in dropdown
            document.getElementById("DeptDropdown").value = savedValues.join(", ");
        }

        // Attach checkbox event listener
        document.querySelectorAll(".Dept-checkbox").forEach(cb => {
            cb.addEventListener("change", updateSelectedDepartments);
        });
    });
</script>
