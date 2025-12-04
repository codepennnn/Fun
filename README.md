<div class="form-group col-md-4">
    <label for="lblRefNo" class="m-0 mr-0 p-0 col-form-label-sm col-sm-2 font-weight-bold fs-6">Ref No:</label>
    <asp:DropDownList ID="ddlRefNo" runat="server" 
        CssClass="form-control form-control-sm col-sm-6" AutoPostBack="true"
        OnSelectedIndexChanged="ddlRefNo_SelectedIndexChanged">
        <asp:ListItem Value="">-- Select RefNo --</asp:ListItem>
    </asp:DropDownList>
</div>


protected void Search_Click(object sender, EventArgs e)
{
    string vcode = Session["UserName"].ToString();
    int year = Convert.ToInt32(Year.SelectedValue);
    string period = SearchPeriod.SelectedValue;

    BL_Half_Yearly blobj = new BL_Half_Yearly();
    DataSet dsRef = blobj.GetRefNoList(vcode, period, year);

    ddlRefNo.Items.Clear();
    ddlRefNo.Items.Add(new ListItem("-- Select RefNo --", ""));

    if (dsRef != null && dsRef.Tables[0].Rows.Count > 0)
    {
        ddlRefNo.DataSource = dsRef;
        ddlRefNo.DataTextField = "RefNo";
        ddlRefNo.DataValueField = "RefNo";
        ddlRefNo.DataBind();
    }
    else
    {
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
            "No RefNo found for the selected period.");
    }
}


protected void ddlRefNo_SelectedIndexChanged(object sender, EventArgs e)
{
    if (ddlRefNo.SelectedValue == "")
    {
        ReportViewer1.Visible = false;
        return;
    }

    LoadReport();
}

private void LoadReport()
{
    string vcode = Session["UserName"].ToString();
    string refNo = ddlRefNo.SelectedValue;

    BL_Half_Yearly blobj = new BL_Half_Yearly();
    DataSet ds = blobj.GetReportByRefNo(vcode, refNo);

    if (ds == null || ds.Tables[0].Rows.Count == 0)
    {
        ReportViewer1.Visible = false;
        MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors, 
            "No report data found for the selected RefNo.");
        return;
    }

    ReportViewer1.LocalReport.ReportPath = "App\\Report\\Half_Yearly_Report.rdlc";
    ReportViewer1.LocalReport.DataSources.Clear();

    ReportDataSource rds = new ReportDataSource("DataSet1", ds.Tables[0]);
    ReportViewer1.LocalReport.DataSources.Add(rds);

    ReportViewer1.Visible = true;
    ReportViewer1.LocalReport.Refresh();
}




public DataSet GetRefNoList(string vcode, string period, int year)
{
    string sql = @"SELECT DISTINCT RefNo
                   FROM App_Half_Yearly_Details
                   WHERE VCode=@VCode AND Period=@Period AND Year=@Year
                   ORDER BY RefNo";

    Dictionary<string, object> p = new Dictionary<string, object>();
    p.Add("VCode", vcode);
    p.Add("Period", period);
    p.Add("Year", year);

    DataHelper dh = new DataHelper();
    return dh.GetDataset(sql, "RefNoList", p);
}

public DataSet GetReportByRefNo(string vcode, string refNo)
{
    string sql = @"SELECT *
                   FROM App_Half_Yearly_Details
                   WHERE VCode=@VCode AND RefNo=@RefNo";

    Dictionary<string, object> p = new Dictionary<string, object>();
    p.Add("VCode", vcode);
    p.Add("RefNo", refNo);

    DataHelper dh = new DataHelper();
    return dh.GetDataset(sql, "ReportData", p);
}



