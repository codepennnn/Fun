public class WorkOrderExemptionResult
{
    public int ID { get; set; }
    public DateTime CreatedOn { get; set; }
    public string CreatedBy { get; set; }
    public string VendorCode { get; set; }
    public string VendorName { get; set; }
    public string WorkOrderNo { get; set; }
    public string Status { get; set; } // e.g., Approved or Returned
    public string Exemption_Vendor { get; set; }
    public int Exemption_CC { get; set; }
    public string Remarks { get; set; }
    public string Attachment { get; set; }
    public DateTime? ResubmittedOn { get; set; }
    public string ResubmittedBy { get; set; }
    public DateTime? Approved_On { get; set; }
    public string Approved_By { get; set; }
    
    public string WithinExemptionCC { get; set; } // YES or NO
}


------------

public async Task<IEnumerable<WorkOrderExemptionResult>> GetExemptionsAsync(string vendorCode, string[] workOrders, DateTime requestedDate)
{
    using (var connection = new SqlConnection(_connectionString))
    {
        string sql = @"
            SELECT *
            FROM App_WorkOrder_Exemption
            WHERE VendorCode = @VendorCode
              AND WorkOrderNo IN @WorkOrders
              AND Status = 'Approved'"; // Only approved entries considered

        var result = (await connection.QueryAsync<WorkOrderExemptionResult>(sql, new
        {
            VendorCode = vendorCode,
            WorkOrders = workOrders
        })).ToList();

        // Add custom logic for Exemption_CC check
        foreach (var item in result)
        {
            if (item.Approved_On.HasValue)
            {
                var diffDays = (requestedDate - item.Approved_On.Value).Days;
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
--------


[HttpGet("check-exemptions")]
public async Task<IActionResult> CheckExemptions(string vendorCode, string workOrders, DateTime requestedDate)
{
    try
    {
        var workOrderArray = workOrders.Split(',', StringSplitOptions.RemoveEmptyEntries)
                                       .Select(w => w.Trim()).ToArray();

        var data = await compliance.GetExemptionsAsync(vendorCode, workOrderArray, requestedDate);

        return Ok(data);
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Failed to fetch exemption data");
        return StatusCode(500, "Internal server error");
    }
}
