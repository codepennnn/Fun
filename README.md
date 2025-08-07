
<script>
    
    $(document).on('change', '.Dept-checkbox', function () {
    updateHiddenFieldFromCheckboxes();
});



    // Collect and update Dept values before form submission
    $('form').on('submit', function (e) {
        const inputVal = $('#pnoSearch').val().trim().toLowerCase();
        const matchedOption = $('#Pno option').filter(function () {
            return $(this).text().trim().toLowerCase() === inputVal;
        }).first();

        // 🔸 Validate PNO
        if (matchedOption.length === 0) {
            alert("Please select a valid PNO from the list.");
            e.preventDefault(); // now works
            return;
        } else {
            $('#Pno').val(matchedOption.val()); // Set PNO value
        }

        // 🔸 Validate Department selection
        const selectedDepts = $('.Dept-checkbox:checked').map(function () {
            return $(this).val();
        }).get();

        if (selectedDepts.length === 0) {
            alert("Please select at least one department.");
            e.preventDefault(); // now works
            return;
        }

      $('#Dept').val(selectedDepts.join(','));
          
    });





      setTimeout(function () {
        $('.alert').fadeOut('slow');
    }, 3000); // 5000 ms = 5 seconds



    // Set ActionType and optionally confirm deletion
    function setAction(action, event) {
        if (action === 'Delete' && !confirm("Are you sure you want to delete this record?")) {
            event.preventDefault();
            return;
        }
        document.getElementById('actionType').value = action;
    }








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






    //Update hidden Dept value + update visible text in input
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










    // Handle showing form manually
    $(document).ready(function () {
        $('#showFormButton2').click(function () {
            $('#formContainer').show();
            $('#Pno,#pnoSearch, #DeptDropdown, #Dept').val('');
            $('#Id').val('');
            $('.Dept-checkbox').prop('checked', false);


           $("#deleteButton").hide();
        });

        // Load form data on clicking a PNO
        $('.OpenFilledForm').click(function () {
            const id = $(this).data('id');
            $.ajax({
                url: '@Url.Action("CoordinatorMaster", "Master")',
                data: { id: id },
                success: function (data) {
                    $('#Id').val(data.id);
                    $('#Pno').val(data.pno);
                    $('#pnoSearch').val(data.pno); // for display in the search box
                    $('#CreatedBy').val(data.createdby);
                    $('#CreatedOn').val(data.createdon);

                    // Department: fill hidden, display field, and check boxes
                    $('#Dept').val(data.dept);
                    $('#DeptDropdown').val(data.dept);
                    checkCheckboxesFromDropdownText();

                    $('#formContainer').show();
                },
                error: function () {
                    alert("Error loading data");
                }
            });
             $("#deleteButton").show();
        });
    });







</script>








   
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
   
   
   
   
   
   
   
   
   [HttpPost]
   public async Task<IActionResult> CoordinatorMaster(CoordinatorWrapper model)
   {
       var UserId = HttpContext.Request.Cookies["Session"];

       if (model == null || model.Coordinators == null || !model.Coordinators.Any())
           return BadRequest("No coordinator data received.");

       if (string.IsNullOrEmpty(model.ActionType))
           return BadRequest("No action specified.");

       if (model.ActionType == "Submit")
       {
           foreach (var coordinator in model.Coordinators)
           {
               coordinator.CreatedBy = UserId;
               coordinator.CreatedOn = DateTime.Now;

               // Clean department string
               if (!string.IsNullOrEmpty(coordinator.DeptName))
               {
                   var depts = coordinator.DeptName
                       .Split(',', StringSplitOptions.RemoveEmptyEntries)
                       .Select(s => s.Trim())
                       .Distinct();

                   coordinator.DeptName = string.Join(",", depts);
               }

           
               var existing = await context.AppCoordinatorMasters
                   .FirstOrDefaultAsync(x => x.Pno == coordinator.Pno);

               if (existing != null)
               {
            
                   existing.DeptName = coordinator.DeptName;
                   existing.CreatedBy = coordinator.CreatedBy;
                   existing.CreatedOn = coordinator.CreatedOn;
               }
               else
               {
                   await context.AppCoordinatorMasters.AddAsync(coordinator);
               }
           }

           await context.SaveChangesAsync();
           TempData["msg1"] = "Coordinator Saved Successfully!";
       }
       else if (model.ActionType == "Delete")
       {
           foreach (var coordinator in model.Coordinators)
           {
               var existing = await context.AppCoordinatorMasters
                   .FirstOrDefaultAsync(x => x.Pno == coordinator.Pno);

               if (existing != null)
                   context.AppCoordinatorMasters.Remove(existing);
           }

           await context.SaveChangesAsync();
           TempData["Dltmsg1"] = "Coordinator Deleted Successfully!";
       }

       return RedirectToAction("CoordinatorMaster");
   }








        [HttpGet]
        public async Task<IActionResult> EmpTaggingMaster(string searchString = "", int page = 1)
        {
            var UserId = HttpContext.Request.Cookies["Session"];
            if (string.IsNullOrEmpty(UserId))
                return RedirectToAction("Login", "User");

            // Check permission
            var allowedPnos = context.AppPermissionMasters.Select(x => x.Pno).ToList();
            if (!allowedPnos.Contains(UserId))
                return RedirectToAction("Login", "User");

            string connectionString = GetRFIDConnectionString();

            List<dynamic> empList = new();
            List<SelectListItem> worksiteList = new();
            List<SelectListItem> pnoDropdown = new(); 

            using (var conn = new SqlConnection(connectionString))
            {
                await conn.OpenAsync();

                // 1. Get logged-in user's department
                string deptSql = "SELECT DeptName FROM App_CoordinatorMaster WHERE Pno = @Pno";
                var department = await conn.QueryFirstOrDefaultAsync<string>(deptSql, new { Pno = UserId });

                if (string.IsNullOrEmpty(department))
                {
                    TempData["msg2"] = "Department not found for logged-in user.";
                    return View();
                }

                // 2. Get employee data (Pno, Name, Position, Worksites)
                string dataSql = @"
             SELECT 
    ep.Pno,
    e.Ema_Ename,
    ep.Position,
    STRING_AGG(sites.Work_Site, ', ') AS Worksites
FROM SAPHRDB.dbo.T_Empl_All e
Inner JOIN App_Emp_Position ep ON e.Ema_perno = ep.Pno
Inner JOIN App_Position_Worksite pw ON ep.Position = pw.Position
OUTER APPLY (
    SELECT l.Work_Site
    FROM STRING_SPLIT(pw.Worksite, ',') AS split
    JOIN App_LocationMaster l ON TRY_CAST(split.value AS uniqueidentifier) = l.ID
) AS sites
WHERE (ema_pyrl_area = 'ZZ' or ema_pyrl_area = 'JS') and  ema_dept_desc IN (SELECT value FROM STRING_SPLIT(@DeptName, ','))
GROUP BY ep.Pno, e.Ema_Ename, ep.Position
ORDER BY ep.Pno";

                empList = (await conn.QueryAsync(dataSql, new { DeptName = department })).ToList();

                // 3. Prepare Pno dropdown (only Pno from department)
                string pnoSql = @"SELECT DISTINCT Ema_perno,ema_dept_desc FROM SAPHRDB.dbo.T_Empl_All WHERE (ema_pyrl_area = 'ZZ' or ema_pyrl_area = 'JS') and  ema_dept_desc IN (
    SELECT value FROM STRING_SPLIT(@DeptName, ',')
) ORDER BY Ema_perno;;";
                var rawPnos = await conn.QueryAsync<string>(pnoSql, new { DeptName = department });

                pnoDropdown = rawPnos.Select(p => new SelectListItem
                {
                    Value = p,
                    Text = p
                }).ToList();

                // 4. Worksite list
                string wsQuery = "SELECT ID, Work_Site FROM App_LocationMaster order by Work_Site";
                var worksites = await conn.QueryAsync(wsQuery);
                worksiteList = worksites.Select(ws => new SelectListItem
                {
                    Value = ws.ID.ToString(),
                    Text = ws.Work_Site.ToString()
                }).ToList();
            }

            // 5. Search filter
            if (!string.IsNullOrEmpty(searchString))
            {
                empList = empList
                    .Where(e => ((string)e.Pno).Contains(searchString, StringComparison.OrdinalIgnoreCase)
                             || (!string.IsNullOrEmpty((string)e.Name) && ((string)e.Name).Contains(searchString, StringComparison.OrdinalIgnoreCase)))
                    .ToList();
            }

            // 6. Pagination
            int pageSize = 5;
            var pagedData = empList.Skip((page - 1) * pageSize).Take(pageSize).ToList();


            ViewBag.pList = pagedData; // Table display
            ViewBag.PnoDropdown = pnoDropdown; // Dropdown Pno
            ViewBag.WorksiteList = worksiteList;

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling(empList.Count / (double)pageSize);
            ViewBag.SearchString = searchString;

            return View();
        }

