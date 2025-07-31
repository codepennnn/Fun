..
$('form').on('submit', function (e) {
    const inputVal = $('#pnoSearch').val().trim().toLowerCase();
    const matchedOption = $('#Pno option').filter(function () {
        return $(this).text().trim().toLowerCase() === inputVal;
    }).first();

    if (matchedOption.length > 0) {
        $('#Pno').val(matchedOption.val());
    } else {
        alert("Please select a valid PNO from the list.");
        e.preventDefault(); // stop submission
        return;
    }

    // Also update Dept hidden input as you already had
    const selected = $('.Dept-checkbox:checked').map(function () {
        return $(this).val();
    }).get();
    $('#Dept').val(selected.join(','));
});
