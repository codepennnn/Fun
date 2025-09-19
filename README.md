    public DataSet GetWorkOrder(string vc)
    {
        string strSQL = " select concat(w.WO_NO, +' - ' + convert(varchar, w.TO_DATE, 103)) as WorkOrderNo ,w.WO_NO as WoNo from App_WorkOrder_Reg w where WO_NO NOT in (select  WO_NO  from App_Vendor_form_C3_Dtl where STATUS='Approved' and C3_CLOSER_DATE>GETDATE() and V_CODE=w.V_CODE ) and w.V_CODE ='" + vc + "' and w.STATUS='Approved'  union  select concat(w.WO_NO, +' - ' + convert(varchar, w.TO_DATE, 103)) as WorkOrderNo ,w.WO_NO as WoNo from App_WorkOrder_Reg w  where WO_NO in (select  WO_NO  from App_Vendor_form_C3_Dtl where Ll_NO like 'NA_%' and STATUS='Approved' and V_CODE=w.V_CODE )  and w.V_CODE ='" + vc + "' and w.STATUS='Approved'";
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
