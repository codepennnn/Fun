 protected void WorkOrder_Exemption_Records_SelectedIndexChanged(object sender, EventArgs e)
 {


     GetRecord(WorkOrder_Exemption_Records.SelectedDataKey.Value.ToString());
     WorkOrder_Exemption_Record.BindData();
     Action_Record.DataBind();



     TextBox txtWO = (TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo");   // System.ArgumentOutOfRangeException
  HResult=0x80131502
  Message=Index was out of range. Must be non-negative and less than the size of the collection.
Parameter name: index



     CheckBoxList chkWO = (CheckBoxList)Action_Record.Rows[0].FindControl("WorkOrderNo");

     chkWO.Items.Clear();

     if (!string.IsNullOrEmpty(txtWO.Text))
     {
         chkWO.Items.Add(new ListItem(txtWO.Text, txtWO.Text));
         chkWO.Items[0].Selected = true;
     }

     btnSave.Visible = false;

 

     BL_WorkOrder_Exemption_Approval blobj = new BL_WorkOrder_Exemption_Approval();
     DataSet ds = new DataSet();
     string ID = PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString();
     ds = blobj.BindRemarks(ID);
     Remarks_grid.DataSource = ds.Tables[0];
     Remarks_grid.DataBind();


  


     WorkOrder_Exemption_Record.Visible = true;
     Action_Record.Visible = true;
     ((HtmlGenericControl)Action_Record.Rows[0].FindControl("div_exp_cc")).Visible = false;
     ((HtmlGenericControl)Action_Record.Rows[0].FindControl("div_newRemarks")).Visible = false;

     if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Approved")
     {
         //WorkOrder_Exemption_Record.Enabled = false;
         //Action_Record.Visible=false;

         //j
         WorkOrder_Exemption_Record.DataBind();
         ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo")).Enabled = false;
         ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Exemption_Vendor")).Enabled = false;
         ((BulletedList)WorkOrder_Exemption_Record.Rows[0].FindControl("Bull_Attach")).Enabled = false;
         btnSave.Visible = false;
         ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Enabled = false;
         Action_Record.Visible = false;
     }
     else if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Pending With CC")
     {

         //WorkOrder_Exemption_Record.Enabled = false;
         //Action_Record.Enabled = true;
         //btnSave.Visible = true;

         //j
         WorkOrder_Exemption_Record.DataBind();
         ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo")).Enabled = false;
         ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Exemption_Vendor")).Enabled = false;
         ((BulletedList)WorkOrder_Exemption_Record.Rows[0].FindControl("Bull_Attach")).Enabled = false;
         btnSave.Visible = true;
         ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Enabled = false;
         Action_Record.Enabled = true;


     }
     else if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Return")
     {
         //WorkOrder_Exemption_Record.Enabled = false;
         //Action_Record.Visible = false;

         //j
         WorkOrder_Exemption_Record.DataBind();
         ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo")).Enabled = false;
         ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Exemption_Vendor")).Enabled = false;
         ((BulletedList)WorkOrder_Exemption_Record.Rows[0].FindControl("Bull_Attach")).Enabled = false;
         btnSave.Visible = false;
         ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Enabled = false;
         Action_Record.Visible = false;

     }
     else
     {

     }
 }
