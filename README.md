[HttpGet("AllDetails")]
public IActionResult GetAllCombinedDetails(string WorkOrderNo, string VendorCode)
{
    try
    {
        var complianceData = compliance.RR_Alert_latest(WorkOrderNo, VendorCode);
        var leaveData = compliance.Leave_details(WorkOrderNo, VendorCode);
        var bonusData = compliance.Bonus_details(WorkOrderNo, VendorCode);

        // Call the new method here
        var isRetentionClosed = compliance.IsRetentionRequestClosed(WorkOrderNo, VendorCode);

        var result = new CombinedModelDto
        {
            ComplianceDetails = complianceData,
            LeaveDetails = leaveData,
            BonusDetails = bonusData,
            IsRetentionRequestClosed = isRetentionClosed // Set the value
        };

        return Ok(result);
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Error Occurred while Getting All Details");
        return StatusCode(500, ex.Message);
    }

    public class CombinedModelDto
{
    public List<Dictionary<string, object>> ComplianceDetails { get; set; }
    public List<Dictionary<string, object>> LeaveDetails { get; set; }
    public List<Dictionary<string, object>> BonusDetails { get; set; }
    public bool IsRetentionRequestClosed { get; set; } // <-- Add this
} and

public bool IsRetentionRequestClosed(string WorkOrder, string VendorCode)
{
    bool isClosed = false;
    using (SqlConnection con = new SqlConnection("Data Source=10.0.168.50;Initial Catalog=CLMSDB;User ID=fs;Password=p@ssW0Rd321;TrustServerCertificate=True"))
    {
        string query = "SELECT COUNT(*) FROM App_retention_summary WHERE WorkOrderNo = @WorkOrder AND VendorCode = @VendorCode AND Status = 'request close'";
        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            cmd.Parameters.AddWithValue("@WorkOrder", WorkOrder);
            cmd.Parameters.AddWithValue("@VendorCode", VendorCode);
            con.Open();
            int count = (int)cmd.ExecuteScalar();
            isClosed = count > 0;
        }
    }
    return isClosed;
}
}
