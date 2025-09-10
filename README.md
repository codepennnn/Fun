// Reset all to 0 first
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Wage"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["PF_ESI"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Leave"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Bonus"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["LabourLicense"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Grievance"] = 0;
PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Notice"] = 0;

// Now set selected ones to 1
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
                PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["PF_ESI"] = 1;
                break;
            case "Leave":
                PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Leave"] = 1;
                break;
            case "Bonus":
                PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Bonus"] = 1;
                break;
            case "Labour License":
                PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["LabourLicense"] = 1;
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










if (e.Row.RowType == DataControlRowType.DataRow)
{
    CheckBoxList chkCompliance = (CheckBoxList)e.Row.FindControl("ComplianceType");

    if (chkCompliance != null)
    {
        DataRowView drv = (DataRowView)e.Row.DataItem;

        chkCompliance.Items.FindByText("Wage").Selected = Convert.ToBoolean(drv["Wage"]);
        chkCompliance.Items.FindByText("PF & ESI").Selected = Convert.ToBoolean(drv["PF_ESI"]);
        chkCompliance.Items.FindByText("Leave").Selected = Convert.ToBoolean(drv["Leave"]);
        chkCompliance.Items.FindByText("Bonus").Selected = Convert.ToBoolean(drv["Bonus"]);
        chkCompliance.Items.FindByText("Labour License").Selected = Convert.ToBoolean(drv["LabourLicense"]);
        chkCompliance.Items.FindByText("Grievance").Selected = Convert.ToBoolean(drv["Grievance"]);
        chkCompliance.Items.FindByText("Notice").Selected = Convert.ToBoolean(drv["Notice"]);
    }
}
