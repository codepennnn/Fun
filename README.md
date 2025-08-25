  protected void Page_Load(object sender, EventArgs e)
  {
 if (!IsPostBack)
{
 GetDropdowns("Locations_jhar_report", ddlParams);
 }

 }

  DDLQuery.Add("Locations_jhar_report", "select '' as LocationCode ,'' as Location, 0 as ord union select  distinct LocationCode, (select LocationNM From App_LocationMaster lm where lm.LocationCode = w.LocationCode) as Location, 1 as ord from App_WagesDetailsJharkhand w where vendorcode = @vendorcode and MonthWage = @MonthWage and YearWage = @YearWage order by ord ");



  and BL
      public DataSet GetDropdowns(string DropdownNames, Dictionary<string, object> ddlParam)
    {
        return DropDownHelper.GetDropDownsDataset(DropdownNames, ddlParam, false);
    }
