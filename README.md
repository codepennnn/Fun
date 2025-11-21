// === Save Return Attachments to Remarks Table ===

List<string> remarkFiles = new List<string>();
FileUpload fu = (FileUpload)Action_Record.Rows[0].FindControl("ReturnAttachment");

if (fu != null && fu.HasFile)
{
    foreach (HttpPostedFile file in fu.PostedFiles)
    {
        // physical file name
        string fileName = Guid.NewGuid().ToString() + "_" + Path.GetFileName(file.FileName);
        fileName = Regex.Replace(fileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");

        // save to folder
        file.SaveAs(@"D:/Cybersoft_Doc/CLMS/Attachments/" + fileName);

        remarkFiles.Add(fileName);
    }
}

// === Handle Remarks Table (Insert/Update) ===

DataTable remarksTable = PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"];
Guid masterID = Guid.Parse(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString());

string remarksText = NewRemarks.Text;
string attachmentList = string.Join(",", remarkFiles);

// Insert new row if empty
if (remarksTable.Rows.Count == 0)
{
    DataRow newRow = remarksTable.NewRow();

    newRow["ID"] = Guid.NewGuid();   // required
    newRow["MASTER_ID"] = masterID;
    newRow["Remarks"] = remarksText;
    newRow["CreatedOn"] = DateTime.Now;
    newRow["CreatedBy"] = Session["UserName"].ToString();
    newRow["Attachment"] = attachmentList;    // ← SAVE HERE

    remarksTable.Rows.Add(newRow);
}
else
{
    // Update existing row
    DataRow row = remarksTable.Rows[0];
    row["Remarks"] = remarksText;
    row["CreatedOn"] = DateTime.Now;
    row["CreatedBy"] = Session["UserName"].ToString();

    if (!string.IsNullOrEmpty(attachmentList))
        row["Attachment"] = attachmentList;   // update attachment
}
