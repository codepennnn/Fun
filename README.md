using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace MyApiDapper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WageController : ControllerBase
    {
        private readonly string _connectionString;

        public WageController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("dbcs");
        }

        [HttpGet]
        public async Task<IActionResult> GetAll([FromQuery] DateTime fromDate, [FromQuery] DateTime toDate)
        {
            try
            {
                string query = @"
                SELECT 
                    W.LocationCode AS Loc_Code,
                    W.LocationNM AS Loc_Name,
                    W.AadharNo,
                    (SELECT TOP 1 Sex FROM App_EmployeeMaster 
                     WHERE AadharCard = W.AadharNo 
                     ORDER BY CreatedOn DESC) AS Gender,
                    W.WorkManCategory AS Skill,
                    CONCAT(W.YearWage, RIGHT('0' + CAST(W.MonthWage AS VARCHAR(2)), 2)) AS YrMonth,
                    W.VendorCode,
                    W.VendorName,
                    W.WorkOrderNo,
                    (SELECT TOP 1 DepartmentCode FROM App_DepartmentMaster 
                     WHERE DepartmentName = 
                         (SELECT TOP 1 DEPT_CODE FROM App_WorkOrder_Reg 
                          WHERE WO_NO = W.WorkOrderNo)) AS DeptCode,
                    (SELECT TOP 1 DEPT_CODE FROM App_WorkOrder_Reg 
                     WHERE WO_NO = W.WorkOrderNo) AS DeptName,
                    W.TotPaymentDays AS PaymentDays,
                    'TSUISL' AS EXECHEAD,
                    W.TotalWages AS GrossWage,
                    W.BasicWages AS Basic,
                    W.DAWages AS Da
                FROM App_WagesDetailsJharkhand W
                WHERE 
                    CONCAT(W.YearWage, '-', RIGHT('0' + CAST(W.MonthWage AS VARCHAR(2)), 2), '-01') 
                    BETWEEN @FromDate AND @ToDate";

                using (var connection = new SqlConnection(_connectionString))
                {
                    var result = await connection.QueryAsync(query, new { FromDate = fromDate, ToDate = toDate });

                    // Return the result as JSON
                    return Ok(result);
                }
            }
            catch (Exception ex)
            {
                // Log the error (improve with a logging library like Serilog)
                Console.WriteLine("The Exception is:\n" + ex.Message);
                return BadRequest(new { Error = ex.Message });
            }
        }
    }
}
