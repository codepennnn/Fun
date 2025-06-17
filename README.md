select v.*,d.DepartmentName
from App_Vendorwodetails v
 left join App_DepartmentMaster d on v.DEPT_CODE = d.DepartmentCode


where  WO_NO in 
(

2500011385,
