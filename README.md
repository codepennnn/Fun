    public string Grievance(string VendorCode)
    {
        string GrievanceData = "";
        using (SqlConnection con = new SqlConnection("Data Source=10.0.168.50;Initial Catalog=CLMSDB;User ID=fs;Password=p@ssW0Rd321;TrustServerCertificate=True"))
        {
            string query = " select G.REF_NO, G.CreatedOn,G.V_CODE,G.STATUS,G.TARGET_DT ,(select TOP 1 Revised_Date from App_Vendor_Grievance_Details where master_id=G.ID and Revised_Date is not null order by CreatedOn) Revised_Date from App_Vendor_Grievance as G where status='OPEN' and V_CODE=@VendorCode";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                
                cmd.Parameters.AddWithValue("@VendorCode", VendorCode);
                con.Open();
                GrievanceData = (string)cmd.ExecuteScalar();
            }
        }
        return GrievanceData;
    }


    public string GovtNotice(string VendorCode)
    {
        string GovtData = "";
        using (SqlConnection con = new SqlConnection("Data Source=10.0.168.50;Initial Catalog=CLMSDB;User ID=fs;Password=p@ssW0Rd321;TrustServerCertificate=True"))
        {
            string query = "select G.REF_NO, G.CreatedOn,G.V_CODE,G.STATUS,G.TARGET_DATE ,(select TOP 1 Revised_Date from App_Gov_Notice_Details where master_id=G.ID and Revised_Date is not null order by CreatedOn) Revised_Date from App_Gov_Notice as G where status='OPEN' and V_CODE=@VendorCode";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
    
                cmd.Parameters.AddWithValue("@VendorCode", VendorCode);
                con.Open();
                GovtData = (string)cmd.ExecuteScalar();
            }
        }
        return GovtData;
    }

    my data not passing and if data null then show blank instead of null



    public IActionResult GetAllCombinedDetails(string WorkOrderNo, string VendorCode)
{


    if (string.IsNullOrWhiteSpace(WorkOrderNo) || string.IsNullOrWhiteSpace(VendorCode))
    {
        return BadRequest("WorkOrderNo and VendorCode are required.");
    }



    try
    {
        var complianceData = compliance.RR_Alert_latest(WorkOrderNo, VendorCode);
        var leaveData = compliance.Leave_details(WorkOrderNo, VendorCode);
        var bonusData = compliance.Bonus_details(WorkOrderNo, VendorCode);

    
        var grievance = compliance.Grievance(VendorCode);
        var govtNotice = compliance.GovtNotice(VendorCode);

        var isRetentionClosed = compliance.RetentionMoney(WorkOrderNo, VendorCode);
        var isRecognised = compliance.Recognized(WorkOrderNo, VendorCode);

        var result = new CombinedModelDto
        {
            ComplianceDetails = complianceData,
            LeaveDetails = leaveData,
            BonusDetails = bonusData,
            Grievance = grievance,
            GovtNotice = govtNotice,
            RetentionMoney = isRetentionClosed,
            Recognized = isRecognised
        };

        return Ok(result);
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "Error Occurred while Getting All Details");
        return StatusCode(500, ex.Message);
    }

}
