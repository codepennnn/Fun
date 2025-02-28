
 select NewID() As ID, YearWage As Year, AadharNo As AdharNo, Workman_Name, Workman_Slno, Workman_Category, Location,'' As V_Code,
 work_order As Workorder_No, sum(WorkOrder_WorkingDays) As total_Working_Days, max(max_rate) As MAX_RATE,


 convert(numeric(10, 3), sum(EL)) EL,convert(numeric(10, 3), sum(EL_CAL))  EL_CAL, convert(numeric(10, 3),
 sum(CL)) CL, convert(numeric(10, 3), sum(CL_CAL))  CL_CAL,convert(numeric(10, 3), sum(FL)) FL ,convert(numeric(10, 3),
 sum(FL_CAL))  FL_CAL,0.00 as EL_FINAL,0.00 as CL_FINAL,0.00 as FL_FINAL  ,0.00 as Total_Leave,case when

 (select  count(*) from App_Leave_Generation_Details l_1 where l_1.Year=YearWage and l_1.V_Code='28236' 
 and l_1.AdharNo=AadharNo and l_1.Workorder_No=work_order and l_1.Workman_Category=Workman_Category and 
 l_1.Workman_Slno =Workman_Slno and l_1.Location=Location and l_1.MAX_RATE=MAX_RATE and l_1.total_Working_days=sum(WorkOrder_WorkingDays) )>0 
 then 
 
 (select distinct Adjustable from App_Leave_Generation_Details l_1 where l_1.Year=YearWage and l_1.V_Code='28236'
 and l_1.AdharNo=AadharNo and l_1.Workorder_No=work_order and l_1.Workman_Category=Workman_Category
 and l_1.Workman_Slno =Workman_Slno and l_1.Location=Location and l_1.MAX_RATE=MAX_RATE and l_1.total_Working_days=sum(WorkOrder_WorkingDays))
 else 0 end as Adjustable,case when
 
 (select count(*) from App_Leave_Generation_Details l_1 where l_1.Year=YearWage and l_1.V_Code='28236'
 and l_1.AdharNo=AadharNo and l_1.Workorder_No=work_order and l_1.Workman_Category=Workman_Category and l_1.Workman_Slno =Workman_Slno
 and l_1.Location=Location and l_1.MAX_RATE=MAX_RATE and l_1.total_Working_days=sum(WorkOrder_WorkingDays))>0   then 
 
 
 (select distinct Final_Leave from App_Leave_Generation_Details l_1 where l_1.Year=YearWage and l_1.V_Code='28236' and l_1.AdharNo=AadharNo
 and l_1.Workorder_No=work_order and l_1.Workman_Category=Workman_Category and l_1.Workman_Slno =Workman_Slno and l_1.Location=Location and 
 l_1.MAX_RATE=MAX_RATE and l_1.total_Working_days=sum(WorkOrder_WorkingDays))   else 0 end as Final_Leave,case when
 
 
 (select count(*) from App_Leave_Generation_Details l_1 where l_1.Year=YearWage and l_1.V_Code='28236' and l_1.AdharNo=AadharNo
 and l_1.Workorder_No=work_order and l_1.Workman_Category=Workman_Category and l_1.Workman_Slno =Workman_Slno and l_1.Location=Location
 and l_1.MAX_RATE=MAX_RATE and l_1.total_Working_days=sum(WorkOrder_WorkingDays))>0   then  
 
 
 (select distinct Leave_Avail from App_Leave_Generation_Details l_1 where l_1.Year=YearWage and l_1.V_Code='28236' and l_1.AdharNo=AadharNo 
 and l_1.Workorder_No=work_order and l_1.Workman_Category=Workman_Category and l_1.Workman_Slno =Workman_Slno and l_1.Location=Location 
 and l_1.MAX_RATE=MAX_RATE and l_1.total_Working_days=sum(WorkOrder_WorkingDays))   else Convert(decimal(18,2),0) end as Leave_Avail,case when
 
 
 (select count(*) from App_Leave_Generation_Details l_1 where l_1.Year=YearWage and l_1.V_Code='28236' and l_1.AdharNo=AadharNo 
 and l_1.Workorder_No=work_order and l_1.Workman_Category=Workman_Category and l_1.Workman_Slno =Workman_Slno and l_1.Location=Location
 and l_1.MAX_RATE=MAX_RATE and l_1.total_Working_days=sum(WorkOrder_WorkingDays))>0   then  
 
 
 (select distinct Leave_FNF from App_Leave_Generation_Details l_1 where l_1.Year=YearWage and l_1.V_Code='28236' and l_1.AdharNo=AadharNo 
 and l_1.Workorder_No=work_order and l_1.Workman_Category=Workman_Category and l_1.Workman_Slno =Workman_Slno and l_1.Location=Location 
 and l_1.MAX_RATE=MAX_RATE and l_1.total_Working_days=sum(WorkOrder_WorkingDays))   else Convert(decimal(18,2),0) end as Leave_FNF from 
 
 
 
 (select w1.WorkManName as Workman_Name, w1.WorkManSl as workman_slno, w1.WorkManCategory as Workman_Category,  
 L.Location as Location, w1.AadharNo, VendorCode, YearWage, WorkOrderNo as work_order,
 IsNull(sum(W1.NoOfDaysWorkedMP + W1.NoOfDaysWorkedRate), 0) WorkOrder_WorkingDays  ,
 iif(IsNull(sum(W1.NoOfDaysWorkedMP + W1.NoOfDaysWorkedRate), 0) / 20.00 <= 15,
 (IsNull(sum(W1.NoOfDaysWorkedMP + W1.NoOfDaysWorkedRate), 0) / 20.00), 15) as EL, 
 
 
 
 (select(    ((select convert(numeric(10, 3), isNull(sum(j2.Jan + j2.Feb + j2.Mar + j2.Apr + j2.May + j2.June + j2.July), 0)) from App_Leave_Generation_Jan_July j2 
 where j2.Vcode = '28236' and j2.Year = '2024' and j2.AdharNo = w1.AadharNo) +  
 
 
 (select convert(numeric(10, 3), IsNull(sum(w2.NoOfDaysWorkedMP + w2.NoOfDaysWorkedRate), 0))
 from App_WagesDetailsJharkhand w2 where w2.VendorCode = '28236' and w2.YearWage = '2024' and w2.AadharNo = w1.AadharNo)) )/ 20.00 EL_CAL) as EL_CAL 
 ,iif(IsNull(sum(W1.NoOfDaysWorkedMP + W1.NoOfDaysWorkedRate), 0) / 35.00 <= 7, (IsNull(sum(W1.NoOfDaysWorkedMP + W1.NoOfDaysWorkedRate), 0) / 35.00), 7) as cl,
 
 
 
 (select(  ((select convert(numeric(10, 3), isNull(sum(j_el.Jan + j_el.Feb + j_el.Mar + j_el.Apr + j_el.May + j_el.June + j_el.July), 0))
 from App_Leave_Generation_Jan_July j_el where j_el.Vcode = '28236' and j_el.Year = '2024' and j_el.AdharNo = w1.AadharNo) +  
 
 
 
 (select convert(numeric(10, 3), IsNull(sum(w_el.NoOfDaysWorkedMP + w_el.NoOfDaysWorkedRate), 0)) from App_WagesDetailsJharkhand w_el where w_el.VendorCode = '28236'
 and w_el.YearWage = '2024' and w_el.AadharNo = w1.AadharNo)))/ 35.00 CL_CAL) as CL_CAL  ,iif(IsNull(sum(W1.NoOfDaysWorkedMP + W1.NoOfDaysWorkedRate), 0) / 60.00 <= 4,
 (IsNull(sum(W1.NoOfDaysWorkedMP + W1.NoOfDaysWorkedRate), 0) / 60.00), 4) as FL, 
 
 (select(  ((select convert(numeric(10, 3),
 isNull(sum(j_el.Jan + j_el.Feb + j_el.Mar + j_el.Apr + j_el.May + j_el.June + j_el.July), 0)) from App_Leave_Generation_Jan_July j_el where j_el.Vcode = '28236'
 and j_el.Year = '2024' and j_el.AdharNo = w1.AadharNo) + 
 
 
 (select convert(numeric(10, 3), IsNull(sum(w_el.NoOfDaysWorkedMP + w_el.NoOfDaysWorkedRate), 0))
 from App_WagesDetailsJharkhand w_el where w_el.VendorCode = '28236' and w_el.YearWage = '2024' and w_el.AadharNo = w1.AadharNo)))/ 60.00 FL_CAL) as FL_CAL  ,
 
 
 
 (select distinct max(BasicRate+DARate) from App_WagesDetailsJharkhand where YearWage='2024' and VendorCode='28236' and AadharNo=w1.AadharNo and WorkManSl=w1.WorkManSl
 and WorkManCategory=w1.WorkManCategory and LocationNM =L.Location and TotPaymentDays!=0.00) as MAX_RATE  from App_WagesDetailsJharkhand w1 
 left join App_LocationMaster L on L.LocationCode = w1.LocationCode  where VendorCode = '28236' and YearWage = '2024'  and TotPaymentDays!=0.00 
 group by AadharNo,VendorCode,YearWage,WorkOrderNo,WorkManName,WorkManSl,WorkManCategory,L.Location  union  
 
 select Workman_Name
 as Workman_Name,Workman_Slno as Workman_Slno,Workman_Category as Workman_Category,   L1.Location as Location ,AdharNo,Vcode,Year,Workorder_No  
 , isNull(sum(J1.Jan + J1.Feb + J1.Mar + J1.Apr + J1.May + J1.June + J1.July), 0) WorkOrder_WorkingDays 
 ,iif(isNull(sum(J1.Jan + J1.Feb + J1.Mar + J1.Apr + J1.May + J1.June + J1.July), 0) / 20.00 <= 15,
 (isNull(sum(J1.Jan + J1.Feb + J1.Mar + J1.Apr + J1.May + J1.June + J1.July), 0) / 20.00), 15) as EL, 
 
 
 (select(  ((select convert(numeric(10, 3), isNull(sum(j_el.Jan + j_el.Feb + j_el.Mar + j_el.Apr + j_el.May + j_el.June + j_el.July), 0))
 from App_Leave_Generation_Jan_July j_el where j_el.Vcode = '28236' and j_el.Year = '2024' and j_el.AdharNo = j1.AdharNo) + 
 
 
 (select convert(numeric(10, 3), IsNull(sum(w_el.NoOfDaysWorkedMP + w_el.NoOfDaysWorkedRate), 0)) from App_WagesDetailsJharkhand w_el 
 where w_el.VendorCode = '28236' and w_el.YearWage = '2024' and w_el.AadharNo = j1.AdharNo)) )/ 20.00 EL_CAL) as EL_CAL
 ,iif(isNull(sum(J1.Jan + J1.Feb + J1.Mar + J1.Apr + J1.May + J1.June + J1.July), 0) / 35.00 <= 7,
 (isNull(sum(J1.Jan + J1.Feb + J1.Mar + J1.Apr + J1.May + J1.June + J1.July), 0) / 35.00), 7) as cl, 
 
 
 
 (select(  ((select convert(numeric(10, 3), isNull(sum(j_el.Jan + j_el.Feb + j_el.Mar + j_el.Apr + j_el.May + j_el.June + j_el.July), 0))
 from App_Leave_Generation_Jan_July j_el where j_el.Vcode = '28236' and j_el.Year = '2024' and j_el.AdharNo = j1.AdharNo) + 
 
 
 
 (select convert(numeric(10, 3), IsNull(sum(w_el.NoOfDaysWorkedMP + w_el.NoOfDaysWorkedRate), 0)) from App_WagesDetailsJharkhand w_el 
 where w_el.VendorCode = '28236' and w_el.YearWage = '2024' and w_el.AadharNo = j1.AdharNo)))/ 35.00 CL_CAL) as CL_CAL  
 ,iif(isNull(sum(J1.Jan + J1.Feb + J1.Mar + J1.Apr + J1.May + J1.June + J1.July), 0) / 60.00 <= 4,
 (isNull(sum(J1.Jan + J1.Feb + J1.Mar + J1.Apr + J1.May + J1.June + J1.July), 0) / 60.00), 4) as FL, 
 
 
 
 (select(    ((select convert(numeric(10, 3), isNull(sum(j_el.Jan + j_el.Feb + j_el.Mar + j_el.Apr + j_el.May + j_el.June + j_el.July), 0))
 from App_Leave_Generation_Jan_July j_el where j_el.Vcode = '28236' and j_el.Year = '2024' and j_el.AdharNo = j1.AdharNo) +
 
 
 
 (select convert(numeric(10, 3), IsNull(sum(w_el.NoOfDaysWorkedMP + w_el.NoOfDaysWorkedRate), 0)) from App_WagesDetailsJharkhand w_el where w_el.VendorCode = '28236'
 and w_el.YearWage = '2024' and w_el.AadharNo = j1.AdharNo)) )/ 60.00 FL_CAL) as FL_CAL  ,
 
 (SELECT MAX(T.field) AS MAX_RATE 
 
 
 
 FROM(  SELECT Jan_rate AS field  FROM App_Leave_Generation_Jan_July where AdharNo = j1.AdharNo
 and Vcode = j1.Vcode  UNION ALL 
 
 
 SELECT Feb_Rate AS field  FROM App_Leave_Generation_Jan_July 
 where AdharNo = j1.AdharNo and Vcode = j1.Vcode  UNION ALL 
 
 SELECT Mar_rate AS field 
 FROM App_Leave_Generation_Jan_July where AdharNo = j1.AdharNo and Vcode = j1.Vcode 
 UNION ALL  
 
 SELECT Apr_rate As field  FROM App_Leave_Generation_Jan_July
 where AdharNo = j1.AdharNo and Vcode = j1.Vcode  UNION ALL

 SELECT May_rate AS field  FROM App_Leave_Generation_Jan_July where AdharNo = j1.AdharNo and Vcode = j1.Vcode  UNION ALL 

 SELECT June_rate AS field  FROM App_Leave_Generation_Jan_July where AdharNo = j1.AdharNo and Vcode = j1.Vcode  UNION ALL

 SELECT July_rate As field  FROM App_Leave_Generation_Jan_July where AdharNo = j1.AdharNo and Vcode = j1.Vcode) AS T) 
 from App_Leave_Generation_Jan_July j1  left join App_LocationMaster L1 on L1.LocationCode = j1.Location  where Vcode = '28236' and Year = '2024' 
 group by  AdharNo,Vcode,Year,Workorder_No,Workman_Name,Workman_Slno,Workman_Category,L1.Location) tab 
 group by AadharNo, VendorCode, YearWage, work_order, Workman_Name, Workman_Slno, Workman_category, Location order by Workman_Name 
