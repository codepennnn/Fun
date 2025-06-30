..
public async Task<RetentionMoneyResult> GetRetentionMoney(string vendorCode, string workOrder)
{
    using (var connection = new SqlConnection(_connectionString))
    {
        string sql = @"
        IF EXISTS (
            SELECT 1 
            FROM App_Retention_Money_Summary 
            WHERE WorkOrderNo = @WorkOrder AND VendorCode = @VendorCode AND Status = 'Request Closed'
        )
        BEGIN
            SELECT VendorCode, WorkOrderNo, 'Y' AS IsRetention
            FROM App_Retention_Money_Summary
            WHERE WorkOrderNo = @WorkOrder AND VendorCode = @VendorCode AND Status = 'Request Closed'
        END
        ELSE
        BEGIN
            SELECT 'N' AS IsRetention
        END";

        var result = await connection.QueryFirstOrDefaultAsync<RetentionMoneyResult>(sql, new
        {
            VendorCode = vendorCode,
            WorkOrder = workOrder
        });

        return result;
    }
}

[HttpGet("RetentionMoney")]
public async Task<IActionResult> RetentionMoneyDetail(string vendorCode, string workOrder)
{
    if (string.IsNullOrWhiteSpace(workOrder) || string.IsNullOrWhiteSpace(vendorCode))
        return BadRequest("Please Enter Vendor code and Workorder.");

    var data = await Context.GetRetentionMoney(vendorCode, workOrder);

    return Ok(data);
}

