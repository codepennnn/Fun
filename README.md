SELECT distinct top 5 m.ID,  m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.COMPLAINT_STATUS,  m.EMAIL_ID ,  m.CREATED_BY FROM  App_COMPLAINT_HELP_REGISTER AS m INNER JOIN  App_COMPLAINT_HELP_DETAILS  AS d ON  m.ID = d.MasterID WHERE       m.COMPLAINT_STATUS = 'S0002' GROUP BY  m.ID,  m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.COMPLAINT_STATUS, m.EMAIL_ID ,  m.CREATED_BY HAVING      DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 3

in this i want my email_id thourh my another table that is App_Vendor_Reg as per vcode
