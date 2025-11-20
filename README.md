protected void btnSave_Click(object sender, EventArgs e)
{
    WorkOrder_Exemption_Record.UnbindData();
    Action_Record.UnbindData();

    // -----------------------------
    // HANDLE RETURN ATTACHMENTS
    // -----------------------------
    if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Return")
    {
        string getFileName = "";
        List<string> FileList = new List<string>();
        FileUpload fu = (FileUpload)Action_Record.Rows[0].FindControl("ReturnAttachment");

        if (fu.HasFile)
        {
            foreach (HttpPostedFile htfiles in fu.PostedFiles)
            {
                getFileName = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString()
                                + "_" + Path.GetFileName(htfiles.FileName);

                getFileName = Regex.Replace(getFileName, @"[,+*/?|><&=\#%:;@[^$?:'()!~}{`]", "");
                htfiles.SaveAs(@"D:/Cybersoft_Doc/CLMS/Attachments/" + getFileName);
                FileList.Add(getFileName);
            }

            PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ReturnAttachment"] =
                string.Join(",", FileList);
        }
    }

    // -----------------------------
    // INSERT NEW REMARK INTO REMARK TABLE
    // -----------------------------
    string Remarks_CC = ((TextBox)Action_Record.Rows[0].FindControl("NewRemarks")).Text;

    DataTable remarksTable = PageRecordDataSet.Tables["App_WorkOrder_exemption_remarks"];
    DataRow newRemarkRow = remarksTable.NewRow();

    newRemarkRow["CreatedOn"] = DateTime.Now;
    newRemarkRow["CreatedBy"] = Session["UserName"].ToString();
    newRemarkRow["Remarks"] = Remarks_CC;
    newRemarkRow["MASTER_ID"] = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"];

    // if storing return attachment for each remark (optional)
    // newRemarkRow["Attachment"] = string.Join(",", FileList);

    remarksTable.Rows.Add(newRemarkRow);

    // -----------------------------
    // ALSO UPDATE MAIN REMARKS COLUMN (IF REQUIRED)
    // -----------------------------
    PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"] =
        PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Remarks"].ToString()
        + "( CC --" + DateTime.Now.ToString("dd/MM/yyyy") + " -- " + Remarks_CC + ")|";

    // -----------------------------
    // APPROVE CASE
    // -----------------------------
    if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Approved")
    {
        PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Approved_On"] = DateTime.Now;
        PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Approved_By"] = Session["UserName"].ToString();
    }

    // -----------------------------
    // SAVE BOTH TABLES (MAIN + REMARK)
    // -----------------------------
    bool result = Save();

    if (result)
    {
        // -----------------------------
        // SEND MAIL (YOUR EXISTING CODE)
        // -----------------------------
        if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Approved")
        {
            Send_Approval_Mail();
        }
        else if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Return")
        {
            Send_Return_Mail();
        }

        // -----------------------------
        // CLEAR AND REBIND
        // -----------------------------
        PageRecordDataSet.Clear();
        WorkOrder_Exemption_Record.BindData();
        Action_Record.BindData();

        GetRecords(GetFilterCondition(), WorkOrder_Exemption_Records.PageSize, 10, "");
        WorkOrder_Exemption_Records.BindData();

        BindRemarksGrid();

        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
        btnSave.Visible = false;
    }
}
