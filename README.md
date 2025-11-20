<script type="text/javascript">

// Close all open dropdowns
function closeAllFloatDivs() {
    document.querySelectorAll(".floatDiv").forEach(function(div) {
        div.style.display = "none";
    });
}

function togglefloatDiv(btn) {

    // Close all dropdowns first
    closeAllFloatDivs();

    var floatDiv = btn.nextElementSibling;

    // Toggle visibility
    if (floatDiv.style.display === "block") {
        floatDiv.style.display = "none";
        return;
    }

    floatDiv.style.display = "block";

    // Position the dropdown below the button
    var rect = btn.getBoundingClientRect();
    floatDiv.style.position = "absolute";
    floatDiv.style.top = (window.scrollY + rect.bottom) + "px";
    floatDiv.style.left = (window.scrollX + rect.left) + "px";
    floatDiv.style.width = rect.width + "px";
}

// Close dropdown when clicking outside
document.addEventListener("click", function (event) {

    // If click is NOT inside button or floatDiv -> close
    if (!event.target.closest(".SearchCheckBoxList")) {
        closeAllFloatDivs();
    }
});

</script>
