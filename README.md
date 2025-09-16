SELECT  
    m.ID,
    m.vendor_code,
    m.vendor_name,
    m.COMPLAINT_NO,
    m.COMPLAINT_STATUS,
    m.EMAIL_ID
    + ',' + ISNULL(
          (
            SELECT TOP 1
                   EMAIL = STUFF(
                        ( SELECT DISTINCT ', ' + EMAIL
                          FROM App_Vendor_Representative b
                          WHERE b.CREATEDBY = m.vendor_code
                          FOR XML PATH('')
                        ),1,2,''
                     )
          ), ''
      ) AS E_Mail,
    -- ▼ NEW sub-query for email(s) from App_Vendor_Reg
    ISNULL(
        (
            SELECT TOP 1
                   EMAIL = STUFF(
                        ( SELECT DISTINCT ', ' + vr.Email_ID
                          FROM App_Vendor_Reg vr
                          WHERE vr.vendor_code = m.vendor_code
                          FOR XML PATH('')
                        ),1,2,''
                     )
        ), ''
    ) AS VendorReg_Email,
    m.CREATED_BY
FROM  App_COMPLAINT_HELP_REGISTER AS m
INNER JOIN App_COMPLAINT_HELP_DETAILS AS d
        ON m.ID = d.MasterID
WHERE  m.COMPLAINT_STATUS = 'S0002'
GROUP BY
    m.ID,
    m.vendor_code,
    m.vendor_name,
    m.COMPLAINT_NO,
    m.COMPLAINT_STATUS,
    m.EMAIL_ID,
    m.CREATED_BY
HAVING DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 10;
