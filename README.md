protected void MonthWage_SelectedIndexChanged(object sender, EventArgs e)
{
    Dictionary<string, object> ddlParams = new Dictionary<string, object>();

    // ❌ Do NOT overwrite user's selected value
    // Use the dropdown's actual selected value
    string selectedMonth = Month.SelectedValue;
    string selectedYear = Year.Text;

    ddlParams.Add("vendorcode", Session["UserName"].ToString());
    ddlParams.Add("MonthWage", selectedMonth);
    ddlParams.Add("YearWage", selectedYear);

    // Get locations for selected month/year
    DataSet ds = GetDropdowns("Locations_jhar_report", ddlParams);

    LocationCode.DataSource = ds.Tables[0];
    LocationCode.DataTextField = "Location";       // what user sees
    LocationCode.DataValueField = "LocationCode";  // actual value
    LocationCode.DataBind();
}
