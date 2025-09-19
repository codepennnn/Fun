
 select concat(w.WO_NO, +' - ' + convert(varchar, w.TO_DATE, 103)) as WorkOrderNo
 ,w.WO_NO as WoNo from App_WorkOrder_Reg w 
 where
 WO_NO  NOT in (select  WO_NO  from App_Vendor_form_C3_Dtl where STATUS='Approved' and C3_CLOSER_DATE>GETDATE() and V_CODE=w.V_CODE )  
 and 
 w.V_CODE ='10482' and w.STATUS='Approved'   

 union 


 select concat(w.WO_NO, +' - ' + convert(varchar, w.TO_DATE, 103)) as WorkOrderNo
 ,w.WO_NO as WoNo from App_WorkOrder_Reg w 
 where
 WO_NO in (select  WO_NO  from App_Vendor_form_C3_Dtl where Ll_NO like 'NA_%' and STATUS='Approved' and V_CODE=w.V_CODE )  
 and 
 w.V_CODE ='10482' and w.STATUS='Approved'   
