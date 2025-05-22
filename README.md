public class CombinedDetailsDto
{
    public object ComplianceDetails { get; set; }
    public object LeaveDetails { get; set; }
    public object BonusDetails { get; set; }
}



[HttpGet("AllDetails")]
public IActionResult GetAllCombinedDetails(string WorkOrderNo, string VendorCode)
{
    try
    {
        var complianceData = compliance.RR_Alert_latest(WorkOrderNo, VendorCode);
        var leaveData = compliance.Leave_details(WorkOrderNo, VendorCode);
        var bonusData = compliance.Bonus_details(WorkOrderNo, VendorCode);

        var result = new CombinedDetailsDto
        {
            ComplianceDetails = complianceData,
            LeaveDetails = leaveData,
            BonusDetails = bonusData
        };

        return Ok(result);
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Error Occurred while Getting All Details");
        return StatusCode(500, ex.Message);
    }
}
