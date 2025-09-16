 public void Complaint_service()
 {
     


     SqlConnection con = new SqlConnection("Data Source=10.0.168.30;Initial Catalog=CLMSDB;User ID=fs;Password=jusco@123");

     con.Open();


     try
     {
         SqlDataAdapter da = new SqlDataAdapter("SELECT distinct m.vendor_code, m.vendor_name, m.COMPLAINT_NO, FROM  App_COMPLAINT_HELP_REGISTER AS m INNER JOIN  App_COMPLAINT_HELP_DETAILS  AS d ON  m.ID = d.MasterID WHERE  m.COMPLAINT_STATUS = 'S0002' GROUP BY m.vendor_code, m.vendor_name, m.COMPLAINT_NO, HAVING  DATEDIFF(DAY, MAX(d.UPDT_DATE), GETDATE()) > 3;", con);

         DataSet ds = new DataSet();
         da.Fill(ds);

       
             String data = "";
             int k = 1;
             foreach (DataRow row in ds.Rows)
             {
                 string id = row["ID"].ToString();
                 string vcode = row["vendor_code"].ToString();
                 string name = row["vendor_name"].ToString();
                 string COMPLAINT_NO = row["COMPLAINT_NO"].ToString();
              



                 data = data + "<tr>\n <td>" + k + "</td>\n"
                    + "    <td>" + vcode + "</td>\n"
                      + "    <td>" + name + "</td>\n"
                         + "    <td>" + COMPLAINT_NO + "</td>\n"
                         + "     </tr>\n";
                 k++;

                 SqlCommand cmd = new SqlCommand("Update set COMPLAINT_STATUS='S0004' from App_COMPLAINT_HELP_REGISTER where id = '" + id + "' ", con);
                 cmd.ExecuteNonQuery();

             }
             string vcode1 = ds.Tables[0].Rows[i]["v_code"].ToString();
             string vname = ds.Tables[0].Rows[i]["v_name"].ToString();
             string email_to = ds.Tables[0].Rows[i]["EMAIL"].ToString();
             string email_cc = " sidheshwar.vishwakarma@tatasteel.com";
             String subject = "Regarding Closed Complaint of M/s " + vname + "(Vendor Code " + vcode1 + " )";
             String msg1 = "Your below mentioned Complaint No. has been closed because of no reponse after three days. ";
             String msg2 = "";
             String msg = "<html><head>" + tablecss()
                               + "</head><body>"

                       + "<B><P>To<BR />M/s "
                       + vname
                       + "<BR />"
                       + vcode1
                       + " <BR /><BR /> Dear Sir / Madam"
                       + " <BR /> "
                       + " <BR /> "
                         + msg1
                                + " <BR /> <BR />"
                       + "<table width='900'>\n"
                       + "  <tr>\n"
                       + "     <th> Sl. No.</th>\n"
                       + "    <th>Name</th>\n"
                       + "    <th>Adhar Number</th>\n"
                       + "    <th>Safety Training Date</th>\n"
                       + "    <th>Safety Training Time</th>\n"
                       + "    <th>Safety Training Location</th>\n"
                       + "    "
                       + "  </tr>\n"

                       + data
                       + "</table>"
                       + " <BR /> "
                       + msg2
                       + "<BR />"
                       + "<BR />"
                       + "For any clarification you may contact Contractor Cell through Online Helpdesk only by using link: https://services.juscoltd.com/CLMS "
                       + " <BR />"
                       + " <BR />"
                       + " <BR /> Note: Please do not reply as it is a system generated mail. "
                       + " <BR /> "
                       + " <BR /> Thanks & Regards "
                       + " <BR /> "
                       + " <BR /> Contractors' Cell "
                       + " <BR /> TATA STEEL UISL</B></body></html>";


             string fromAddress = "automatic_mail@tatasteel.com";
             string Div_emailid = email_to;

             string msg_static = msg;


             if (Div_emailid != "")
             {
                 MailMessage mail_meesage = new MailMessage();
                 mail_meesage.From = new MailAddress(fromAddress);
                 mail_meesage.To.Add(Div_emailid);
                 mail_meesage.Subject = subject;
                 mail_meesage.CC.Add(email_cc);
                 mail_meesage.IsBodyHtml = true;

                 mail_meesage.Body = msg_static; //+ "<br>" + body1;

                 var smtp1 = new System.Net.Mail.SmtpClient();
                 {
                     smtp1.Host = "144.0.11.253";
                     smtp1.Port = 25;
                     smtp1.Timeout = 20000;
                 }
                 smtp1.Send(mail_meesage);
                 //Console.WriteLine("Mail Sent!!!");
             }




         }

         con.Close();
     }

     catch (Exception ex)
     {
        
     }

 }
