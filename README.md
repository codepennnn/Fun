   public async Task<IEnumerable<WorkOrderExemptionResult>> GetExemptionsAsync(string vendorCode, string[] workOrders)
   {
       using (var connection = new SqlConnection(_connectionString))
       {
           string sql = @"
           SELECT TOP 1
               VendorCode,
               WorkOrderNo,
               CASE 
                   WHEN DATEDIFF(DAY, Approved_On, GETDATE()) <= Exemption_CC THEN 'YES'
                   ELSE 'NO'
               END AS IsExemption
           FROM App_WorkOrder_Exemption
           WHERE VendorCode = @VendorCode
             AND WorkOrderNo IN @WorkOrders
             AND Status = 'Approved' order by Approved_On desc";







           var result = await connection.QueryAsync<WorkOrderExemptionResult>(sql, new
           {
               VendorCode = vendorCode,
               WorkOrders = workOrders
           });

           return result;
       }
   }

-------------


        [HttpGet("check-exemptions")]
        public async Task<IActionResult> CheckExemptions(string vendorCode, string workOrders)
        {
            try
            {
                var workOrderArray = workOrders.Split(',', StringSplitOptions.RemoveEmptyEntries)
                                               .Select(w => w.Trim()).ToArray();

                var data = await ExemtionContext.GetExemptionsAsync(vendorCode, workOrderArray);

                return Ok(data);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error checking exemptions");
                return StatusCode(500, "Internal server error");
            }
        }
