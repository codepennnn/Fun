  public DataSet GetWorkOrder(string vc)
  {
      string strSQL = "select LicNo,WorkOrderNo from App_LabourLicenseSubmission where WorkOrderNo is not null";
      Dictionary<string, object> objParam = new Dictionary<string, object>();
      DataHelper dh = new DataHelper();
      DataSet ds = dh.GetDataset(strSQL, "App_LabourLicenseSubmission", objParam);
      return ds;
  }

 
 protected void Labourdetails_RowDataBound(object sender, GridViewRowEventArgs e)
 {
     if (Labourdetails.Rows.Count > 0)
     {

         if (PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0].RowState == DataRowState.Added)
         {

             string vc = Session["username"].ToString();
            

             BL_LabourLicense blobj = new BL_LabourLicense();

             DataSet ds_USed = blobj.GetWorkOrder(vc);



              CheckBoxList chklist = (CheckBoxList)Labourdetails.Rows[0].FindControl("WorkOrderNo");
             chklist.Items.Clear();
             chklist.DataSource = ds_All.Tables[0];
             chklist.DataTextField = "WorkOrderNo";
             chklist.DataValueField = "WoNo";
             chklist.DataBind();

             foreach (ListItem item in chklist.Items)
             {
                 if (selectedWorkOrders.Contains(item.Value))
                 {
                     item.Selected = true;
                 }
             }

         }
