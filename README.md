<script>
    const DELIMITER = "||";

    $(document).on('change', '.Dept-checkbox', function () {
        updateHiddenFieldFromCheckboxes();
    });

    // Form submission
    $('form').on('submit', function (e) {
        const inputVal = $('#pnoSearch').val().trim().toLowerCase();
        const matchedOption = $('#Pno option').filter(function () {
            return $(this).text().trim().toLowerCase() === inputVal;
        }).first();

        if (matchedOption.length === 0) {
            alert("Please select a valid PNO from the list.");
            e.preventDefault();
            return;
        } else {
            $('#Pno').val(matchedOption.val());
        }

        const selectedDepts = $('.Dept-checkbox:checked').map(function () {
            return $(this).val();
        }).get();

        if (selectedDepts.length === 0) {
            alert("Please select at least one department.");
            e.preventDefault();
            return;
        }

        $('#Dept').val(selectedDepts.join(DELIMITER));
    });

    setTimeout(function () {
        $('.alert').fadeOut('slow');
    }, 3000);

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
        const selectedNames = dropdownText.split(DELIMITER).map(s => s.trim()).filter(s => s);

        document.querySelectorAll(".Dept-checkbox").forEach(cb => cb.checked = false);

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

    function updateHiddenFieldFromCheckboxes() {
        const selectedValues = [];
        const selectedLabels = [];

        document.querySelectorAll(".Dept-checkbox:checked").forEach(cb => {
            selectedValues.push(cb.value);
            const label = document.querySelector(`label[for="${cb.id}"]`);
            if (label) selectedLabels.push(label.textContent.trim());
        });

        document.getElementById("Dept").value = selectedValues.join(DELIMITER);
        document.getElementById("DeptDropdown").value = selectedLabels.join(DELIMITER);
    }

    $(document).ready(function () {
        $('#showFormButton2').click(function () {
            $('#formContainer').show();
            $('#Pno,#pnoSearch, #DeptDropdown, #Dept').val('');
            $('#Id').val('');
            $('.Dept-checkbox').prop('checked', false);
            $("#deleteButton").hide();
        });

        $('.OpenFilledForm').click(function () {
            const id = $(this).data('id');
            $.ajax({
                url: '@Url.Action("CoordinatorMaster", "Master")',
                data: { id: id },
                success: function (data) {
                    $('#Id').val(data.id);
                    $('#Pno').val(data.pno);
                    $('#pnoSearch').val(data.pno);
                    $('#CreatedBy').val(data.createdby);
                    $('#CreatedOn').val(data.createdon);

                    // ✅ Use delimiter instead of comma
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



var depts = coordinator.DeptName
    .Split("||", StringSplitOptions.RemoveEmptyEntries)
    .Select(s => s.Trim())
    .Distinct();
coordinator.DeptName = string.Join("||", depts);

SELECT value FROM STRING_SPLIT(@DeptName, '||')


