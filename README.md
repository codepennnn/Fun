WITH Processed AS (
    SELECT 
        *,
        ISNULL(
            CASE 
                WHEN ReSubmiteddate > CreatedOn THEN ReSubmiteddate 
                ELSE CreatedOn 
            END,
            CreatedOn
        ) AS ApplicationDate
    FROM App_Leave_Comp_Summary
    WHERE CreatedOn IS NOT NULL
)

SELECT 
    'Leave Compliance' AS Module,
    '5 days' AS SLG,
    FORMAT(ApplicationDate, 'yyyy-MM') AS MonthYear,
    COUNT(*) AS TotalApplications,
    SUM(CASE WHEN Status = 'Request Closed' THEN 1 ELSE 0 END) AS ApprovedApplications,
    SUM(CASE 
            WHEN Status = 'Request Closed' 
                 AND CC_CreatedOn_L1 IS NOT NULL
                 AND DATEDIFF(DAY, ApplicationDate, CC_CreatedOn_L1) <= 5
         THEN 1 ELSE 0 
    END) AS ApprovedUnderSLA,
    CAST(
        100.0 * SUM(CASE 
                     WHEN Status = 'Request Closed' 
                          AND CC_CreatedOn_L1 IS NOT NULL
                          AND DATEDIFF(DAY, ApplicationDate, CC_CreatedOn_L1) <= 5
                   THEN 1 ELSE 0 
                 END)
        / NULLIF(SUM(CASE WHEN Status = 'Request Closed' THEN 1 ELSE 0 END), 0)
    AS DECIMAL(5,2)) AS SLAPercentage
FROM Processed
GROUP BY FORMAT(ApplicationDate, 'yyyy-MM')
ORDER BY FORMAT(ApplicationDate, 'yyyy-MM');
