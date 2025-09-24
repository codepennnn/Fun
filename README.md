if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"]
                     .Rows[0]["Status"].ToString() == "Return")
{
    List<string> fileList = new List<string>();

    // Directly use the page-level control
    if (ReturnAttachment.HasFiles)       // AllowMultiple="true"
    {
        foreach (HttpPostedFile file in ReturnAttachment.PostedFiles)
        {
            string id = PageRecordDataSet.Tables["App_WorkOrder_Exemption"]
                        .Rows[0]["ID"].ToString();
            string safeName = id + "_" + Path.GetFileName(file.FileName);

            // strip unwanted characters
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
