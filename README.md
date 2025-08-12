SELECT *
FROM App_EmployeeMaster e WHERE TRY_CONVERT(date, '20' + e.DOB) BETWEEN '2025-07-01' AND '2025-07-31'
    and  e.AadharCard IN (SELECT AadharCard FROM App_EmployeeMaster GROUP BY AadharCard
        HAVING COUNT(DISTINCT VendorCode) = 1)
Msg 402, Level 16, State 1, Line 7
The data types varchar and date are incompatible in the add operator.
