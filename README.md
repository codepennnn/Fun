public class WorkOrderExemptionResult
{
    public int ID { get; set; }
    public DateTime CreatedOn { get; set; }
    public string CreatedBy { get; set; }
    public string VendorCode { get; set; }
    public string VendorName { get; set; }
    public string WorkOrderNo { get; set; }
    public string Status { get; set; } // e.g., Approved or Returned
    public string Exemption_Vendor { get; set; }
    public int Exemption_CC { get; set; }
    public string Remarks { get; set; }
    public string Attachment { get; set; }
    public DateTime? ResubmittedOn { get; set; }
    public string ResubmittedBy { get; set; }
    public DateTime? Approved_On { get; set; }
    public string Approved_By { get; set; }
    
    public string WithinExemptionCC { get; set; } // YES or NO
}
