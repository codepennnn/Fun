<script>
    $('form').on('submit', function (e) {
        // 🔸 Validate PNO
        const pnoVal = $('#Pno').val();
        if (!pnoVal) {
            alert("Please select a PNO.");
            e.preventDefault();
            return;
        }

        // 🔸 Validate Position
        const positionVal = $('#Position').val();
        if (!positionVal || isNaN(positionVal) || parseInt(positionVal) <= 0) {
            alert("Please enter a valid Position.");
            e.preventDefault();
            return;
        }

        // 🔸 Validate Worksite
        const selectedWorksites = $('.worksite-checkbox:checked').map(function () {
            return $(this).val();
        }).get();

        if (selectedWorksites.length === 0) {
            alert("Please select at least one Worksite.");
            e.preventDefault();
            return;
        }

        // 🔸 Set hidden input for worksite
        $('#Worksite').val(selectedWorksites.join(','));
    });
</script>
