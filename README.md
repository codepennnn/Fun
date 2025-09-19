
 select concat(w.WO_NO, +' - ' + convert(varchar, w.TO_DATE, 103)) as WorkOrderNo
 ,w.WO_NO as WoNo from App_WorkOrder_Reg w where
 WO_NO in (select  WO_NO  from App_Vendor_form_C3_Dtl where Ll_NO like 'NA_%' and STATUS='Approved' and C3_CLOSER_DATE>GETDATE() ) 
 
 and w.V_CODE ='17316' and w.STATUS='Approved'   
