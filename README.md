public DataSet GetReport(string vcode, string period, int year)
{
    string strSQL = @"
        SELECT * FROM App_Half_Yearly_Details 
        WHERE Vcode = @Vcode 
        AND Year = @year 
        AND Period = @Period";

    Dictionary<string, object> objParam = new Dictionary<string, object>();
    
    objParam.Add("Vcode", vcode);
    objParam.Add("year", year);
    objParam.Add("Period", period);

    DataHelper dh = new DataHelper();
    DataSet ds = dh.GetDataset(strSQL, "App_Half_Yearly_Details", objParam);
    return ds;
}



protected void Search_Click(object sender, EventArgs e)
{
    BL_Half_Yearly blobj = new BL_Half_Yearly();
    DataSet ds = new DataSet();

    int year = Convert.ToInt32(Year.SelectedValue);
    string period = SearchPeriod.SelectedValue;
    string vcode = Session["UserName"].ToString();

    if (Year.SelectedIndex == 0 || SearchPeriod.SelectedIndex == 0)
    {
        ReportViewer1.Visible = false;
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, 
                     "Please select Month & Year !!!");
        return;
    }

    ds = blobj.GetReport(vcode, period, year);

    PageRecordDataSet.Clear();
    PageRecordDataSet.Merge(ds);

    ReportViewer1.Visible = true;
    ReportViewer1.LocalReport.DataSources.Clear();
    ReportViewer1.LocalReport.DataSources.Add(
        new ReportDataSource("DataSet1", ds.Tables[0])
    );

    ReportViewer1.LocalReport.ReportPath =
        Server.MapPath("~/App/Report/Half_Yearly_Report.rdlc");

    ReportViewer1.LocalReport.Refresh();
}
