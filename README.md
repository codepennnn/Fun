select * from App_Emp_Surrender where  Ref_No ='EM/0000040/2025'
select * from App_Emp_Surrender_Details where MasterID='B49663BB-ADBD-4D50-8197-B4508EB21CB1'

SELECT 'Workman Movement (vendor to vendor)' as Modules,
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 0 AND Status= 'Pending With CC' THEN 1 ELSE 0 END) AS [Pending application days count: 0],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 1 AND Status= 'Pending with CC' THEN 1 ELSE 0 END) AS [Pending application days count: 1],
  SUM(CASE WHEN DATEDIFF(DAY,ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 2 AND Status= 'Pending with CC' THEN 1 ELSE 0 END) AS [Pending application days count: 2],
  SUM(CASE WHEN DATEDIFF(DAY,ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 3 AND Status= 'Pending with CC' THEN 1 ELSE 0 END) AS [Pending application days count: 3],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 4 AND Status= 'Pending with CC' THEN 1 ELSE 0 END) AS [Pending application days count: 4],
  SUM(CASE WHEN DATEDIFF(DAY,ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) = 5 AND Status= 'Pending with CC' THEN 1 ELSE 0 END) AS [Pending application days count: 5],
  SUM(CASE WHEN DATEDIFF(DAY, ISNULL(detail.CreatedOn, master.CreatedOn), GETDATE()) > 5 AND Status= 'Pending with CC' THEN 1 ELSE 0 END) AS [Pending application days count: more than 5],

 SUM(CASE WHEN CAST(master.CreatedOn  AS DATE) = CAST(GETDATE() AS DATE) AND Status = 'Request Closed' THEN 1 ELSE 0 END)AS [Count of applications action taken as on today (approved)],

SUM(CASE WHEN CAST(ISNULL(detail.CreatedOn, master.CreatedOn)  AS DATE) = CAST(GETDATE() AS DATE) AND (Status = 'Forwarded to Previous Vendor' OR status='Forward To Applied Vendor') THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (returned/ rejected)]


FROM App_Emp_Surrender master
LEFT JOIN App_Emp_Surrender_Details detail
  ON master.ID = detail.MasterID;


  --testing
  select   *
  FROM App_Emp_Surrender master
LEFT JOIN App_Emp_Surrender_Details detail
  ON master.ID = detail.MasterID
  where CAST(ISNULL(detail.CreatedOn, master.CreatedOn)  AS DATE) = CAST(GETDATE() AS DATE) AND (Status = 'Forwarded to Previous Vendor' OR status='Forward To Applied Vendor') 
