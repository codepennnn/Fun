SELECT  m.ID,  m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.COMPLAINT_STATUS,  m.EMAIL_ID

+','+isnull((select top 1 EMAIL = STUFF((SELECT DISTINCT ', ' + EMAIL from App_Vendor_Representative as b where b.CREATEDBY = m.vendor_code FOR XML PATH('')), 1, 2, '') FROM App_Vendor_Representative as a),'') E_Mail


,
m.CREATED_BY 
FROM  App_COMPLAINT_HELP_REGISTER AS m 
INNER JOIN  App_COMPLAINT_HELP_DETAILS  AS d ON  m.ID = d.MasterID 
WHERE       m.COMPLAINT_STATUS = 'S0002' 
GROUP BY  m.ID,  m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.COMPLAINT_STATUS, m.EMAIL_ID , 
m.CREATED_BY HAVING      DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 10;
