if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"]
                     .Rows[0]["Status"].ToString() == "Return")
{
    List<string> fileList = new List<string>();

    // Correct: use the control outside the grid
    FileUpload fu = (FileUpload)div_ReturnAttachment.FindControl("ReturnAttachment");
    // or simply: FileUpload fu = ReturnAttachment;   (since it’s on the page)

    if (fu != null && fu.HasFiles)   // HasFiles for multiple uploads
    {
        foreach (HttpPostedFile file in fu.PostedFiles)
        {
            string id = PageRecordDataSet.Tables["App_WorkOrder_Exemption"]
                        .Rows[0]["ID"].ToString();
            string safeName = id + "_" + Path.GetFileName(file.FileName);

            // remove unwanted chars
            safeName = Regex.Replace(safeName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");

            string savePath = Path.Combine(
                @"D:\Cybersoft_Doc\CLMS\Attachments", safeName);

            file.SaveAs(savePath);
            fileList.Add(safeName);
        }

        PageRecordDataSet.Tables["App_WorkOrder_Exemption"]
                         .Rows[0]["ReturnAttachment"] = string.Join(",", fileList);
    }
}
{



             





               string subject = "";
               string msg = "";
               string to = "";

               DataSet ds = new DataSet();
               DataSet ds1 = new DataSet();
               BL_Send_Mail blobj = new BL_Send_Mail();
               ds = blobj.Get_Vendor_mail(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["VendorCode"].ToString());
               if (ds != null && ds.Tables[0].Rows.Count > 0)
               {
                   to = ds.Tables["aspnet_Membership"].Rows[0]["Email"].ToString();
               }
               string v_name = "";

               ds1 = blobj.Get_Vendor_name(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["VendorCode"].ToString());
               if (ds1 != null && ds1.Tables[0].Rows.Count > 0)
               {
                   v_name = ds1.Tables["App_vendor_reg"].Rows[0]["v_name"].ToString();
               }

               string v_code = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["VendorCode"].ToString();
               string remarks = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"].ToString();
               string wo_no = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["WorkOrderNo"].ToString();



               subject = "Application of Work Order Exemption of work order no " + wo_no + " has been approved of M/S " + v_name + "(Vendor Code – " + v_code + ") ";
               msg = "<html><body><P><B>"
                   + "To<BR /> "
                   + v_name
                   + "<BR />" + v_code
                   + "<BR />Dear Sir/Madam"
                   + "<BR /> "

                   + "Application against the Work Order Exemption of Work Order No " + wo_no + " has been retuned because of (" + remarks + "). Kindly resubmit the application along with correct data/ details/ attachments as per remarks given by Contractors’ Cell. "

                   + "<BR />You may visit and open link  :-  https://services.tsuisl.co.in/CLMS/Account/Login.aspx  or you may approach Contractors’ Cell at 0657-6652063/ 6652064 for clarifications, if any. "
                   + " <BR /> " + " <BR /> Thanks & Regards " + " <BR /> "
                   + " <BR /> TATA STEEL UISL Contractor's Cell </B></P></html></body>"
                   + " <BR /> "
                   + " <BR /> Note: Please do not reply as it is a system generated mail. ";




               BL_Send_Mail blobj1 = new BL_Send_Mail();
               blobj1.sendmail_approve(to, "", subject, msg, "");


           }

           PageRecordDataSet.Clear();
           WorkOrder_Exemption_Record.BindData();
           Action_Record.BindData();
           GetRecords(GetFilterCondition(), WorkOrder_Exemption_Records.PageSize, 10, "");
           WorkOrder_Exemption_Records.BindData();

           MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
           btnSave.Visible = false;
         
       }
   }
