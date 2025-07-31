financial year parameter - 2024-2025

header - object	            SLG	   RevisedSLG	       APR	          APR_Value	    MAY	               MAY_Value   ....similarly till march
values  - Leave Compliance	5 days	5 days	         95.21	          179	        97.66	             209


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
)
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
         THEN 1 ELSE 0 END) AS ApprovedUnderSLA,
    ISNULL(
        CAST(
            100.0 * SUM(CASE 
                         WHEN Status = 'Request Closed' 
                              AND CC_CreatedOn_L2 IS NOT NULL 
                              AND DATEDIFF(DAY, ApplicationDate, CC_CreatedOn_L2) <= 5 
                    THEN 1 ELSE 0 END)
            / NULLIF(SUM(CASE WHEN Status = 'Request Closed' THEN 1 ELSE 0 END), 0)
        AS DECIMAL(5,2)),
    0.00) AS SLAPercentage
FROM Processed
GROUP BY FORMAT(ApplicationDate, 'yyyy-MM')
ORDER BY FORMAT(ApplicationDate, 'yyyy-MM');








