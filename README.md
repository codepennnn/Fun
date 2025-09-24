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
