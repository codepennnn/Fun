  SELECT TOP 1 ref_no = STUFF((SELECT DISTINCT ', ' + ref_no FROM App_Vendor_Grievance AS b WHERE b.STATUS='OPEN'
  AND b.ClosedOn IS NULL AND b.V_CODE='10482' FOR XML PATH('')),1,2,''),
  CreatedOn = (SELECT TOP 1 FORMAT(b.CreatedOn ,'dd-MM-yyyy') as CreatedOn  FROM App_Vendor_Grievance b WHERE b.STATUS='OPEN' 
  AND b.ClosedOn IS NULL AND b.V_CODE='10482' ORDER BY b.CreatedOn DESC) FROM App_Vendor_Grievance AS a


  i want - CreatedOn , REF_NO TARGET_DT , STATUS and revised_date from another tbl of latest createdon
