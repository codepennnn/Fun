
 select distinct  (select top 1 EMP_ESI_EXEMPTED from App_EmployeeMaster where VendorCode = AttDtl.VendorCode and 
 AadharCard = AttDtl.AadharNo order by CreatedOn desc) EMP_ESI_EXEMPTED,  (select top 1 EMP_PF_EXEMPTED
 from App_EmployeeMaster where VendorCode = AttDtl.VendorCode and AadharCard = AttDtl.AadharNo order by CreatedOn desc)
 EMP_PF_EXEMPTED,  masterID MasterID, sum(OT_hrs) OT_hrs, 2025 YearWage,2 MonthWage,AttDtl.AadharNo AadharNo,
 AttDtl.VendorCode VendorCode, VR.V_NAME VendorName, SN.STATE_NAME StateName,     AttDtl.LocationCode LocationCode,
 LM.Location LocationNM,'' SiteID,'' WorkSite ,WorkOrderNo WorkOrderNo, WorkManSl WorkManSl,WorkManName WorkManName,   
 AttDtl.WorkManCategory WorkManCategory, (select top 1 PFNo from App_EmployeeMaster
 where VendorCode = AttDtl.VendorCode and AadharCard = AttDtl.AadharNo order by CreatedOn desc) PFNo,
 (select top 1 ESINo from App_EmployeeMaster where VendorCode = AttDtl.VendorCode 
 and AadharCard = AttDtl.AadharNo order by CreatedOn desc) ESINo,(select top 1 UANNo 
 from App_EmployeeMaster where VendorCode = AttDtl.VendorCode and AadharCard = AttDtl.AadharNo 

 order by CreatedOn desc) UANNo,DAY(EOMONTH('01/2/2025')) TotDaysInMonth,  DATEDIFF(ww, CAST('20250201' AS datetime) - 1, '20250228') AS TotSunDays,  
 
 (select(Count(ah.Hdate)) from App_HolidayMaster ah where DATEPART(month, ah.Hdate) = '2' and Location = LM.Location 
 and DATEPART(year, ah.Hdate) = '2025') as TotHoliDays,  DAY(EOMONTH('01/2/2025')) - DATEDIFF(ww, CAST('20241001' AS datetime) - 1, '20241031') TotWorkingDays, 


 0.0 NoOfDaysAbsMP,CAST(1 as BIT) Approve,null Flag,0.0 PieceRate,  0.0 OverTimeAmt  from App_AttendanceDetails AttDtl 
 inner join App_EmployeeMaster EM on AttDtl.AadharNo = em.AadharCard and AttDtl.VendorCode = em.VendorCode 
 inner join App_LocationMaster LM on AttDtl.LocationCode = LM.LocationCode  inner join App_Vendor_Reg VR on VR.V_CODE = AttDtl.VendorCode 
 inner join STATE_NAME SN on SN.ID = LM.State  where  year(AttDtl.Dates) = '2025'  and AttDtl.LocationCode = 'L_45' and month(AttDtl.Dates) = '2'
 and AttDtl.VendorCode = '10511'  and AttDtl.WorkOrderNo
 IN  ('4700022498','4700024710','4700022544','4700021947','4700024271','4700025038','4700025541','4700023837','4700022135','4700026363','4700023312','4700023850','4700023337','4700023284','4700023792','4700025486','4700025641','4700024519','4700023262','4700023302','4700022134','4700025058','4700024459','4700025545','4700026589') 
 group by AttDtl.AadharNo,masterID,WorkManSl,WorkOrderNo,AttDtl.VendorCode,AttDtl.LocationCode,WorkManSl,WorkManName, 
 AttDtl.WorkManCategory,LM.Location,EngagementType,Basic_rate,VR.V_NAME,SN.STATE_NAME order by WorkManName  
