foreach (DataRow row in ds.Tables[0].Rows)
{
    Guid id = Guid.Parse(row["ID"].ToString());
    string vcode = row["vendor_code"].ToString();
    string vname = row["vendor_name"].ToString();
    string complaintNo = row["COMPLAINT_NO"].ToString();

    // 🔹 Temporary override — only Asif will get mail
    string emailTo = "asif.akhtar@gmail.com";  
    
    string createdBy = row["CREATED_BY"].ToString();

    updateCmd.Parameters["@ID"].Value = id;
    updateCmd.ExecuteNonQuery();

    string body = BuildEmailBody(vcode, vname, complaintNo);

    if (!string.IsNullOrWhiteSpace(emailTo))
    {
        using (var mail = new MailMessage())
        {
            mail.From = new MailAddress("automatic_mail@tatasteel.com");
            mail.To.Add(emailTo);

            mail.CC.Add("sidheshwar.vishwakarma@tatasteel.com");  // keep CC if needed
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
