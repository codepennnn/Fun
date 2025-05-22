namespace ComplianceDBTS_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DBTSController : ControllerBase
    {
        private readonly complianceDBTSService compliance;
        private readonly ILogger<DBTSController> logger;

        public DBTSController(complianceDBTSService compliance,ILogger<DBTSController>logger) 
        {
            this.compliance = compliance;
            this.logger = logger;
        }

        [HttpGet("ComplianceDetails")]
        public IActionResult GetAllDetails(string WorkOrderNo, string VendorCode)
        {
            try
            {
                var data = compliance.RR_Alert_latest(WorkOrderNo, VendorCode);

                return Ok(data);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error Occured while Getting RR_ALert_Latest");
                return StatusCode(500, ex.Message);
            }


        }

        [HttpGet("LeaveDetails")]
        public IActionResult GetLeaveDetails(string WorkOrderNo, string VendorCode)
        {
            try
            {
                var data = compliance.Leave_details(WorkOrderNo, VendorCode);

                return Ok(data);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error Occured while Getting RR_ALert_Latest");
                return StatusCode(500, ex.Message);
            }
        }

        [HttpGet("BonusDetails")]
        public IActionResult GetBonusDetails(string WorkOrderNo, string VendorCode)
        {
            try
            {
                var data = compliance.Bonus_details(WorkOrderNo, VendorCode);

                return Ok(data);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error Occured while Getting RR_ALert_Latest");
                return StatusCode(500, ex.Message);
            }
        }

        
    }
}
