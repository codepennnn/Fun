7SELECT 
    e.ID, e.EMP_PF_EXEMPTED, e.EMP_ESI_EXEMPTED,
    e.EXEMPTED_FILE, e.VendorCode, e.VendorName,
    (d.DepartmentName + '-' + e.DeptCode) AS DeptCode, e.WorkOrder,
    e.Name, e.Sex, e.WorkManSlNo, e.WorkManCategory, e.IdentityMark,
    e.Religion, e.WorkLocation, e.NatureOfWork, e.DOB, e.DOJ, e.UANNo,
    e.PFNo, e.ESINo, e.Mobile, e.AadharCard, e.VoterID, e.DLNo, e.BankAc,
    e.BankName, e.IFSC, e.BloodGroup, e.WorkManAddress, e.District, e.LabourState,
    e.PINCode, e.CreatedBy, e.CreatedOn, e.OffDay, e.OffDay1, e.ShiftDuty, e.ManualEntry,
    e.ManualFromDt, e.ManualToDt, e.Shift, e.WMImageAttach, e.AadharAttach, e.PoliceVerifAttach,
    e.BankDocAttach, e.DLAttach, e.OtherAttach, w.WoNoValidFrom, w.WoNoValidTo,
    e.ApproverID, e.ApprvStatus, e.ApproverRemarks, e.ApprovalDate, e.PFAttach,
    e.ESIAttach, e.MedicalAttach, e.EmploymentAttach, e.HRA, e.OtherAllow, e.Father_Name,
    e.Emp_type, e.Emp_type_attach, e.Emergency_contact_no, e.Email, e.Social_Category,
    e.Curr_emp_status, e.Inactive_reason, e.Emp_stat_filename, e.UPDATEDBY,
    e.UPDATEDON, e.Basic_rate, e.Da_rate, e.DOE, e.Approve_First_Date
FROM  
    App_EmployeeMaster e
INNER JOIN  
    App_DepartmentMaster d ON d.DepartmentCode = e.DeptCode
LEFT JOIN 
    App_WorkOrderReg w ON w.WorkOrderNo = e.WorkOrder
WHERE 
    e.ID = @ID
----------------

  string strSQL = "SELECT e.ID, e.EMP_PF_EXEMPTED,e.EMP_ESI_EXEMPTED ,e.EXEMPTED_FILE,e.VendorCode, e.VendorName, (d.DepartmentName  +'-'+e.DeptCode  ) DeptCode, e.WorkOrder, e.Name, e.Sex, e.WorkManSlNo, e.WorkManCategory, e.IdentityMark, e.Religion, e.WorkLocation, e.NatureOfWork, e.DOB, e.DOJ, e.UANNo, e.PFNo, e.ESINo, e.Mobile, e.AadharCard, e.VoterID, e.DLNo, e.BankAc, e.BankName, e.IFSC, e.BloodGroup, e.WorkManAddress, e.District, e.LabourState, e.PINCode, e.CreatedBy, e.CreatedOn, e.OffDay, e.OffDay1, e.ShiftDuty, e.ManualEntry, e.ManualFromDt, e.ManualToDt, e.Shift, e.WMImageAttach, e.AadharAttach, e.PoliceVerifAttach, e.BankDocAttach, e.DLAttach, e.OtherAttach,  w.FROM_DATE, w.TO_DATE, e.ApproverID, e.ApprvStatus, e.ApproverRemarks, e.ApprovalDate, e.PFAttach, e.ESIAttach, e.MedicalAttach, e.EmploymentAttach, e.HRA, e.OtherAllow, e.Father_Name, e.Emp_type, e.Emp_type_attach, e.Emergency_contact_no, e.Email, e.Social_Category, e.Curr_emp_status, e.Inactive_reason, e.Emp_stat_filename, e.UPDATEDBY, e.UPDATEDON, e.Basic_rate,e.Da_rate,e.DOE,e.Approve_First_Date FROM  App_EmployeeMaster e inner join  App_DepartmentMaster d on d.DepartmentCode=e.DeptCode INNER JOIN App_WorkOrder_Reg w ON w.WO_NO = e.WorkOrder where e.ID=@ID";


OUTER APPLY (
    SELECT TOP 1 FROM_DATE, TO_DATE
    FROM App_WorkOrder_Reg w 
    WHERE w.WO_NO = e.WorkOrder 
    ORDER BY TO_DATE DESC
) w
