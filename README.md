
 WITH Processed AS (
    SELECT 
        *,
        COALESCE(ReSubmiteddate, CreatedOn) AS ApplicationDate
    FROM App_Leave_Comp_Summary
    WHERE 
        COALESCE(ReSubmiteddate, CreatedOn) IS NOT NULL
)

SELECT 'Leave Compliance' as Module, '5 days' as SLG, 
    FORMAT(ApplicationDate, '2024-01') AS MonthYear,
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
GROUP BY FORMAT(ApplicationDate, '2024-01')
ORDER BY FORMAT(ApplicationDate, '2024-01');

check which is greated createdon and resubmit take that and why its giving same result on anohter month 
