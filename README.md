
select 'Please Select' as WorkOrderNo , 0 as ID union select concat(w.WO_NO, +' - ' + convert(varchar, TO_DATE, 103)) as WorkOrderNo 
,1 as ID from App_WorkOrder_Reg w where 
NOT EXISTS

(select wo_no from App_Vendor_form_C3_Dtl c where w.WO_NO = c.WO_NO and
(c.STATUS='Approved' or c.STATUS='Pending with CC')  ) and

w.V_CODE = '10511' and w.STATUS='Approved' order by ID
