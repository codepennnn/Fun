        protected void WorkOrder_Exemption_Record_PreRender(object sender, EventArgs e)
        {
            BL_WorkOrder_Exemption blobjs = new BL_WorkOrder_Exemption();
            DataSet ds = new DataSet();
            if (WorkOrder_Exemption_Record.Rows.Count > 0)
            {

          


                if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows.Count > 0)
                {
                    ds = blobjs.BindRemarks(PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["ID"].ToString());
                    Remarks_grid.DataSource = ds;
                    Remarks_grid.DataBind();
                    
                }



            }
            if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["WorkOrderNo"].ToString() != "") 
            {
          
                
                
                if (PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Pending With CC" &&
                    PageRecordDataSet.Tables["App_WorkOrder_Exemption"].Rows[0]["Status"].ToString() == "Approved")
                {
                //WorkOrder_Exemption_Record.Enabled = false;
                //btnSave.Enabled = false;
                //((FileUpload)WorkOrder_Exemption_Record.Rows[0].FindControl("Attachment")).Enabled = false;
                //((BulletedList)WorkOrder_Exemption_Record.Rows[0].FindControl("Bull_Attach")).Enabled = true;

                //j
                ((CheckBoxList)WorkOrder_Exemption_Record.Rows[0].FindControl("WorkOrderNo")).Enabled = false;
                ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Exemption_Vendor")).Enabled = false;
                ((FileUpload)WorkOrder_Exemption_Record.Rows[0].FindControl("Attachment")).Enabled = false;
                 btnSave.Enabled = false;
                ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Enabled = false;


            }
            else
            {
                WorkOrder_Exemption_Record.Enabled = true;
                btnSave.Enabled = true;
               
                ((TextBox)WorkOrder_Exemption_Record.Rows[0].FindControl("Remarks")).Text = "";
                ((FileUpload)WorkOrder_Exemption_Record.Rows[0].FindControl("Attachment")).Enabled = true;

            }

            }




        }
