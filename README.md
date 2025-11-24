-- Step 1: derive latest CreatedOn per MASTER_ID, then join back to details to get full row
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
  d_det.CreatedOn    AS DetailCreatedOn,
  d_det.*            -- or list specific detail columns instead of d_det.*
FROM App_Vendor_Grievance g
LEFT JOIN (
  SELECT MASTER_ID, MAX(CreatedOn) AS LatestCreatedOn
  FROM App_Vendor_Grievance_Details
  GROUP BY MASTER_ID
) d_max
  ON d_max.MASTER_ID = g.ID
LEFT JOIN App_Vendor_Grievance_Details d_det
  ON d_det.MASTER_ID = d_max.MASTER_ID
  AND d_det.CreatedOn = d_max.LatestCreatedOn
WHERE g.V_CODE = '10482';
