function checkCheckboxesFromDropdownText() {
    const dropdownText = document.getElementById("DeptDropdown").value.trim();

    // Get all checkbox labels
    const checkboxes = document.querySelectorAll(".Dept-checkbox");

    // Clear all first
    checkboxes.forEach(cb => cb.checked = false);

    // Try to match full labels inside dropdown text
    checkboxes.forEach(cb => {
        const label = document.querySelector(`label[for="${cb.id}"]`);
        const labelText = label ? label.textContent.trim() : "";
        // Use a regex with word boundary or exact match
        if (dropdownText.includes(labelText)) {
            cb.checked = true;
        }
    });

    updateHiddenFieldFromCheckboxes();
}
