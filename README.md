  using (var mail = new MailMessage())
  {
      mail.From = new MailAddress("automatic_mail@tatasteel.com");

      if (!string.IsNullOrWhiteSpace(emailTo))
          mail.To.Add(emailTo);

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
          smtp.Send(mail); - error System.Net.Mail.SmtpException: 'Mailbox unavailable. The server response was: rejected because of not in approved list'
      }
  }
