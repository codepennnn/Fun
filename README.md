function checkCheckboxesFromDropdownText() {
    const dropdownText = document.getElementById("DeptDropdown").value.trim();
    const allLabels = Array.from(document.querySelectorAll(".Dept-checkbox")).map(cb => {
        const label = document.querySelector(`label[for="${cb.id}"]`);
        return label ? label.textContent.trim() : '';
    });

    // Start with all unchecked
    document.querySelectorAll(".Dept-checkbox").forEach(cb => cb.checked = false);

    allLabels.forEach((labelText, index) => {
        if (dropdownText.includes(labelText)) {
            const checkbox = document.querySelectorAll(".Dept-checkbox")[index];
            checkbox.checked = true;
        }
    });

    updateHiddenFieldFromCheckboxes();
}
