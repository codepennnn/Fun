public async Task<WorkOrderExemptionResult> GetExemptionAsync(string vendorCode, string workOrder)
{
    using (var connection = new SqlConnection(_connectionString))
    {
        string sql = @"
        SELECT TOP 1
            VendorCode,
            WorkOrderNo,
            CASE 
                WHEN DATEDIFF(DAY, Approved_On, GETDATE()) <= Exemption_CC THEN 'YES'
                ELSE 'NO'
            END AS IsExemption
        FROM App_WorkOrder_Exemption
        WHERE VendorCode = @VendorCode
          AND WorkOrderNo = @WorkOrder
          AND Status = 'Approved'
        ORDER BY Approved_On DESC";

        return await connection.QueryFirstOrDefaultAsync<WorkOrderExemptionResult>(sql, new
        {
            VendorCode = vendorCode,
            WorkOrder = workOrder
        });
    }
}

-------

[HttpGet("check-exemptions")]
public async Task<IActionResult> CheckExemptions(string vendorCode, string workOrders)
{
    try
    {
        // Even if user adds commas by mistake, just take first valid one
        var workOrder = workOrders.Split(',', StringSplitOptions.RemoveEmptyEntries)
                                  .Select(w => w.Trim())
                                  .FirstOrDefault();

        if (string.IsNullOrWhiteSpace(workOrder))
            return BadRequest("Invalid work order.");

        var data = await ExemtionContext.GetExemptionAsync(vendorCode, workOrder);

        if (data == null)
            return NotFound("No exemption found.");

        return Ok(data);
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Error checking exemptions");
        return StatusCode(500, "Internal server error");
    }
}
---------

public async Task<IEnumerable<WorkOrderExemptionResult>> GetExemptionsAsync(string vendorCode, string workOrder)
{
    using (var connection = new SqlConnection(_connectionString))
    {
        string sql = @"
        SELECT TOP 1
            VendorCode,
            WorkOrderNo,
            CASE 
                WHEN DATEDIFF(DAY, Approved_On, GETDATE()) <= Exemption_CC THEN 'YES'
                ELSE 'NO'
            END AS IsExemption
        FROM App_WorkOrder_Exemption
        WHERE VendorCode = @VendorCode
          AND Status = 'Approved'
          AND (
                WorkOrderNo = @WorkOrder
                OR WorkOrderNo LIKE @LikePattern1
                OR WorkOrderNo LIKE @LikePattern2
                OR WorkOrderNo LIKE @LikePattern3
          )
        ORDER BY Approved_On DESC";

        var result = await connection.QueryAsync<WorkOrderExemptionResult>(sql, new
        {
            VendorCode = vendorCode,
            WorkOrder = workOrder,
            LikePattern1 = workOrder + ",%",
            LikePattern2 = "%," + workOrder + ",%",
            LikePattern3 = "%," + workOrder
        });

        return result;
    }
}
