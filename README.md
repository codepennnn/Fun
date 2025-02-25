  if (sum_category >= pre_count) {
                var rem = document.getElementById("MainContent_Vendor_dtl_Record_LLWM_STRENGTH_0").value;
                console.log("remain", rem);
                if (rem >= 0) {
                    if (sum_category > rem) {
                        if (remain_total > rem) {
                            alert(" Sum of all the workman category is greater than the Remaining Workman Strength for which c3 can be applied or blank please select labour license number.");
                            document.getElementById("MainContent_txtcal").value = "";
                        }
                    }
                } else {
                    alert("Remaining Workman Strength for which c3 can be applied is blank or negative please select labour license number.");
                    document.getElementById("MainContent_txtcal").value = "";
                }
