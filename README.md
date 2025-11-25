 <div class="SearchCheckBoxList" style="width:287%;">
     <button class="btn btn-sm btn-default selectArea w-100" type="button" onclick="togglefloatDiv(this);" 
             id="btn-dwn1" style="border:0.5px solid #ced2d5;">
         <span class="filter-option float-left">No item Selected</span>
         <span class="caret"></span>
     </button>
     <div class="floatDiv" runat="server" style="border:1px solid #ced2d5; position:absolute; z-index:1000;
             box-shadow:0 6px 12px rgb(0 0 0 / 18%); background-color:white; padding:5px; display:none; width:100%;">
                    
         <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control form-control-sm col-sm-6"  
                      oninput="filterCheckBox(this)" AutoComplete="off" ViewStateMode="Disabled" 
                      placeholder="Enter Workorder" Font-Size="Smaller" />
                    
         <div style="overflow:auto; max-height:210px; overflow-y:auto; overflow-x:hidden;" class="searchList p-0">
             <asp:CheckBoxList ID="CC_WorkOrderNo" runat="server" DataMember="CC_Wo_No" DataSource="<%# PageDDLDataset %>"
                               DataTextField="WorkOrderNo" DataValueField="WorkOrderNo" CssClass="form-control-sm radio">
             </asp:CheckBoxList>
         </div>
                    
         <asp:TextBox runat="server" ID="TextBox3" Width="0%" style="display:none" />
     </div>
 </div>



  <script type="text/javascript">

     // Close all open dropdowns
     function closeAllFloatDivs() {
         document.querySelectorAll(".floatDiv").forEach(function (div) {
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
        // floatDiv.style.top = (window.scrollY + rect.bottom) + "px";
         //floatDiv.style.left = (window.scrollX + rect.left) + "px";
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


 <script type="text/javascript">



    function filterCheckBox(e) {
        // Declare variables
        var input, filter, table, tbody, tr, td, a, i, txtValue;
        input = e.value.trim();
        //if (input != "") {
        //    e.nextSibling.nextSibling.innerHTML = '<div class="w-80 text-center mt-2" ><div class="spinner-border spinner-border-sm text-primary" role="status"><span class="sr-only">Loading...</span></div><strong style="font-size:10px"> Loading..</strong></div>';
        //}
        //input = document.getElementById('MainContent_SearchObserver');
        filter = input.toUpperCase();
        //table = document.getElementById("MainContent_ObserverList");e.nextSibling.nextSibling
        table = e.nextSibling.nextSibling.childNodes[1];
        tbody = table.getElementsByTagName('tbody');
        tr = table.getElementsByTagName('tr');

        // Loop through all list items, and hide those who don't match the search query
        for (i = 0; i < tr.length; i++) {
            a = tr[i].getElementsByTagName("td")[0];
            txtValue = a.textContent || a.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {

                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }


    }

    function getClickedElement() {

        //PageMethods.ProcessIT("bvnbv", "bvnbv", onSucess, onError);
        //function onSucess(result) {
        //    alert(result);
        //}

        //function onError(result) {
        //    alert('Something wrong.');
        //}
        var specifiedElement = document.getElementsByClassName('VendorColumn');
        for (var i = 0; i < specifiedElement.length; i++) {

            specifiedElement[i].childNodes[3].childNodes[3].onclick = function (event) {
                var target = getEventTarget(event);
                var data = target.parentNode.getAttribute("data-index-no");

                //$("#MainContent_VendorViolationRecord_VendorName_0").append($("<option></option>").val
                //    ("").html("select"));
                //$("#MainContent_VendorViolationRecord_VendorName_0").text("ram");
                //document.getElementById("MainContent_VendorViolationRecord_VendorName_0").value = data;
                event.currentTarget.nextElementSibling.value = data;
                event.currentTarget.previousElementSibling.value = "";
                event.currentTarget.nextElementSibling.onchange();
                // document.getElementById("MainContent_VendorViolationRecord_SearchObserver_0").value = "";
                //document.getElementById("MainContent_VendorViolationRecord_VendorName_0").selectedIndex = 1;
                //document.getElementById("MainContent_VendorViolationRecord_VendorName_0").onchange();
                //return true;
            };


            if (specifiedElement[i].childNodes[3].childNodes[5].value.trim() == "")
                specifiedElement[i].childNodes[1].childNodes[1].innerHTML = "No item selected";
            else
                specifiedElement[i].childNodes[1].childNodes[1].innerHTML = specifiedElement[i].childNodes[3].childNodes[5].value.trim();
        }

        //var ul = document.getElementById("searchList");


        //if (document.getElementById("MainContent_VendorViolationRecord_VendorName_0").value.trim() == "")
        //    document.getElementById("filter-option").innerHTML = "No item selected";
        //else
        //    document.getElementById("filter-option").innerHTML = document.getElementById("MainContent_VendorViolationRecord_VendorName_0").value;
    }

    //function validateCombobox() {
    //    var comboboxId = document.getElementById('Department_HOD_TextBox');


    //    if (comboboxId.value === "") {
    //        alert("Please Select!!!!!");
    //        return false;
    //    }

    //    return true;

    //}



    //function updateSelectedWorkorder() {
    //    alert("ok");
    //    var selected = [];
    //    document.querySelectorAll('[id*="WorkOrderNo"] input[type="checkbox"]').forEach(function (cb) {
    //        if (cb.checked) {
    //            selected.push(cb.parentElement.textContent.trim());
    //        }
    //    });
    //    document.querySelector('[id$="TextBox1"]').value = selected.join(", ");

    //    alert("selected");
    //}

    //window.onload = function () {
    //    setTimeout(function () {
    //        document.querySelectorAll('[id*="WorkOrderNo"] input[type="checkbox"]').forEach(function (cb) {
    //            cb.addEventListener("change", updateSelectedWorkorder);
    //        });
    //    }, 300);
    //};
everythings working fine except when i checked workorder checkbox its not showing in textbox its showing no item selected







</script> 
