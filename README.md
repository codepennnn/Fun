    <div class="form-group col-md-12 mb-1">

                                               <label for="lblComplianceType" class="m-0 mr-5 p-0 col-form-label-sm col-sm-2  font-weight-bold fs-6 justify-content-start">Compliance Type:
                                                     <span style="color: #FF0000;">*</span>
                                                </label>

                                            <asp:CheckBox ID="Wage"  runat="server"/>
                                            <asp:CheckBox ID="PfEsi"  runat="server"/>
                                            <asp:CheckBox ID="Leave"  runat="server"/>
                                            <asp:CheckBox ID="Bonus"  runat="server"/>
                                            <asp:CheckBox ID="LL"  runat="server"/>
                                            <asp:CheckBox ID="Grievance"  runat="server"/>
                                            <asp:CheckBox ID="Notice"  runat="server"/>


                                        </div>
     
            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Wage"] = 0;
            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["PfEsi"] = 0;
            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Leave"] = 0;
            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Bonus"] = 0;
            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["LL"] = 0;
            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Grievance"] = 0;
            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Notice"] = 0;

        
            CheckBoxList chkCompliance = (CheckBoxList)WorkOrder_Exemption_Record.Rows[0].FindControl("ComplianceType");
            foreach (ListItem item in chkCompliance.Items)
            {
                if (item.Selected)
                {
                    switch (item.Text.Trim())
                    {
                        case "Wage":
                            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Wage"] = 1;
                            break;
                        case "PF & ESI":
                            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["PfEsi"] = 1;
                            break;
                        case "Leave":
                            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Leave"] = 1;
                            break;
                        case "Bonus":
                            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Bonus"] = 1;
                            break;
                        case "Labour License":
                            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["LL"] = 1;
                            break;
                        case "Grievance":
                            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Grievance"] = 1;
                            break;
                        case "Notice":
                            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Notice"] = 1;
                            break;
                    }
                }
            }

