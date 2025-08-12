SELECT *
FROM App_EmployeeMaster e
WHERE e.DOJ BETWEEN '2025-07-01' AND '2025-07-31'
  AND e.AadharCard IN (
        SELECT AadharCard
        FROM App_EmployeeMaster
        GROUP BY AadharCard
        HAVING COUNT(DISTINCT VendorCode) = 1
  );
  
