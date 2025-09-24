protected void WorkOrder_Exemption_Records_SelectedIndexChanged(object sender, EventArgs e)
{
    GetRecord(WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());
    WorkOrder_Exemption_Records.SelectedIndex = -1;
    WorkOrder_Exemption_Record.BindData();
    DivInputFields.Visible = true;

    // Ensure there is at least one row and handle DBNull safely
    if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows.Count > 0)
    {
        var status = PageRecordDataSet.Tables["App_WorkOrder_Exemption"]
                                       .Rows[0]["Status"]?.ToString();

        if (string.Equals(status, "Approved", StringComparison.OrdinalIgnoreCase))
        {
            btnSave.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
        }
    }
}
