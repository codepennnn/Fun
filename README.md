 select CR.*,HM.NEXT_STATUS,CR.NEXT_USER_ID,
 case when NEXT_STATUS!='Closed' then DATEDIFF(day,STATUS_DATE,getdate()) else null
 end as PendingDays,DATEDIFF(day,CR.CREATED_ON, GETDATE()) as Created_vs_Current 

 from App_COMPLAINT_HELP_REGISTER CR left join App_HELPDESK_STATUS_MASTER HM on CR.COMPLAINT_STATUS = HM.STATUS_CODE 

 where 1=1 and STATUS_CODE= 'S0007' order by COMPLAINT_DATE desc




 select * from App_COMPLAINT_HELP_DETAILS where MasterID=''
 select USERNAME from App_HELPDESK_FWD_LIST where USERID=''
 
