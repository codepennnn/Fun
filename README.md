<div class="form-group col-md-12 mb-1">


                                               <label for="lblComplianceType" class="m-0 mr-5 p-0 col-form-label-sm col-sm-2  font-weight-bold fs-6 justify-content-start">Compliance Type:
                                                     <span style="color: #FF0000;">*</span>
                                                </label>


                                                <asp:CheckBoxList ID="ComplianceType" runat="server" 
                                                                     CssClass="form-control-sm radio col-sm-5"
                                                                     RepeatDirection="Horizontal">
                                                    <asp:ListItem> Wage</asp:ListItem>
                                                    <asp:ListItem> PF & ESI</asp:ListItem>
                                                    <asp:ListItem> Leave</asp:ListItem>
                                                    <asp:ListItem> Bonus</asp:ListItem>
                                                    <asp:ListItem> Labour License</asp:ListItem>
                                                    <asp:ListItem> Grievance</asp:ListItem>
                                                    <asp:ListItem> Notice</asp:ListItem>
                                                </asp:CheckBoxList>


                                            </div>
