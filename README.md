<script>
    const DELIMITER = "||"; // Use a delimiter that's safe from department names

    function updateSelectedDepartments() {
        const selectedLabels = [];

        document.querySelectorAll(".Dept-checkbox:checked").forEach(cb => {
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label) selectedLabels.push(label.textContent.trim());
        });

        // Save real data using safe delimiter
        document.getElementById("Dept").value = selectedLabels.join(DELIMITER);

        // Show nice comma-separated list in textarea
        document.getElementById("DeptDropdown").value = selectedLabels.join(", ");
    }

    // Load saved values on page load (for edit mode)
    document.addEventListener("DOMContentLoaded", function () {
        const saved = document.getElementById("Dept").value;
        const savedDepts = saved.split(DELIMITER).map(s => s.trim());

        document.querySelectorAll(".Dept-checkbox").forEach(cb => {
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label && savedDepts.includes(label.textContent.trim())) {
                cb.checked = true;
            }

            cb.addEventListener("change", updateSelectedDepartments);
        });

        updateSelectedDepartments(); // Initial fill
    });
</script>




<!-- Department Multi-Select -->
<div class="col-sm-5">
    <label class="form-label">Department</label>

    <div class="dropdown">
        <textarea class="form-control" placeholder="Select Depts"
                  id="DeptDropdown"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                  readonly></textarea>

        <ul class="dropdown-menu w-100" aria-labelledby="DeptDropdown" id="locationList" style="max-height: 200px; overflow-y: auto;">
            @foreach (var item in ViewBag.DeptList as List<SelectListItem>)
            {
                <li style="margin-left:5%;">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input Dept-checkbox"
                               value="@item.Value" id="Dept_@item.Value" />
                        <label class="form-check-label" for="Dept_@item.Value">@item.Text</label>
                    </div>
                </li>
            }
        </ul>
    </div>

    <!-- Hidden field to store actual selected values -->
    <input type="hidden" id="Dept" name="Coordinators[0].DeptName" />
</div>
