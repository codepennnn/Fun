protected void btnSave_Click(object sender, EventArgs e)
{
    string vcode  = Session["UserName"].ToString();
    string period = SearchPeriod.SelectedValue;
    string year   = Year.SelectedValue;

    BL_Half_Yearly blobj = new BL_Half_Yearly();

    // 🔹 Clear ONCE before loop (not inside)
    PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();

    foreach (GridViewRow row in gvRefUpload.Rows)
    {
        string lic = row.Cells[0].Text.Trim();
        FileUpload fu = (FileUpload)row.FindControl("Final_Attachment");

        if (fu == null || !fu.HasFile)
            continue;

        // Get data for this licence
        DataSet ds = blobj.Get_Data_By_Lic(lic, vcode, period, year);
        if (ds == null || ds.Tables[0].Rows.Count == 0)
            continue;

        // 🔹 Add these rows into PageRecordDataSet (without clearing!)
        PageRecordDataSet.Merge(ds);

        // Save uploaded files for this licence
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

        // 🔹 Update only rows for this licence
        foreach (DataRow dr in PageRecordDataSet.Tables["App_Half_Yearly_Details"].Rows)
        {
            if (dr["LabourLicNo"].ToString() == lic)   // or correct column name
            {
                dr["Final_Attachment"] = attachments;
                dr["Status"]           = "Pending With CC";
            }
        }
    }

    bool result = Save();

    if (result)
    {
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
        gvRefUpload.Visible = false;
        gvRefUpload.DataSource = null;
        gvRefUpload.DataBind();
        btnSave.Visible = false;
    }
    else
    {
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, "Error While Saving !");
    }
}
