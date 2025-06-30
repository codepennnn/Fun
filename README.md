    [HttpGet("RetentionMoney")]
    public async Task<IActionResult> RetentionMoneyDetail(string vendorCode, string workOrder)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(workOrder) || string.IsNullOrWhiteSpace(vendorCode))
                return BadRequest("Please Enter Vendor code and Workorder.");

            var data = await Context.GetRetentionMoney(vendorCode, workOrder);

            if (data != null)
                return Ok(new { Status = "Y", Data = data });
            else
                return Ok(new { Status = "N" });
        }
        catch (Exception ex)
        {
            return StatusCode(500, "Internal server error");
        }
    }

       public async Task<RetentionMoneyResult> GetRetentionMoney(string vendorCode, string workOrder)
   {
       using (var connection = new SqlConnection(_connectionString))
       {
           string sql = @"
           SELECT VendorCode, WorkOrderNo, 'Y' AS IsRetention
           FROM App_Retention_Money_Summary
           WHERE WorkorderNo = @workOrder AND VendorCode = @VendorCode AND Status = 'Request Closed'";

           var result = await connection.QueryFirstOrDefaultAsync<RetentionMoneyResult>(sql, new
           {
               VendorCode = vendorCode,
               WorkorderNo = workOrder
           });

           return result;
       }
   }

       public class RetentionMoneyResult
    {

        public string vendorCode { get; set; }

        public string workOrder { get; set; }
        public string IsRetention { get; set; }
    }
