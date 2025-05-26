foreach (var item in result)
{
    if (item.Approved_On.HasValue && item.Exemption_CC > 0)
    {
        int diffDays = (DateTime.Today - item.Approved_On.Value.Date).Days;
        item.WithinExemptionCC = diffDays <= item.Exemption_CC ? "YES" : "NO";
    }
    else
    {
        item.WithinExemptionCC = "NO";
    }
}

-----
[HttpGet("check-exemptions")]
public async Task<IActionResult> CheckExemptions(string vendorCode, string workOrders)
{
    try
    {
        var workOrderArray = workOrders.Split(',', StringSplitOptions.RemoveEmptyEntries)
                                       .Select(w => w.Trim()).ToArray();

        var data = await compliance.GetExemptionsAsync(vendorCode, workOrderArray);

        return Ok(data);
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Error checking exemptions");
        return StatusCode(500, "Internal server error");
    }
}
-----
public async Task<IEnumerable<WorkOrderExemptionResult>> GetExemptionsAsync(string vendorCode, string[] workOrders)
{
    using (var connection = new SqlConnection(_connectionString))
    {
        string sql = @"
            SELECT *
            FROM App_WorkOrder_Exemption
            WHERE VendorCode = @VendorCode
              AND WorkOrderNo IN @WorkOrders
              AND Status = 'Approved'";

        var result = (await connection.QueryAsync<WorkOrderExemptionResult>(sql, new
        {
            VendorCode = vendorCode,
            WorkOrders = workOrders
        })).ToList();

        foreach (var item in result)
        {
            if (item.Approved_On.HasValue && item.Exemption_CC > 0)
            {
                int diffDays = (DateTime.Today - item.Approved_On.Value.Date).Days;
                item.WithinExemptionCC = diffDays <= item.Exemption_CC ? "YES" : "NO";
            }
            else
            {
                item.WithinExemptionCC = "NO";
            }
        }

        return result;
    }
}
