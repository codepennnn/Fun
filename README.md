
    everything is fine just add in here both code validation that if status is approved or pending then show msg 
    
    
    protected void Search_Click(object sender, EventArgs e)
    {
        btnSave.Visible = true;
        BL_Half_Yearly blobj = new BL_Half_Yearly();
        DataSet ds = new DataSet();
        

       
            int year = Convert.ToInt32(Year.SelectedValue);
            string month = SearchPeriod.SelectedValue.ToString();
            string fromdt = "";
            string todt = "";
            string wageMonth = "";
             string displayPeriod = "";


        if (month == "Jan-June")
            {
               wageMonth = "1,2,3,4,5,6";
               fromdt = new DateTime(year, 1, 1).ToString("yyyy-MM-dd");
                todt = new DateTime(year, 6, 30).ToString("yyyy-MM-dd");

            displayPeriod = $"Jan{year.ToString().Substring(2)} - June{year.ToString().Substring(2)}";
        }
            else
            {
                wageMonth = "7,8,9,10,11,12";
                fromdt = new DateTime(year, 7, 1).ToString("yyyy-MM-dd");
                todt = new DateTime(year, 12, 31).ToString("yyyy-MM-dd");

            displayPeriod = $"July{year.ToString().Substring(2)} - Dec{year.ToString().Substring(2)}";
        }
            string vcode = Session["UserName"].ToString();
            string Period = SearchPeriod.SelectedValue;
            ds = blobj.GetData(vcode, fromdt, todt, Period, year, wageMonth);

        if (ds == null || ds.Tables[0].Rows.Count == 0)
        {
            PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();
            HalfYearly_Records.BindData();

            MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
                "No data found.");

            return;
        }





             PageRecordDataSet.Tables["App_Half_Yearly_Details"].Clear();
            PageRecordDataSet.Merge(ds);
            HalfYearly_Records.BindData();
    


        
    }



--------------------------------------------------------------------








         protected void Search_Click(object sender, EventArgs e)
     {
         string vcode = Session["UserName"].ToString();
         int year = Convert.ToInt32(Year.SelectedValue);
         string period = SearchPeriod.SelectedValue;

         BL_Half_Yearly blobj = new BL_Half_Yearly();
         DataSet ds = blobj.Get_LabourLicNo(vcode, period, year);

         if (ds == null || ds.Tables[0].Rows.Count == 0)
         {
             MyMsgBox.show(CLMS.Control.MyMsgBox.MessageType.Errors,
                 "No records found. Please submit Half Yearly first.");
             gvRefUpload.Visible = false;
             return;
         }







         gvRefUpload.Visible = true;
         gvRefUpload.DataSource = ds.Tables[0];
         gvRefUpload.DataBind();
         btnSave.Visible = true;
     }
