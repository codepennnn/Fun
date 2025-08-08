WITH LatestDetails AS (
    SELECT *
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY MASTER_ID ORDER BY CREATEDON DESC) AS rn
        FROM App_Gov_Notice_Details
    ) AS sub
    WHERE rn = 1
),

GovNoticeWithLatestDetails AS (
    SELECT 
        n.*,
        d.DETAIL_COLUMN1,  -- replace with actual detail columns you want
        d.DETAIL_COLUMN2,
        d.CREATEDON AS DetailCreatedOn
    FROM App_Gov_Notice n
    LEFT JOIN LatestDetails d ON n.ID = d.MASTER_ID
    WHERE n.ID = 'F5E1DDB3-43D3-4F07-918C-FFFF7255F937'
)

SELECT * FROM GovNoticeWithLatestDetails
