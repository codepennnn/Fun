  IF EXISTS (
       SELECT 1 
       FROM App_Retention_Money_Summary 
       WHERE  VendorCode='14243' and WorkorderNo='4700015059' AND Status = 'Request Closed'
   )
   BEGIN
       SELECT 'Y' AS Status,
SlNo as [To],
       R.VendorCode, R.WorkOrderNo,R.VendorName
       , format(R.WorkOrder_Fromdate,'dd-MM-yyyy') as WorkOrder_FromDate, 
         format(R.WorkOrder_Todate,'dd-MM-yyyy') as WorkOrder_ToDate, 
         lm.Location as Location_Of_Work,
         R.CreatedBy as Document_Receipt_Date_1st_Time
       ,format(R.Resubmit_Date,'dd-MM-yyyy') as Complete_Document_Receipt_On_Or_After_Correction
       ,R.L1_CreatedBy as Scruntiny_Done_By_Name_Of_Verifier
       ,format(R.L1_CreatedOn,'dd-MM-yyyy' ) as Date_Of_Scruntiny
       ,'Contractor_Cell' as 'Final_Approvers_Name'
       ,format(R.L2_CreatedOn,'dd-MM-yyyy')  as Compliance_Report_Issue_Date
       ,REPLACE(REPLACE(R.L1_Remarks, CHAR(13), ' '), CHAR(10), ' ') AS Level_1_Remarks
       ,REPLACE(REPLACE(R.L2_Remarks, CHAR(13), ' '), CHAR(10), ' ') AS Level_2_Remarks
       FROM App_Retention_Money_Summary R
       inner join App_WorkOrder_Reg G
       on R.WorkorderNo = G.WO_NO 
       inner join  App_LocationMaster lm on G.LOC_OF_WORK = lm.LocationCode
       WHERE R.WorkOrderNo = '4700015059' AND R.VendorCode = '14243' AND R.Status = 'Request Closed'
   END
   ELSE
   BEGIN
       SELECT 'N' AS Status
   END
