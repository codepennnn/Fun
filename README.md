protected void Month_SelectedIndexChanged(object sender, EventArgs e)
{
    Dictionary<string, object> ddlParams = new Dictionary<string, object>();

    string selectedMonth = Month.SelectedValue;
    string selectedYear = Year.Text;

    ddlParams.Add("vendorcode", Session["UserName"].ToString());
    ddlParams.Add("MonthWage", selectedMonth);
    ddlParams.Add("YearWage", selectedYear);

    // Get dataset again from BL
    dsDDL = blobj.GetDropdowns("Locations_jhar_report", ddlParams);

    // assign dataset to PageDDLDataset
    PageDDLDataset = dsDDL;

    // rebind the dropdown
    LocationCode.DataBind();

    // optional: add a default item at top
    LocationCode.Items.Insert(0, new ListItem("-- Select Location --", ""));
}
