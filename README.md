function checkCheckboxesFromDropdownText() {
    const dropdownText = document.getElementById("DeptDropdown").value.trim();

    // Split first assuming it's comma-separated
    let tempParts = dropdownText.split(",").map(s => s.trim()).filter(s => s);

    const selectedNames = [];
    for (let i = 0; i < tempParts.length; i++) {
        const part = tempParts[i];

        // Handle known department with comma manually
        if (part === "Row" && tempParts[i + 1] === "Admin & Compliances") {
            selectedNames.push("Row,Admin & Compliances");
            i++; // skip next part
        } else {
            selectedNames.push(part);
        }
    }

    // Clear all checkboxes
    document.querySelectorAll(".Dept-checkbox").forEach(cb => cb.checked = false);

    // Check matching checkboxes
    selectedNames.forEach(name => {
        document.querySelectorAll(".Dept-checkbox").forEach(cb => {
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label && label.textContent.trim() === name) {
                cb.checked = true;
            }
        });
    });

    updateHiddenFieldFromCheckboxes();
}
