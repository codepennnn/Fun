protected void Search_Click(object sender, EventArgs e)
{
    if (Session["UserName"] == null)
        return;

    string vcode = Session["UserName"].ToString();
    int year = Convert.ToInt32(Year.SelectedValue);
    string period = SearchPeriod.SelectedValue;

    BL_Half_Yearly blobj = new BL_Half_Yearly();

    // 1️⃣ LOAD ALL REFNO AVAILABLE FOR THIS VENDOR+YEAR+PERIOD
    DataSet dsRef = blobj.Get_Ref_NoDDL(vcode, period, year);

    // 2️⃣ If no record exists → STOP and show message
    if (dsRef == null || dsRef.Tables[0].Rows.Count == 0)
    {
        // hide upload section
        Upload_Half_Yearly_Record.Visible = false;

        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
            "No record found! Please submit Half Yearly return first, then upload attachment.");

        return;
    }

    // 3️⃣ Show dropdown
    divLL.Style["display"] = "flex";
    SearchLLBtn.Visible = true;

    BindRefNoDropdown(dsRef);

    // 4️⃣ Get latest RefNo from dataset
    string latestRefNo = dsRef.Tables[0].Rows[0]["RefNo"].ToString();

    // 5️⃣ FETCH STATUS OF THAT REFNO
    DataSet dsStatus = blobj.Get_Data_By_RefNo(latestRefNo, vcode);

    if (dsStatus.Tables[0].Rows.Count > 0)
    {
        string status = dsStatus.Tables[0].Rows[0]["Status"].ToString();

        // 6️⃣ Disable Search button based on status
        if (status == "Approved" || status == "Pending With CC")
        {
            SearchLLBtn.Enabled = false;

            MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
                "This record is already " + status + ". You cannot upload again.");
        }
        else
        {
            SearchLLBtn.Enabled = true;
        }
    }
}
