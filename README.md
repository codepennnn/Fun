using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using MyApiDapper.Models;

namespace MyApiDapper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WageController : ControllerBase
    {
        private readonly string conn;

        public WageController(IConfiguration configuration)
        {
            conn = configuration.GetConnectionString("dbcs");

            //  Console.WriteLine($"Connection string: {conn}");
        }


        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
               string query = "SELECT W.LocationCode As Loc_Code ,W.LocationNM As Loc_Name,W.AadharNo" +
                    ",(select top 1 Sex from App_EmployeeMaster where AadharCard=w.AadharNo order by CreatedOn desc) " +
                    "Gender,W.WorkManCategory As Skill,CONCAT(W.YearWage, RIGHT('0' + CAST(W.MonthWage AS VARCHAR(2)), 2)) AS YrMonth" +
                    ",W.VendorCode,W.VendorName," +
                    "W.WorkOrderNo," +
                    "(select top 1 DepartmentCode from App_DepartmentMaster " +
                    "where DepartmentName=(select top 1 DEPT_CODE from App_WorkOrder_Reg where WO_NO=w.WorkOrderNo) ) DeptCode," +
                    "(select top 1 DEPT_CODE from App_WorkOrder_Reg where WO_NO=w.WorkOrderNo )" +
                    " DeptName, W.TotPaymentDays As PaymentDays,'TSUISL' As EXECHEAD,W.TotalWages  As GrossWage," +
                    "W.BasicWages as Basic,W.DAWages as Da FROM App_WagesDetailsJharkhand w" +
                    " where MonthWage in ('12') and YearWage in ('2024' )";

                using (var connection = new SqlConnection(conn))
                {
                    var result = connection.Query(query);

                }
            }
            catch (Exception ex)
            {

                Console.WriteLine("The Exception is :\n" + ex.Message);
                return BadRequest(ex.Message);
            }
            return Ok();
        }



    }
}
