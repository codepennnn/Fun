 if (Pre_ESI[i].value === "" || Pre_ESI[i].value === null) {

     if (total_gross_as_per_rate >= 21000) {
         mESIAmt = 0;
         mESIAmt3_25 = 0;
         mESIAmt4 = 0;

     } else {
         //alert(TotalWages[i].value);
         mESIAmt = (parseFloat(TotalWages[i].value) * 0.0075);
         mESIAmt3_25 = (parseFloat(TotalWages[i].value) * 0.0325);
         mESIAmt4 = (parseFloat(TotalWages[i].value) * 0.04);
     }
