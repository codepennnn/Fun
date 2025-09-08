protected void Approvalsave_Click(object sender, EventArgs e)
{
    try
    {
        String s = "";
        LabourLicensevendordetails.UnbindData();

        PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["LCreartedBy"] = Session["username"].ToString();
        PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["LCreatedOn"] = System.DateTime.Now.ToString();

        if (PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Approval"].ToString() == "Approved")
        {
            PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["ApprovedOnce"] = "Yes";
        }

        //Remarks handling
        if (((TextBox)LabourLicensevendordetails.Rows[0].FindControl("txtnewRemarks")).Text == "")
        {
            PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Remarks"] =
                "(" + PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Remarks"] + " - " + System.DateTime.Now.ToString("dd/MM/yyyy") + ")";
        }
        else
        {
            PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Remarks"] +=
                ",(" + ((TextBox)LabourLicensevendordetails.Rows[0].FindControl("txtnewRemarks")).Text + " - " + System.DateTime.Now.ToString("dd/MM/yyyy") + ")";
        }

        bool result = Save();
        if (result)
        {
            // ✅ After save, update validity
            string licNo = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["LicNo"].ToString();
            DateTime validityToDate = Convert.ToDateTime(PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["ValidityToDate"]);

            UpdateLicenseValidity(licNo, validityToDate);

            // --- existing mail code ---
            if (PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Approval"].ToString() == "Approved")
            {
                // send mail logic ...
            }
            else if (PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["Approval"].ToString() == "Rejected")
            {
                // send mail logic ...
            }

            PageRecordDataSet.Clear();
            LabourLicensevendordetails.BindData();
            GetRecords(GetFilterCondition(), LabourLicApproval.PageSize, 10, "");
            LabourLicApproval.BindData();
            MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record saved successfully !");
        }
        else
        {
            MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Success, "Record Not saved !");
        }
    }
    catch (Exception ex)
    {
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Error, "Error: " + ex.Message);
    }
}




private void UpdateLicenseValidity(string licNo, DateTime licNoToDate)
{
    string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

    using (SqlConnection conn = new SqlConnection(connStr))
    {
        conn.Open();

        // Step 1: Update validity to all records with given licNo
        string updateValidityQuery = @"
            UPDATE App_LabourLicenseSubmission
            SET LicNoToDate = @LicNoToDate
            WHERE LicNo = @LicNo";

        using (SqlCommand cmd = new SqlCommand(updateValidityQuery, conn))
        {
            cmd.Parameters.AddWithValue("@LicNoToDate", licNoToDate);
            cmd.Parameters.AddWithValue("@LicNo", licNo);
            cmd.ExecuteNonQuery();
        }

        // Step 2: Check condition and update C3Closer
        string updateC3CloserQuery = @"
            UPDATE App_LabourLicenseSubmission
            SET C3Closer = 'Yes'
            WHERE LicNo = @LicNo
              AND WO_No_ToDate < LicNoToDate";

        using (SqlCommand cmd = new SqlCommand(updateC3CloserQuery, conn))
        {
            cmd.Parameters.AddWithValue("@LicNo", licNo);
            cmd.ExecuteNonQuery();
        }
    }
}

