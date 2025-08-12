select '' as WorkOrder,0 as ord union select distinct WorkOrderNo, 1 as ord   from App_AttendanceDetails
where Dates = '2025-07-30' and VendorCode ='15941'

union all

select  WO_NO as Workorder, 0 as ord  from App_Vendor_form_C3_Dtl 
where C3_CLOSER_DATE >= '2025-07-30 00:00:00:000' and V_CODE = '15941' 


and WO_NO not in
(select WO_NO from App_Wo_Nil where TEMPORARY_MONTH = '7' and TEMPORARY_YEAR = '2025' and NO_WORK = 'Temporary')

and WO_NO not in
(select WO_NO from App_Wo_Nil where convert(int, TEMPORARY_YEAR + FORMAT(CONVERT(INT, CLOSER_DATE), '00')) <= 2025-07-30
and NO_WORK = 'Permanent') 
group by WO_NO order by ord
