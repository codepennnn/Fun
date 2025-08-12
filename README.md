SELECT *
FROM Employee e
WHERE 
    -- DOB between 1st July and 31st July in any year
    TRY_CONVERT(date, '20' + e.DOB) BETWEEN '2025-07-01' AND '2025-07-31'
    
    -- Aadhar appears only once per VendorCode
    AND e.AadharNo IN (
        SELECT AadharNo
        FROM Employee
        GROUP BY AadharNo
        HAVING COUNT(DISTINCT VendorCode) = 1
    );
