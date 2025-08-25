
        protected void Month_SelectedIndexChanged(object sender, EventArgs e)
        {
            Dictionary<string, object> ddlParams = new Dictionary<string, object>();

      
            string selectedMonth = Month.SelectedValue;
            string selectedYear = Year.Text;

            ddlParams.Add("vendorcode", Session["UserName"].ToString());
            ddlParams.Add("MonthWage", selectedMonth);
            ddlParams.Add("YearWage", selectedYear);
                    
             DataSet ds = new DataSet();
            ds = blobj.GetDropdowns("Locations_jhar_report", ddlParams);


            if (ds.Tables[0].Rows.Count > 0)

                LocationCode.DataTextField = "Location";
               LocationCode.DataValueField = "LocationCode";
       

            else
                LocationCode.Text = "";



            LocationCode.DataBind();
        }
