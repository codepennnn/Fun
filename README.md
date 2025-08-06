<!-- Department with checkboxes -->
<div class="col-sm-5">
    <label class="form-label">Department</label>

    <div class="dropdown">
        <input class="form-control"
               placeholder="Select Depts"
               type="button"
               id="DeptDropdown"
               data-bs-toggle="dropdown"
               aria-expanded="false" />

        <ul class="dropdown-menu w-100"
            aria-labelledby="DeptDropdown"
            id="locationList"
            style="max-height: 200px; overflow-y: auto;">
            @foreach (var item in ViewBag.DeptList as List<SelectListItem>)
            {
                <li style="margin-left:5%;">
                    <div class="form-check">
                        <input type="checkbox"
                               class="form-check-input Dept-checkbox"
                               value="@item.Value"
                               id="Dept_@item.Value" />
                        <label class="form-check-label"
                               for="Dept_@item.Value">@item.Text</label>
                    </div>
                </li>
            }
        </ul>
    </div>

    <!-- Hidden dept field for form -->
    <input type="hidden" id="Dept" name="Coordinators[0].DeptName" />
</div>


<script>
    // Set hidden field from selected checkboxes
    function updateSelectedDepartments() {
        var selected = [];
        document.querySelectorAll(".Dept-checkbox:checked").forEach(function (checkbox) {
            var label = checkbox.nextElementSibling.textContent.trim();
            selected.push(label);
        });
        document.getElementById("Dept").value = selected.join("||"); // Use '||' delimiter
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
</script>
