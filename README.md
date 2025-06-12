SELECT  
  'Govt. Notice' AS Modules,

  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(latestDetail.CreatedOn, master.CreatedOn), GETDATE()) = 0 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 0],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(latestDetail.CreatedOn, master.CreatedOn), GETDATE()) = 1 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 1],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(latestDetail.CreatedOn, master.CreatedOn), GETDATE()) = 2 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 2],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(latestDetail.CreatedOn, master.CreatedOn), GETDATE()) = 3 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 3],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(latestDetail.CreatedOn, master.CreatedOn), GETDATE()) = 4 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 4],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(latestDetail.CreatedOn, master.CreatedOn), GETDATE()) = 5 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 5],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(latestDetail.CreatedOn, master.CreatedOn), GETDATE()) > 5 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: more than 5],

  SUM(CASE WHEN CAST(ISNULL(latestDetail.ClosedOn, master.ClosedOn) AS DATE) = CAST(GETDATE() AS DATE) AND master.Status = 'CLOSE' THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (approved)],
  
  SUM(CASE WHEN CAST(ISNULL(latestDetail.ClosedOn, master.ClosedOn) AS DATE) = CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (returned/ rejected)]

FROM App_Gov_Notice master
OUTER APPLY (
    SELECT TOP 1 *
    FROM App_Gov_Notice_Details d
    WHERE d.MASTER_ID = master.ID
    ORDER BY d.CreatedOn DESC
) AS latestDetail;
