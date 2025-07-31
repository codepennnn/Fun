WITH Processed AS (
    SELECT 
        *,
        ISNULL(
            CASE  
                WHEN ReSubmiteddate > CreatedOn THEN ReSubmiteddate  
                ELSE CreatedOn  
            END,
        CreatedOn) AS ApplicationDate  
    FROM App_Leave_Comp_Summary
),
Filtered AS (
    SELECT *
    FROM Processed
    WHERE ApplicationDate >= '2024-04-01' AND ApplicationDate < '2025-04-01'
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
              AND CC_CreatedOn_L2 IS NOT NULL 
              AND DATEDIFF(DAY, ApplicationDate, CC_CreatedOn_L2) <= 5 
            THEN 1 ELSE 0 
        END) AS ApprovedUnderSLA
    FROM Filtered
    GROUP BY FORMAT(ApplicationDate, 'yyyy-MM'), DATEPART(MONTH, ApplicationDate), DATENAME(MONTH, ApplicationDate)
),
Pivoted AS (
    SELECT
        'Leave Compliance' AS Object,
        '5 days' AS SLG,
        '5 days' AS RevisedSLG,

        -- SLA %
        MAX(CASE WHEN MonthNum = 4 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS APR,
        MAX(CASE WHEN MonthNum = 4 THEN ApprovedUnderSLA ELSE NULL END) AS APR_Value,

        MAX(CASE WHEN MonthNum = 5 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS MAY,
        MAX(CASE WHEN MonthNum = 5 THEN ApprovedUnderSLA ELSE NULL END) AS MAY_Value,

        MAX(CASE WHEN MonthNum = 6 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS JUN,
        MAX(CASE WHEN MonthNum = 6 THEN ApprovedUnderSLA ELSE NULL END) AS JUN_Value,

        MAX(CASE WHEN MonthNum = 7 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS JUL,
        MAX(CASE WHEN MonthNum = 7 THEN ApprovedUnderSLA ELSE NULL END) AS JUL_Value,

        MAX(CASE WHEN MonthNum = 8 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS AUG,
        MAX(CASE WHEN MonthNum = 8 THEN ApprovedUnderSLA ELSE NULL END) AS AUG_Value,

        MAX(CASE WHEN MonthNum = 9 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS SEP,
        MAX(CASE WHEN MonthNum = 9 THEN ApprovedUnderSLA ELSE NULL END) AS SEP_Value,

        MAX(CASE WHEN MonthNum = 10 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS OCT,
        MAX(CASE WHEN MonthNum = 10 THEN ApprovedUnderSLA ELSE NULL END) AS OCT_Value,

        MAX(CASE WHEN MonthNum = 11 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS NOV,
        MAX(CASE WHEN MonthNum = 11 THEN ApprovedUnderSLA ELSE NULL END) AS NOV_Value,

        MAX(CASE WHEN MonthNum = 12 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS DEC,
        MAX(CASE WHEN MonthNum = 12 THEN ApprovedUnderSLA ELSE NULL END) AS DEC_Value,

        MAX(CASE WHEN MonthNum = 1 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS JAN,
        MAX(CASE WHEN MonthNum = 1 THEN ApprovedUnderSLA ELSE NULL END) AS JAN_Value,

        MAX(CASE WHEN MonthNum = 2 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS FEB,
        MAX(CASE WHEN MonthNum = 2 THEN ApprovedUnderSLA ELSE NULL END) AS FEB_Value,

        MAX(CASE WHEN MonthNum = 3 THEN CAST(100.0 * ApprovedUnderSLA / NULLIF(Approved, 0) AS DECIMAL(5,2)) ELSE NULL END) AS MAR,
        MAX(CASE WHEN MonthNum = 3 THEN ApprovedUnderSLA ELSE NULL END) AS MAR_Value

    FROM Aggregated
)
SELECT * FROM Pivoted;
