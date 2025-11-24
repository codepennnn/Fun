SELECT 
    g.ID,
    g.REF_NO,
    g.CreatedOn,
    g.TARGET_DT,
    g.STATUS,

    -- Latest revised_date from details table
    d.revised_date,
    d.CreatedOn AS DetailCreatedOn

FROM App_Vendor_Grievance g

LEFT JOIN (
    SELECT d1.*
    FROM App_Vendor_Grievance_Details d1
    INNER JOIN (
        SELECT MASTER_ID, MAX(CreatedOn) AS LatestCreatedOn
        FROM App_Vendor_Grievance_Details
        GROUP BY MASTER_ID
    ) d2
        ON d1.MASTER_ID = d2.MASTER_ID
       AND d1.CreatedOn = d2.LatestCreatedOn
) d
    ON d.MASTER_ID = g.ID

WHERE g.V_CODE = '10482'
  AND g.STATUS = 'OPEN'
  AND g.ClosedOn IS NULL;
