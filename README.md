SELECT DISTINCT 
    Em.AadharCard,
    Em.EMP_PF_EXEMPTED,
    Em.EMP_ESI_EXEMPTED
FROM 
    App_EmployeeMaster Em
WHERE 
    Em.VendorCode = '15941' 
    AND Em.Curr_emp_status = 'Active'
    AND Em.AadharCard IS NOT NULL
ORDER BY 
    Em.AadharCard DESC;
