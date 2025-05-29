SELECT TO_DATE, FROM_DATE, WO_NO 
FROM App_WorkOrder_Reg  
WHERE V_CODE = '15235' 
  AND WO_NO = (
    SELECT TOP 1 WO_NO 
    FROM App_EmployeeMaster 
    WHERE VendorCode = '15235' 
      AND AadharCard = '929025599977' 
    ORDER BY CreatedOn DESC
);
