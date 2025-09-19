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


             if ( !usedWoOrder.Contains(trimmed))
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



    public DataSet GetusedWorkOrder(string vc)
    {
        string strSQL = " select concat(w.WO_NO, +' - ' + convert(varchar, w.TO_DATE, 103)) as WorkOrderNo ,w.WO_NO as WoNo from App_WorkOrder_Reg w where WO_NO NOT in (select  WO_NO  from App_Vendor_form_C3_Dtl where STATUS='Approved' and C3_CLOSER_DATE>GETDATE() and V_CODE=w.V_CODE ) and w.V_CODE ='" + vc + "' and w.STATUS='Approved'  union  select concat(w.WO_NO, +' - ' + convert(varchar, w.TO_DATE, 103)) as WorkOrderNo ,w.WO_NO as WoNo from App_WorkOrder_Reg w  where WO_NO in (select  WO_NO  from App_Vendor_form_C3_Dtl where Ll_NO like 'NA_%' and STATUS='Approved' and V_CODE=w.V_CODE )  and w.V_CODE ='" + vc + "' and w.STATUS='Approved'";
        Dictionary<string, object> objParam = new Dictionary<string, object>();
        DataHelper dh = new DataHelper();
        DataSet ds = dh.GetDataset(strSQL, "App_LabourLicenseSubmission", objParam);
        return ds;
    }


    //j 02-06-2025
    public DataSet GetSelectedWorkOrder(string LicNo)
    {
        string strSQL = "select WorkOrderNo from App_LabourLicenseSubmission where LicNo='"+ LicNo + "'";
        Dictionary<string, object> objParam = new Dictionary<string, object>();
        DataHelper dh = new DataHelper();
        DataSet ds = dh.GetDataset(strSQL, "App_LabourLicenseSubmission", objParam);
        return ds;
    }

    public DataSet GetAllWorkOrder(string vc)
    {
        string strSQL = " select concat(w.WO_NO, +' - ' + convert(varchar, w.TO_DATE, 103)) as WorkOrderNo ,w.WO_NO as WoNo from App_WorkOrder_Reg w" +
" where WO_NO Not in (select  WO_NO  from App_Vendor_form_C3_Dtl where Ll_NO not like 'NA_%' and STATUS='Approved'   )  and w.V_CODE =@V_CODE and " +
"w.STATUS='Approved'  "
+ " union "
+ " select concat(w.WO_NO, +' - ' + convert(varchar, w.TO_DATE, 103)) as WorkOrderNo ,w.WO_NO as WoNo  "
+ " from App_WorkOrder_Reg w "
+ "  where WO_NO in  "
+ "  (select  WO_NO  from App_Vendor_form_C3_Dtl where Labour_License_site='Others' and V_CODE=w.V_CODE   )    "
+ "  and w.V_CODE =@V_CODE and  "
+ " w.STATUS='Approved'    ";
        Dictionary<string, object> objParam = new Dictionary<string, object>();
        objParam.Add("V_CODE", vc);
         DataHelper dh = new DataHelper();
        DataSet ds = dh.GetDataset(strSQL, "App_LabourLicenseSubmission", objParam);
        return ds;
    }


 please explain whats happening here
