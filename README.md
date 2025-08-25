  protected void Page_Load(object sender, EventArgs e)
  {
      if (!IsPostBack)
      {
          //ReportViewer1.Visible = false;
          // ReportViewer1.Style.Add("display", "none");
          ReportViewer3.Visible = false;

          // All DropDown
          Dictionary<string, object> ddlParams = new Dictionary<string, object>();
          ddlParams.Add("VCode", Session["UserName"].ToString()); 
          ddlParams.Add("V_CODE", Session["UserName"].ToString()); 
          ddlParams.Add("Location", "abc");
          ddlParams.Add("LocationNM", "abc");
          ddlParams.Add("vendorcode", Session["UserName"].ToString());

          GetDropdowns("VendorList");


   
          Month.SelectedValue = DateTime.Now.Month.ToString();
          Year.Text = DateTime.Now.Month.ToString();


          ddlParams.Add("MonthWage", Month.SelectedValue.ToString());
          ddlParams.Add("YearWage", Year.Text.ToString());

          GetDropdowns("Locations_jhar_report", ddlParams);




          GetDropdowns("SiteByLocation", ddlParams);
          GetDropdowns("WorkOrderNoAll_jhar_report", ddlParams);

          VendorCode.DataBind();
          LocationCode.DataBind();
          SiteID.DataBind();
          WorkOrderNo.DataBind();

          Year.Text = DateTime.Now.Year.ToString();
          Month.SelectedValue = DateTime.Now.Month.ToString();

          VendorCode.SelectedValue = Session["UserName"].ToString();
          //VendorName.Text = VendorCode.SelectedItem.Text.ToString();
          DataSet ds = new DataSet();
          ds = blobj.GetVendorName(VendorCode.SelectedValue.ToString());

          if (ds.Tables[0].Rows.Count > 0)
              VendorName.Text = ds.Tables[0].Rows[0]["VendorName"].ToString();
          else
              VendorName.Text = "";


      }
