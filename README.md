SELECT      m.ID,
            m.COMPLAINT_NO,
            m.COMPLAINT_STATUS,
            MAX(d.UPDT_DATE)  AS LastReplyDate
FROM        App_COMPLAINT_HELP_REGISTER AS m
INNER JOIN  App_COMPLAINT_HELP_DETAILS  AS d
        ON  m.ID = d.MasterID
WHERE       m.COMPLAINT_STATUS = 'Awaiting for Vendor Response'
GROUP BY    m.ID, m.COMPLAINT_NO, m.COMPLAINT_STATUS
HAVING      DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 3;
