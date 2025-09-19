 if (PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0].RowState == DataRowState.Added)
 {
     string vc = Session["username"].ToString();
     string LicNo = PageRecordDataSet.Tables["App_LabourLicenseSubmission"].Rows[0]["LicNo"].ToString();

     BL_LabourLicense blobj = new BL_LabourLicense();

     DataSet ds_USed = blobj.GetusedWorkOrder(vc);

     List<string> usedWoOrder = new List<string>();

     foreach (DataRow row in ds_USed.Tables[0].Rows)
     {
         string licno = row["LicNo"].ToString();
         string[] orders = row["WorkOrderNo"].ToString().Split(',');
         foreach (string order in orders)
         {
             string trimmed = order.Trim();


             if (licno != LicNo && !usedWoOrder.Contains(trimmed))
             {
                 usedWoOrder.Add(trimmed);
             }
         }
     }




     DataSet ds_Selected = blobj.GetSelectedWorkOrder(LicNo);
     List<string> selectedWorkOrders = new List<string>();

     foreach (DataRow row in ds_Selected.Tables[0].Rows)
     {
         string[] selected = row["WorkOrderNo"].ToString().Split(',');
         foreach (string sel in selected)
         {
             string trimmed = sel.Trim();
             if (!selectedWorkOrders.Contains(trimmed))
                 selectedWorkOrders.Add(trimmed);
         }
     }






     DataSet ds_All = blobj.GetAllWorkOrder(vc);


     for (int i = ds_All.Tables[0].Rows.Count - 1; i >= 0; i--)
     {
         string wono = ds_All.Tables[0].Rows[i]["WoNo"].ToString().Trim();
         if (usedWoOrder.Contains(wono) && !selectedWorkOrders.Contains(wono))
         {
             ds_All.Tables[0].Rows.RemoveAt(i);
         }
     }
     ds_All.Tables[0].AcceptChanges();

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
