[HttpGet("RetentionMoney")]
public async Task<IActionResult> RetentionMoneyDetail(string vendorCode, string workOrder)
{
    try
    {
        if (string.IsNullOrWhiteSpace(workOrder) || string.IsNullOrWhiteSpace(vendorCode))
            return BadRequest("Invalid vendor code or work order.");

        var data = await Context.GetRetentionMoney(vendorCode, workOrder);

        if (data != null)
            return Ok(new { Status = "Y", Data = data });
        else
            return Ok(new { Status = "N" });
    }
    catch (Exception ex)
    {
        return StatusCode(500, "Internal server error");
    }
}


public async Task<RetentionMoneyResult> GetRetentionMoney(string vendorCode, string workOrder)
{
    using (var connection = new SqlConnection(_connectionString))
    {
        string sql = @"
            SELECT VendorCode, WorkOrderNo, 'Y' AS IsRetention
            FROM App_Retention_Money_Summary
            WHERE WorkOrder = @WorkOrder AND VendorCode = @VendorCode AND Status = 'request close'";

        var result = await connection.QueryFirstOrDefaultAsync<RetentionMoneyResult>(sql, new
        {
            VendorCode = vendorCode,
            WorkOrder = workOrder
        });

        return result;
    }
}

