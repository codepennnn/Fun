protected void btnSave_Click(object sender, EventArgs e)
{
    string getFileName = "";
    List<string> FileList = new List<string>();

    FileUpload fu = (FileUpload)Upload_Half_Yearly_Record.Rows[0].FindControl("Final_Attachment");

    if (fu.HasFile)
    {
        foreach (HttpPostedFile htfiles in fu.PostedFiles)
        {
            getFileName = PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows[0]["ID"].ToString() 
                          + "_" + Path.GetFileName(htfiles.FileName);

            getFileName = Regex.Replace(getFileName,
                @"[,+*/?|><&=\#%:;@^$?:'()!~}{`]", "");

            htfiles.SaveAs(@"D:/Cybersoft_Doc/CLMS/Attachments/" + getFileName);

            FileList.Add(getFileName);
        }

        string attachments = string.Join(",", FileList);

        // ❗ Apply to all rows for SAME RefNo
        foreach (DataRow r in PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows)
        {
            r["Final_Attachment"] = attachments;
        }
    }

    bool result = Save();

    if (result)
    {
        PageRecordDataSet.Clear();
        Upload_Half_Yearly_Record.BindData();
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
    }
    else
    {
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error While Saving !");
    }
}
