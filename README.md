WITH Processed AS (
    SELECT 
        s.*,
        d.UpdatedOn, -- assuming this is the column from the details table
        ISNULL(s.UpdatedOn_GP, s.CreatedOn) AS ApplicationDate
    FROM App_Emp_Surrender s
    LEFT JOIN App_Emp_Surrender_Details d
        ON s.ID = d.SurrenderID  -- replace with actual key column
),
Filtered AS (
    SELECT *
    FROM Processed
    WHERE ApplicationDate >= '2025-04-01' AND ApplicationDate < '2026-04-01'
),
Aggregated AS (
    SELECT
        FORMAT(ApplicationDate, 'yyyy-MM') AS MonthYear,
        DATENAME(MONTH, ApplicationDate) AS MonthName,
        LEFT(DATENAME(MONTH, ApplicationDate), 3) AS MonthShort,
        DATEPART(MONTH, ApplicationDate) AS MonthNum,
        SUM(CASE WHEN Status = 'Request Closed' THEN 1 ELSE 0 END) AS Approved
        -- Add more aggregations if needed from the joined table
    FROM Filtered
    GROUP BY FORMAT(ApplicationDate, 'yyyy-MM'), DATEPART(MONTH, ApplicationDate), DATENAME(MONTH, ApplicationDate)
)
SELECT * FROM Aggregated;
