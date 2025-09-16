    public void Complaint_service()
    {
        string connStr = "Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123";

        string sql = @"SELECT distinct  m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.COMPLAINT_STATUS,  m.EMAIL_ID ,  m.CREATED_BY FROM  App_COMPLAINT_HELP_REGISTER AS m INNER JOIN  App_COMPLAINT_HELP_DETAILS  AS d ON  m.ID = d.MasterID WHERE       m.COMPLAINT_STATUS = 'S0002' GROUP BY    m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.COMPLAINT_STATUS, m.EMAIL_ID ,  m.CREATED_BY HAVING      DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 3;";

        using (var con = new SqlConnection(connStr))
        using (var da = new SqlDataAdapter(sql, con))
        {
            var ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
                return;   

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
                    string createdBy = row["CREATED_BY"].ToString();


                    updateCmd.Parameters["@ID"].Value = id;
                    updateCmd.ExecuteNonQuery();


                    string extraEmails;
                    using (var cmdExtra = new SqlCommand(@"Select SUBSTRING((select * from(select ',' + m.Email COLLATE database_default as [data()]from UserLoginDB.dbo.aspnet_Users q join UserLoginDB.dbo.aspnet_Membership m on m.UserId = q.UserId where q.UserName = @CreatedBy union select ',' + Email from App_Vendor_Representative where CREATEDBY = @CreatedBy) A FOR XML PATH('')), 2 , 9999) As Email", con))
                    {
                        cmdExtra.Parameters.AddWithValue("@CreatedBy", createdBy);
                        object result = cmdExtra.ExecuteScalar();
                        extraEmails = result == DBNull.Value ? string.Empty : result.ToString();
                    }



                    string body = BuildEmailBody(vcode, vname, complaintNo);

                    if (!string.IsNullOrWhiteSpace(emailTo))
                    {
                        


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
                                smtp.Send(mail);
                            }
                        }





                    }
                }
            }
        }
    }

       check step by step code and if any issue guid me and also explaint code
