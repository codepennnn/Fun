 public void Complaint_service()
 {
     string start=System.DateTime.Now.ToString();    

     string connStr = "Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123";

     string sql = @"SELECT m.ID,  m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.COMPLAINT_STATUS,  m.EMAIL_ID +','+isnull((select top 1 EMAIL = STUFF((SELECT DISTINCT ', ' + EMAIL from App_Vendor_Representative as b where b.CREATEDBY = m.vendor_code FOR XML PATH('')), 1, 2, '') FROM App_Vendor_Representative as a),'') E_Mail,isnull (v.EMAIL,'') as V_Email,m.CREATED_BY FROM  App_COMPLAINT_HELP_REGISTER AS m INNER JOIN  App_COMPLAINT_HELP_DETAILS  AS d ON  m.ID = d.MasterID LEFT JOIN App_Vendor_Reg AS v  ON v.V_CODE = m.VENDOR_CODE WHERE m.COMPLAINT_STATUS = 'S0002' and m.ID='39314ED4-73CA-4A45-8148-61D64B10BC7C' GROUP BY  m.ID,  m.vendor_code, m.vendor_name, m.COMPLAINT_NO, m.COMPLAINT_STATUS, m.EMAIL_ID , v.EMAIL, m.CREATED_BY HAVING DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 10;";

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
                 string emailTo = string.Join(", ",new[] { row["E_Mail"].ToString(), row["V_Email"].ToString() }.Where(s => !string.IsNullOrWhiteSpace(s)));
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
                         {
                             foreach (var addr in emailTo.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries))
                             {
                                 mail.To.Add(addr.Trim());
                             }
                         }



                         mail.CC.Add(" sidheshwar.vishwakarma@tatasteel.com");
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




     Tracelog( start,  System.DateTime.Now.ToString(), "HelpDesk_Complaint_Close",  status);


 }


   public void Tracelog(string start, string end, string taskname, string status)
  {

      SqlConnection con3 = new SqlConnection("Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123");
      con3.Open();
      String s1 = "Insert into App_JUSCOTASKDETAILS (UPDATEDAT,UPDATEDBY,STARTTIME,ENDTIME,TASKNAME,STATUS) values('" + System.DateTime.Now + "','000001','" + start + "','" + end + "','" + taskname + "','" + status + "') ";
      SqlCommand cmd = new SqlCommand(s1, con3);
      cmd.ExecuteNonQuery();
      con3.Close();

  }
