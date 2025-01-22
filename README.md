SELECT  W.LocationCode As Loc_Code ,W.LocationNM As Loc_Name,
W.AadharNo,
(select top 1 Sex from App_EmployeeMaster where AadharCard=w.AadharNo order by CreatedOn desc) Gender,
W.WorkManCategory As Skill,
CONCAT(W.YearWage, RIGHT('0' + CAST(W.MonthWage AS VARCHAR(2)), 2)) AS YrMonth,
W.VendorCode,
W.VendorName,
W.WorkOrderNo,


(select top 1 DepartmentCode from App_DepartmentMaster
where DepartmentName=(select top 1 DEPT_CODE from App_WorkOrder_Reg where WO_NO=w.WorkOrderNo) ) DeptCode, 

(select top 1 DEPT_CODE from App_WorkOrder_Reg where WO_NO=w.WorkOrderNo ) DeptName, 

W.TotPaymentDays As PaymentDays,
'TSUISL' As EXECHEAD,
W.TotalWages  As GrossWage,
W.BasicWages as Basic,
W.DAWages as Da


FROM App_WagesDetailsJharkhand w where MonthWage in ('1','2','3','4','5','6') and YearWage in ('2024' )

