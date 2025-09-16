SELECT DISTINCT TOP 5
       m.ID,
       m.vendor_code,
       m.vendor_name,
       m.COMPLAINT_NO,
       m.COMPLAINT_STATUS,
       m.EMAIL_ID AS RegisterEmail,        -- email already in register table
       v.Email_ID AS VendorRegEmail,       -- email from App_Vendor_Reg
       m.CREATED_BY
FROM App_COMPLAINT_HELP_REGISTER AS m
INNER JOIN App_COMPLAINT_HELP_DETAILS AS d
        ON m.ID = d.MasterID
LEFT JOIN App_Vendor_Reg AS v            -- join to get email from vendor table
        ON v.vendor_code = m.vendor_code  -- match by vendor code
WHERE m.COMPLAINT_STATUS = 'S0002'
GROUP BY m.ID,
         m.vendor_code,
         m.vendor_name,
         m.COMPLAINT_NO,
         m.COMPLAINT_STATUS,
         m.EMAIL_ID,
         v.Email_ID,
         m.CREATED_BY
HAVING DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 3;
