Msg 156, Level 15, State 1, Line 3
Incorrect syntax near the keyword 'WITH'.
Msg 319, Level 15, State 1, Line 3
Incorrect syntax near the keyword 'with'. If this statement is a common table expression, an xmlnamespaces clause or a change tracking context clause, the previous statement must be terminated with a semicolon.
Msg 102, Level 15, State 1, Line 13
Incorrect syntax near ','.
Msg 102, Level 15, State 1, Line 18
Incorrect syntax near ','.
Msg 102, Level 15, State 1, Line 39
Incorrect syntax near ')'.

SELECT * FROM (
    WITH Processed AS (
        SELECT *, CreatedOn AS ApplicationDate
        FROM App_Leave_Comp_Summary
        WHERE ReSubmiteddate IS NULL

        UNION ALL

        SELECT *, ReSubmiteddate AS ApplicationDate
        FROM App_Leave_Comp_Summary
        WHERE ReSubmiteddate IS NOT NULL
    ),
    Filtered AS (
        SELECT *
        FROM Processed
        WHERE ApplicationDate >= '2025-04-01' AND ApplicationDate < '2026-04-01'
    ),
    Aggregated AS (
        SELECT
            DATEPART(MONTH, ApplicationDate) AS MonthNum,
            SUM(CASE WHEN Status = 'Request Closed' THEN 1 ELSE 0 END) AS Approved,
            SUM(CASE 
                WHEN Status = 'Request Closed' 
                     AND CC_CreatedOn_L2 IS NOT NULL 
                     AND DATEDIFF(DAY, ApplicationDate, CC_CreatedOn_L2) <= 5 
                THEN 1 ELSE 0 
            END) AS ApprovedUnderSLA
        FROM Filtered
        GROUP BY DATEPART(MONTH, ApplicationDate)
    )
    SELECT
        'Leave Compliance' AS Object,
        '5 days' AS SLG,
        '5 days' AS RevisedSLG,
        MAX(CASE WHEN MonthNum = 4 THEN ApprovedUnderSLA * 100.0 / NULLIF(Approved, 0) END) AS APR
        -- (repeat for other months)
    FROM Aggregated
) AS LeaveData
