SELECT VendorCode, WorkOrderNo, Approved_On, Exemption_CC,
       CASE 
           WHEN DATEDIFF(DAY, Approved_On, GETDATE()) <= Exemption_CC THEN 'YES'
           ELSE 'NO'
       END AS IsExemption
FROM App_WorkOrder_Exemption a
WHERE Approved_On = (
    SELECT MAX(Approved_On)
    FROM App_WorkOrder_Exemption
    WHERE WorkOrderNo = a.WorkOrderNo
      AND VendorCode = @VendorCode
      AND Status = 'Approved'
)
AND VendorCode = @VendorCode
AND WorkOrderNo IN @WorkOrders
