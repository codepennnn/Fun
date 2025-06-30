using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using RetentionMoneyApi.DataAcess;

namespace RetentionMoneyApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RetentionController : ControllerBase
    {

        private readonly RetentionDataAcessLayer Context;

        private string _connectionString;

        public RetentionController(RetentionDataAcessLayer ExemtionContext)
        {
            this.Context = Context;
       
        }





        [HttpGet("RetentionMoney")]

        public async Task<IActionResult> RetentionMoneyDetail(string vendorCode, string workOrders)
        {
            try
            {

       

                if (string.IsNullOrWhiteSpace())
                    return BadRequest("Invalid work order.");

                var data = await Context.GetRetentionMoney(vendorCode, workOrder);

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
    }
}


namespace RetentionMoneyApi.DataAcess;
using Dapper;
using System.Data.SqlClient;
using RetentionMoneyApi.ViewModelDto;

{
    public class RetentionDataAcessLayer
    {
        private readonly string _connectionString;

        public RetentionDataAcessLayer(string connectionString)
        {
            _connectionString = connectionString;

        }


        public async Task<IEnumerable<RetentionMoneyResult>> GetRetentionMoney(string vendorCode, string workOrder)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                string sql = @"
        SELECT ";

                var result = await connection.QueryAsync<RetentionMoneyResult>(sql, new
                {
                 
                });

                return result;
            }
        }
    }
}

public class RetentionMoneyResult
{

    public string VendorCode { get; set; }

    public string WorkOrderNo { get; set; }
    public string IsRetention { get; set; }
}
