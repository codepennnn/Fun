

    // Used when manually selecting department checkboxes from dropdown label text
    function checkCheckboxesFromDropdownText() {
        const dropdownText = document.getElementById("DeptDropdown").value;
       // const selectedNames = dropdownText.split(",").map(s => s.trim()).filter(s => s);
            const selectedNames = saved.split("||").map(s => s.trim());

        // Clear all checkboxes first
        document.querySelectorAll(".Dept-checkbox").forEach(cb => cb.checked = false);

           


        // Recheck matching boxes based on label text
        selectedNames.forEach(name => {
            document.querySelectorAll(".Dept-checkbox").forEach(cb => {
                const label = document.querySelector(`label[for="${cb.id}"]`);
                        if (label && selectedNames.includes(label.textContent.trim()) === name) {
                    cb.checked = true;
                }
            });
        });

        updateHiddenFieldFromCheckboxes(); // Update hidden input and label display
    }

    // Update hidden Dept value + update visible text in input
    function updateHiddenFieldFromCheckboxes() {
        const selectedValues = [];
        const selectedLabels = [];

        document.querySelectorAll(".Dept-checkbox:checked").forEach(cb => {
            selectedValues.push(cb.value);
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label) selectedLabels.push(label.textContent.trim());
        });

           document.getElementById("Dept").value = selectedLabels.join("||");
            document.getElementById("DeptDropdown").value = selectedLabels.join(", ");
    }



    CoordinatorMaster:2524 Uncaught ReferenceError: saved is not defined
    at checkCheckboxesFromDropdownText (CoordinatorMaster:2524:35)
    at Object.success (CoordinatorMaster:2606:21)
    at c (jquery.min.js:2:28294)
    at Object.fireWith [as resolveWith] (jquery.min.js:2:29039)
    at l (jquery.min.js:2:79800)
    at XMLHttpRequest.<anonymous> (jquery.min.js:2:82254)



