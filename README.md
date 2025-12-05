protected void Search_Click(object sender, EventArgs e)
{
    string vcode = Session["UserName"].ToString();
    int year = Convert.ToInt32(Year.SelectedValue);
    string period = SearchPeriod.SelectedValue;

    BL_Half_Yearly blobj = new BL_Half_Yearly();
    DataSet ds = blobj.Get_LabourLicNo(vcode, period, year);

    if (ds == null || ds.Tables[0].Rows.Count == 0)
    {
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
            "No records found. Please submit Half Yearly first.");
        gvRefUpload.Visible = false;
        return;
    }

    // 💥 Check status from Half Yearly table
    DataSet dsStatus = blobj.Get_Status_By_Period(vcode, period, year);

    if (dsStatus != null && dsStatus.Tables[0].Rows.Count > 0)
    {
        string status = dsStatus.Tables[0].Rows[0]["Status"].ToString();

        if (status == "Approved" || status == "Pending With CC")
        {
            MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
                "Upload is not allowed. Status is already " + status + ".");
            gvRefUpload.Visible = false;
            btnSave.Visible = false;
            return;
        }
    }

    gvRefUpload.DataSource = ds.Tables[0];
    gvRefUpload.DataBind();
    gvRefUpload.Visible = true;
    btnSave.Visible = true;
}


function validateCompliance() {

    let allUploads = document.querySelectorAll(".compact-grid input[type='file']");
    let allowedExtensions = /\.(pdf|xls|xlsx)$/i;

    for (let i = 0; i < allUploads.length; i++) {

        let fileInput = allUploads[i];

        // Must be selected
        if (fileInput.files.length === 0) {
            alert("Please upload attachment for all records.");
            return false;
        }

        // Validate file extensions
        for (let f = 0; f < fileInput.files.length; f++) {
            if (!allowedExtensions.test(fileInput.files[f].name)) {
                alert("Only PDF and Excel files are allowed.");
                return false;
            }
        }
    }

    return true;
}


