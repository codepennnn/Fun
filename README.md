// Reset all columns to 0
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Wage"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["PfEsi"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Leave"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Bonus"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["LL"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Grievance"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Notice"] = 0;

// Set selected ones to 1
if (((CheckBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Wage")).Checked)
    PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Wage"] = 1;

if (((CheckBox)WorkOrder_Exemption_Record.Rows[0].FindControl("PfEsi")).Checked)
    PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["PfEsi"] = 1;

if (((CheckBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Leave")).Checked)
    PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Leave"] = 1;

if (((CheckBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Bonus")).Checked)
    PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Bonus"] = 1;

if (((CheckBox)WorkOrder_Exemption_Record.Rows[0].FindControl("LL")).Checked)
    PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["LL"] = 1;

if (((CheckBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Grievance")).Checked)
    PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Grievance"] = 1;

if (((CheckBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Notice")).Checked)
    PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Notice"] = 1;



    <div class="form-group col-md-12 mb-3">
    <label for="lblComplianceType" 
           class="col-form-label-sm font-weight-bold fs-6 d-block mb-2">
        Compliance Type: <span style="color:#FF0000;">*</span>
    </label>

    <div class="row">
        <div class="col-md-3 col-sm-6 mb-2">
            <div class="form-check">
                <asp:CheckBox ID="Wage" runat="server" CssClass="form-check-input" />
                <label class="form-check-label" for="Wage">Wage</label>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-2">
            <div class="form-check">
                <asp:CheckBox ID="PfEsi" runat="server" CssClass="form-check-input" />
                <label class="form-check-label" for="PfEsi">PF &amp; ESI</label>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-2">
            <div class="form-check">
                <asp:CheckBox ID="Leave" runat="server" CssClass="form-check-input" />
                <label class="form-check-label" for="Leave">Leave</label>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-2">
            <div class="form-check">
                <asp:CheckBox ID="Bonus" runat="server" CssClass="form-check-input" />
                <label class="form-check-label" for="Bonus">Bonus</label>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-2">
            <div class="form-check">
                <asp:CheckBox ID="LL" runat="server" CssClass="form-check-input" />
                <label class="form-check-label" for="LL">Labour License</label>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-2">
            <div class="form-check">
                <asp:CheckBox ID="Grievance" runat="server" CssClass="form-check-input" />
                <label class="form-check-label" for="Grievance">Grievance</label>
            </div>
        </div>

        <div class="col-md-3 col-sm-6 mb-2">
            <div class="form-check">
                <asp:CheckBox ID="Notice" runat="server" CssClass="form-check-input" />
                <label class="form-check-label" for="Notice">Notice</label>
            </div>
        </div>
    </div>
</div>
