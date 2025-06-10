SELECT
  SUM(CASE WHEN DATEDIFF(DAY, CREATEDON, GETDATE()) = 0 AND ( ApprvStatus='pending') THEN 1 ELSE 0 END) AS [Pending application days count: 0],
  SUM(CASE WHEN DATEDIFF(DAY, CREATEDON, GETDATE()) = 1 AND ( ApprvStatus='pending') THEN 1 ELSE 0 END) AS [Pending application days count: 1],
  SUM(CASE WHEN DATEDIFF(DAY, CREATEDON, GETDATE()) = 2 AND ( ApprvStatus='pending') THEN 1 ELSE 0 END) AS [Pending application days count: 2],
  SUM(CASE WHEN DATEDIFF(DAY, CREATEDON, GETDATE()) = 3 AND ( ApprvStatus='pending') THEN 1 ELSE 0 END) AS [Pending application days count: 3],
  SUM(CASE WHEN DATEDIFF(DAY, CREATEDON, GETDATE()) = 4 AND ( ApprvStatus='pending') THEN 1 ELSE 0 END) AS [Pending application days count: 4],
  SUM(CASE WHEN DATEDIFF(DAY, CREATEDON, GETDATE()) = 5 AND ( ApprvStatus='pending') THEN 1 ELSE 0 END) AS [Pending application days count: 5],
  SUM(CASE WHEN DATEDIFF(DAY, CREATEDON, GETDATE()) > 5 AND (  ApprvStatus='pending') THEN 1 ELSE 0 END) AS [Pending application days count: more than 5],
 
 SUM(CASE WHEN  CAST(CREATEDON AS DATE) = CAST(GETDATE() AS DATE) OR CAST(UpdatedON AS DATE) = CAST(GETDATE() AS DATE)  AND (ApprvStatus='Approve') THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (approved)],

 SUM(CASE WHEN  CAST(CREATEDON AS DATE) = CAST(GETDATE() AS DATE) AND (ApprvStatus='Return' OR ApprvStatus='GP Return') THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (returned/ rejected)]
FROM App_EmployeeMaster;
