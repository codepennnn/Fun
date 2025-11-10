  from(  
  
  select    0.00 as EL_FINAL,
  0.00 as CL_FINAL,
  0.00 as FL_FINAL,
  0.00 as Total_Leave, 
  w1.WorkManName as Workman_Name,
  w1.WorkManSl as workman_slno,
  w1.WorkManCategory as Workman_Category, 
  L.Location as Location,
  w1.AadharNo,
  VendorCode,
  YearWage, 
  WorkOrderNo as work_order,  
  IsNull(sum(isnull(w1.NoOfDaysWorkedMP,0)+isnull(w1.NoOfDaysWorkedRate,0)), 0)   WorkOrder_WorkingDays,   
  
  iif(sum(isnull(w1.NoOfDaysWorkedMP,0)+isnull(w1.NoOfDaysWorkedRate,0))/20.0 <=15.0,
  sum(isnull(w1.NoOfDaysWorkedMP,0)+isnull(w1.NoOfDaysWorkedRate,0))/20.0 , 15) as EL,   

  iif(sum(isnull(w1.NoOfDaysWorkedMP,0)+isnull(w1.NoOfDaysWorkedRate,0)) / 35.00 <= 7, 
  (sum(isnull(w1.NoOfDaysWorkedMP,0)+isnull(w1.NoOfDaysWorkedRate,0)) / 35.00), 7)  as cl, 

  iif(sum(isnull(w1.NoOfDaysWorkedMP,0)+isnull(w1.NoOfDaysWorkedRate,0)) / 60.00 <= 4, 
  (sum(isnull(w1.NoOfDaysWorkedMP,0)+isnull(w1.NoOfDaysWorkedRate,0)) / 60.00), 4)  as FL,  
  
  (select distinct max(BasicRate+DARate) from App_WagesDetailsJharkhand where YearWage='2024' and VendorCode='17201' and 
  AadharNo =w1.AadharNo and WorkManSl=w1.WorkManSl and WorkManCategory=w1.WorkManCategory and LocationNM =L.Location and 
  TotPaymentDays !=0.00  and WorkOrderNo=w1.WorkOrderNo      )     as MAX_RATE,  
  (select distinct max(MonthWage) from App_WagesDetailsJharkhand where YearWage='2024' and VendorCode='17201'
  and AadharNo=w1.AadharNo and   WorkManSl =w1.WorkManSl and WorkManCategory=w1.WorkManCategory 
  and LocationNM =L.Location and TotPaymentDays!= 0.00    and WorkOrderNo=w1.WorkOrderNo  )    as last_wage_month,
  Convert (varchar(10),wr.TO_DATE,103) to_date    from App_WagesDetailsJharkhand w1  
  left join App_LocationMaster L on L.LocationCode = w1.LocationCode   
  left join App_WorkOrder_Reg Wr on Wr.WO_NO=w1.WorkOrderNo   where VendorCode = '17201' and YearWage = '2024'
  and TotPaymentDays!= 0.00     group by w1.AadharNo, w1.VendorCode, w1.YearWage, 
  w1.WorkOrderNo, w1.WorkManName, w1.WorkManSl, w1.WorkManCategory, l.Location ,wr.TO_DATE 
  
  






  ) x group by 
  x.AadharNo,x.last_wage_month,x.Location,x.MAX_RATE,x.to_date,x.Total_Leave,x.VendorCode,x.work_order,
  x.Workman_Category,x.Workman_Name,x.workman_slno,x.WorkOrder_WorkingDays,x.YearWage,x.CL_FINAL,x.EL_FINAL,x.FL_FINAL,
  x.EL,x.cl,X.FL   order by x.Workman_Name  
