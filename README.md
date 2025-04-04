    <style>
        /* From Uiverse.io by kamehame-ha */
        .cards {
            display: flex;
            flex-direction: row;
            gap: 15px;
        }


        p {
            color: #fff;
        }

        .cards .red {
            background-color: #cb6274;
        }

        .cards .blue {
            background-color: #4882e1;
        }

        .cards .green {
            background-color: #17a74c;
        }





        .cards .yellow {
            background-color: #c3bf58;
        }


        .cards .orange {
            background-color: lightcoral;
        }


        .cards .purple {
            background-color: mediumpurple;
        }


        .cards .card {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            text-align: center;
            height: 100px;
            width: 250px;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            transition: 400ms;
        }

            .cards .card p.tip {
                font-size: 1em;
                font-weight: 700;
            }

            .cards .card p.second-text {
                font-size: .7em;
            }

            .cards .card:hover {
                transform: scale(1.1, 1.1);
            }

        .cards:hover > .card:not(:hover) {
            filter: blur(10px);
            transform: scale(0.9, 0.9);
        }

        @media (max-width: 767.98px) {
            .cards {
       
            flex-wrap:wrap;

               
        }


    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="card m-2 shadow-lg">
        <div class="card-header bg-info text-light">
            <h6 class="m-0">FNF ENTRY PAGE </h6>
        </div>




        <div class="card-body pt-1">
            <div>
            </div>
            <fieldset class="" style="border: 1px solid #bfbebe; padding: 5px 20px 5px 20px; border-radius: 6px">
                <legend style="width: auto; border: 0; font-size: 14px; margin: 0px 6px 0px 6px; padding: 0px 5px 0px 5px; color: #0000FF"><b>Full & Final Pages</b></legend>
                <div style="margin-left: 300px">

                    <span id="MainContent_employee_attach_lbl" style="color: Red; font-size: X-Large; vertical-align: central"></span>

                </div>




                <div class="container-fluid">





                    <div class="cards">


                        <div class="card red" onclick="window.location.href='FNF_StartPage.aspx'">
                            <p class="tip"><a href="FNF_StartPage.aspx">Full & Final Excel Upload  </a></p>

                        </div>


                        <div class="card blue" onclick="window.location.href='Full_N_Final_Settlement.aspx'">
                            <p class="tip"><a href="Full_N_Final_Settlement.aspx">Full & Final Generation</a> </p>

                        </div>
                        <div class="card green" onclick="window.location.href='../Report/Annexure_of_FormG_Report.aspxx'">
                            <p class="tip"><a href="../Report/Annexure_of_FormG_Report.aspx">Annexure Form G Report</a></p>

                        </div>

                        <div class="card yellow" onclick="window.location.href='../Report/FORM_G_Confirmation_Report.aspx'">
                            <p class="tip"><a href="../Report/FORM_G_Confirmation_Report.aspx">Form G Download</a></p>

                        </div>


                        <div class="card orange" onclick="window.location.href='FNF_FormG.aspx'">
                            <p class="tip"><a href="FNF_FormG.aspx">Form G Upload</a></p>

                        </div>

                        <div class="card purple" onclick="window.location.href='../Report/FNF_Final_Report.aspx'">
                            <p class="tip"><a href="../Report/FNF_Final_Report.aspx">Full & Final Report</a></p>

                        </div>
                    </div>


                    <%-- <div class="row gutters justify-content-center mt-3 mb-5">
                        <input type="submit" name="" value="EMPLOYMENT ATTACHMENT" id="MainContent_btn_attach1" class="button"/>
                       </div>
                 
                      <div class="row gutters justify-content-center mt-3 mb-5">
                        <input type="submit" name="" value="WORKMAN PROFILE ENTRY" id="MainContent_btn_emp_entry1" class="button2"/>
                       </div>

                       <div class="row gutters justify-content-center mt-3 mb-5">
                          <input type="submit" name="" value="UPDATE WITHOUT APPROVAL" id="MainContent_Btn_Upd_without_Entry1" class="button3"/>
                        </div>--%>
                </div>

            </fieldset>






        </div>
    </div>



</asp:Content>
