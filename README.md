SELECT 
    ID,
    VendorCode,
    WorkOrderNo,
    Approved_On,
    Exemption_CC,
    DATEDIFF(DAY, Approved_On, GETDATE()) AS DaysSinceApproval,
    CASE 
        WHEN DATEDIFF(DAY, Approved_On, GETDATE()) <= Exemption_CC THEN 'YES'
        ELSE 'NO'
    END AS WithinExemptionCC
FROM App_WorkOrder_Exemption
WHERE VendorCode = 'YourVendorCode' 
  AND WorkOrderNo IN ('4700025465', '4700025445') 
  AND Status = 'Approved'
