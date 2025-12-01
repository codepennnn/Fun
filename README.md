  protected void btnSave_Click(object sender, EventArgs e)
  {


      



      string getFileName = "";
      List<string> FileList = new List<string>();
      if (((FileUpload)Upload_Half_Yearly_Record.Rows[0].FindControl("Final_Attachment")).HasFile)
      {
          foreach (HttpPostedFile htfiles in ((FileUpload)Upload_Half_Yearly_Record.Rows[0].FindControl("Final_Attachment")).PostedFiles)
          {
              getFileName = PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["ID"].ToString() + "_" + Path.GetFileName(htfiles.FileName);
              getFileName = Regex.Replace(getFileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");
              htfiles.SaveAs((@"D:/Cybersoft_Doc/CLMS/Attachments/" + getFileName));
              FileList.Add(getFileName);
          }
          PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["Final_Attachment"] = string.Join(",", FileList);
      }





      bool result = Save();

      if (result)
      {
                        
          PageRecordDataSet.Clear();
          Upload_Half_Yearly_Record.BindData();
         
          MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
          //btnSave.Visible = false;
          //DivInputFields.Visible = false;

      }
      else
      {
          MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error While Saving !");
      }
  }
