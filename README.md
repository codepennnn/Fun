SELECT 
  'Govt. Notice' AS Module_Name,

  -- Pending application days count
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 0 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 0],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 1 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 1],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 2 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 2],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 3 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 3],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 4 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 4],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 5 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: 5],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) > 5 AND master.Status = 'OPEN' THEN 1 ELSE 0 END) AS [Pending application days count: more than 5],

  -- Closed today (approved)
  SUM(CASE 
        WHEN CAST(ISNULL(detail.ClosedOn, master.ClosedOn) AS DATE) = CAST(GETDATE() AS DATE) 
             AND master.Status = 'CLOSE' 
        THEN 1 ELSE 0 
      END) AS [Count of applications action taken as on today (approved)],

  -- Closed today (total)
  SUM(CASE 
        WHEN CAST(ISNULL(detail.ClosedOn, master.ClosedOn) AS DATE) = CAST(GETDATE() AS DATE) 
        THEN 1 ELSE 0 
      END) AS [Count of applications action taken as on today (returned/ rejected)]

FROM App_Gov_Notice master
LEFT JOIN App_Gov_Notice_Details detail
  ON master.ID = detail.MASTER_ID;
