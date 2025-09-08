      protected void Approvalsave_Click(object sender, EventArgs e)
        {
            String s = "";
            LabourLicensevendordetails.UnbindData();

            PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["LCreartedBy"] = Session["username"].ToString();
            PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["LCreatedOn"] =  System.DateTime.Now.ToString();

            if (PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Approval"].ToString() == "Approved")
            {
                PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["ApprovedOnce"] = "Yes";
            }



            //GK
            if (((TextBox)LabourLicensevendordetails.Rows[0].FindControl("txtnewRemarks")).Text == "")
            {
                PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Remarks"] = "(" + PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Remarks"] + " - " + System.DateTime.Now.ToString("dd/MM/yyyy") + ")";
            }
            else
                PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Remarks"] += ",(" + ((TextBox)LabourLicensevendordetails.Rows[0].FindControl("txtnewRemarks")).Text + " - " + System.DateTime.Now.ToString("dd/MM/yyyy") + ")";
            //GK
            bool result = Save();
            if (result)
            {

                if (PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Approval"].ToString() == "Approved")
                {
                    string subject = "";
                    string msg = "";
                    string to = "";

                    DataSet ds = new DataSet();
                    BL_Send_Mail blobj = new BL_Send_Mail();
                    ds = blobj.Get_Vendor_mail(PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Vcode"].ToString());
                    if (ds != null && ds.Tables[0].Rows.Count > 0)
                    {
                        to = ds.Tables["aspnet_Membership"].Rows[0]["Email"].ToString();
                    }
                    string v_name = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Vname"].ToString();
                    string v_code = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Vcode"].ToString();
                    string remarks = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Remarks"].ToString();
                    string lic_no = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["LicNo"].ToString();
                    


                    subject = "Application of labour License bearing no "+ lic_no + " has been approved of M/S "+ v_name + " (Vendor Code – "+ v_code + ")";
                    msg = "<html><body><P><B>"
                        + "To<BR /> "
                        + v_name
                        + "<BR />" + v_code
                        + "<BR /><BR />Dear Sir/Madam"
                        + "<BR /> "

                        + "Based on submission of your documents and details, your application against the labour License no "+ lic_no + " has been approved by Contractor Cell with remarks ("+remarks+")."
                        + " <BR />Point is to be noted and recorded that approval is based on your details/documents which is submitted to us. "

                        + "<BR />You may visit and open link  :-  https://services.tsuisl.co.in/CLMS/Account/Login.aspx  or you may approach Contractors’ Cell at 0657-6652063/ 6652064 for clarifications, if any. "
                        + " <BR /> " + " <BR /> Thanks & Regards " + " <BR /> "
                        + " <BR /> TATA STEEL UISL Contractor's Cell </B></P></html></body>"
                        + " <BR /> "
                        + " <BR /> Note: Please do not reply as it is a system generated mail. ";




                    BL_Send_Mail blobj1 = new BL_Send_Mail();
                    blobj1.sendmail_approve(to, "", subject, msg, "");















                }
                else if (PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Approval"].ToString() == "Rejected")
                {

                    string subject = "";
                    string msg = "";
                    string to = "";

                    DataSet ds = new DataSet();
                    BL_Send_Mail blobj = new BL_Send_Mail();
                    ds = blobj.Get_Vendor_mail(PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Vcode"].ToString());
                    if (ds != null && ds.Tables[0].Rows.Count > 0)
                    {
                        to = ds.Tables["aspnet_Membership"].Rows[0]["Email"].ToString();
                    }
                    string v_name = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Vname"].ToString();
                    string v_code = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Vcode"].ToString();
                    string remarks = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Remarks"].ToString();
                    string lic_no = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["LicNo"].ToString();



                    subject = "Application of labour License has been returned of M/S "+ v_name + "(Vendor Code – "+v_code+")";
                    msg = "<html><body><P><B>"
                        + "To<BR /> "
                        + v_name
                        + "<BR />" + v_code
                        + "<BR />Dear Sir/Madam"
                        + "<BR /> "

                        + "Application against the labour License bearing no "+ lic_no + "  has been returned because of ("+remarks+"). Kindly resubmit the application along with correct data/ details/ attachments as per remarks given by Contractors’ Cell. "
                        
                        + "<BR />You may visit and open link  :-  https://services.tsuisl.co.in/CLMS/Account/Login.aspx  or you may approach Contractors’ Cell at 0657-6652063/ 6652064 for clarifications, if any. "
                        + " <BR /> " + " <BR /> Thanks & Regards " + " <BR /> "
                        + " <BR /> TATA STEEL UISL Contractor's Cell </B></P></html></body>"
                        + " <BR /> "
                        + " <BR /> Note: Please do not reply as it is a system generated mail. ";




                    BL_Send_Mail blobj1 = new BL_Send_Mail();
                    blobj1.sendmail_approve(to, "", subject, msg, "");


                }




                PageRecordDataSet.Clear();
                LabourLicensevendordetails.BindData();
                GetRecords(GetFilterCondition(), LabourLicApproval.PageSize, 10, "");
                LabourLicApproval.BindData();
                MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
            }
            else
            {
                MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record Not saved !");
            }

        }
i want here update query in which in  where clause it took licno from my pagerecord dataset and update it and then check one conditon in my table App_labourlicesnessubmission if wo_no todate and licno todate which lower then again update this value in my coulmn c3closer
