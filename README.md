SELECT 
    'Wages' AS [Modules],
    'VGPMS' AS [Software],
    '3' AS [SLG Days],

    -- Pending counts by day difference
    SUM(CASE WHEN DATEDIFF(DAY, W.UPDATEDAT, GETDATE()) = 0 
             AND W.STATUS = 'pending with verifier' THEN 1 ELSE 0 END) AS [Pending application days count: 0],

    SUM(CASE WHEN DATEDIFF(DAY, W.UPDATEDAT, GETDATE()) = 1 
             AND W.STATUS = 'pending with verifier' THEN 1 ELSE 0 END) AS [Pending application days count: 1],

    SUM(CASE WHEN DATEDIFF(DAY, W.UPDATEDAT, GETDATE()) = 2 
             AND W.STATUS = 'pending with verifier' THEN 1 ELSE 0 END) AS [Pending application days count: 2],

    SUM(CASE WHEN DATEDIFF(DAY, W.UPDATEDAT, GETDATE()) = 3 
             AND W.STATUS = 'pending with verifier' THEN 1 ELSE 0 END) AS [Pending application days count: 3],

    SUM(CASE WHEN DATEDIFF(DAY, W.UPDATEDAT, GETDATE()) = 4 
             AND W.STATUS = 'pending with verifier' THEN 1 ELSE 0 END) AS [Pending application days count: 4],

    SUM(CASE WHEN DATEDIFF(DAY, W.UPDATEDAT, GETDATE()) = 5 
             AND W.STATUS = 'pending with verifier' THEN 1 ELSE 0 END) AS [Pending application days count: 5],

    SUM(CASE WHEN DATEDIFF(DAY, W.UPDATEDAT, GETDATE()) > 5 
             AND W.STATUS = 'pending with verifier' THEN 1 ELSE 0 END) AS [Pending application days count: more than 5],

    -- Approved Today
    SUM(CASE WHEN CAST(W.LEVEL_2_UPDATEDAT AS DATE) = CAST(GETDATE() AS DATE)
             AND W.STATUS = 'Approved' THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (Approved)],

    -- Returned/Rejected Today
    SUM(CASE WHEN CAST(W.LEVEL_2_UPDATEDAT AS DATE) = CAST(GETDATE() AS DATE)
             AND W.STATUS = 'pending with verifier' THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (Returned / Rejected)]

FROM online_temp_wages_2 W
INNER JOIN online_temp_c_entry_details C
    ON W.application_id = C.application_id     -- ← CHANGE THIS COLUMN AS PER YOUR TABLE STRUCTURE
;
