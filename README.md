  private void LoadReport()
  {
      string lic = ddlLabourLicNo.SelectedValue;
      string vcode = Session["UserName"].ToString();
      string year = Year.SelectedValue;
      string period = SearchPeriod.SelectedValue;



      string displayPeriod = "";

      if (period == "Jan-June")
      {
          displayPeriod = $"Jan{year.ToString().Substring(2)} - June{year.ToString().Substring(2)}";
      }
      else
      {
          displayPeriod = $"July{year.ToString().Substring(2)} - Dec{year.ToString().Substring(2)}";
      }


      BL_Half_Yearly blobj = new BL_Half_Yearly();
      DataSet ds = blobj.Get_Report_Data( lic,vcode,year,period);

      // fetch vname
      BL_Vendor_RFQ_Block_Unblock blobj2 = new BL_Vendor_RFQ_Block_Unblock();
      blobj2.GetVName(vcode);


      if (ds == null || ds.Tables[0].Rows.Count == 0)
      {
          ReportViewer1.Visible = false;
          MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
              "No report data found for the selected RefNo.");
          return;
      }



      ReportParameter[] rp = new ReportParameter[]
      {
          new ReportParameter("PeriodDisplay", displayPeriod)
      };

      ReportViewer1.LocalReport.SetParameters(rp);
      ReportViewer1.LocalReport.Refresh();


      ReportViewer1.LocalReport.ReportPath = "App\\Report\\Half_Yearly_Report.rdlc";
      ReportViewer1.LocalReport.DataSources.Clear();

      ReportDataSource rds = new ReportDataSource("DataSet1", ds.Tables[0]);
      ReportViewer1.LocalReport.DataSources.Add(rds);

      ReportViewer1.Visible = true;
      ReportViewer1.LocalReport.Refresh();
  }
