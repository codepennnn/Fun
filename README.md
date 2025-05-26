this is my controller 
namespace WorkOrderExemtionApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ExemptionController : ControllerBase
    {
        private readonly WorkOrderExemptionDataAcess compliance;
        private readonly ILogger<ExemptionController> logger;

        public ExemptionController(WorkOrderExemptionDataAcess compliance, ILogger<ExemptionController> logger)
        {
            this.compliance = compliance;
            this.logger = logger;
        }


    }

    and this DataAcess cs 
        public class WorkOrderExemptionDataAcess
    {
        private readonly string _connectionString;

        public WorkOrderExemptionDataAcess(string connectionString)
        {
            _connectionString = connectionString;

        }






    }



    and i have table App_WorkOrder_Exemption
   => i want to get data on some conditon that if approveOndate and user requestedDate difference is under with my column which name exemption_cc data then print YES else NO
   and i am passing vendorCode and WorkOrder as a parameter my workorder data like 4700025465,4700025445 comma comma


    
