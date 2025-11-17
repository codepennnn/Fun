  SELECT 'Wages' as [Modules] ,'VGPMS' as [Software],'3' [SLG Days],
SUM(CASE WHEN DATEDIFF(DAY, ( UPDATEDAT), GETDATE()) = 0 AND (STATUS = 'pending with verifier') THEN 1 ELSE 0 END) AS[Pending application days count: 0],
SUM(CASE WHEN DATEDIFF(DAY, ( UPDATEDAT), GETDATE()) = 1 AND(  STATUS ='pending with verifier') THEN 1 ELSE 0 END) AS[Pending application days count: 1],
SUM(CASE WHEN DATEDIFF(DAY, ( UPDATEDAT), GETDATE()) = 2 AND( STATUS = 'pending with verifier' ) THEN 1 ELSE 0 END) AS[Pending application days count: 2],
SUM(CASE WHEN DATEDIFF(DAY, ( UPDATEDAT), GETDATE()) = 3 AND( STATUS = 'pending with verifier' ) THEN 1 ELSE 0 END) AS[Pending application days count: 3],
SUM(CASE WHEN DATEDIFF(DAY, ( UPDATEDAT), GETDATE()) = 4 AND( STATUS = 'pending with verifier') THEN 1 ELSE 0 END)AS[Pending application days count: 4],
SUM(CASE WHEN DATEDIFF(DAY, ( UPDATEDAT), GETDATE()) = 5 AND( STATUS = 'pending with verifier') THEN 1 ELSE 0 END) AS[Pending application days count: 5],
SUM(CASE WHEN DATEDIFF(DAY, ( UPDATEDAT), GETDATE()) > 5 AND( STATUS = 'pending with verifier') THEN 1 ELSE 0 END) AS[Pending application days count: more than 5],
SUM(CASE WHEN  CAST(( LEVEL_2_UPDATEDAT) AS DATE) = CAST(GETDATE() AS DATE)  AND(STATUS = 'Approved') THEN 1 ELSE 0 END) AS[Count of applications action taken as on today (Approved)],
SUM(CASE WHEN  CAST((LEVEL_2_UPDATEDAT) AS DATE) = CAST(GETDATE() AS DATE) AND(STATUS = 'pending with verifier')  THEN 1 ELSE 0 END) AS[Count of applications action taken as on today (Returned / Rejected)] FROM online_temp_wages_2  

application showing 2 but in actual it is 11. this problem comes because i have work order wise application and work orde is in this table - online_temp_c_entry_details
