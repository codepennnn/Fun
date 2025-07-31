..
WITH Processed AS (
    SELECT 
        *,
        COALESCE(ResubmittedOn, CreatedOn) AS ApplicationDate
    FROM App_Leave_Summary
    WHERE 
        COALESCE(ResubmittedOn, CreatedOn) IS NOT NULL
)

SELECT 
    FORMAT(ApplicationDate, 'yyyy-MM') AS MonthYear,
    COUNT(*) AS TotalApplications,
    SUM(CASE WHEN Status = 'Approved' THEN 1 ELSE 0 END) AS ApprovedApplications,
    SUM(CASE 
            WHEN Status = 'Approved' 
                 AND ApprovedOn IS NOT NULL
                 AND DATEDIFF(DAY, ApplicationDate, ApprovedOn) <= 5
            THEN 1 ELSE 0 
        END) AS ApprovedUnderSLA,
    CAST(
        100.0 * SUM(CASE 
                     WHEN Status = 'Approved' 
                          AND ApprovedOn IS NOT NULL
                          AND DATEDIFF(DAY, ApplicationDate, ApprovedOn) <= 5
                     THEN 1 ELSE 0 
                   END)
        / NULLIF(SUM(CASE WHEN Status = 'Approved' THEN 1 ELSE 0 END), 0)
    AS DECIMAL(5,2)) AS SLAPercentage
FROM Processed
GROUP BY FORMAT(ApplicationDate, 'yyyy-MM')
ORDER BY FORMAT(ApplicationDate, 'yyyy-MM');
