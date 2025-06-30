public async Task<dynamic> GetRetentionMoney(string vendorCode, string workOrder)
{
    using (var connection = new SqlConnection(_connectionString))
    {
        string sql = @" 
        IF EXISTS (
            SELECT 1 
            FROM App_Retention_Money_Summary 
            WHERE WorkOrderNo = @WorkOrder AND VendorCode = @VendorCode AND Status = 'Request Closed'
        )
        BEGIN
            SELECT 'Y' AS Status,
                   SlNo AS [To],
                   R.VendorCode,
                   R.WorkOrderNo,
                   R.VendorName,
                   R.WorkOrder_Fromdate,
                   R.WorkOrder_Todate,
                   G.LOC_OF_WORK,
                   R.CreatedBy AS Document_Receipt_Date_1st_Time,
                   R.Resubmit_Date AS Complete_Document_Receipt_On_Or_After_Correction,
                   R.L1_CreatedBy AS Scruntiny_Done_By_Name_Of_Verifier,
                   R.L1_CreatedOn AS Date_Of_Scruntiny,
                   'Contractor_Cell' AS Final_Approvers_Name,
                   R.L2_CreatedOn AS Compliance_Report_Issue_Date,
                   R.L1_Remarks AS Remarks
            FROM App_Retention_Money_Summary R
            INNER JOIN App_WorkOrder_Reg G ON R.WorkOrderNo = G.WO_NO
            WHERE R.WorkOrderNo = @WorkOrder AND R.VendorCode = @VendorCode AND R.Status = 'Request Closed'
        END
        ELSE
        BEGIN
            SELECT 'N' AS Status
        END";

        var result = await connection.QueryFirstOrDefaultAsync(sql, new { VendorCode = vendorCode, WorkOrder = workOrder });

        return result;
    }
}


[HttpGet("RetentionMoney")]
public async Task<IActionResult> RetentionMoneyDetail(string vendorCode, string workOrder)
{
    if (string.IsNullOrWhiteSpace(workOrder) || string.IsNullOrWhiteSpace(vendorCode))
        return BadRequest("Please Enter Vendor code and Workorder.");

    var data = await Context.GetRetentionMoney(vendorCode, workOrder);

    return Ok(data);
}




