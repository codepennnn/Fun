          var unsk, smsk, sk, hgsk, oth;

            for (var i = 0; i < 5; i++)
            {
                sum_category += parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_" + i).value) + parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_" + i).value);
                //alert(sum_category);
                if (i == 0) {
                    unsk = parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_" + i).value) + parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_" + i).value);
                } else if (i == 1) {
                    smsk = parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_" + i).value) + parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_" + i).value);
                }
                else if (i == 2) {
                    sk = parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_" + i).value) + parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_" + i).value);
                }
                else if (i == 3) {
                    hgsk = parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_" + i).value) + parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_" + i).value);
                } else if (i == 4)
                {
                    oth = parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_" + i).value) + parseInt(document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_" + i).value);
                }

               
            }
            document.getElementById("MainContent_txtcal").value = sum_category;

            var ll_total = document.getElementById("MainContent_txtcal").value;
            var pre_count = parseInt(document.getElementById("MainContent_Vendor_dtl_Record_pre_total_0").value);
            var curr_online_gp = parseInt(document.getElementById("MainContent_Vendor_dtl_Record_curr_online_gp_0").value);

            var unsk_curr_online_gp = parseInt(document.getElementById("MainContent_Vendor_dtl_Record_unsk_gp_0").value);
            var smsk_curr_online_gp = parseInt(document.getElementById("MainContent_Vendor_dtl_Record_smsk_gp_0").value);
            var sk_curr_online_gp = parseInt(document.getElementById("MainContent_Vendor_dtl_Record_sk_gp_0").value);
            var hgsk_curr_online_gp = parseInt(document.getElementById("MainContent_Vendor_dtl_Record_hgsk_gp_0").value);
            var oth_curr_online_gp = parseInt(document.getElementById("MainContent_Vendor_dtl_Record_oth_gp_0").value);

            var sum_previous = parseInt(unsk_curr_online_gp) + parseInt(smsk_curr_online_gp) + parseInt(sk_curr_online_gp) + parseInt(hgsk_curr_online_gp) + parseInt(oth_curr_online_gp);
            var remain_total = parseInt(ll_total) - parseInt(sum_previous);

            alert(sum_category);
            alert(pre_count);
            alert(remain_total);
            alert(rem);

            if (sum_category >= pre_count) {
                var rem = document.getElementById("MainContent_Vendor_dtl_Record_LLWM_STRENGTH_0").value;
               
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
