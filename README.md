ISNULL(
        CAST(
            100.0 * SUM(CASE  
                          WHEN Status = 'Request Closed'  
                               AND CC_CreatedOn_L2 IS NOT NULL  
                               AND DATEDIFF(DAY, ApplicationDate, CC_CreatedOn_L2) <= 5  
                          THEN 1 ELSE 0  
                       END)
            / NULLIF(SUM(CASE WHEN Status = 'Request Closed' THEN 1 ELSE 0 END), 0)
        AS DECIMAL(5,2)),
    0.00) AS SLAPercentage
