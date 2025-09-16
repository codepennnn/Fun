private string GetExtraEmails(SqlConnection con, string createdBy)
{
    string emailSql = @"
        SELECT STUFF((
            SELECT ',' + u.Email COLLATE database_default
            FROM   UserLoginDB.dbo.aspnet_Users  q
            JOIN   UserLoginDB.dbo.aspnet_Membership u ON u.UserId = q.UserId
            WHERE  q.UserName = @CreatedBy
            UNION
            SELECT ',' + v.Email
            FROM   App_Vendor_Representative v
            WHERE  v.CREATEDBY = @CreatedBy
            FOR XML PATH(''), TYPE).value('.', 'nvarchar(max)'), 1, 1, '')";

    using (var cmd = new SqlCommand(emailSql, con))
    {
        cmd.Parameters.AddWithValue("@CreatedBy", createdBy);
        object result = cmd.ExecuteScalar();
        return result == DBNull.Value ? string.Empty : result.ToString();
    }
}




public void Complaint_service()
{
    string connStr = "Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123";

    using (var con = new SqlConnection(connStr))
    using (var da = new SqlDataAdapter(sql, con))
    {
        var ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0) return;

        using (var updateCmd = new SqlCommand(
            "UPDATE App_COMPLAINT_HELP_REGISTER SET COMPLAINT_STATUS='S0004', STATUS_DATE=GETDATE() WHERE ID=@ID",
            con))
        {
            updateCmd.Parameters.Add("@ID", SqlDbType.Int);
            con.Open();

            foreach (DataRow row in ds.Tables[0].Rows)
            {
                int id = (int)row["ID"];
                string vcode       = row["vendor_code"].ToString();
                string vname       = row["vendor_name"].ToString();
                string complaintNo = row["COMPLAINT_NO"].ToString();
                string emailTo     = row["EMAIL_ID"].ToString();
                string createdBy   = row["CREATED_BY"].ToString();

                // close the complaint
                updateCmd.Parameters["@ID"].Value = id;
                updateCmd.ExecuteNonQuery();

                // fetch extra addresses with the separate query
                string extraEmails = GetExtraEmails(con, createdBy);

                // compose mail
                string body = BuildEmailBody(vcode, vname, complaintNo);

                using (var mail = new MailMessage())
                {
                    mail.From = new MailAddress("automatic_mail@tatasteel.com");

                    if (!string.IsNullOrWhiteSpace(emailTo))
                        mail.To.Add(emailTo);

                    if (!string.IsNullOrWhiteSpace(extraEmails))
                    {
                        foreach (var addr in extraEmails.Split(new[] {','}, StringSplitOptions.RemoveEmptyEntries))
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


