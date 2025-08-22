     WITH RankedAttendance AS (
         SELECT
             AD.VendorCode,
             AD.WorkOrderNo,
             EM.Sex,
             EM.Social_Category,
             AD.WorkManCategory,
             EM.AadharCard,
             CAST(AD.Present AS INT) AS Present,
             EM.CreatedOn,
             ROW_NUMBER() OVER (
                 PARTITION BY AD.VendorCode, AD.WorkOrderNo, EM.Sex, EM.Social_Category, AD.WorkManCategory
                 ORDER BY EM.CreatedOn DESC
             ) AS rn
         FROM App_AttendanceDetails AD
         INNER JOIN App_EmployeeMaster EM
             ON EM.AadharCard = AD.AadharNo
             AND EM.VendorCode = AD.VendorCode
             AND EM.WorkManSlNo = AD.WorkManSl
         WHERE AD.dates >= '2025-07-01' AND AD.dates < '2025-07-31 23:59:59'
     ),

     AttendanceAgg AS (
         SELECT
             VendorCode,
             WorkOrderNo,
             Sex,
             Social_Category,
             WorkManCategory,
             COUNT(DISTINCT AadharCard) AS TotalWorkers,
             SUM(Present) AS TotalMandays
         FROM RankedAttendance
         WHERE rn = 1
         GROUP BY VendorCode, WorkOrderNo, Sex, Social_Category, WorkManCategory
     ),
