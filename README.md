
select * from App_COMPLAINT_HELP_DETAILS where   MasterID in (select * from App_COMPLAINT_HELP_REGISTER   where	VENDOR_CODE='10104')

select * from App_COMPLAINT_HELP_REGISTER   where	VENDOR_CODE='10104'  order by CREATED_ON desc	
