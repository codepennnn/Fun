[HttpGet("check-exemptions")]
public async Task<IActionResult> CheckExemptions(string vendorCode, string workOrders)
{
    try
    {
        var workOrder = workOrders.Split(',', StringSplitOptions.RemoveEmptyEntries)
                                  .Select(w => w.Trim())
                                  .FirstOrDefault();

        if (string.IsNullOrWhiteSpace(workOrder))
            return BadRequest("Invalid work order.");

        var data = await ExemtionContext.GetExemptionsAsync(vendorCode, workOrder);

        if (data == null || !data.Any())
            return NotFound("No exemption found.");

        return Ok(data);
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Error checking exemptions");
        return StatusCode(500, "Internal server error");
    }
}
