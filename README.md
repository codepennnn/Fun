// =====================
// Attachment Handling
// =====================

List<string> FileList = new List<string>();

FileUpload fu = (FileUpload)Action_Record.Rows[0].FindControl("Attachment");

if (fu != null && fu.HasFile)
{
    foreach (HttpPostedFile htfiles in fu.PostedFiles)
    {
        string fileName = Guid.NewGuid() + "_" + Path.GetFileName(htfiles.FileName);
        fileName = Regex.Replace(fileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");

        htfiles.SaveAs(@"D:/Cybersoft_Doc/CLMS/Attachments/" + fileName);

        FileList.Add(fileName);
    }
}

// Save attachments into Exemption Table (always update)
PageRecordDataSet.Tables["App_WorkOrder_Exemption"]
    .Rows[0]["ReturnAttachment"] = string.Join(",", FileList);

// =====================
// Insert INTO Remarks Table (ALWAYS ADD NEW RECORD)
// =====================

DataTable remarksTable = PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"];
Guid masterID =
    Guid.Parse(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString());

DataRow newRow = remarksTable.NewRow();

newRow["ID"] = Guid.NewGuid();                        // NEW GUID each time
newRow["MASTER_ID"] = masterID;                       // FK
newRow["Remarks"] = NewRemarks.Text;                  // remark text
newRow["CreatedOn"] = DateTime.Now;                   // timestamp
newRow["CreatedBy"] = Session["UserName"].ToString(); // user
newRow["Attachment"] = string.Join(",", FileList);    // same attachments

remarksTable.Rows.Add(newRow);
