if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Pending With CC" ||
    PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Approved")
{
    ((CheckBoxList)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo")).Enabled = false;
    ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Exemption_Vendor")).Enabled = false;
    ((FileUpload)WorkOrder_Exemption_Record.Rows[0].FindControl("Attachment")).Enabled = false;
    ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Enabled = false;
    btnSave.Enabled = false;
}
else
{
    WorkOrder_Exemption_Record.Enabled = true;
    btnSave.Enabled = true;
    ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Text = "";
    ((FileUpload)WorkOrder_Exemption_Record.Rows[0].FindControl("Attachment")).Enabled = true;
}
