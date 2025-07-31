SELECT COUNT(*) 
FROM App_Leave_Comp_Summary
WHERE Status = 'Request Closed'
  AND CC_CreatedOn_L1 IS NOT NULL
  AND DATEDIFF(DAY, 
      ISNULL(CASE 
               WHEN ReSubmiteddate > CreatedOn THEN ReSubmiteddate 
               ELSE CreatedOn 
             END, CreatedOn), 
      CC_CreatedOn_L1
  ) <= 5
