} else {
    if (Pre_ESI[i].value === "" || Pre_ESI[i].value === null) {

        if (total_gross_as_per_rate >= 21000) {
            mESIAmt = 0;
            mESIAmt3_25 = 0;
            mESIAmt4 = 0;
        } else {
            let wages = parseFloat(TotalWages[i].value) || 0;

            mESIAmt = wages * 0.0075;
            mESIAmt3_25 = wages * 0.0325;
            mESIAmt4 = wages * 0.04;
        }

    } else if (parseFloat(Pre_ESI[i].value) == 0) {
        mESIAmt = 0;
        mESIAmt3_25 = 0;
        mESIAmt4 = 0;
    } else {
        if (total_gross_as_per_rate >= 21000) {
            mESIAmt = 21000 * 0.0075;
            mESIAmt3_25 = 21000 * 0.0325;
            mESIAmt4 = 21000 * 0.04;
        } else {
            let wages = parseFloat(TotalWages[i].value) || 0;
            mESIAmt = wages * 0.0075;
            mESIAmt3_25 = wages * 0.0325;
            mESIAmt4 = wages * 0.04;
        }
    }

    // 🔍 Debugging for only one workman (change index as needed)
    if (i === 2) {
        console.log("Debugging ESI for workman index 2", {
            index: i,
            gross: total_gross_as_per_rate,
            wages: parseFloat(TotalWages[i].value) || 0,
            preESI: Pre_ESI[i].value,
            mESIAmt,
            mESIAmt3_25,
            mESIAmt4
        });

        // Optional: alert if you want a popup
        // alert("ESI Amt: " + mESIAmt);
    }
}
