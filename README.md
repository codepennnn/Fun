SELECT 
    a.ID,
    a.CreatedOn AS MasterCreatedOn,
    a.REF_NO,
    a.TARGET_DT,
    a.STATUS,
    
    -- Compliance logic
    CASE 
        WHEN a.STATUS = 'Open' THEN 'Y'
        ELSE 'N'
    END AS Compliance,

    -- Latest detail record datetime
    d.LatestCreatedOn,
    d.DetailData

FROM App_Vendor_Grievance a
OUTER APPLY
(
    SELECT TOP 1 
        CreatedOn AS LatestCreatedOn,
        * AS DetailData
    FROM App_Vendor_Grievance_Details
    WHERE MASTER_ID = a.ID
    ORDER BY CreatedOn DESC
) d
WHERE a.V_CODE = '10482';
