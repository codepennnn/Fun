-- Step 1: Declare date range
WITH DateList AS (
    SELECT CAST('2025-06-01' AS DATE) AS AttnDate
    UNION ALL
    SELECT DATEADD(DAY, 1, AttnDate)
    FROM DateList
    WHERE AttnDate < '2025-06-30'
),

-- Step 2: Get Active Employees
ActiveEmployees AS (
    SELECT PNO, EMPNAME  -- Adjust as needed
    FROM App_Empl_Master
    WHERE Discharge_Date IS NULL
),

-- Step 3: Cross join dates with employees
EmployeeDates AS (
    SELECT e.PNO, e.EMPNAME, d.AttnDate
    FROM ActiveEmployees e
    CROSS JOIN DateList d
),

-- Step 4: Get Attendance
Attendance AS (
    SELECT DISTINCT TRBDGDA_BD_PNO AS PNO, TRBDGDA_BD_DATE AS AttnDate
    FROM T_TRBDGDAT_EARS
),

-- Step 5: Combine and mark Present/Absent
AttendanceStatus AS (
    SELECT 
        ed.PNO,
        ed.EMPNAME,
        ed.AttnDate,
        CASE 
            WHEN a.PNO IS NOT NULL THEN 'Present'
            ELSE 'Absent'
        END AS Status
    FROM EmployeeDates ed
    LEFT JOIN Attendance a 
        ON ed.PNO = a.PNO AND ed.AttnDate = a.AttnDate
)

-- Final Output
SELECT *
FROM AttendanceStatus
ORDER BY PNO, AttnDate
OPTION (MAXRECURSION 1000);  -- Prevent recursion limit error
