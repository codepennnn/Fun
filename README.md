WITH Processed AS (
    SELECT 
        *, 
        CreatedOn AS ApplicationDate
    FROM App_Leave_Comp_Summary
    WHERE ReSubmiteddate IS NULL

    UNION ALL

    SELECT 
        *, 
        ReSubmiteddate AS ApplicationDate
    FROM App_Leave_Comp_Summary
    WHERE ReSubmiteddate IS NOT NULL
),
Filtered AS (
    SELECT * 
    FROM Processed
    WHERE ApplicationDate >= '2024-04-01' AND ApplicationDate < '2025-04-01'
),
MonthlyData AS (
    SELECT 
        DATENAME(MONTH, ApplicationDate) AS MonthName,
        LEFT(DATENAME(MONTH, ApplicationDate), 3) AS MonthShort,
        DATEPART(MONTH, ApplicationDate) AS MonthNumber,
        SUM(CASE WHEN Status = 'Request Closed' THEN 1 ELSE 0 END) AS Approved,
        SUM(CASE 
                WHEN Status = 'Request Closed'
                     AND CC_CreatedOn_L2 IS NOT NULL
                     AND DATEDIFF(DAY, ApplicationDate, CC_CreatedOn_L2) <= 5 
                THEN 1 ELSE 0 END) AS ApprovedUnderSLA
    FROM Filtered
    GROUP BY DATEPART(MONTH, ApplicationDate), DATENAME(MONTH, ApplicationDate)
),
Pivoted AS (
    SELECT
        'Leave Compliance' AS Object,
        '5 days' AS SLG,
        '5 days' AS RevisedSLG,

        -- SLA Percentage (ApprovedUnderSLA / Approved)
        CAST(100.0 * ISNULL([4]_SLA, 0) / NULLIF(ISNULL([4]_Total, 0), 0) AS DECIMAL(5,2)) AS APR,
        ISNULL([4]_SLA, 0) AS APR_Value,

        CAST(100.0 * ISNULL([5]_SLA, 0) / NULLIF(ISNULL([5]_Total, 0), 0) AS DECIMAL(5,2)) AS MAY,
        ISNULL([5]_SLA, 0) AS MAY_Value,

        CAST(100.0 * ISNULL([6]_SLA, 0) / NULLIF(ISNULL([6]_Total, 0), 0) AS DECIMAL(5,2)) AS JUN,
        ISNULL([6]_SLA, 0) AS JUN_Value,

        CAST(100.0 * ISNULL([7]_SLA, 0) / NULLIF(ISNULL([7]_Total, 0), 0) AS DECIMAL(5,2)) AS JUL,
        ISNULL([7]_SLA, 0) AS JUL_Value,

        CAST(100.0 * ISNULL([8]_SLA, 0) / NULLIF(ISNULL([8]_Total, 0), 0) AS DECIMAL(5,2)) AS AUG,
        ISNULL([8]_SLA, 0) AS AUG_Value,

        CAST(100.0 * ISNULL([9]_SLA, 0) / NULLIF(ISNULL([9]_Total, 0), 0) AS DECIMAL(5,2)) AS SEP,
        ISNULL([9]_SLA, 0) AS SEP_Value,

        CAST(100.0 * ISNULL([10]_SLA, 0) / NULLIF(ISNULL([10]_Total, 0), 0) AS DECIMAL(5,2)) AS OCT,
        ISNULL([10]_SLA, 0) AS OCT_Value,

        CAST(100.0 * ISNULL([11]_SLA, 0) / NULLIF(ISNULL([11]_Total, 0), 0) AS DECIMAL(5,2)) AS NOV,
        ISNULL([11]_SLA, 0) AS NOV_Value,

        CAST(100.0 * ISNULL([12]_SLA, 0) / NULLIF(ISNULL([12]_Total, 0), 0) AS DECIMAL(5,2)) AS DEC,
        ISNULL([12]_SLA, 0) AS DEC_Value,

        CAST(100.0 * ISNULL([1]_SLA, 0) / NULLIF(ISNULL([1]_Total, 0), 0) AS DECIMAL(5,2)) AS JAN,
        ISNULL([1]_SLA, 0) AS JAN_Value,

        CAST(100.0 * ISNULL([2]_SLA, 0) / NULLIF(ISNULL([2]_Total, 0), 0) AS DECIMAL(5,2)) AS FEB,
        ISNULL([2]_SLA, 0) AS FEB_Value,

        CAST(100.0 * ISNULL([3]_SLA, 0) / NULLIF(ISNULL([3]_Total, 0), 0) AS DECIMAL(5,2)) AS MAR,
        ISNULL([3]_SLA, 0) AS MAR_Value

    FROM (
        SELECT 
            MonthNumber,
            SUM(Approved) AS Total,
            SUM(ApprovedUnderSLA) AS SLA
        FROM MonthlyData
        GROUP BY MonthNumber
    ) AS Source
    PIVOT (
        MAX(Total) FOR MonthNumber IN ([1]_Total, [2]_Total, [3]_Total, [4]_Total, [5]_Total, [6]_Total, [7]_Total, [8]_Total, [9]_Total, [10]_Total, [11]_Total, [12]_Total)
    ) AS PivotTotal
    INNER JOIN (
        SELECT 
            MonthNumber,
            SUM(ApprovedUnderSLA) AS SLA
        FROM MonthlyData
        GROUP BY MonthNumber
    ) AS SLAData ON PivotTotal.MonthNumber = SLAData.MonthNumber
    PIVOT (
        MAX(SLA) FOR MonthNumber IN ([1]_SLA, [2]_SLA, [3]_SLA, [4]_SLA, [5]_SLA, [6]_SLA, [7]_SLA, [8]_SLA, [9]_SLA, [10]_SLA, [11]_SLA, [12]_SLA)
    ) AS PivotSLA
)

SELECT * FROM Pivoted;
