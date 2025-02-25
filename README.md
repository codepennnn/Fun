if (sum_category >= pre_count) {
    var rem = document.getElementById("MainContent_Vendor_dtl_Record_LLWM_STRENGTH_0").value;
    console.log("remain", rem);
    debugger; // Execution will pause here, allowing inspection.

    if (rem >= 0) {
        console.log("rem is positive or zero", rem);
        debugger;

        if (sum_category > rem) {
            console.log("sum_category is greater than rem", sum_category, rem);
            debugger;

            if (remain_total > rem) {
                console.log("remain_total is greater than rem", remain_total, rem);
                debugger;

                alert("Sum of all the workman category is greater than the Remaining Workman Strength for which c3 can be applied or blank. Please select a labour license number.");
                document.getElementById("MainContent_txtcal").value = "";
            }
        }
    } else {
        console.log("rem is negative or blank", rem);
        debugger;

        alert("Remaining Workman Strength for which c3 can be applied is blank or negative. Please select a labour license number.");
        document.getElementById("MainContent_txtcal").value = "";
    }
}
