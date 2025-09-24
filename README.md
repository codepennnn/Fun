                              <div class="form-group col-md-12 mb-1">
                                 <label class="m-0 mr-5 p-0 col-form-label-sm col-sm-2  font-weight-bold fs-6 justify-content-start">
                                     Compliance Type: <span style="color:#FF0000;">*</span>
                                 </label>

                                 <asp:CheckBox ID="Wage"     CssClass="mr-2 compliance-check" runat="server" />
                                 <label class="form-check-label mr-3" for="Wage">Wage</label>

                                 <asp:CheckBox ID="PfEsi"    CssClass="mr-2 compliance-check" runat="server" />
                                 <label class="form-check-label mr-3" for="PfEsi">PF &amp; ESI</label>

                                 <asp:CheckBox ID="Leave"    CssClass="mr-2 compliance-check" runat="server" />
                                 <label class="form-check-label mr-3" for="Leave">Leave</label>

                                 <asp:CheckBox ID="Bonus"    CssClass="mr-2 compliance-check" runat="server" />
                                 <label class="form-check-label mr-3" for="Bonus">Bonus</label>

                                 <asp:CheckBox ID="LL"       CssClass="mr-2 compliance-check" runat="server" />
                                 <label class="form-check-label mr-3" for="LL">Labour License</label>

                                 <asp:CheckBox ID="Grievance" CssClass="mr-2 compliance-check" runat="server" />
                                 <label class="form-check-label mr-3" for="Grievance">Grievance</label>

                                 <asp:CheckBox ID="Notice"   CssClass="mr-2 compliance-check" runat="server" />
                                 <label class="form-check-label mr-3" for="Notice">Notice</label>
                            
                                  
                                    <asp:CheckBox ID="All"   CssClass="mr-2 compliance-check" runat="server" />
                                     <label class="form-check-label mr-3" for="All">All</label>
                            


                              </div>

                                 <script type="text/javascript">
       function validateCompliance() {
           
           var checks = document.querySelectorAll(".compliance-check input[type='checkbox']");
           var atLeastOne = Array.from(checks).some(cb => cb.checked);

           if (!atLeastOne) {
               alert("Please select at least one Compliance Type.");
               return false; 
           }
           return true; 
       }
   </script>
 
