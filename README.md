foreach (DataRow row in ds.Tables[0].Rows)
{
    int id = (int)row["ID"];
    string vcode       = row["vendor_code"].ToString();
    string vname       = row["vendor_name"].ToString();
    string complaintNo = row["COMPLAINT_NO"].ToString();
    string emailTo     = row["EMAIL_ID"].ToString();
    string createdBy   = row["CREATED_BY"].ToString();   // make sure your first query selects CREATED_BY

    // update status
    updateCmd.Parameters["@ID"].Value = id;
    updateCmd.ExecuteNonQuery();

    // ✨ fetch your extra comma-separated emails with your exact SQL
    string extraEmails;
    using (var cmdExtra = new SqlCommand(@"
        Select SUBSTRING((select * from(
            select ',' + m.Email COLLATE database_default as [data()]
            from UserLoginDB.dbo.aspnet_Users q
            join UserLoginDB.dbo.aspnet_Membership m on m.UserId = q.UserId
            where q.UserName = @CreatedBy
            union
            select ',' + Email
            from App_Vendor_Representative
            where CREATEDBY = @CreatedBy
        ) A FOR XML PATH('')), 2 , 9999) As Email", con))
    {
        cmdExtra.Parameters.AddWithValue("@CreatedBy", createdBy);
        object result = cmdExtra.ExecuteScalar();
        extraEmails = result == DBNull.Value ? string.Empty : result.ToString();
    }

    // build body and send mail
    string body = BuildEmailBody(vcode, vname, complaintNo);

    using (var mail = new MailMessage())
    {
        mail.From = new MailAddress("automatic_mail@tatasteel.com");

        // add main email if present
        if (!string.IsNullOrWhiteSpace(emailTo))
            mail.To.Add(emailTo);

        // add every extra address returned by your query
        if (!string.IsNullOrWhiteSpace(extraEmails))
        {
            foreach (var addr in extraEmails.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries))
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
