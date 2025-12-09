 protected void btnSave_Click(object sender, EventArgs e)
 {
     string vcode = Session["UserName"].ToString();
     string period = SearchPeriod.SelectedValue;
     string year = Year.SelectedValue;
     BL_Half_Yearly blobj = new BL_Half_Yearly();

     foreach (GridViewRow row in gvRefUpload.Rows)
     {
         string lic = row.Cells[0].Text.Trim(); 
         FileUpload fu = (FileUpload)row.FindControl("Final_Attachment");

         if (fu != null && fu.HasFile)
         {
            
             DataSet ds = blobj.Get_Data_By_Lic(lic, vcode, period, year);

             if (ds == null || ds.Tables[0].Rows.Count == 0)
                 continue;

             PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();
             PageRecordDataSet.Merge(ds);

        
             List<string> fileList = new List<string>();

             foreach (HttpPostedFile file in fu.PostedFiles)
             {
                 string fileName =
                     PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["ID"].ToString()
                     + "_" + Path.GetFileName(file.FileName);

                 fileName = Regex.Replace(fileName, @"[,+*/?|><&=\#%:;@^$?:'()!~}{`]", "");

                 file.SaveAs(@"D:/Cybersoft_Doc/CLMS/Attachments/" + fileName);

                 fileList.Add(fileName);
             }

             string attachments = string.Join(",", fileList);

          
             foreach (DataRow dr in PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows)
             {
                 dr["Final_Attachment"] = attachments;
                 dr["Status"] = "Pending With CC";
             }

            
         }
     }

     bool result = Save();

     if (result)
     {

        // btn.Visible = false;

         MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");


         gvRefUpload.Visible = false;
         gvRefUpload.DataBind();
         btnSave.Visible = false;
     }
     else
     {
         MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error While Saving !");
     }

when i have two records of licensee its saving only last attachment and satsus why first record attachment and status not saving
