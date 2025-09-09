
select top 89 S.*,(select top 1 Name from App_EmployeeMaster where AadharCard=S.AdharNo and 
VendorCode=S.VendorCode order by CreatedOn desc) As WorkMan_Name,

(select top 1 convert(varchar(10), DOJ,103) from App_EmployeeMaster where AadharCard=S.AdharNo
and S.VendorCode=VendorCode  order by CreatedOn desc) as DOJ from App_FNF_Summary S 

where S.workorderno like '4700025453' and S.vendorcode 
like '11262' and S.comp_masterid like 'CC70C1AD-668E-4A78-BA7F-C7D6D4B3879B' and AdharNo='464132795067' order by S.CreatedOn 

