<div class="SearchCheckBoxList" style="width:287%; position:relative;">
    
    <!-- Button -->
    <button class="btn btn-sm btn-default selectArea w-100 dropdown-btn"
            type="button" onclick="togglefloatDiv(this);">
        <span class="filter-option float-left">No item Selected</span>
        <span class="caret"></span>
    </button>

    <!-- Dropdown -->
    <div class="floatDiv" style="border:1px solid #ced2d5; position:absolute; 
         z-index:1000; box-shadow:0 6px 12px rgb(0 0 0 / 18%); background:#fff;
         padding:5px; display:none; width:100%;">

        <!-- Search -->
        <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control form-control-sm"
                     oninput="filterCheckBox(this)" placeholder="Search..." />

        <!-- List -->
        <div class="searchList" style="max-height:210px; overflow-y:auto;">
            <asp:CheckBoxList ID="CC_WorkOrderNo" runat="server"
                DataTextField="WorkOrderNo" DataValueField="WorkOrderNo"
                CssClass="form-control-sm" />
        </div>

        <!-- Hidden value field (if you want selected values) -->
        <asp:TextBox runat="server" ID="TextBox3" style="display:none;" />
    </div>

</div>


// Close all float dropdowns
function closeAllFloatDivs() {
    document.querySelectorAll(".floatDiv").forEach(div => div.style.display = "none");
}

// Toggle dropdown
function togglefloatDiv(btn) {
    closeAllFloatDivs();

    const floatDiv = btn.nextElementSibling;
    floatDiv.style.display = floatDiv.style.display === "block" ? "none" : "block";

    // Match button width
    floatDiv.style.width = btn.getBoundingClientRect().width + "px";
}

// Close when clicking outside
document.addEventListener("click", function (event) {
    if (!event.target.closest(".SearchCheckBoxList")) {
        closeAllFloatDivs();
    }
});

// Search inside checkbox list
function filterCheckBox(input) {
    const filter = input.value.toUpperCase();
    const table = input.parentElement.querySelector("table"); // CheckBoxList renders a table
    const rows = table.getElementsByTagName("tr");

    for (let i = 0; i < rows.length; i++) {
        const cell = rows[i].getElementsByTagName("td")[0];
        const txt = cell.textContent || cell.innerText;
        rows[i].style.display = txt.toUpperCase().includes(filter) ? "" : "none";
    }
}

// Attach events AFTER CheckBoxList is rendered
window.onload = function () {
    setTimeout(function () {

        document.querySelectorAll('.SearchCheckBoxList').forEach(function (container) {

            const btnText = container.querySelector(".filter-option");
            const hiddenBox = container.querySelector("#TextBox3");

            // Attach checkbox change event
            container.querySelectorAll('input[type="checkbox"]').forEach(function (cb) {
                cb.addEventListener("change", function () {

                    let selected = [];
                    container.querySelectorAll('input[type="checkbox"]').forEach(function (box) {
                        if (box.checked) selected.push(box.parentElement.innerText.trim());
                    });

                    // Update display text
                    btnText.innerText = selected.length === 0
                        ? "No item Selected"
                        : selected.join(", ");

                    // Update hidden textbox (optional)
                    if (hiddenBox)
                        hiddenBox.value = selected.join(",");
                });
            });

        });

    }, 300); // wait for ASP.NET to fully render CheckBoxList
};


