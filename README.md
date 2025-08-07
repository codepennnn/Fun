// Used when manually selecting department checkboxes from dropdown label text
function checkCheckboxesFromDropdownText() {
    const dropdown = document.getElementById("DeptDropdown");
    let raw = dropdown.value.trim();

    // 🔧 Hardcoded fix: replace the department name with a placeholder
    raw = raw.replace("Row,Admin & Compliances", "SPECIAL_DEPT");

    // Split by comma (safe now that special name is replaced)
    const selectedNames = raw.split(",").map(s => s.trim()).filter(s => s);

    // Restore original name
    const finalNames = selectedNames.map(name =>
        name === "SPECIAL_DEPT" ? "Row,Admin & Compliances" : name
    );

    // Clear all checkboxes first
    document.querySelectorAll(".Dept-checkbox").forEach(cb => cb.checked = false);

    // Recheck matching boxes based on label text
    finalNames.forEach(name => {
        document.querySelectorAll(".Dept-checkbox").forEach(cb => {
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label && label.textContent.trim() === name) {
                cb.checked = true;
            }
        });
    });

    updateHiddenFieldFromCheckboxes(); // Update hidden input and label display
}
