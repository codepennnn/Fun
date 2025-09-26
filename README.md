   public bool IsWorkOrderInExemptionPeriod(string workOrderNo)
   {
       string StrSQL = "SELECT COUNT(*) FROM App_WorkOrder_Exemption WHERE WorkOrderNo = @WorkOrderNo  AND Status = 'Approved'  AND GETDATE() <= DATEADD(DAY, exemption_cc, ApprovedDate)";
       Dictionary<string, object> objParam = new Dictionary<string, object>();
       DataHelper dh = new DataHelper();
       return dh.GetDataset(StrSQL, "App_WorkOrder_Exemption", objParam);
   }
