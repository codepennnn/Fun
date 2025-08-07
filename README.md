// Used when manually selecting department checkboxes from dropdown label text
function checkCheckboxesFromDropdownText() {
    const dropdownText = document.getElementById("Dept").value; // Get from hidden field
    const selectedNames = dropdownText.split("||").map(s => s.trim()).filter(s => s);

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

    updateHiddenFieldFromCheckboxes(); // Update hidden input and textarea
}
