I have two checkbox department that is saved in my table - Administration & Event Management and Row,Admin & Compliances   
but when this function execute only this Administration & Event Management department but not coming this Row,Admin & Compliances  

note - Row,Admin & Compliances  its one department with comma already saved in table
it meas if my department name data already have comma then issue occurs not showing it otherwise perfect wokring
 








     <div class="col-sm-5">
         <label class="form-label">Department</label>

         <div class="dropdown">
             <textarea class="form-control" placeholder="Select Depts"
                    type="button" id="DeptDropdown" data-bs-toggle="dropdown" aria-expanded="false" ></textarea>

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

         <!-- Hidden dept field for form -->
         <input type="hidden" id="Dept" name="Coordinators[0].DeptName" />
     </div>


   <!-- Department with checkboxes -->
  <div class="col-sm-5">
      <label class="form-label">Department</label>

      <div class="dropdown">
          <input class="form-control" placeholder="Select Depts"
                 type="button" id="DeptDropdown" data-bs-toggle="dropdown" aria-expanded="false" />

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

      <!-- Hidden dept field for form -->
      <input type="hidden" id="Dept" name="Coordinators[0].DeptName" />
  </div>


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

  // Update hidden Dept value + update visible text in input
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



