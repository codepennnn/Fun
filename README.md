WITH AttendanceWithEmp AS (
    SELECT
        AD.VendorCode,
        AD.WorkOrderNo,
        EM.Sex,
        EM.Social_Category,
        AD.WorkManCategory,
        EM.AadharCard,
        CAST(AD.Present AS INT) AS Present,
        AD.dates
    FROM App_AttendanceDetails AD
    OUTER APPLY (
        SELECT TOP 1 *
        FROM App_EmployeeMaster EM
        WHERE EM.AadharCard = AD.AadharNo
          AND EM.VendorCode = AD.VendorCode
          AND EM.WorkManSlNo = AD.WorkManSl
        ORDER BY EM.CreatedOn DESC
    ) EM
    WHERE AD.dates >= '2025-07-01'
      AND AD.dates < '2025-07-31 23:59:59'
),

AttendanceAgg AS (
    SELECT
        VendorCode,
        WorkOrderNo,
        Sex,
        Social_Category,
        WorkManCategory,
        COUNT(DISTINCT AadharCard) AS TotalWorkers,   -- unique workers
        SUM(Present) AS TotalMandays                  -- sum of daily attendance
    FROM AttendanceWithEmp
    GROUP BY VendorCode, WorkOrderNo, Sex, Social_Category, WorkManCategory
)
SELECT * FROM AttendanceAgg;

