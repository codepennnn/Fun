SELECT DISTINCT a.wo_no AS Workorder
FROM App_WorkOrder_Reg AS a
WHERE a.FROM_DATE <= '2025-06-30'
  AND a.TO_DATE >= '2025-06-01'
  AND a.STATUS = 'Approved'
