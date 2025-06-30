public async Task<RetentionMoneyResult> GetRetentionMoney(string vendorCode, string workOrder)
{
    using (var connection = new SqlConnection(_connectionString))
    {
        string sql = @"
            SELECT VendorCode, WorkOrderNo, 'Y' AS IsRetention
            FROM App_Retention_Money_Summary
            WHERE WorkOrderNo = @WorkOrder AND VendorCode = @VendorCode AND Status = 'Request Closed'";

        var result = await connection.QueryFirstOrDefaultAsync<RetentionMoneyResult>(sql, new
        {
            VendorCode = vendorCode,
            WorkOrder = workOrder  // <-- Match the SQL placeholder @WorkOrder
        });

        return result;
    }
}


public class RetentionMoneyResult
{
    public string VendorCode { get; set; }
    public string WorkOrderNo { get; set; }
    public string IsRetention { get; set; }
}
