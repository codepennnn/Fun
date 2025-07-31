    $('form').on('submit', function () {




            const inputVal = $('#pnoSearch').val().trim().toLowerCase();
        const matchedOption = $('#Pno option').filter(function () {
            return $(this).text().trim().toLowerCase() === inputVal;
        }).first();

        // 🔸 Validate PNO
        if (matchedOption.length === 0) {
            alert("Please select a valid PNO from the list.");
            e.preventDefault();
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
            e.preventDefault();
            return;
        }


        const selected = $('.Dept-checkbox:checked').map(function () {
            return $(this).val();
        }).get();
        $('#Dept').val(selected.join(','));
    });
check its correct and why its still saving blank after alert message
