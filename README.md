protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
    {
        ReportViewer3.Visible = false;

        // Prepare dropdown parameters
        Dictionary<string, object> ddlParams = new Dictionary<string, object>();
        ddlParams.Add("vendorcode", Session["UserName"].ToString()); 
        ddlParams.Add("Location", "abc");      // If required by query
        ddlParams.Add("LocationNM", "abc");    // If required by query

        // First dropdown (if it needs only vendorcode)
        GetDropdowns("VendorList", ddlParams);

        // Set default month/year
        Month.SelectedValue = DateTime.Now.Month.ToString();
        Year.Text = DateTime.Now.Year.ToString();   // FIXED (year instead of month)

        // Add month/year params
        ddlParams.Add("MonthWage", Month.SelectedValue);
        ddlParams.Add("YearWage", Year.Text);

        // Other dropdowns
        GetDropdowns("Locations_jhar_report", ddlParams);
        GetDropdowns("SiteByLocation", ddlParams);
        GetDropdowns("WorkOrderNoAll_jhar_report", ddlParams);

        // Bind
        VendorCode.DataBind();
        LocationCode.DataBind();
        SiteID.DataBind();
        WorkOrderNo.DataBind();

        // Select default vendor
        VendorCode.SelectedValue = Session["UserName"].ToString();

        // Load Vendor Name
        DataSet ds = blobj.GetVendorName(VendorCode.SelectedValue);
        if (ds.Tables[0].Rows.Count > 0)
            VendorName.Text = ds.Tables[0].Rows[0]["VendorName"].ToString();
        else
            VendorName.Text = "";
    }
}
