  select TO_DATE,FROM_DATE,WO_NO from App_WorkOrder_Reg  where V_CODE = '15235' and 
  WO_NO = (select  top 1 * from App_EmployeeMaster where VendorCode = '15235' and AadharCard = '929025599977' order by CreatedOn desc )
