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

        if (fu == null || !fu.HasFile)
            continue;  // skip if no file uploaded

        // ---------- GET ONLY THIS LICENSE DATA ----------
        DataSet ds = blobj.Get_Data_By_Lic(lic, vcode, period, year);
        if (ds == null || ds.Tables[0].Rows.Count == 0)
            continue;

        // build file list
        List<string> fileList = new List<string>();

        foreach (HttpPostedFile file in fu.PostedFiles)
        {
            string fileName =
                ds.Tables[0].Rows[0]["ID"].ToString() + "_" +
                Path.GetFileName(file.FileName);

            fileName = Regex.Replace(fileName,
                @"[,+*/?|><&=\#%:;@^$?:'()!~}{`]", "");

            file.SaveAs(@"D:/Cybersoft_Doc/CLMS/Attachments/" + fileName);
            fileList.Add(fileName);
        }

        string attachments = string.Join(",", fileList);

        // ---------- UPDATE ONLY THIS LIC'S RECORDS ----------
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            dr["Final_Attachment"] = attachments;
            dr["Status"] = "Pending With CC";
        }

        // ---------- SAVE THIS LIC IMMEDIATELY ----------
        blobj.SaveRecord(ref ds);
    }

    MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success,
        "Record saved successfully !");

    gvRefUpload.Visible = false;
    btnSave.Visible = false;
}
