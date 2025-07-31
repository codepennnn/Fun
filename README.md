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
          <input type="hidden" id="Dept" name="Coordinators[0].DeptName" />



          // PNO dropdown search 
document.addEventListener("DOMContentLoaded", function () {
    const input = document.getElementById("pnoSearch");
    const select = document.getElementById("Pno");
    const ul = document.getElementById("pnoList");

    const options = Array.from(select.options)
        .filter(opt => opt.value !== "")
        .map(opt => ({ value: opt.value, text: opt.text }));

    input.addEventListener("input", function () {
        const search = input.value.toLowerCase();
        ul.innerHTML = "";

        if (search === "") {
            ul.style.display = "none";
            return;
        }

        const filtered = options.filter(opt => opt.text.toLowerCase().includes(search));
        if (filtered.length === 0) {
            ul.style.display = "none";
            return;
        }

        filtered.forEach(opt => {
            const li = document.createElement("li");
            li.className = "list-group-item";
            li.textContent = opt.text;
            li.dataset.value = opt.value;

            li.addEventListener("click", () => {
                input.value = opt.text;
                select.value = opt.value;
                ul.style.display = "none";
            });

            ul.appendChild(li);
        });

        ul.style.display = "block";
    });

    document.addEventListener("click", function (e) {
        if (!ul.contains(e.target) && e.target !== input) {
            ul.style.display = "none";
        }
    });
});
