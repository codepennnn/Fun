   public string IsRetentionRequestClosed(string WorkOrder, string VendorCode)
   {
       string isClosed = "";
       using (SqlConnection con = new SqlConnection("Data Source=10.0.168.50;Initial Catalog=CLMSDB;User ID=fs;Password=p@ssW0Rd321;TrustServerCertificate=True"))
       {
           string query = "SELECT  ISNULL(case when COUNT(*) > 0 then 'Y' else 'N' end,'N') as RetentionMoney FROM App_Retention_Money_summary WHERE WorkOrderNo = @WorkOrder AND VendorCode = @VendorCode AND Status = 'Request Closed'";
           using (SqlCommand cmd = new SqlCommand(query, con))
           {
               cmd.Parameters.AddWithValue("@WorkOrder", WorkOrder);
               cmd.Parameters.AddWithValue("@VendorCode", VendorCode);
               con.Open();
               int count = (int)cmd.ExecuteScalar();

               using (SqlDataReader rdr = cmd.ExecuteReader())
               {
                   while (rdr.Read())
                   {
                       isClosed = rdr.GetString(0);
                   }
               }

           }
       }
       return isClosed;
   }
and    [HttpGet("AllDetails")]
   public IActionResult GetAllCombinedDetails(string WorkOrderNo, string VendorCode)
   {
       try
       {
           var complianceData = compliance.RR_Alert_latest(WorkOrderNo, VendorCode);
           var leaveData = compliance.Leave_details(WorkOrderNo, VendorCode);
           var bonusData = compliance.Bonus_details(WorkOrderNo, VendorCode);

       
           var isRetentionClosed = compliance.IsRetentionRequestClosed(WorkOrderNo, VendorCode);

           var result = new CombinedModelDto
           {
               ComplianceDetails = complianceData,
               LeaveDetails = leaveData,
               BonusDetails = bonusData,
               IsRetentionRequestClosed = isRetentionClosed 
           };

           return Ok(result);
       }
       catch (Exception ex)
       {
           logger.LogError(ex, "Error Occurred while Getting All Details");
           return StatusCode(500, ex.Message);
       }

   }


   	
Error: response status is 500

Response body
Download
Unable to cast object of type 'System.String' to type 'System.Int32'.
