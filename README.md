public void Complaint_service()
{
    string connStr = "Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123";

    string sql = @"
        SELECT 
            m.ID,
            m.vendor_code,
            m.vendor_name,
            m.COMPLAINT_NO,
            m.EMAIL_ID
        FROM App_COMPLAINT_HELP_REGISTER AS m
        INNER JOIN App_COMPLAINT_HELP_DETAILS AS d ON m.ID = d.MasterID
        WHERE m.COMPLAINT_STATUS = 'S0002'
        GROUP BY m.ID, m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.EMAIL_ID
        HAVING DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 3;
    ";

    using (var con = new SqlConnection(connStr))
    using (var da = new SqlDataAdapter(sql, con))
    {
        var ds = new DataSet();
        da.Fill(ds);

        if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
            return;   // nothing to process

        using (var updateCmd = new SqlCommand(
            "UPDATE App_COMPLAINT_HELP_REGISTER SET COMPLAINT_STATUS = 'S0004', STATUS_DATE = GETDATE() WHERE ID = @ID",
            con))
        {
            updateCmd.Parameters.Add("@ID", SqlDbType.Int);

            con.Open();

            foreach (DataRow row in ds.Tables[0].Rows)
            {
                int id = Convert.ToInt32(row["ID"]);
                string vcode = row["vendor_code"].ToString();
                string vname = row["vendor_name"].ToString();
                string complaintNo = row["COMPLAINT_NO"].ToString();
                string emailTo = row["EMAIL_ID"].ToString();

                // Update status safely
                updateCmd.Parameters["@ID"].Value = id;
                updateCmd.ExecuteNonQuery();

                // Build email body
                string body = BuildEmailBody(vcode, vname, complaintNo);

                if (!string.IsNullOrWhiteSpace(emailTo))
                {
                    using (var mail = new MailMessage())
                    {
                        mail.From = new MailAddress("automatic_mail@tatasteel.com");
                        mail.To.Add(emailTo);
                        mail.CC.Add("sidheshwar.vishwakarma@tatasteel.com");
                        mail.Subject = $"Regarding Closed Complaint of M/s {vname} (Vendor Code {vcode})";
                        mail.Body = body;
                        mail.IsBodyHtml = true;

                        using (var smtp = new SmtpClient("144.0.11.253", 25))
                        {
                            smtp.Timeout = 20000;
                            smtp.Send(mail);
                        }
                    }
                }
            }
        }
    }
}

/// <summary>
/// Simple helper to create the HTML email
/// </summary>
private string BuildEmailBody(string vcode, string vname, string complaintNo)
{
    return $@"
    <html>
    <body>
        <b>
        Dear {vname} ({vcode})<br/><br/>
        Your complaint number <strong>{complaintNo}</strong> has been closed because no response was received after three days.<br/><br/>
        For any clarification please contact Contractor Cell through the Online Helpdesk:
        https://services.juscoltd.com/CLMS <br/><br/>
        Note: Please do not reply to this system generated mail.<br/><br/>
        Thanks &amp; Regards<br/>
        Contractors' Cell<br/>
        TATA STEEL UISL
        </b>
    </body>
    </html>";
}
