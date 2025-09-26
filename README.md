public bool IsWorkOrderInExemptionPeriod(string workOrderNo)
{
    // Example query – adjust table/column names if different
    string sql = @"
        SELECT COUNT(*) 
        FROM App_WorkOrder_Exemption 
        WHERE WorkOrderNo = @WorkOrderNo
          AND Status = 'Approved'
          AND GETDATE() <= DATEADD(DAY, exemption_cc, ApprovedDate)";

    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["YourConn"].ConnectionString))
    using (SqlCommand cmd = new SqlCommand(sql, con))
    {
        cmd.Parameters.AddWithValue("@WorkOrderNo", workOrderNo);
        con.Open();
        int cnt = (int)cmd.ExecuteScalar();
        return cnt > 0;
    }
}
// Validation: ensure no duplicate approved workorder in exemption period
BL_WorkOrder_Exemption blobj = new BL_WorkOrder_Exemption();

string[] selectedWorkorders = PageRecordDataSet.Tables["App_WorkOrder_Exemption"]
                                .Rows[0]["WorkOrderNo"].ToString()
                                .Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

foreach (string wo in selectedWorkorders)
{
    if (blobj.IsWorkOrderInExemptionPeriod(wo.Trim()))
    {
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
            $"Work Order {wo} is already approved and still within the exemption period. Duplicate not allowed!");
        return;   // Stop saving
    }
}
