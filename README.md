   } else {
       if (Pre_ESI[i].value === "" || Pre_ESI[i].value === null) {

           if (total_gross_as_per_rate >= 21000) {
               mESIAmt = 0;
               mESIAmt3_25 = 0;
               mESIAmt4 = 0;

               console.log("Gross >= 21000 → ESI not applicable", {
                   index: i,
                   totalGross: total_gross_as_per_rate,
                   mESIAmt,
                   mESIAmt3_25,
                   mESIAmt4
               });

           } else {
               let wages = parseFloat(TotalWages[i].value) || 0;

               mESIAmt = wages * 0.0075;
               mESIAmt3_25 = wages * 0.0325;
               mESIAmt4 = wages * 0.04;

               console.log("Gross < 21000 → ESI applicable", {
                   index: i,
                   wages,
                   mESIAmt,
                   mESIAmt3_25,
                   mESIAmt4
               });

               // Optional: quick popup for testing one value
               // alert("ESI Amount: " + mESIAmt);
           }
       


       } else if (parseFloat(Pre_ESI[i].value) == 0) {
           mESIAmt = 0;
           mESIAmt3_25 = 0;
           mESIAmt4 = 0;
       }
       else {
           
           if (total_gross_as_per_rate >= 21000) {

               mESIAmt = (parseFloat(21000) * 0.0075);
               mESIAmt3_25 = (parseFloat(21000) * 0.0325);
               mESIAmt4 = (parseFloat(21000) * 0.04);
           } else {
               mESIAmt = (parseFloat(TotalWages[i].value) * 0.0075);
               mESIAmt3_25 = (parseFloat(TotalWages[i].value) * 0.0325);
               mESIAmt4 = (parseFloat(TotalWages[i].value) * 0.04);
           }
       }
   }

