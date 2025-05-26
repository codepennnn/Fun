public class WorkOrderExemptionResult
{
    public string WorkOrder { get; set; }
    public string VendorCode { get; set; }
    public DateTime ApproveOnDate { get; set; }
    public int Exemption_Cc { get; set; }
    public string Status { get; set; } // YES or NO
}
-----------

public async Task<IEnumerable<WorkOrderExemptionResult>> GetExemptionsAsync(string vendorCode, string[] workOrders, DateTime requestedDate)
{
    using (var connection = new SqlConnection(_connectionString))
    {
        string sql = @"
            SELECT WorkOrder, VendorCode, ApproveOnDate, exemption_cc
            FROM App_WorkOrder_Exemption
            WHERE VendorCode = @VendorCode
              AND WorkOrder IN @WorkOrders";

        var result = await connection.QueryAsync<WorkOrderExemptionResult>(sql, new { VendorCode = vendorCode, WorkOrders = workOrders });

        // Process result to add Status (YES or NO)
        foreach (var item in result)
        {
            var diff = (requestedDate - item.ApproveOnDate).Days;
            item.Status = diff <= item.Exemption_Cc ? "YES" : "NO";
        }

        return result;
    }
}

---------
public class WorkOrderExemptionResult
{
    public string WorkOrder { get; set; }
    public string VendorCode { get; set; }
    public DateTime ApproveOnDate { get; set; }
    public int Exemption_Cc { get; set; }
    public string Status { get; set; } // YES or NO
}
