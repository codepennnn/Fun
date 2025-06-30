..


public class RetentionMoneyResult
{
    public string Status { get; set; }
    public int To { get; set; }   // Assuming SlNo is INT
    public string VendorCode { get; set; }
    public string WorkOrderNo { get; set; }
    public string VendorName { get; set; }
    public DateTime? WorkOrder_Fromdate { get; set; }
    public DateTime? WorkOrder_Todate { get; set; }
    public string Loc_Of_Work { get; set; }
    public string Document_Receipt_Date_1st_Time { get; set; }
    public DateTime? Complete_Document_Receipt_On_Or_After_Correction { get; set; }
    public string Scruntiny_Done_By_Name_Of_Verifier { get; set; }
    public DateTime? Date_Of_Scruntiny { get; set; }
    public string Final_Approvers_Name { get; set; }
    public DateTime? Compliance_Report_Issue_Date { get; set; }
    public string Remarks { get; set; }
}
