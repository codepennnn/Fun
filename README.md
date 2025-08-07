function updateHiddenFieldFromCheckboxes() {
    const selectedValues = [];
    const selectedLabels = [];

    document.querySelectorAll(".Dept-checkbox:checked").forEach(cb => {
        selectedValues.push(cb.value);
        const label = document.querySelector(`label[for="${cb.id}"]`);
        if (label) selectedLabels.push(label.textContent.trim());
    });

    document.getElementById("Dept").value = selectedLabels.join("||");     // 🔸 Use || for saving
    document.getElementById("DeptDropdown").value = selectedLabels.join(", "); // 🔸 Still show as comma in textbox
}


function checkCheckboxesFromDropdownText() {
    const dropdownText = document.getElementById("Dept").value; // 🔸 Get value from hidden input
    const selectedNames = dropdownText.split("||").map(s => s.trim()).filter(s => s); // 🔸 Use ||

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

    updateHiddenFieldFromCheckboxes(); // keep this
}

$('#Dept').val(selectedDepts.join('||')); // 🔸 Again use || here


