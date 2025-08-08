WITH NoticeProcessed AS (
    SELECT 
        n.ID,
        n.Status,
        n.ClosedOn,
        n.CREATEDON AS CreatedOn,
        n.CREATEDON AS ApplicationDate
    FROM App_Gov_Notice n
    WHERE NOT EXISTS (
        SELECT 1 FROM App_Gov_Notice_Details d WHERE d.MASTER_ID = n.ID
    )

    UNION ALL

    SELECT 
        n.ID,
        n.Status,
        n.ClosedOn,
        d.CREATEDON AS CreatedOn,
        d.CREATEDON AS ApplicationDate
    FROM App_Gov_Notice n
    INNER JOIN (
        SELECT *
        FROM (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY MASTER_ID ORDER BY CREATEDON DESC) AS rn
            FROM App_Gov_Notice_Details
        ) AS ranked
        WHERE rn = 1
    ) d ON d.MASTER_ID = n.ID
)
