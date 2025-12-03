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

    // Show dropdown for RefNo selection
    divLL.Style["display"] = "flex";
    SearchLLBtn.Visible = true;

    BindRefNoDropdown(dsRef);

    // 2️⃣ No RefNo available → allow normal search
    if (dsRef.Tables[0].Rows.Count == 0)
    {
        SearchLLBtn.Enabled = true;
        return;
    }

    // 3️⃣ TAKE THE LATEST REFNO
    string latestRefNo = dsRef.Tables[0].Rows[0]["RefNo"].ToString();

    // 4️⃣ GET STATUS OF THIS REFNO
    DataSet dsStatus = blobj.Get_Data_By_RefNo(latestRefNo, vcode);

    if (dsStatus.Tables[0].Rows.Count > 0)
    {
        string status = dsStatus.Tables[0].Rows[0]["Status"].ToString();

        // 5️⃣ CHECK STATUS AND ENABLE/DISABLE SEARCH BUTTON
        if (status == "Approved" || status == "Pending With CC")
        {
            SearchLLBtn.Enabled = false;

            MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
                "This record is already " + status + ". You cannot upload again.");
        }
        else if (status == "Return")
        {
            SearchLLBtn.Enabled = true;
        }
        else
        {
            // Unknown status → allow but warn
            SearchLLBtn.Enabled = true;
        }
    }
}
