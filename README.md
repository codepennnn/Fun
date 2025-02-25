<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
        <script language="Javascript" type="text/javascript">

            alert("sss");
            alert(sum_category);
            alert(pre_count);
            alert(remain_total);
            alert(rem);

        $(document).ready(function () {
            $('#myselection').on('change', function () {
                var demovalue = $(this).val();
                $("div.myDiv").hide();
                $("#show" + demovalue).show();
            });
        });

        function NumericChecking3digitLen(fld, fldlen) {
            if (isNaN(fld.value)) {
                alert("Please Enter Number Only !!! ");
                fld.form.reset();
                fld.focus();
                
                return false;
            }
            total_cal();
        }

        function WaterMarkFocus(txt, text) {
            if (txt.value == text) {
                txt.value = "";
                txt.style.color = "black";
            }
        }

        function WaterMarkBlur(txt, text) {
            if (txt.value == "") {
                txt.value = text;
                txt.style.color = "gray";
            }
        }


        function total_cal()
        {
            //alert("1");
            var sum_category = 0;

            var NO_OF_EMP_REG_0 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_0").value;
            if (NO_OF_EMP_REG_0 == '' || NO_OF_EMP_REG_0 == null)
            {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_0").value = 0;
            }
            var NO_OF_EMP_REG_1 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_1").value;
            if (NO_OF_EMP_REG_1 == '' || NO_OF_EMP_REG_1 == null) {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_1").value = 0;
            }
            var NO_OF_EMP_REG_2 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_2").value;
            if (NO_OF_EMP_REG_2 == '' || NO_OF_EMP_REG_2 == null) {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_2").value = 0;
            }
            var NO_OF_EMP_REG_3 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_3").value;
            if (NO_OF_EMP_REG_3 == '' || NO_OF_EMP_REG_3 == null) {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_3").value = 0;
            }
            var NO_OF_EMP_REG_4 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_4").value;
            if (NO_OF_EMP_REG_4 == '' || NO_OF_EMP_REG_4 == null) {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_REG_4").value = 0;
            }


            var NO_OF_EMP_TEMP_0 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_0").value;
            if (NO_OF_EMP_TEMP_0 == '' || NO_OF_EMP_TEMP_0 == null) {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_0").value = 0;
            }
            var NO_OF_EMP_TEMP_1 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_1").value;
            if (NO_OF_EMP_TEMP_1 == '' || NO_OF_EMP_TEMP_1 == null) {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_1").value = 0;
            }
            var NO_OF_EMP_TEMP_2 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_2").value;
            if (NO_OF_EMP_TEMP_2 == '' || NO_OF_EMP_TEMP_2 == null) {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_2").value = 0;
            }
            var NO_OF_EMP_TEMP_3 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_3").value;
            if (NO_OF_EMP_TEMP_3 == '' || NO_OF_EMP_TEMP_3 == null) {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_3").value = 0;
            }
            var NO_OF_EMP_TEMP_4 = document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_4").value;
            if (NO_OF_EMP_TEMP_4 == '' || NO_OF_EMP_TEMP_4 == null) {
                document.getElementById("MainContent_workers_Records_NO_OF_EMP_TEMP_4").value = 0;
            }

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
            } else if (sum_category < pre_count)
            {

                if (sum_category < curr_online_gp) {
                    alert("Total sum of all category can not be less than the currently ongoing gatepass .");
                    document.getElementById("MainContent_txtcal").value = "";
                }
                else if (unsk < unsk_curr_online_gp)
                {
                    alert("Total sum of Unskilled category can not be less than the currently unskilled ongoing gatepass .");
                    document.getElementById("MainContent_txtcal").value = "";
                } else if (smsk < smsk_curr_online_gp) {
                    alert("Total sum of Semiskilled category can not be less than the currently semiskilled ongoing gatepass .");
                    document.getElementById("MainContent_txtcal").value = "";
                } else if (sk < sk_curr_online_gp) {
                    alert("Total sum of Skilled category can not be less than the currently skilled ongoing gatepass .");
                    document.getElementById("MainContent_txtcal").value = "";
                }
                else if (hgsk < hgsk_curr_online_gp) {
                    alert("Total sum of HighlySkilled category can not be less than the currently highlyskilled ongoing gatepass .");
                    document.getElementById("MainContent_txtcal").value = "";
                } else if (oth < oth_curr_online_gp) {
                 
                    alert("Total sum of Other category can not be less than the currently Other ongoing gatepass .");
                    document.getElementById("MainContent_txtcal").value = "";
                }

            }
            



           
            

        } 

        </script>
</asp:Content>
