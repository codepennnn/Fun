SELECT 
  g.ID,
  g.CreatedOn        AS MasterCreatedOn,
  g.REF_NO,
  g.TARGET_DT,
  g.STATUS,
  CASE 
    WHEN LOWER(g.STATUS) = 'open' THEN 'Y'
    ELSE 'N'
  END AS Compliance,
  d.LatestCreatedOn
FROM App_Vendor_Grievance g
LEFT JOIN (
  SELECT MASTER_ID, MAX(CreatedOn) AS LatestCreatedOn
  FROM App_Vendor_Grievance_Details
  GROUP BY MASTER_ID
) d
  ON d.MASTER_ID = g.ID
WHERE g.V_CODE = '10482';
