
 IF EXISTS (
            SELECT 1 
            FROM App_Retention_Money_Summary 
            WHERE WorkOrderNo = '4700019766' AND VendorCode = '13893' AND Status = 'Request Closed'
        )
        BEGIN
            SELECT 'Y' AS R.Status,
     SlNo as [To],
            R.VendorCode, R.WorkOrderNo,R.VendorName,R.WorkOrder_Fromdate, R.WorkOrder_Todate,
             G.LOC_OF_WORK,
            R.CreatedBy as Document_Receipt_Date_1st_Time
            ,R.Resubmit_Date as Complete_Document_Receipt_On_Or_After_Correction
            ,R.L1_CreatedBy as Scruntiny_Done_By_Name_Of_Verifier
            ,R.L1_CreatedOn as Date_Of_Scruntiny
            ,'Contractor_Cell' as 'Final_Approvers_Name'
            ,R.L2_CreatedOn as Compliance_Report_Issue_Date
            ,R.L1_Remarks as Remarks




            FROM App_Retention_Money_Summary R

            inner join App_WorkOrder_Reg G
            on R.WorkorderNo = G.WO_NO 

            WHERE WorkOrderNo = '4700019766' AND VendorCode = '13893' AND Status = 'Request Closed'
        END
        ELSE
        BEGIN
            SELECT 'N' AS IsRetention
        END
