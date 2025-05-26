SELECT Approved_On,Exemption_CC,
    DATEDIFF(DAY, Approved_On, GETDATE()) AS DaysSinceApproval,
    CASE 
        WHEN DATEDIFF(DAY, Approved_On, GETDATE()) <= Exemption_CC THEN 'YES'
        ELSE 'NO'
    END AS isExemption
FROM App_WorkOrder_Exemption
WHERE VendorCode = '17201' 
  AND WorkOrderNo IN ('4700023762') 
  AND Status = 'Approved'
