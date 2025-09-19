SELECT 
    CONCAT(w.WO_NO, ' - ', CONVERT(varchar, w.TO_DATE, 103)) AS WorkOrderNo,
    w.WO_NO AS WoNo
FROM App_WorkOrder_Reg w
WHERE w.V_CODE = '10482' 
  AND w.STATUS = 'Approved'
  AND w.WO_NO NOT IN (
        SELECT c3.WO_NO 
        FROM App_Vendor_form_C3_Dtl c3
        WHERE c3.STATUS = 'Approved' 
          AND c3.C3_CLOSER_DATE > GETDATE()
          AND c3.V_CODE = w.V_CODE
  )

UNION

SELECT 
    CONCAT(w.WO_NO, ' - ', CONVERT(varchar, w.TO_DATE, 103)) AS WorkOrderNo,
    w.WO_NO AS WoNo
FROM App_WorkOrder_Reg w
WHERE w.V_CODE = '10482' 
  AND w.STATUS = 'Approved'
  AND w.WO_NO IN (
        SELECT c3.WO_NO 
        FROM App_Vendor_form_C3_Dtl c3
        WHERE c3.Ll_NO LIKE 'NA_%' 
          AND c3.STATUS = 'Approved'
          AND c3.V_CODE = w.V_CODE
  );
  
