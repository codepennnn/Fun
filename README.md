
select '' as WO_NO,'' as validity  from App_Vendorwodetails union Select WO_NO, (WO_NO +' - '+ convert (varchar(50),END_DATE,103)) as validity 
from App_Vendorwodetails where WO_NO not in (select Workorder_No from App_Indemnity_Bond) and V_Code='14216' and WO_NO='2500011296'


https://wphtml.com/html/tf/duralux-demo/analytics.html
