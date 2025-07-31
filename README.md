SELECT 
    'Leave Compliance' AS Module,
    '5 days' AS SLG,
    FORMAT(ApplicationDate, 'yyyy-MM') AS MonthYear,
    COUNT(*) AS TotalApplications,
    SUM(CASE WHEN Status = 'Request Closed' THEN 1 ELSE 0 END) AS ApprovedApplications,
    SUM(CASE 
            WHEN Status = 'Request Closed' 
                 AND CC_CreatedOn_L2 IS NOT NULL
                 AND DATEDIFF(DAY, ApplicationDate, CC_CreatedOn_L2) <= 5
        THEN 1 ELSE 0 
    END) AS ApprovedUnderSLA,
    CAST(
        AVG(CASE 
            WHEN Status = 'Request Closed' 
                 AND CC_CreatedOn_L2 IS NOT NULL 
                 AND DATEDIFF(DAY, ApplicationDate, CC_CreatedOn_L2) <= 5 
            THEN 1.0 ELSE 0.0 END) * 100
    AS DECIMAL(5,2)) AS SLAPercentage
FROM Processed
GROUP BY FORMAT(ApplicationDate, 'yyyy-MM')
ORDER BY FORMAT(ApplicationDate, 'yyyy-MM');
