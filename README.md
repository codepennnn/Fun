    // Used when manually selecting department checkboxes from dropdown label text
    function checkCheckboxesFromDropdownText() {
        const dropdownText = document.getElementById("DeptDropdown").value;
        const selectedNames = dropdownText.split(",").map(s => s.trim()).filter(s => s);

        // Clear all checkboxes first
        document.querySelectorAll(".Dept-checkbox").forEach(cb => cb.checked = false);

                // Recheck matching boxes based on label text
        selectedNames.forEach(name => {
            document.querySelectorAll(".Dept-checkbox").forEach(cb => {
                const label = document.querySelector(`label[for="${cb.id}"]`);
                if (label && label.textContent.trim() === name) {
                    cb.checked = true;
                }
            });
        });

        updateHiddenFieldFromCheckboxes(); // Update hidden input and label display
    }

    //Update hidden Dept value + update visible text in input
    function updateHiddenFieldFromCheckboxes() {
        const selectedValues = [];
        const selectedLabels = [];

        document.querySelectorAll(".Dept-checkbox:checked").forEach(cb => {
            selectedValues.push(cb.value);
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label) selectedLabels.push(label.textContent.trim());
        });

        document.getElementById("Dept").value = selectedValues.join(",");
        document.getElementById("DeptDropdown").value = selectedLabels.join(", ");
    }



        function updateSelectedDepartments() {
            var selected = [];
            document.querySelectorAll(".Dept-checkbox:checked").forEach(function (checkbox) {
                var label = checkbox.nextElementSibling.textContent.trim();
                selected.push(label);
            });
            document.getElementById("Dept").value = selected.join("||"); 
        }

        // Attach onchange to each checkbox
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".Dept-checkbox").forEach(function (checkbox) {
                checkbox.addEventListener("change", updateSelectedDepartments);
            });

            // Pre-check if Dept field already has values (e.g. on edit page)
            var saved = document.getElementById("Dept").value;
            if (saved) {
                var savedValues = saved.split("||");
                document.querySelectorAll(".Dept-checkbox").forEach(function (checkbox) {
                    var label = checkbox.nextElementSibling.textContent.trim();
                    if (savedValues.includes(label)) {
                        checkbox.checked = true;
                    }
                });
            }
        });
