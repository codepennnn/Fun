  protected void btnSave_Click(object sender, EventArgs e)
  {
      string vcode = Session["UserName"].ToString();
      BL_Half_Yearly blobj = new BL_Half_Yearly();

      foreach (GridViewRow row in gvRefUpload.Rows)
      {
          string refno = row.Cells[0].Text.Trim(); 
          FileUpload fu = (FileUpload)row.FindControl("Final_Attachment");

          if (fu != null && fu.HasFile)
          {
             
              DataSet ds = blobj.Get_Data_By_RefNo(refno, vcode);

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

                  file.SaveAs(@"C:/Cybersoft_Doc/CLMS/Attachments/" + fileName);

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
      }
      else
      {
          MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error While Saving !");
      }
  }
