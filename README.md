      public void Complaint_service()
      {
          string connStr = "Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123";

          string sql = @"SELECT  m.ID,  m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.COMPLAINT_STATUS,  m.EMAIL_ID +','+isnull((select top 1 EMAIL = STUFF((SELECT DISTINCT ', ' + EMAIL from App_Vendor_Representative as b where b.CREATEDBY = m.vendor_code FOR XML PATH('')), 1, 2, '') FROM App_Vendor_Representative as a),'') E_Mail,isnull (v.EMAIL,'') as V_Email,m.CREATED_BY FROM  App_COMPLAINT_HELP_REGISTER AS m INNER JOIN  App_COMPLAINT_HELP_DETAILS  AS d ON  m.ID = d.MasterID LEFT JOIN App_Vendor_Reg AS v  ON v.V_CODE = m.VENDOR_CODE WHERE m.COMPLAINT_STATUS = 'S0002' GROUP BY  m.ID,  m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.COMPLAINT_STATUS, m.EMAIL_ID , v.EMAIL, m.CREATED_BY HAVING DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 10;";

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
                  updateCmd.Parameters.Add("@ID", SqlDbType.UniqueIdentifier);

                  con.Open();

                  foreach (DataRow row in ds.Tables[0].Rows)
                  {
                      Guid id = Guid.Parse(row["ID"].ToString());
                      string vcode = row["vendor_code"].ToString();
                      string vname = row["vendor_name"].ToString();
                      string complaintNo = row["COMPLAINT_NO"].ToString();
                      string emailTo = row["EMAIL_ID"].ToString() row["V_Email"].ToString();
                      string createdBy = row["CREATED_BY"].ToString();


                      updateCmd.Parameters["@ID"].Value = id;
                      updateCmd.ExecuteNonQuery();

                                

                      string body = BuildEmailBody(vcode, vname, complaintNo);

                      if (!string.IsNullOrWhiteSpace(emailTo))
                      {



                          using (var mail = new MailMessage())
                          {
                              mail.From = new MailAddress("automatic_mail@tatasteel.com");

                              if (!string.IsNullOrWhiteSpace(emailTo))
                                  mail.To.Add(emailTo);

                            

                              mail.CC.Add("asif.akhtar@partners.tatasteel.com");
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

       
