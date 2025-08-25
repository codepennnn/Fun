protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
    {
        Dictionary<string, object> ddlParams = new Dictionary<string, object>();

        // Example values – replace with your actual logic
        ddlParams.Add("@VendorCode", "V123");  
        ddlParams.Add("@MonthWage", 7);        // July
        ddlParams.Add("@YearWage", 2025);      // 2025

        GetDropdowns("Locations_jhar_report", ddlParams);
    }
}
