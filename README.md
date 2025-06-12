select * from App_Gov_Notice where ID='1C155D1F-C8FF-474E-8337-002F00C406C7'
select * from App_Gov_Notice_Details where MASTER_ID='1C155D1F-C8FF-474E-8337-002F00C406C7'


SELECT 'Govt. Notice' as Module_Name,
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 0 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 0],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 1 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 1],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 2 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 2],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 3 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 3],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 4 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 4],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) = 5 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: 5],
  SUM(CASE WHEN DATEDIFF(DAY, CreatedOn, GETDATE()) > 5 AND (Status= 'OPEN') THEN 1 ELSE 0 END) AS [Pending application days count: more than 5],

  SUM(CASE WHEN CAST( ClosedOn AS DATE) = CAST(GETDATE() AS DATE) AND Status = 'CLOSE' THEN 1 ELSE 0 END)AS [Count of applications action taken as on today (approved)],
 
 SUM(CASE WHEN CAST(ClosedOn  AS DATE) = CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END) AS [Count of applications action taken as on today (returned/ rejected)]
FROM App_Gov_Notice 


App_Gov_Notice 
ID
CreatedOn
CreatedBy
ClosedOn
ClosedBy
V_CODE
V_NAME
V_PHONE_NO
V_EMAIL
OWNER_NAME
WO_NO
WO_VALIDITY
NATURE_OF_GREIVANCE
G_TYPE
TARGET_DT
STATUS
REMARKS
CC_REMARKS
ATTACHMENT
REF_NO 


App_Gov_Notice_Details

ID
MASTER_ID
V_CODE
CREATEDON
CREATEDBY
ClosedOn
ClosedBy
REF_NO
ATTACH_FILE
REMARKS
CC_REMARKS
DONE_BY
Slno
