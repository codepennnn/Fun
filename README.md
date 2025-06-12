select * from App_Vendor_Grievance where ID='123CB112-41D9-4DDC-8A3F-033A878903E0'
select * from App_Vendor_Grievance_Details where Master_ID='123CB112-41D9-4DDC-8A3F-033A878903E0'


SELECT 'Grievance' as   Module_Name,
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 0 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 0],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 1 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 1],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 2 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 2],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 3 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 3],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 4 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 4],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 5 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 5],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) > 5 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: more than 5],
  SUM(CASE WHEN CAST( ClosedOn   AS DATE) = CAST(GETDATE() AS DATE) AND Status = 'CLOSE' THEN 1 ELSE 0 END)
  AS [Count of applications action taken as on today (approved)],
 SUM(CASE WHEN CAST(ClosedOn  AS DATE) = CAST(GETDATE() AS DATE) 
      THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (returned/ rejected)]
FROM App_Vendor_Grievance
