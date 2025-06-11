
SELECT
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(ReSubmitedOn, CreatedOn), GETDATE()) = 0 AND ( STATUS = 'Pending With Vendor' OR STATUS = 'Pending with L1 Level' OR STATUS='Pending With L2 Level') THEN 1 ELSE 0 END) AS [Pending application days count: 0],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(ReSubmitedOn, CreatedOn), GETDATE()) = 1 AND ( STATUS = 'Pending With Vendor' OR STATUS = 'Pending with L1 Level' OR STATUS='Pending With L2 Level') THEN 1 ELSE 0 END) AS [Pending application days count: 1],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(ReSubmitedOn, CreatedOn), GETDATE()) = 2 AND ( STATUS = 'Pending With Vendor' OR STATUS = 'Pending with L1 Level' OR STATUS='Pending With L2 Level') THEN 1 ELSE 0 END) AS [Pending application days count: 2],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(ReSubmitedOn, CreatedOn), GETDATE()) = 3 AND ( STATUS = 'Pending With Vendor' OR STATUS = 'Pending with L1 Level' OR STATUS='Pending With L2 Level') THEN 1 ELSE 0 END) AS [Pending application days count: 3],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(ReSubmitedOn, CreatedOn), GETDATE()) = 4 AND (STATUS = 'Pending With Vendor' OR STATUS = 'Pending with L1 Level' OR STATUS='Pending With L2 Level') THEN 1 ELSE 0 END) AS [Pending application days count: 4],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(ReSubmitedOn, CreatedOn), GETDATE()) = 5 AND ( STATUS = 'Pending With Vendor' OR STATUS = 'Pending with L1 Level' OR STATUS='Pending With L2 Level') THEN 1 ELSE 0 END) AS [Pending application days count: 5],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(ReSubmitedOn, CreatedOn), GETDATE()) > 5 AND (STATUS = 'Pending With Vendor' OR STATUS = 'Pending with L1 Level' OR STATUS='Pending With L2 Level') THEN 1 ELSE 0 END) AS [Pending application days count: more than 5],
  SUM(CASE WHEN  CAST(ISNULL(LEVEL_1_UPDATEDON, LEVEL_2_UPDATEDON) AS DATE) = CAST(GETDATE() AS DATE)  AND (STATUS='Request Closed') THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (approved)],

 SUM(CASE WHEN  CAST(ISNULL(L1_RETURN_DATE, Last_ReturnedOn) AS DATE) = CAST(GETDATE() AS DATE) AND (STATUS='Returned By L1 Level' OR STATUS='Pending With Vendor')  THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (returned/ rejected)]
FROM App_Online_Wages;
