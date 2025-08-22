WITH RankedAttendance AS (
    SELECT
        AD.VendorCode,
        AD.WorkOrderNo,

        (SELECT TOP 1 EM.Sex 
         FROM App_EmployeeMaster EM
         WHERE EM.AadharCard = AD.AadharNo
           AND EM.VendorCode = AD.VendorCode
           AND EM.WorkManSlNo = AD.WorkManSl
         ORDER BY EM.CreatedOn DESC) AS Sex,

        (SELECT TOP 1 EM.Social_Category
         FROM App_EmployeeMaster EM
         WHERE EM.AadharCard = AD.AadharNo
           AND EM.VendorCode = AD.VendorCode
           AND EM.WorkManSlNo = AD.WorkManSl
         ORDER BY EM.CreatedOn DESC) AS Social_Category,

        AD.WorkManCategory,

        (SELECT TOP 1 EM.AadharCard
         FROM App_EmployeeMaster EM
         WHERE EM.AadharCard = AD.AadharNo
           AND EM.VendorCode = AD.VendorCode
           AND EM.WorkManSlNo = AD.WorkManSl
         ORDER BY EM.CreatedOn DESC) AS AadharCard,

        CAST(AD.Present AS INT) AS Present,

        (SELECT TOP 1 EM.CreatedOn
         FROM App_EmployeeMaster EM
         WHERE EM.AadharCard = AD.AadharNo
           AND EM.VendorCode = AD.VendorCode
           AND EM.WorkManSlNo = AD.WorkManSl
         ORDER BY EM.CreatedOn DESC) AS CreatedOn,

        ROW_NUMBER() OVER (
            PARTITION BY AD.VendorCode,
                         AD.WorkOrderNo,
                         (SELECT TOP 1 EM.Sex 
                          FROM App_EmployeeMaster EM
                          WHERE EM.AadharCard = AD.AadharNo
                            AND EM.VendorCode = AD.VendorCode
                            AND EM.WorkManSlNo = AD.WorkManSl
                          ORDER BY EM.CreatedOn DESC),
                         (SELECT TOP 1 EM.Social_Category
                          FROM App_EmployeeMaster EM
                          WHERE EM.AadharCard = AD.AadharNo
                            AND EM.VendorCode = AD.VendorCode
                            AND EM.WorkManSlNo = AD.WorkManSl
                          ORDER BY EM.CreatedOn DESC),
                         AD.WorkManCategory
            ORDER BY (SELECT TOP 1 EM.CreatedOn
                      FROM App_EmployeeMaster EM
                      WHERE EM.AadharCard = AD.AadharNo
                        AND EM.VendorCode = AD.VendorCode
                        AND EM.WorkManSlNo = AD.WorkManSl
                      ORDER BY EM.CreatedOn DESC) DESC
        ) AS rn

    FROM App_AttendanceDetails AD
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
        COUNT(DISTINCT AadharCard) AS TotalWorkers,
        SUM(Present) AS TotalMandays
    FROM RankedAttendance
    WHERE rn = 1
    GROUP BY VendorCode, WorkOrderNo, Sex, Social_Category, WorkManCategory
)
