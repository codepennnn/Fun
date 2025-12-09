private void LoadReport()
{
    string lic = ddlLabourLicNo.SelectedValue;
    string vcode = Session["UserName"].ToString();
    string year = Year.SelectedValue;
    string period = SearchPeriod.SelectedValue;

    // ----- PERIOD DISPLAY -----
    string displayPeriod = (period == "Jan-June")
        ? $"Jan{year.Substring(2)} - June{year.Substring(2)}"
        : $"July{year.Substring(2)} - Dec{year.Substring(2)}";

    BL_Half_Yearly blobj = new BL_Half_Yearly();
    DataSet ds = blobj.Get_Report_Data(lic, vcode, year, period);

    if (ds == null || ds.Tables[0].Rows.Count == 0)
    {
        ReportViewer1.Visible = false;
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
            "No report data found for the selected Ref No.");
        return;
    }

    // ----- FETCH VENDOR NAME -----
    BL_Vendor_RFQ_Block_Unblock blobj2 = new BL_Vendor_RFQ_Block_Unblock();
    DataSet dsV = blobj2.GetVName(vcode);

    string vname = "";
    if (dsV != null && dsV.Tables[0].Rows.Count > 0)
    {
        vname = dsV.Tables[0].Rows[0]["V_NAME"].ToString();
    }

    // ----- PASS PARAMETERS TO RDLC -----
    ReportParameter[] rp = new ReportParameter[]
    {
        new ReportParameter("PeriodDisplay", displayPeriod),
        new ReportParameter("VendorName", vname)  // <--------- NEW PARAMETER
    };

    ReportViewer1.LocalReport.ReportPath = "App\\Report\\Half_Yearly_Report.rdlc";
    ReportViewer1.LocalReport.DataSources.Clear();
    ReportViewer1.LocalReport.SetParameters(rp);

    ReportDataSource rds = new ReportDataSource("DataSet1", ds.Tables[0]);
    ReportViewer1.LocalReport.DataSources.Add(rds);

    ReportViewer1.Visible = true;
    ReportViewer1.LocalReport.Refresh();
}
