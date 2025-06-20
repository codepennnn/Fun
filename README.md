select distinct a.wo_no as Workorder from App_WorkOrder_Reg as a where  a.TO_DATE >'2025-06-30 00:00:00.000'
and STATUS='Approved'
