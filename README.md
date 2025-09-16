public void Complaint_service()
{
    string connStr = "Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123";

    string sql = @"
        SELECT m.ID, m.vendor_code, m.vendor_name, m.COMPLAINT_NO,
               m.EMAIL_ID,
               ExtraEmails =
                   STUFF((
                       SELECT ',' + u.Email COLLATE database_default
                       FROM   UserLoginDB.dbo.aspnet_Users  q
                       JOIN   UserLoginDB.dbo.aspnet_Membership u ON u.UserId = q.UserId
                       WHERE  q.UserName = m.CREATED_BY
                       UNION
                       SELECT ',' + v.Email
                       FROM   App_Vendor_Representative v
                       WHERE  v.CREATEDBY = m.CREATED_BY
                       FOR XML PATH(''), TYPE).value('.', 'nvarchar(max)'), 1, 1, '')
        FROM App_COMPLAINT_HELP_REGISTER AS m
        INNER JOIN App_COMPLAINT_HELP_DETAILS AS d
            ON m.ID = d.MasterID
        WHERE m.COMPLAINT_STATUS = 'S0002'
        GROUP BY m.ID, m.vendor_code, m.vendor_name, m.COMPLAINT_NO,
                 m.EMAIL_ID, m.CREATED_BY
        HAVING DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 3;
    ";

    using (var con = new SqlConnection(connStr))
    using (var da = new SqlDataAdapter(sql, con))
    {
        var ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0) return;

        using (var updateCmd = new SqlCommand(
            "UPDATE App_COMPLAINT_HELP_REGISTER SET COMPLAINT_STATUS = 'S0004', STATUS_DATE = GETDATE() WHERE ID = @ID",
            con))
        {
            updateCmd.Parameters.Add("@ID", SqlDbType.Int);
            con.Open();

            foreach (DataRow row in ds.Tables[0].Rows)
            {
                int id = (int)row["ID"];
                string vcode      = row["vendor_code"].ToString();
                string vname      = row["vendor_name"].ToString();
                string complaintNo= row["COMPLAINT_NO"].ToString();
                string emailTo    = row["EMAIL_ID"].ToString();
                string extra      = row["ExtraEmails"].ToString();   // <── new

                // close the complaint
                updateCmd.Parameters["@ID"].Value = id;
                updateCmd.ExecuteNonQuery();

                // build mail
                string body = BuildEmailBody(vcode, vname, complaintNo);

                using (var mail = new MailMessage())
                {
                    mail.From = new MailAddress("automatic_mail@tatasteel.com");

                    // main vendor email
                    if (!string.IsNullOrWhiteSpace(emailTo))
                        mail.To.Add(emailTo);

                    // add each extra email if present
                    if (!string.IsNullOrWhiteSpace(extra))
                    {
                        foreach (var addr in extra.Split(new[] {','}, StringSplitOptions.RemoveEmptyEntries))
                            mail.To.Add(addr.Trim());
                    }

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
