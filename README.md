 select * from App_Emp_Surrender;
 select * from App_Emp_Surrender_Details;




  

    WITH Processed AS (
    SELECT 
        *, 
        CreatedOn AS ApplicationDate
    FROM App_Emp_Surrender
    WHERE UPDATEDON_GP IS NULL

    UNION ALL

    SELECT 
        *, 
        UPDATEDON_GP AS ApplicationDate
    FROM App_Emp_Surrender
    WHERE UPDATEDON_GP IS NOT NULL
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
        SUM(CASE WHEN Status = 'Request Closed' THEN 1 ELSE 0 END) AS Approved,
        SUM(CASE 
            WHEN Status = 'Request Closed'
              AND CC_CREATEDON_GP IS NOT NULL 
              AND DATEDIFF(DAY, ApplicationDate, CC_CREATEDON_GP) <= 1 
            THEN 1 ELSE 0 
        END) AS ApprovedUnderSLA
    FROM Filtered
    GROUP BY FORMAT(ApplicationDate, 'yyyy-MM'), DATEPART(MONTH, ApplicationDate), DATENAME(MONTH, ApplicationDate)
),
Pivoted AS (
    SELECT
        'Workman Movement (vendor to vendor)' AS Object,
        '1 days' AS SLG,
        '1 days' AS RevisedSLG,

     
        ISNULL( MAX(CASE WHEN MonthNum = 4 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS APR,
        ISNULL (MAX(CASE WHEN MonthNum = 4 THEN ApprovedUnderSLA ELSE NULL END),0) AS APR_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 5 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS MAY,
        ISNULL ( MAX(CASE WHEN MonthNum = 5 THEN ApprovedUnderSLA ELSE NULL END),0) AS MAY_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 6 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS JUN,
        ISNULL ( MAX(CASE WHEN MonthNum = 6 THEN ApprovedUnderSLA ELSE NULL END),0) AS JUN_Value,

        ISNULL ( MAX(CASE WHEN MonthNum = 7 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS JUL,
        ISNULL ( MAX(CASE WHEN MonthNum = 7 THEN ApprovedUnderSLA ELSE NULL END),0) AS JUL_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 8 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS AUG,
         ISNULL (MAX(CASE WHEN MonthNum = 8 THEN ApprovedUnderSLA ELSE NULL END),0) AS AUG_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 9 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS SEP,
         ISNULL (MAX(CASE WHEN MonthNum = 9 THEN ApprovedUnderSLA ELSE NULL END),0) AS SEP_Value,

        ISNULL ( MAX(CASE WHEN MonthNum = 10 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS OCT,
         ISNULL (MAX(CASE WHEN MonthNum = 10 THEN ApprovedUnderSLA ELSE NULL END),0) AS OCT_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 11 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS NOV,
         ISNULL (MAX(CASE WHEN MonthNum = 11 THEN ApprovedUnderSLA ELSE NULL END),0) AS NOV_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 12 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS DEC,
         ISNULL (MAX(CASE WHEN MonthNum = 12 THEN ApprovedUnderSLA ELSE NULL END),0) AS DEC_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 1 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS JAN,
         ISNULL (MAX(CASE WHEN MonthNum = 1 THEN ApprovedUnderSLA ELSE NULL END),0) AS JAN_Value,

         ISNULL (MAX(CASE WHEN MonthNum = 2 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS FEB,
         ISNULL (MAX(CASE WHEN MonthNum = 2 THEN ApprovedUnderSLA ELSE NULL END),0) AS FEB_Value,

        ISNULL ( MAX(CASE WHEN MonthNum = 3 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END),0) AS MAR,
         ISNULL (MAX(CASE WHEN MonthNum = 3 THEN ApprovedUnderSLA ELSE '' END),0) AS MAR_Value

    FROM Aggregated
)
SELECT * FROM Pivoted;
