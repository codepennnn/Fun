protected void Month_SelectedIndexChanged(object sender, EventArgs e)
{
    Dictionary<string, object> ddlParams = new Dictionary<string, object>();

    string selectedMonth = Month.SelectedValue;
    string selectedYear = Year.Text;

    ddlParams.Add("vendorcode", Session["UserName"].ToString());
    ddlParams.Add("MonthWage", selectedMonth);
    ddlParams.Add("YearWage", selectedYear);

    DataSet ds = blobj.GetDropdowns("Locations_jhar_report", ddlParams);

    // clear old items
    LocationCode.Items.Clear();

    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
    {
        foreach (DataRow row in ds.Tables[0].Rows)
        {
            ListItem li = new ListItem(row["Location"].ToString(), row["LocationCode"].ToString());
            LocationCode.Items.Add(li);
        }
    }
    else
    {
        // Optional: add a default "No Locations" message
        LocationCode.Items.Add(new ListItem("-- No Locations Found --", ""));
    }
}
